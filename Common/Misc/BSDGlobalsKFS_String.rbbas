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
