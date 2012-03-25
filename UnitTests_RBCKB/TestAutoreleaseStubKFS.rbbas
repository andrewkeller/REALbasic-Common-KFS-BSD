#tag Class
Protected Class TestAutoreleaseStubKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Setup things so that a test case can run.
		  
		  // Clear the expected_hooks array:
		  
		  ReDim expected_hooks( -1 )
		  
		  // Clear the invoked_hooks array:
		  
		  ReDim invoked_hooks( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub VerifyTestCase(testMethodName As String)
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Perform generalized test case verification.
		  
		  // The expected hooks array should have contents
		  // equal to the invoked hooks array.
		  
		  AssertEquals Join( expected_hooks, " & " ), Join( invoked_hooks, " & " ), "This test case did not cause the expected set of hooks to be invoked."
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub StringMethodHook(arg As String)
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Acts as a method that can get called.
		  
		  // Record that this method was invoked:
		  
		  invoked_hooks.Append arg
		  
		  // Cause some trouble?
		  
		  If InStr( arg, "error" ) > 0 Then
		    
		    #pragma BreakOnExceptions Off
		    
		    Raise New NilObjectException
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddHook()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that delegates can be added to an
		  // AutoreleaseStubKFS object and that they get invoked.
		  
		  Dim s As New AutoreleaseStubKFS
		  
		  s.Add ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test1" )
		  expected_hooks.Append "Test1"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddHook_Const()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that the constructor accepts
		  // a delegate and that it gets invoked.
		  
		  Dim s As New AutoreleaseStubKFS( ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test1" ) )
		  expected_hooks.Append "Test1"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddHook_Multiples()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that the constructor accepts
		  // a delegate, and the Add method also
		  // works, and that they all get invoked.
		  
		  Dim s As New AutoreleaseStubKFS( ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test1" ) )
		  expected_hooks.Append "Test1"
		  
		  s.Add ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test2" )
		  expected_hooks.Append "Test2"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCancel()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that the Cancel method works.
		  
		  Dim s As New AutoreleaseStubKFS
		  
		  s.Add ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test1" )
		  
		  s.Cancel
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDefaultState()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that the default state of the
		  // AutoreleaseStubKFS class works as expected.
		  
		  Dim s As New AutoreleaseStubKFS
		  
		  AssertTrue s.Enabled, "The Enabled property should be True by default."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEnabled()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that the Enabled property has an effect.
		  
		  Dim s As New AutoreleaseStubKFS
		  
		  s.Add ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test1" )
		  
		  AssertTrue s.Enabled, "The Enabled property did not start out at True."
		  
		  s.Enabled = False
		  
		  AssertFalse s.Enabled, "The Enabled property did not change to False."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInvokeAll()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Makes sure that the InvokeAll method works.
		  
		  Dim s As New AutoreleaseStubKFS
		  
		  s.Add ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test1" )
		  s.Add ClosuresKFS.NewClosure_From_String( AddressOf StringMethodHook, "Test2" )
		  
		  expected_hooks.Append "Test1"
		  expected_hooks.Append "Test2"
		  expected_hooks.Append "Test1"
		  expected_hooks.Append "Test2"
		  
		  s.InvokeAll
		  
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
		
		Copyright (c) 2010, 2011 Andrew Keller.
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


	#tag Property, Flags = &h0
		expected_hooks() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		invoked_hooks() As String
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
