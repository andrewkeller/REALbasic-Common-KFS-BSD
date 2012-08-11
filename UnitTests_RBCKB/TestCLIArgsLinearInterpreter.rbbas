#tag Class
Protected Class TestCLIArgsLinearInterpreter
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertEquals(expected() As String, found() As String, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Equal( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Equal(expected() As String, found() As String, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 8/10/2012 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given two values are equal.
		  
		  If expected Is Nil And found Is Nil Then Return Nil
		  
		  If expected Is Nil Or found Is Nil Then Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, expected, found, failureMessage )
		  
		  Dim s_expected As String = "{}"
		  Dim s_found As String = "{}"
		  
		  If UBound(expected) > -1 Then s_expected = "{'" + Join( expected, "', '" ) + "'}"
		  If UBound(found) > -1 Then s_found = "{'" + Join( found, "', '" ) + "'}"
		  
		  If s_expected = s_found Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected " + s_expected + " but found " + s_found + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NewParser(ParamArray args As String) As CLIArgsKFS.Parser.ArgParser
		  // Created 8/3/2012 by Andrew Keller
		  
		  // Returns an argument parser that runs through the given arguments.
		  
		  Return New CLIArgsKFS.Parser.PosixArgParser( args )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeEquals(expected() As String, found() As String, failureMessage As String = "") As Boolean
		  // Created 8/10/2012 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given values are not equal.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Equal( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAppInvStr()
		  // Created 8/3/2012 by Andrew Keller
		  
		  // Makes sure the Parse method works correctly when
		  // the parser only has an app invocation string.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  Dim rslt As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = int.Parse( NewParser( "app inv str" ) )
		  
		  AssertNotIsNil rslt, "The Parse method should never return Nil."
		  
		  AssertEquals "app inv str", rslt.GetAppInvocationString, "The Parse method should return a result with an empty app invocation string."
		  AssertZero rslt.CountArguments, "The Parse method should return a result with zero arguments."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAttachedParcel()
		  // Created 8/10/2012 by Andrew Keller
		  
		  // Makes sure the Parse method works correctly when
		  // the parser includes an attached parcel.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  int.AssociateFlagWithArgument "abc", "arg1"
		  
		  Dim rslt As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = int.Parse( NewParser( "app inv str", "--abc:def" ) )
		  
		  AssertNotIsNil rslt, "The Parse method should never return Nil."
		  
		  AssertEquals "app inv str", rslt.GetAppInvocationString, "The Parse method should return a result with an empty app invocation string."
		  AssertEquals Array( "arg1" ), rslt.ListArguments, "The Parse method should return a result with a list of arguments {'arg1'}."
		  AssertEquals Array( "abc" ), rslt.ListFlagsForArgument( "arg1" ), "The Parse method should return a result with the flags {'abc'} set for the argument 'arg1'."
		  AssertEquals Array( "def" ), rslt.ListParcelsForArgument( "arg1" ), "The Parse method should return a result with the parcels {'def'} set for the argument 'arg1'."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEmpty()
		  // Created 8/2/2012 by Andrew Keller
		  
		  // Makes sure the Parse method works correctly when
		  // the parser has no items.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  Dim rslt As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = int.Parse( NewParser )
		  
		  AssertNotIsNil rslt, "The Parse method should never return Nil."
		  
		  AssertEmptyString rslt.GetAppInvocationString, "The Parse method should return a result with an empty app invocation string."
		  AssertZero rslt.CountArguments, "The Parse method should return a result with zero arguments."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFlag()
		  // Created 8/10/2012 by Andrew Keller
		  
		  // Makes sure the Parse method works correctly when
		  // the parser includes a flag.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  int.AssociateFlagWithArgument "abc", "arg1"
		  
		  Dim rslt As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = int.Parse( NewParser( "app inv str", "--abc" ) )
		  
		  AssertNotIsNil rslt, "The Parse method should never return Nil."
		  
		  AssertEquals "app inv str", rslt.GetAppInvocationString, "The Parse method should return a result with an empty app invocation string."
		  AssertEquals Array( "arg1" ), rslt.ListArguments, "The Parse method should return a result with a list of arguments {'arg1'}."
		  AssertEquals Array( "abc" ), rslt.ListFlagsForArgument( "arg1" ), "The Parse method should return a result with the flags {'abc'} set for the argument 'arg1'."
		  AssertEquals esa, rslt.ListParcelsForArgument( "arg1" ), "The Parse method should return a result with no parcels."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNil()
		  // Created 8/2/2012 by Andrew Keller
		  
		  // Makes sure the Parse method fails correctly if
		  // Nil is passed to the Parse method.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    AssertFailure "The Parse method should raise a NilObjectException when you provide Nil.", _
		    "Expected an exception but found " + ObjectDescriptionKFS( int.Parse( Nil ) ) + "."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestParcel()
		  // Created 8/10/2012 by Andrew Keller
		  
		  // Makes sure the Parse method works correctly when
		  // the parser includes a parcel.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  int.AssociateFlagWithArgument "abc", "arg1"
		  int.AssociateNextNParcelsWithArgument 1, "arg1"
		  
		  Dim rslt As CLIArgsKFS.Interpreter.LinearlyInterpretedResults = int.Parse( NewParser( "app inv str", "--abc", "def" ) )
		  
		  AssertNotIsNil rslt, "The Parse method should never return Nil."
		  
		  AssertEquals "app inv str", rslt.GetAppInvocationString, "The Parse method should return a result with an empty app invocation string."
		  AssertEquals Array( "arg1" ), rslt.ListArguments, "The Parse method should return a result with a list of arguments {'arg1'}."
		  AssertEquals Array( "abc" ), rslt.ListFlagsForArgument( "arg1" ), "The Parse method should return a result with the flags {'abc'} set for the argument 'arg1'."
		  AssertEquals Array( "def" ), rslt.ListParcelsForArgument( "arg1" ), "The Parse method should return a result with the parcels {'def'} set for the argument 'arg1'."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnregisteredFlag()
		  // Created 8/3/2012 by Andrew Keller
		  
		  // Makes sure the Parse method fails correctly when
		  // a flag cannot be mapped to any argument.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    AssertFailure "The Parse method should raise an UnknownFlagException when you provide an unknown flag.", _
		    "Expected an exception but found " + ObjectDescriptionKFS( int.Parse( NewParser( "app inv str", "-a" ) ) ) + "."
		    
		  Catch err As CLIArgsKFS.Interpreter.Err.UnknownFlagException
		    
		    AssertEquals "a", err.OffendingFlag, "The OffendingFlag property of the exception should have been set to 'a'."
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnregisteredParcel()
		  // Created 8/3/2012 by Andrew Keller
		  
		  // Makes sure the Parse method fails correctly when
		  // a parcel cannot be mapped to any argument.
		  
		  Dim int As New CLIArgsKFS.Interpreter.LinearInterpreter
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    AssertFailure "The Parse method should raise an UnknownFlagException when you provide an unexpected parcel.", _
		    "Expected an exception but found " + ObjectDescriptionKFS( int.Parse( NewParser( "app inv str", "p" ) ) ) + "."
		    
		  Catch err As CLIArgsKFS.Interpreter.Err.UnexpectedParcelException
		    
		    AssertEquals "p", err.OffendingParcel, "The OffendingParcel property of the exception should have been set to 'p'."
		    
		  End Try
		  
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


	#tag Property, Flags = &h1
		Protected esa(-1) As String
	#tag EndProperty


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
