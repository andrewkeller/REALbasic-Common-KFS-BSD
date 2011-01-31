#tag Class
Protected Class UnitTestResultKFS
	#tag Method, Flags = &h0
		Sub Constructor(subject As UnitTestBaseClassKFS, topic As Introspection.MethodInfo, doRunTheTest As Boolean = True)
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Executes the given test and stores the results locally.
		  
		  // Setup:
		  
		  ReDim e_ClassSetup( -1 )
		  ReDim e_Core( -1 )
		  ReDim e_Setup( -1 )
		  ReDim e_TearDown( -1 )
		  TestClassName = subject.ClassName
		  TestMethodName = topic.Name
		  t_ClassSetup = New DurationKFS
		  t_Core = New DurationKFS
		  t_Setup = New DurationKFS
		  t_TearDown = New DurationKFS
		  
		  If doRunTheTest Then
		    
		    bSkipped = False
		    
		    subject.Lock.Enter
		    
		    Call GatherExceptions( subject )
		    
		    // Invoke the class setup method:
		    
		    If RunTestClassSetup( subject ) Then
		      
		      // Invoke the test case setup method:
		      
		      If RunTestCaseSetup( subject, topic ) Then
		        
		        // Invoke the test method itself:
		        
		        Call RunTestCase( subject, topic )
		        
		        // Invoke the tear down method:
		        
		        Call RunTestCaseTearDown( subject, topic )
		        
		      End If
		    End If
		    
		    subject.Lock.Leave
		    
		  Else
		    
		    bSkipped = True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GatherExceptions(subject As UnitTestBaseClassKFS, terminalError As RuntimeException = Nil) As UnitTestExceptionKFS()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Gathers the exceptions in the exception stash, and the given uncaught exception
		  // into a single array, and returns it.  Also clears the subject's exception stash.
		  
		  // Assumes the subject is already locked.
		  
		  Dim result() As UnitTestExceptionKFS
		  
		  For Each e As UnitTestExceptionKFS In subject.AssertionFailureStash
		    result.Append e
		  Next
		  
		  If Not ( terminalError Is Nil ) Then
		    result.Append UnitTestExceptionKFS.NewExceptionFromUncaughtException( subject, terminalError )
		  End If
		  
		  ReDim subject.AssertionFailureStash( -1 )
		  ReDim subject.AssertionMessageStack( -1 )
		  subject.AssertionCount = 0
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RunTestCase(subject As UnitTestBaseClassKFS, topic As Introspection.MethodInfo) As Boolean
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Runs the test case and stores the results locally.
		  
		  // Assumes the subject is already locked.
		  
		  Dim terminalException As RuntimeException
		  
		  t_Core.Start
		  Try
		    topic.Invoke subject
		  Catch err
		    terminalException = err
		  End Try
		  t_Core.Stop
		  
		  e_Core = GatherExceptions( subject, terminalException )
		  
		  Return UBound( e_Core ) < 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RunTestCaseSetup(subject As UnitTestBaseClassKFS, topic As Introspection.MethodInfo) As Boolean
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Runs the test case setup method and stores the results locally.
		  
		  // Assumes the subject is already locked.
		  
		  Dim terminalException As RuntimeException
		  
		  t_Setup.Start
		  Try
		    subject.PushMessageStack "While running the test case setup routine: "
		    subject.InvokeTestCaseSetup topic.Name
		  Catch err
		    terminalException = err
		  End Try
		  t_Setup.Stop
		  
		  e_Setup = GatherExceptions( subject, terminalException )
		  
		  Return UBound( e_Setup ) < 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RunTestCaseTearDown(subject As UnitTestBaseClassKFS, topic As Introspection.MethodInfo) As Boolean
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Runs the test case tear down method and stores the results locally.
		  
		  // Assumes the subject is already locked.
		  
		  Dim terminalException As RuntimeException
		  
		  t_TearDown.Start
		  Try
		    subject.PushMessageStack "While running the test case tear down routine: "
		    subject.InvokeTestCaseTearDown topic.Name
		  Catch err
		    terminalException = err
		  End Try
		  t_TearDown.Stop
		  
		  e_TearDown = GatherExceptions( subject, terminalException )
		  
		  Return UBound( e_TearDown ) < 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RunTestClassSetup(subject As UnitTestBaseClassKFS) As Boolean
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Runs the test class setup method and stores the results locally.
		  
		  // Assumes the subject is already locked.
		  
		  Dim terminalException As RuntimeException
		  
		  t_ClassSetup.Start
		  Try
		    subject.PushMessageStack "While running the test class setup routine: "
		    If Not subject.InvokeClassSetup Then t_ClassSetup.Value = 0
		  Catch err
		    terminalException = err
		  End Try
		  t_ClassSetup.Stop
		  
		  e_ClassSetup = GatherExceptions( subject, terminalException )
		  
		  Return UBound( e_ClassSetup ) < 0
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
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
		Protected bSkipped As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		e_ClassSetup() As UnitTestExceptionKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		e_Core() As UnitTestExceptionKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		e_Setup() As UnitTestExceptionKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		e_TearDown() As UnitTestExceptionKFS
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/2/2010 by Andrew Keller
			  
			  // Returns whether or not the this test case is considered failed.
			  
			  If Not bSkipped Then
			    If UBound( e_ClassSetup ) < 0 Then
			      If UBound( e_Setup ) < 0 Then
			        If UBound( e_Core ) < 0 Then
			          If UBound( e_TearDown ) < 0 Then
			            
			            Return False
			            
			          End If
			        End If
			      End If
			    End If
			    
			    Return True
			    
			  End If
			  
			  Return False
			  
			  // done.
			  
			End Get
		#tag EndGetter
		TestCaseFailed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/2/2010 by Andrew Keller
			  
			  // Returns whether or not the this test case is considered passed.
			  
			  If Not bSkipped Then
			    If UBound( e_ClassSetup ) < 0 Then
			      If UBound( e_Setup ) < 0 Then
			        If UBound( e_Core ) < 0 Then
			          If UBound( e_TearDown ) < 0 Then
			            
			            Return True
			            
			          End If
			        End If
			      End If
			    End If
			  End If
			  
			  Return False
			  
			  // done.
			  
			End Get
		#tag EndGetter
		TestCasePassed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/2/2010 by Andrew Keller
			  
			  // Returns whether or not the this test case is considered skipped.
			  
			  Return bSkipped
			  
			  // done.
			  
			End Get
		#tag EndGetter
		TestCaseSkipped As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TestClassName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TestMethodName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		t_ClassSetup As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		t_Core As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		t_Setup As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		t_TearDown As DurationKFS
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
			Name="TestCaseFailed"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestCasePassed"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestCaseSkipped"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestClassName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestMethodName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
