#tag Class
Protected Class TestDelegateClosureKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Setup things so that a test case can run.
		  
		  // Clear the expected_args array:
		  
		  ReDim expected_args( -1 )
		  
		  // Clear the expected_hooks array:
		  
		  ReDim expected_hooks( -1 )
		  
		  // Clear the invoked_hooks array:
		  
		  ReDim invoked_hooks( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub VerifyTestCase(testMethodName As String)
		  // Created 3/12/2011 by Andrew Keller
		  
		  // Perform generalized test case verification.
		  
		  // The expected hooks array should have contents
		  // equal to the invoked hooks array.
		  
		  AssertEquals Join( expected_hooks, " & " ), Join( invoked_hooks, " & " ), "This test case did not cause the expected set of hooks to be invoked."
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub hook_Dictionary_void(arg1 As Dictionary)
		  // Created 3/16/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0), arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hook_Double_void(arg1 As Double)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0), arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hook_Int64_void(arg1 As Int64)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0), arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hook_String_void(arg1 As String)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 1, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  AssertEquals expected_args(0), arg1, "Arg1 has an unexpected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hook_void_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // This is a sample method used as a target for the closures.
		  
		  // First thing's first: record that this method was invoked:
		  
		  invoked_hooks.Append LastField( CurrentMethodName, "." )
		  
		  // Next, verify that the arguments were delivered intact:
		  
		  AssertEquals 0, expected_args.Ubound+1, "An unexpected number of arguments were expected to be expected."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

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
		Sub Test_From_Dictionary_void()
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Makes sure the x_Dictionary_void closure works.
		  
		  Dim dic As New Dictionary
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_From_Dictionary( AddressOf hook_Dictionary_void, dic )
		  
		  expected_args.Append dic
		  expected_hooks.Append "hook_Dictionary_void"
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_From_Double_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the x_Double_void closure works.
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_From_Double( AddressOf hook_Double_void, 13.7 )
		  
		  expected_args.Append 13.7
		  expected_hooks.Append "hook_Double_void"
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_From_Int64_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the x_Int64_void closure works.
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_From_Int64( AddressOf hook_Int64_void, 884724 )
		  
		  expected_args.Append 884724
		  expected_hooks.Append "hook_Int64_void"
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_From_String_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the x_String_void closure works.
		  
		  Dim d As PlainMethod = DelegateClosureKFS.NewClosure_From_String( AddressOf hook_String_void, "Hello, World!" )
		  
		  expected_args.Append "Hello, World!"
		  expected_hooks.Append "hook_String_void"
		  
		  d.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_Thread_From_void_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the Thread_x_void => void_void closure works.
		  
		  Dim d As ThreadMethod = DelegateClosureKFS.NewClosure_Thread_From_void( AddressOf hook_void_void )
		  
		  expected_hooks.Append "hook_void_void"
		  
		  d.Invoke New Thread
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_Timer_From_void_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Makes sure the Timer_x_void => void_void closure works.
		  
		  Dim d As TimerMethod = DelegateClosureKFS.NewClosure_Timer_From_void( AddressOf hook_void_void )
		  
		  expected_hooks.Append "hook_void_void"
		  
		  d.Invoke New Timer
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub ThreadMethod(arg1 As Thread)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub TimerMethod(arg1 As Timer)
	#tag EndDelegateDeclaration


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
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
		Protected expected_hooks() As String
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
