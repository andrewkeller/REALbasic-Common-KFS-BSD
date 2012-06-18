#tag Class
Protected Class TestPosixCommandLineArgumentParser
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertBlowsUp(method As MethodReturningString, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises an exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As String
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found """ + fn_rslt + """.", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.CommandLineArgumentParserException Then
		    
		    // This is good.
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type CommandLineArgumentParserException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNextItemValueEquals(expected_field As ParserFields, expected_value As String, found As CommandLineArgumentsKFS.CommandLineArgumentParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the next item in the parser has the expected characteristics.
		  
		  PushMessageStack failureMessage
		  
		  PushMessageStack "Testing the initial state of the fields:"
		  AssertEquals ParserFields.AppInvocationString = expected_field, found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertEquals ParserFields.Flag = expected_field, found.HasNextFlag, "HasNextFlag"
		  AssertEquals ParserFields.Parcel = expected_field, found.HasNextParcel, "HasNextParcel"
		  AssertTrue found.HasNextSomething, "HasNextSomething"
		  PopMessageStack
		  
		  PushMessageStack "Peeking/Getting the values of the fields:"
		  
		  If ParserFields.AppInvocationString = expected_field Then
		    AssertEquals expected_value, found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		  Else
		    AssertBlowsUp AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		    AssertBlowsUp AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  End If
		  
		  If ParserFields.Flag = expected_field Then
		    AssertEquals expected_value, found.PeekNextFlag, "PeekNextFlag"
		  Else
		    AssertBlowsUp AddressOf found.PeekNextFlag, "PeekNextFlag"
		    AssertBlowsUp AddressOf found.GetNextFlag, "GetNextFlag"
		  End If
		  
		  If ParserFields.Parcel = expected_field Then
		    AssertEquals expected_value, found.PeekNextParcel, "PeekNextParcel"
		  Else
		    AssertBlowsUp AddressOf found.PeekNextParcel, "PeekNextParcel"
		    AssertBlowsUp AddressOf found.GetNextParcel, "GetNextParcel"
		  End If
		  
		  PushMessageStack "Testing afterward:"
		  AssertEquals ParserFields.AppInvocationString = expected_field, found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertEquals ParserFields.Flag = expected_field, found.HasNextFlag, "HasNextFlag"
		  AssertEquals ParserFields.Parcel = expected_field, found.HasNextParcel, "HasNextParcel"
		  AssertTrue found.HasNextSomething, "HasNextSomething"
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Getting the value of the requested field:"
		  
		  If ParserFields.AppInvocationString = expected_field Then
		    AssertEquals expected_value, found.GetNextAppInvocationString
		  ElseIf ParserFields.Flag = expected_field Then
		    AssertEquals expected_value, found.GetNextFlag
		  ElseIf ParserFields.Parcel = expected_field Then
		    AssertEquals expected_value, found.GetNextParcel
		  End If
		  
		  PopMessageStack
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNoItemsLeft(found As CommandLineArgumentsKFS.CommandLineArgumentParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the given parser has no elements left.
		  
		  PushMessageStack failureMessage
		  
		  AssertFalse found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertFalse found.HasNextFlag, "HasNextFlag"
		  AssertFalse found.HasNextParcel, "HasNextParcel"
		  AssertFalse found.HasNextSomething, "HasNextSomething"
		  AssertBlowsUp AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		  AssertBlowsUp AddressOf found.PeekNextFlag, "PeekNextFlag"
		  AssertBlowsUp AddressOf found.PeekNextParcel, "PeekNextParcel"
		  AssertBlowsUp AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  AssertBlowsUp AddressOf found.GetNextFlag, "GetNextFlag"
		  AssertBlowsUp AddressOf found.GetNextParcel, "GetNextParcel"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningString() As String
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub TestDash1()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with a single-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "-h" )
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
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
		Sub TestDashDash1()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with a double-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "--h" )
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "help", parser, "The second item should be the 'help' flag:"
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNoItemsLeft parser, "There should be no items left:"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmptyDashDash()
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Makes sure the parser works with an empty double-dash flag.
		  
		  Dim args() As String = Array( "foo bar", "--" )
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with an empty flag:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Flag, "", parser, "The second item should be an empty flag:"
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
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
		  Dim parser As New CommandLineArgumentsKFS.PosixCommandLineArgumentParser( args )
		  
		  PushMessageStack "After supplying an array with one parcel:"
		  AssertNextItemValueEquals ParserFields.AppInvocationString, "foo bar", parser, "The first item should be the app invocation string:"
		  AssertNextItemValueEquals ParserFields.Parcel, "fish cat", parser, "The second item should be the parcel:"
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


	#tag Enum, Name = ParserFields, Flags = &h0
		AppInvocationString
		  Flag
		Parcel
	#tag EndEnum


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
