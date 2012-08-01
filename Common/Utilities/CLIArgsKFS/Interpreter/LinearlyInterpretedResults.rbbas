#tag Class
Protected Class LinearlyInterpretedResults
	#tag Method, Flags = &h0
		Function AddEncounteredFlag(argument_id As String, flag As String) As CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns a new LinearlyInterpretedResults object that contains the requested change.
		  
		  Dim result As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = Clone
		  
		  Dim s(-1) As String
		  If result.p_data.HasKey( argument_id ) Then
		    s = result.p_data.Value( argument_id )
		  Else
		    result.p_data.Value( argument_id ) = s
		  End If
		  s.Append flag
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddEncounteredParcel(argument_id As String, parcel As String) As CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ArgumentWasEncountered(argument_id As String) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Clone() As CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns a clone of this object.
		  
		  Return New CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Initializes this object.
		  
		  init
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountArguments() As Integer
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns the number of arguments in this object.
		  
		  Return p_data.Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountFlagsForArgument(argument_id As String) As Integer
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns the number of flags encountered for the given argument.
		  
		  Dim s(-1) As String
		  s = p_data.Lookup( argument_id, s )
		  
		  Return UBound( s ) + 1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountParcelsForArgument(argument_id As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub init()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Initializes this object.
		  
		  p_data = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListArguments() As String()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns an array of the arguments contained in this object.
		  
		  Dim s(-1) As String
		  
		  For Each k As Variant In p_data.Keys
		    s.Append k
		  Next
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFlagsForArgument(argument_id As String) As String()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns an array of the flags encountered for the given argument.
		  
		  Dim s(-1), result(-1) As String
		  s = p_data.Lookup( argument_id, s )
		  
		  For Each item As String In s
		    result.Append item
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListParcelsForArgument(argument_id As String) As String()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Returns an array of the parcels encountered for the given argument.
		  
		  Dim result(-1) As String
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2012 Andrew Keller.
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


	#tag Property, Flags = &h1
		Protected p_data As Dictionary
	#tag EndProperty


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
End Class
#tag EndClass
