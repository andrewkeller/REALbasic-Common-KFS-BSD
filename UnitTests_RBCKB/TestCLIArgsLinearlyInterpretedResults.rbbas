#tag Class
Protected Class TestCLIArgsLinearlyInterpretedResults
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestFlag()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Makes sure that you can add flags and they are accessible.
		  
		  Dim r1, r2 As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = Nil
		  Dim s() As String
		  
		  r1 = New CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  
		  // Check the default values:
		  
		  AssertZero r1.CountArguments, "The value of CountArguments should be zero by default."
		  s = r1.ListArguments
		  AssertNotIsNil s, "The ListArguments method should never return Nil."
		  AssertEquals -1, s.Ubound, "The ListArguments method should return an empty array by default."
		  
		  AssertZero r1.CountFlagsForArgument( "arg1" ), "The CountFlagsForArgument method should be zero by default."
		  s = r1.ListFlagsForArgument( "arg1" )
		  AssertNotIsNil s, "The ListFlagsForArgument method should never return Nil."
		  AssertEquals -1, s.Ubound, "The ListFlagsForArgument method should return an empty array by default."
		  
		  // Add a flag and see what happens:
		  
		  r2 = r1
		  r1 = r1.AddEncounteredFlag( "arg1", "fish" )
		  
		  AssertNotIsNil r1, "The AddEncounteredFlag method should never return Nil."
		  AssertNotSame r1, r2, "The AddEncounteredFlag method should never return the same object as the original."
		  
		  AssertEquals 1, r1.CountArguments, "The value of CountArguments should be 1 now that a flag has been added."
		  s = r1.ListArguments
		  AssertNotIsNil s, "The ListArguments method should never return Nil."
		  AssertEquals 0, s.Ubound, "The ListArguments method should return an array with a single item."
		  AssertEquals "arg1", s(0), "The ListArguments method should return an array with the item 'arg1'."
		  
		  AssertEquals 1, r1.CountFlagsForArgument( "arg1" ), "The CountFlagsForArgument method should be 1 now that a flag has been added."
		  s = r1.ListFlagsForArgument( "arg1" )
		  AssertNotIsNil s, "The ListFlagsForArgument method should never return Nil."
		  AssertEquals 0, s.Ubound, "The ListFlagsForArgument method should return an array with a single item."
		  AssertEquals "fish", s(0), "The ListArguments method should return an array with the item 'fish'."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestParcel()
		  // Created 8/1/2012 by Andrew Keller
		  
		  // Makes sure that you can add parcels and they are accessible.
		  
		  Dim r1, r2 As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = Nil
		  Dim s() As String
		  
		  r1 = New CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  
		  // Check the default values:
		  
		  AssertZero r1.CountArguments, "The value of CountArguments should be zero by default."
		  s = r1.ListArguments
		  AssertNotIsNil s, "The ListArguments method should never return Nil."
		  AssertEquals -1, s.Ubound, "The ListArguments method should return an empty array by default."
		  
		  AssertZero r1.CountParcelsForArgument( "arg1" ), "The CountParcelsForArgument method should be zero by default."
		  s = r1.ListParcelsForArgument( "arg1" )
		  AssertNotIsNil s, "The ListParcelsForArgument method should never return Nil."
		  AssertEquals -1, s.Ubound, "The ListParcelsForArgument method should return an empty array by default."
		  
		  // Add a parcel and see what happens:
		  
		  r2 = r1
		  r1 = r1.AddEncounteredParcel( "arg1", "shark" )
		  
		  AssertNotIsNil r1, "The AddEncounteredParcel method should never return Nil."
		  AssertNotSame r1, r2, "The AddEncounteredParcel method should never return the same object as the original."
		  
		  AssertEquals 1, r1.CountArguments, "The value of CountArguments should be 1 now that a parcel has been added."
		  s = r1.ListArguments
		  AssertNotIsNil s, "The ListArguments method should never return Nil."
		  AssertEquals 0, s.Ubound, "The ListArguments method should return an array with a single item."
		  AssertEquals "arg1", s(0), "The ListArguments method should return an array with the item 'arg1'."
		  
		  AssertEquals 1, r1.CountParcelsForArgument( "arg1" ), "The CountParcelsForArgument method should be 1 now that a parcel has been added."
		  s = r1.ListParcelsForArgument( "arg1" )
		  AssertNotIsNil s, "The ListParcelsForArgument method should never return Nil."
		  AssertEquals 0, s.Ubound, "The ListParcelsForArgument method should return an array with a single item."
		  AssertEquals "shark", s(0), "The ListParcelsForArgument method should return an array with the item 'shark'."
		  
		  // done.
		  
		End Sub
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
		#tag EndViewProperty
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