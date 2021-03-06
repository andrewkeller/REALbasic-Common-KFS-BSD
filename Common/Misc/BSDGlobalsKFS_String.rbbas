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
		    
		    Dim b As Boolean = v
		    Return Str( b )
		    
		  ElseIf v.Type = Variant.TypeCFStringRef _
		    Or v.Type = Variant.TypeCString _
		    Or v.Type = Variant.TypePString _
		    Or v.Type = Variant.TypeString _
		    Or v.Type = Variant.TypeWString Then
		    
		    If v = "" Then Return "an empty string"
		    
		    Return chr(34) + v + chr(34)
		    
		  ElseIf v.Type = Variant.TypeDate Then
		    
		    Return Date( v ).SQLDateTime + " " + Format( Date( v ).GMTOffset, "+##;+##;\Z" )
		    
		  ElseIf v.IsNumeric Then
		    
		    If v = 0 Then
		      
		      Return "zero"
		      
		    ElseIf v.Type = Variant.TypeDouble Then
		      
		      Dim d As Double = v
		      Return Str( d )
		      
		    Else
		      
		      Return v
		      
		    End If
		    
		  End If
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Return "'" + v + "'"
		    
		  Catch err As TypeMismatchException
		    
		    // Apparently the variant cannot be converted to a String.
		    // Let's hope we can get by with just the name of the class.
		    
		    Return v.TypeDescriptionKFS
		    
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
		Function InStrB_BSa_KFS(Extends src As BinaryStream, ByRef regionStart As UInt64, ByRef regionEnd As UInt64, ByRef matchIndex As Integer, startPos As UInt64, subStrings() As BinaryStream) As UInt64
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Returns the position of the first occurrence of the given substrings
		  // in this object's string data, starting at the given position.
		  
		  // Basic parameter checking:
		  matchIndex = -1
		  regionStart = 0
		  regionEnd = 0
		  If subStrings.Ubound < 0 Then Return 0
		  Dim srcUBound As UInt64 = src.Length
		  If srcUBound = 0 Then Return 0
		  If startPos > srcUBound Then Return 0
		  
		  // Convert the start position to base-zero:
		  If startPos > 0 Then startPos = startPos -1
		  srcUBound = srcUBound -1
		  
		  // Sanitize the substrings list:
		  Dim s_streams() As BinaryStream // the stream itself
		  Dim s_priorities() As Integer // the order provided // 1...n
		  Dim s_triggers() As Integer // the first character (a quick optimization)
		  Dim s_lengths() As UInt64 // the length of this stream
		  For p As Integer = 0 To subStrings.Ubound
		    Dim s As BinaryStream = subStrings(p)
		    If Not ( s Is Nil ) Then
		      If s.Length > 0 Then
		        
		        s_streams.Append s
		        s_lengths.Append s.Length
		        s_priorities.Append p
		        
		        s.Position = 0
		        s_triggers.Append s.ReadByte
		        If s.Position = 0 Then
		          Dim e As New IOException
		          e.Message = "An IO Error occurred while reading one of the substring streams."
		          Raise e
		        End If
		        
		      End If
		    End If
		  Next
		  
		  // Initialize the working match pool:
		  Dim m_streams() As BinaryStream // the stream that matches
		  Dim m_priorities() As Integer // the priority of this substring
		  Dim m_offsets() As UInt64 // the start position of this substring within the search string
		  Dim m_lengths() As UInt64 // the total length of this substring
		  
		  // Initialize the result bucket:
		  Dim r_stream As BinaryStream = Nil
		  Dim r_priority As Integer = -1
		  Dim r_offset As UInt64 = 0
		  Dim r_length As UInt64 = 0
		  
		  // Initialize the temporary variables:
		  Dim char As Integer // the current character in the search string
		  Dim iop As UInt64 // used to detect read errors
		  
		  // Rewind the source string:
		  src.Position = startPos
		  
		  // Start the main loop:
		  
		  For offset As UInt64 = startPos To srcUBound
		    
		    // Get the current character:
		    
		    iop = src.Position
		    char = src.ReadByte
		    If src.Position <> iop + 1 Then Raise New IOException
		    
		    
		    // Add the substrings that match the current character:
		    
		    For i As Integer = s_streams.Ubound DownTo 0
		      If offset + s_lengths(i) > srcUBound Then
		        
		        // Stop examining this substring, because it
		        // doesn't fit in the remainder of the source string.
		        
		        s_streams.Remove i
		        s_triggers.Remove i
		        s_lengths.Remove i
		        s_priorities.Remove i
		        
		      ElseIf s_triggers(i) = char Then
		        
		        // This stream might start at this location.
		        
		        m_streams.Append s_streams(i)
		        m_offsets.Append offset
		        m_lengths.Append s_lengths(i)
		        m_priorities.Append s_priorities(i)
		        
		      End If
		    Next
		    
		    
		    // Remove the substrings that no longer match the current character
		    // or are on their last character and should be removed:
		    
		    For i As Integer = m_streams.Ubound DownTo 0
		      
		      // Does the current character in this substring still match?
		      
		      iop = offset - m_offsets(i)
		      m_streams(i).Position = iop
		      If m_streams(i).ReadByte = char Then
		        
		        // Yes, it still matches.
		        
		        // Is this the end of the substring?
		        
		        If m_streams(i).Position = m_streams(i).Length Then
		          
		          // Yes, this is the end of this substring.
		          
		          // This substring might be a viable result:
		          
		          If r_priority < 0 Or m_priorities(i) < r_priority Then
		            r_stream = m_streams(i)
		            r_offset = m_offsets(i)
		            r_length = m_lengths(i)
		            r_priority = m_priorities(i)
		          End If
		          
		          // This substring may have started at the beginning of this region:
		          
		          If regionStart = 0 Or regionStart > m_offsets(i)+1 Then
		            regionStart = m_offsets(i) +1
		          End If
		          
		          // This substring may mark the end of this region:
		          
		          If regionEnd < offset+2 Then
		            regionEnd = offset +2
		          End If
		          
		          // And finally, stop tracking this substring:
		          
		          m_streams.Remove i
		          m_offsets.Remove i
		          m_lengths.Remove i
		          m_priorities.Remove i
		          
		        Else
		          
		          // No, this is not the end of this substring.
		          // Oh well...  keep going...
		          
		        End If
		      ElseIf m_streams(i).Position = iop Then
		        
		        // The position of the stream did not advance, which suggests that a read error occurred.
		        
		        Raise New IOException
		        
		      Else
		        
		        // This substring simply does not match anymore.
		        
		        // Remove it from the match pool.
		        
		        m_streams.Remove i
		        m_offsets.Remove i
		        m_lengths.Remove i
		        m_priorities.Remove i
		        
		      End If
		    Next
		    
		    
		    // Check to see if we have a result yet:
		    
		    If Not ( r_stream Is Nil ) And m_streams.Ubound < 0 Then
		      
		      matchIndex = r_priority
		      Return r_offset +1
		      
		    End If
		    
		    // Check to see if there is no possibility of future matches:
		    
		    If m_streams.Ubound < 0 And s_streams.Ubound < 0 Then Exit
		    
		  Next
		  
		  // A match was never found.
		  
		  Return 0
		  
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

	#tag Method, Flags = &h0
		Function ObjectTypeDescriptionKFS(v As Variant) As String
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Returns a textual description of the type of the given Variant, designed for integrating in a sentence.
		  
		  // For example:  "This variable is " + ObjectTypeDescriptionKFS( v ) + "."
		  
		  Return v.TypeDescriptionKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TypeDescriptionKFS(Extends v As Variant) As String
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Returns a textual description of the type of the given Variant, designed for integrating in a sentence.
		  
		  // For example:  "This variable is " + v.TypeDescriptionKFS + "."
		  
		  Dim t As Integer = v.Type
		  
		  If v.IsNull Then
		    
		    Return "Nil"
		    
		  ElseIf t >= Variant.TypeArray Then
		    
		    Dim a As Integer = v.ArrayElementType
		    Dim s As String = "an array of "
		    
		    If a = Variant.TypeBoolean Then
		      Return s + "Booleans"
		      
		    ElseIf a = Variant.TypeCFStringRef Then
		      Return s + "CFStringRefs"
		      
		    ElseIf a = Variant.TypeColor Then
		      Return s + "Colors"
		      
		    ElseIf a = Variant.TypeCString Then
		      Return s + "CStrings"
		      
		    ElseIf a = Variant.TypeCurrency Then
		      Return s + "Currencies"
		      
		    ElseIf a = Variant.TypeDate Then
		      Return s + "Dates"
		      
		    ElseIf a = Variant.TypeDouble Then
		      Return s + "Doubles"
		      
		    ElseIf a = Variant.TypeInteger Then
		      Return s + "Integers"
		      
		    ElseIf a = Variant.TypeLong Then
		      Return s + "Long Integers"
		      
		    ElseIf a = Variant.TypeNil Then
		      Return s + "Nil"
		      
		    ElseIf a = Variant.TypeObject Then
		      Return s + "objects"
		      
		    ElseIf a = Variant.TypeOSType Then
		      Return s + "OSTypes"
		      
		    ElseIf a = Variant.TypePString Then
		      Return s + "PStrings"
		      
		    ElseIf a = Variant.TypePtr Then
		      Return s + "Pointers"
		      
		    ElseIf a = Variant.TypeSingle Then
		      Return s + "Singles"
		      
		    ElseIf a = Variant.TypeString Then
		      Return s + "Strings"
		      
		    ElseIf a = Variant.TypeStructure Then
		      Return s + "Structures"
		      
		    ElseIf a = Variant.TypeWindowPtr Then
		      Return s + "Window Pointers"
		      
		    ElseIf a = Variant.TypeWString Then
		      Return s + "WStrings"
		      
		    End If
		    
		  ElseIf t = Variant.TypeBoolean Then
		    Return "a Boolean"
		    
		  ElseIf t = Variant.TypeCFStringRef Then
		    Return "a CFStringRef"
		    
		  ElseIf t = Variant.TypeColor Then
		    Return "a Color"
		    
		  ElseIf t = Variant.TypeCString Then
		    Return "a CString"
		    
		  ElseIf t = Variant.TypeCurrency Then
		    Return "a Currency"
		    
		  ElseIf t = Variant.TypeDate Then
		    Return "a Date"
		    
		  ElseIf t = Variant.TypeDouble Then
		    Return "a Double"
		    
		  ElseIf t = Variant.TypeInteger Then
		    Return "an Integer"
		    
		  ElseIf t = Variant.TypeLong Then
		    Return "a Long Integer"
		    
		  ElseIf t = Variant.TypeNil Then
		    Return "Nil"
		    
		  ElseIf t = Variant.TypeObject Then
		    Return "a " + Introspection.GetType( v ).Name + " object"
		    
		  ElseIf t = Variant.TypeOSType Then
		    Return "an OSType"
		    
		  ElseIf t = Variant.TypePString Then
		    Return "a PString"
		    
		  ElseIf t = Variant.TypePtr Then
		    Return "a Pointer"
		    
		  ElseIf t = Variant.TypeSingle Then
		    Return "a Single"
		    
		  ElseIf t = Variant.TypeString Then
		    Return "a String"
		    
		  ElseIf t = Variant.TypeStructure Then
		    Return "a Structure"
		    
		  ElseIf t = Variant.TypeWindowPtr Then
		    Return "a Window Pointer"
		    
		  ElseIf t = Variant.TypeWString Then
		    Return "a WString"
		    
		  End If
		  
		  Return "unidentifiable data"
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This module is licensed as BSD.  This generally means you may do
		whatever you want with this module so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this module does NOT require
		your work to inherit the license of this module.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this module.
		
		The full official license is as follows:
		
		Copyright (c) 2010, 2011 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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
