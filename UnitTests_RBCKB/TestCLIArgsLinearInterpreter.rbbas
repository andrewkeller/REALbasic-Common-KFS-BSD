#tag Class
Protected Class TestCLIArgsLinearInterpreter
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Function NewParser(ParamArray args As String) As CLIArgsKFS.Parser.ArgParser
		  // Created 8/3/2012 by Andrew Keller
		  
		  // Returns an argument parser that runs through the given arguments.
		  
		  Return New CLIArgsKFS.Parser.PosixArgParser( args )
		  
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
