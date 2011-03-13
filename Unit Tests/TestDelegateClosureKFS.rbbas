#tag Class
Protected Class TestDelegateClosureKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Setup things so that a test case can run.
		  
		  // Clear the invoked_hooks array:
		  
		  ReDim invoked_hooks( -1 )
		  
		  // Clear the expected_args array:
		  
		  ReDim expected_args( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function MethodIsATestMethod(methodName As String, ByRef isATestMethod As Boolean) As Boolean
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Customizes the selection of the test cases.
		  
		  // Add the hook test cases:
		  
		  If Left( methodName, 3 ) = "th_" Then
		    
		    isATestMethod = Right( methodName, 5 ) <> "_hook"
		    
		    Return True
		    
		  Else
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub VerifyTestCase(testMethodName As String)
		  // Created 3/12/2011 by Andrew Keller
		  
		  // Perform generalized test case verification.
		  
		  // For all the hook test cases, exactly one
		  // hook should have been called, and it should
		  // have the basename of the current test method.
		  
		  If Left( testMethodName, 3 ) = "th_" Then
		    
		    If PresumePositive( invoked_hooks.Ubound+1, "The "+Mid(testMethodName, 4)+" hook was not invoked." ) Then
		      
		      AssertEquals testMethodName + "_hook", Join( invoked_hooks, " & " ), "The "+Mid(testMethodName, 4)+" hook should have been invoked exactly once."
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function LastField(src As String, delimiter As String) As String
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Returns the last field in the given string separated by the given delimiter.
		  
		  Return NthField( src, delimiter, CountFields( src, delimiter ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub PlainMethod()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub th_x_Double_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the x_Double_void closure works.
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_Double( AddressOf th_x_Double_void_hook, 13.7 )
		  
		  expected_args.Append 13.7
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub th_x_Double_void_hook(arg1 As Double)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0).DoubleValue, arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub th_x_Int64_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the x_Int64_void closure works.
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_Int64( AddressOf th_x_Int64_void_hook, 884724 )
		  
		  expected_args.Append 884724
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub th_x_Int64_void_hook(arg1 As Int64)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0).Int64Value, arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub th_x_String_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the x_String_void closure works.
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_String( AddressOf th_x_String_void_hook, "Hello, World!" )
		  
		  expected_args.Append "Hello, World!"
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub th_x_String_void_hook(arg1 As String)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0).StringValue, arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
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


	#tag Property, Flags = &h1
		Protected expected_args() As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected invoked_hooks() As String
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
