#tag Class
Protected Class TestCLIArgsPosixArgParser
Inherits UnitTests_RBCKB.BaseTestCLIArgsArgParser
	#tag Method, Flags = &h0
		Sub TestDash1()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with a single-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "-h" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with a single-dash flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "h", parser, "The second item should be the 'h' flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDash2()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with a single-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "-help" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with multiple single-dash flags:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "h", parser, "The second item should be the 'h' flag:"
		  AssertNextItemValueEquals ParserFields.Flag, "e", parser, "The second item should be the 'e' flag:"
		  AssertNextItemValueEquals ParserFields.Flag, "l", parser, "The second item should be the 'l' flag:"
		  AssertNextItemValueEquals ParserFields.Flag, "p", parser, "The second item should be the 'p' flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDashAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure that the parser can handle attached parcels correctly.
		  
		  Dim args() As String = Array( "foo bar", "-fish=cat:bird=dog", "-cat:fish=dog:bird" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with multiple single-dash flags, two of which have attached parcels:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "f", parser, "The second item should be the flag 'f':"
		  AssertNextItemValueEquals ParserFields.Flag, "i", parser, "The third item should be the flag 'i':"
		  AssertNextItemValueEquals ParserFields.Flag, "s", parser, "The fourth item should be the flag 's':"
		  AssertNextItemValueEquals ParserFields.Flag, "h", parser, "The fifth item should be the flag 'h':"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "cat:bird=dog", parser, "The sixth item should be the attached parcel cat:bird=dog:"
		  AssertNextItemValueEquals ParserFields.Flag, "c", parser, "The seventh item should be the flag 'c':"
		  AssertNextItemValueEquals ParserFields.Flag, "a", parser, "The eighth item should be the flag 'a':"
		  AssertNextItemValueEquals ParserFields.Flag, "t", parser, "The nineth item should be the flag 't':"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "fish=dog:bird", parser, "The tenth item should be the attached parcel fish=dog:bird:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDashDash1()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with a double-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "--h" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with a double-dash flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "h", parser, "The second item should be the 'h' flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDashDash2()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with a double-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "--help" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with a double-dash flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "help", parser, "The second item should be the 'help' flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDashDashAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure that the parser can handle attached parcels correctly.
		  
		  Dim args() As String = Array( "foo bar", "--fish cat=bird:dog", "--bird dog:fish=cat" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with two double-dash flags with attached parcels:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "fish cat", parser, "The second item should be the flag:"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "bird:dog", parser, "The third item should be the attached parcel:"
		  AssertNextItemValueEquals ParserFields.Flag, "bird dog", parser, "The fourth item should be the second flag:"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "fish=cat", parser, "The fifth item should be the second attached parcel:"
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
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an empty array:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDash()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty single-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "-" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty single-dash:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDashAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty single-dash flag with an attached parcel.
		  
		  Dim args() As String = Array( "foo bar", "-:foo" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty single-dash with an attached parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertException_MissingFlagForAttachedParcel "-:foo", parser, "The parser should throw an exception when the input contains an attached parcel with nothing to attach to:"
		  PopMessageStack
		  
		  
		  args = Array( "foo bar", "-=foo" )
		  parser = New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty single-dash with an attached parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertException_MissingFlagForAttachedParcel "-=foo", parser, "The parser should throw an exception when the input contains an attached parcel with nothing to attach to:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDashDash()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty double-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "--" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty double-dash flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "", parser, "The second item should be an empty flag:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDashDashAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty double-dash flag with an attached parcel.
		  
		  Dim args() As String = Array( "foo bar", "--:foo", "--=bar" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with empty double-dash flags with attached parcels:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "", parser, "The second item should be an empty flag:"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "foo", parser, "The third item should be an empty attached parcel:"
		  AssertNextItemValueEquals ParserFields.Flag, "", parser, "The fourth item should be the second empty flag:"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "bar", parser, "The third item should be the second empty attached parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDashDashEmptyAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty double-dash flag with an empty attached parcel.
		  
		  Dim args() As String = Array( "foo bar", "--:", "--=" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with empty double-dash flags with empty attached parcels:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "", parser, "The second item should be an empty flag:"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "", parser, "The third item should be an empty attached parcel:"
		  AssertNextItemValueEquals ParserFields.Flag, "", parser, "The fourth item should be the second empty flag:"
		  AssertNextItemValueEquals ParserFields.AttachedParcel, "", parser, "The third item should be the second empty attached parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDashEmptyAttachedParcel()
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty single-dash flag with an empty attached parcel.
		  
		  Dim args() As String = Array( "foo bar", "-:" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty single-dash with an empty attached parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertException_MissingFlagForAttachedParcel "-:", parser, "The parser should throw an exception when the input contains an attached parcel with nothing to attach to:"
		  PopMessageStack
		  
		  
		  args = Array( "foo bar", "-=" )
		  parser = New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty single-dash with an empty attached parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertException_MissingFlagForAttachedParcel "-=", parser, "The parser should throw an exception when the input contains an attached parcel with nothing to attach to:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyParcel()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty parcel.
		  
		  Dim args() As String = Array( "foo bar", "" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with an empty parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Parcel, "", parser, "The second item should be the empty parcel:"
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
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with mixed POSIX and DOS flags:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "f", parser, "The second item should be the 'f' in -fish:"
		  AssertNextItemValueEquals ParserFields.Flag, "i", parser, "The thrid item should be the 'i' in -fish:"
		  AssertNextItemValueEquals ParserFields.Flag, "s", parser, "The fourth item should be the 's' in -fish:"
		  AssertNextItemValueEquals ParserFields.Flag, "h", parser, "The fifth item should be the 'h' in -fish:"
		  AssertNextItemValueEquals ParserFields.Flag, "cat", parser, "The sixth item should be the 'cat' in --cat:"
		  AssertNextItemValueEquals ParserFields.Parcel, "/bird dog", parser, "The fourth item should be the DOS flag, which is a parcel here:"
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
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with only the app invocation string:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
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
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  PushMessageStack "After supplying an array with one parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Parcel, "fish cat", parser, "The second item should be the parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTreatFlagsAsParcels1()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the ProcessFlagsAsParcels property works in the parser.
		  
		  Dim args() As String = Array( "foo bar", "-fish", "--cat" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  parser.ProcessFlagsAsParcels = True
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is True:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should still be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Parcel, "-fish", parser, "The second item should be the '-fish' flags, interpreted as a parcel:"
		  AssertNextItemValueEquals ParserFields.Parcel, "--cat", parser, "The second item should be the 'cat' flag, interpreted as a parcel:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTreatFlagsAsParcels2()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the ProcessFlagsAsParcels property works in the parser.
		  
		  Dim args() As String = Array( "foo bar", "-fish", "--cat", "bird", "--dog" )
		  Dim parser As New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  AssertFalse parser.ProcessFlagsAsParcels, "The ProcessFlagsAsParcels property is supposed to default to False."
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is False:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "f", parser, "The second item should be the 'f' flag:"
		  AssertNextItemValueEquals ParserFields.Flag, "i", parser, "The third item should be the 'i' flag:"
		  AssertNextItemValueEquals ParserFields.Flag, "s", parser, "The fourth item should be the 's' flag:"
		  AssertNextItemValueEquals ParserFields.Flag, "h", parser, "The fifth item should be the 'h' flag:"
		  PopMessageStack
		  
		  parser.ProcessFlagsAsParcels = True
		  AssertTrue parser.ProcessFlagsAsParcels, "Failed to change the ProcessFlagsAsParcels property to True."
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is True:"
		  AssertNextItemValueEquals ParserFields.Parcel, "--cat", parser, "The sixth item should be the 'cat' flag, which needs to be a parcel in this case:"
		  AssertNextItemValueEquals ParserFields.Parcel, "bird", parser, "The seventh item should be the 'bird' parcel:"
		  PopMessageStack
		  
		  parser.ProcessFlagsAsParcels = False
		  AssertFalse parser.ProcessFlagsAsParcels, "Failed to change the ProcessFlagsAsParcels to False."
		  
		  PushMessageStack "While the ProcessFlagsAsParcels property is False:"
		  AssertNextItemValueEquals ParserFields.Flag, "dog", parser, "The eighth item should be the 'dog' flag:"
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
