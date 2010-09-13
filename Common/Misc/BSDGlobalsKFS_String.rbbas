#tag Module
Protected Module BSDGlobalsKFS_String
	#tag Method, Flags = &h0
		Function DescriptionKFS(Extends v As Variant) As String
		  // Created 5/12/2010 by Andrew Keller
		  
		  // Returns a textual description of the given Variant, designed for integrating in a sentence.
		  
		  // For example:  "This variable contains " + v.DescriptionKFS + "."
		  
		  If v.IsNull Then
		    
		    Return "Nil"
		    
		  ElseIf v.Type = Variant.TypeBoolean Then
		    
		    If v = True Then Return "True"
		    If v = False Then Return "False"
		    
		  ElseIf v.Type = Variant.TypeLong Then
		    
		    Dim d As Int64 = v
		    
		    If d = 0 Then Return "zero"
		    
		    Return str( d )
		    
		  ElseIf v.IsNumeric Then
		    
		    Dim d As Double = v
		    
		    If d = 0 Then Return "zero"
		    
		    Return str( d )
		    
		  ElseIf v.Type = Variant.TypeCFStringRef _
		    Or v.Type = Variant.TypeCString _
		    Or v.Type = Variant.TypePString _
		    Or v.Type = Variant.TypeString _
		    Or v.Type = Variant.TypeWString Then
		    
		    If v = "" Then Return "an empty string"
		    
		  End If
		  
		  Try
		    
		    Return "'" + v + "'"
		    
		  Catch err As TypeMismatchException
		    
		    // Apparently the variant cannot be converted to a String.
		    // Let's hope we can get by with just the name of the class.
		    
		    Return "a " + Introspection.GetType( v ).Name + " object"
		    
		  End Try
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfLineKFS() As String
		  // Created 5/12/2010 by Andrew Keller
		  
		  // A version of EndOfLine that returns Unix line endings when running on OS X.
		  
		  #if TargetMacOS and not TargetMacOSClassic then
		    
		    Return EndOfLine.UNIX
		    
		  #else
		    
		    Return EndOfLine
		    
		  #endif
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfLineSetKFS() As String()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Returns the set of all EndOfLine's.
		  
		  Return Array( chr(13)+chr(10), chr(10), chr(13) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB_BSa_KFS(Extends src As BinaryStream, startPos As UInt64, ByRef matchIndex As Integer, subStrings() As BinaryStream) As UInt64
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Returns the position of the first occurrence of the given substrings
		  // in this object's string data, starting at the given position.
		  
		  delLength = 0
		  If subStrings.Ubound < 0 Then Return 0
		  Dim srcUBound As UInt64 = src.Length
		  If srcUBound = 0 Then Return 0
		  If startPos > srcUBound Then Return 0
		  
		  // Convert the start position to base-zero:
		  If startPos > 0 Then startPos = startPos -1
		  srcUBound = srcUBound -1
		  
		  // Rewind the source string:
		  src.Position = startPos
		  
		  // Sanitize the substrings list:
		  Dim s_streams() As BinaryStream
		  Dim s_triggers() As Integer
		  Dim s_lengths() As UInt64
		  For Each s As BinaryStream In subStrings
		    If s <> Nil Then
		      If s.Length > 0 Then
		        s_streams.Append s
		        s.Position = 0
		        s_triggers.Append s.ReadByte
		        If s.Position = 0 Then Raise New IOException
		        s_lengths.Append s.Length
		      End If
		    End If
		  Next
		  
		  // Initialize the match pool:
		  Dim m_streams() As BinaryStream
		  Dim m_offsets() As UInt64
		  Dim m_lengths() As UInt64
		  
		  Dim char As Integer
		  Dim iop As UInt64
		  Dim smallestOffset As UInt64
		  
		  // Start the main loop:
		  
		  For offset As UInt64 = startPos To srcUBound
		    
		    // Get the current character:
		    
		    iop = src.Position
		    char = src.ReadByte
		    If src.Position <> iop + 1 Then Raise New IOException
		    
		    // Remove the substrings that no longer match the current character:
		    
		    For i As Integer = m_streams.Ubound DownTo 0
		      
		      iop = offset - m_offsets(i)
		      m_streams(i).Position = iop
		      If m_streams(i).ReadByte = char Then
		        // The substring still matches.
		        // Could this be the match?
		        If m_offsets(i) + m_lengths(i) >= offset Then
		          If m_offsets(i) = smallestOffset Then
		            // Got it!
		            delLength = m_lengths(i)
		            Return m_offsets(i) +1 // because InStr uses base-1 offsets.
		          End If
		        End If
		      ElseIf m_streams(i).Position = iop Then
		        // A read error occurred.
		        Raise New IOException
		      Else
		        // The substring does not match anymore.
		        m_streams.Remove i
		        m_offsets.Remove i
		        m_lengths.Remove i
		        smallestOffset = Min( m_offsets )
		      End If
		      
		    Next
		    
		    // Add the substrings that match the current character:
		    
		    For i As Integer = s_streams.Ubound DownTo 0
		      If offset + s_lengths(i) > srcUBound Then
		        
		        // Stop examining this substring, because
		        // it can't fit in the remainder of src:
		        
		        s_streams.Remove i
		        s_triggers.Remove i
		        s_lengths.Remove i
		        
		      ElseIf s_triggers(i) = char Then
		        If s_lengths(i) = 1 Then
		          
		          // This stream is only one byte long, so it's automatically a match.
		          
		          delLength = 1
		          Return offset +1
		          
		        Else
		          
		          // This stream might start at this location.
		          
		          m_streams.Append s_streams(i)
		          m_offsets.Append offset
		          m_lengths.Append s_lengths(i)
		          
		          If m_offsets.Ubound = 0 Then smallestOffset = m_offsets(0)
		          
		        End If
		      End If
		    Next
		    
		  Next
		  
		  // A match was not found.
		  
		  Return 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Min(ary() As UInt64) As UInt64
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Returns the minimum value in the given array.
		  // Returns 0 if the array is empty.
		  
		  If ary.Ubound < 0 Then Return 0
		  
		  Dim result As UInt64 = ary(0)
		  
		  For row As Integer = ary.Ubound DownTo 1
		    
		    If ary(row) < result Then result = ary(row)
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectDescriptionKFS(v As Variant) As String
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Returns a textual description of the given Variant, designed for integrating in a sentence.
		  
		  // For example:  "This variable contains " + ObjectDescriptionKFS( v ) + "."
		  
		  Return v.DescriptionKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
		  contributors may be used to endorse or promote products derived
		  from this software without specific prior written permission.
		
		THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
		"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
		LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
		FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
		COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
		INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
		BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
		LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
		CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
		LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
		ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
		POSSIBILITY OF SUCH DAMAGE.
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
