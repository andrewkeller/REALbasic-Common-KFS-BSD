#tag Class
Protected Class TestCLIArgsDosArgParser
Inherits UnitTests_RBCKB.BaseTestCLIArgsArgParser
	#tag Method, Flags = &h0
		Sub TestAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure that the parser can handle attached parcels correctly.
		  
		  Dim args() As String = Array( "foo bar", "/fish cat=bird:dog", "/bird dog:fish=cat" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with two flags each with attached parcels:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "fish cat", parser, "The second item should be the flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAttachedParcel, "bird:dog", parser, "The third item should be the attached parcel:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "bird dog", parser, "The fourth item should be the second flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAttachedParcel, "fish=cat", parser, "The fifth item should be the second attached parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyArgs()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty array.
		  
		  Dim args(-1) As String
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an empty array:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyFlag()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty flag.
		  
		  Dim args() As String = Array( "foo bar", "/" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "", parser, "The second item should be the empty flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyFlagWithAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty flag with an attached parcel.
		  
		  Dim args() As String = Array( "foo bar", "/:foo", "/=bar" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with empty flags with attached parcels:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "", parser, "The second item should be the empty flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAttachedParcel, "foo", parser, "The third item should be the attached parcel:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "", parser, "The fourth item should be the second empty flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAttachedParcel, "bar", parser, "The fifth item should be the second attached parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyFlagWithEmptyAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty flag with an empty attached parcel.
		  
		  Dim args() As String = Array( "foo bar", "/:", "/=" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with empty flags with empty attached parcels:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "", parser, "The second item should be the empty flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAttachedParcel, "", parser, "The third item should be the empty attached parcel:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "", parser, "The fourth item should be the second empty flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAttachedParcel, "", parser, "The fifth item should be the second empty attached parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyParcel()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty parcel.
		  
		  Dim args() As String = Array( "foo bar", "" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty parcel:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "", parser, "The second item should be the empty parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFlag()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser can handle a flag.
		  
		  Dim args() As String = Array( "foo bar", "/fish cat" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with one flag:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "fish cat", parser, "The second item should be the flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMixedPosixAndDos()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with more than one item.
		  
		  Dim args() As String = Array( "foo bar", "-fish", "--cat", "/bird dog" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with mixed POSIX and DOS flags:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "-fish", parser, "The second item should be the POSIX flag, which is a parcel here:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "--cat", parser, "The third item should be another POSIX flag, which is a parcel here:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "bird dog", parser, "The fourth item should be the DOS flag, which is actually a flag here:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOneArg()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an array with only one item.
		  
		  Dim args() As String = Array( "foo bar" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with only the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestParcel()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser can handle a parcel.
		  
		  Dim args() As String = Array( "foo bar", "fish cat" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  PushMessageStack "After supplying an array with one parcel:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "fish cat", parser, "The second item should be the parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTreatFlagsAsParcels1()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the ProcessFlagsAsParcels property works in the parser.
		  
		  Dim args() As String = Array( "foo bar", "/fish" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  parser.ProcessFlagsAsParcels = True
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is True:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should still be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "/fish", parser, "The second item should be the 'fish' flag, interpreted as a parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTreatFlagsAsParcels2()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the ProcessFlagsAsParcels property works in the parser.
		  
		  Dim args() As String = Array( "foo bar", "/fish", "/cat:bam", "bird", "/dog" )
		  Dim parser As New CLIArgsKFS.Parser.DosArgParser( args )
		  
		  AssertFalse parser.ProcessFlagsAsParcels, "The ProcessFlagsAsParcels property is supposed to default to False."
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is False:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeAppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "fish", parser, "The second item should be the 'fish' flag:"
		  PopMessageStack
		  
		  parser.ProcessFlagsAsParcels = True
		  AssertTrue parser.ProcessFlagsAsParcels, "Failed to change the ProcessFlagsAsParcels property to True."
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is True:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "/cat:bam", parser, "The third item should be the 'cat' flag and its attached parcel, which needs to be all one parcel in this case:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeParcel, "bird", parser, "The fourth item should be the 'bird' parcel:"
		  PopMessageStack
		  
		  parser.ProcessFlagsAsParcels = False
		  AssertFalse parser.ProcessFlagsAsParcels, "Failed to change the ProcessFlagsAsParcels to False."
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is False:"
		  AssertNextItemEquals CLIArgsKFS.Parser.Argument.kTypeFlag, "dog", parser, "The fifth item should be the 'dog' flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
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
