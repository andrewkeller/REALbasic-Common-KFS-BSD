#tag Class
Protected Class UnitTestArbiterKFS
Inherits Thread
	#tag Event
		Sub Run()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Invokes the ChewOnQueue method.
		  
		  ChewOnQueue
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub ChewOnQueue()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Runs all the tests in the queue.
		  
		  TestsAreRunning = True
		  RaiseEvent TestRunnerStarting
		  
		  While Not myTestClassQueue.IsEmpty
		    
		    Dim subject As UnitTestBaseClassKFS = myTestClassQueue.Pop
		    
		    If subject <> Nil Then
		      
		      Dim bTestShouldRun As Boolean = True
		      
		      For Each item As Introspection.MethodInfo In subject.GetTestMethods
		        
		        RaiseEvent TestStarting subject.ClassName, item.Name
		        myLock.Enter
		        Dim startTime As Double = Microseconds
		        
		        // Execute the test:
		        Dim r As New UnitTestResultKFS( subject, item, bTestShouldRun )
		        myTestResults.Value( subject.ClassName, item.Name ) = r
		        
		        // Skip the rest of the tests for this test class if the setup method failed:
		        If UBound( r.e_ClassSetup ) >= 0 Or UBound( r.e_Setup ) >= 0 Then bTestShouldRun = False
		        
		        myElapsedTime = myElapsedTime + ( Microseconds - startTime ) / 1000000
		        myLock.Leave
		        RaiseEvent TestFinished r
		        
		      Next
		    End If
		  Wend
		  
		  TestsAreRunning = False
		  RaiseEvent TestRunnerFinished
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Clears the data in this instance.
		  
		  myLock.Enter
		  
		  myElapsedTime = 0
		  myTestClassQueue.Clear
		  myTestResults.Clear
		  
		  myLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Basic constructor.
		  
		  Mode = Modes.Synchronous
		  myElapsedTime = 0
		  myLock = New CriticalSection
		  myTestClassQueue = New DataChainKFS
		  myTestResults = New Dictionary
		  _tasr = 0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountFailedTestCases() As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of failed test cases that are currently logged.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  For Each d As Dictionary In myTestResults.Children
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If r.TestCaseFailed Then
		          
		          result = result + 1
		          
		        End If
		      End If
		    Next
		  Next
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountFailedTestCases(testClassName As String) As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of failed test cases that are currently logged for the given test class.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If r.TestCaseFailed Then
		          
		          result = result + 1
		          
		        End If
		      End If
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountPassedTestCases() As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of passed test cases that are currently logged.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  For Each d As Dictionary In myTestResults.Children
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If r.TestCasePassed Then
		          
		          result = result + 1
		          
		        End If
		      End If
		    Next
		  Next
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountPassedTestCases(testClassName As String) As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of passed test cases that are currently logged for the given test class.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If r.TestCasePassed Then
		          
		          result = result + 1
		          
		        End If
		      End If
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountSkippedTestCases() As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of skipped test cases that are currently logged.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  For Each d As Dictionary In myTestResults.Children
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If r.TestCaseSkipped Then
		          
		          result = result + 1
		          
		        End If
		      End If
		    Next
		  Next
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountSkippedTestCases(testClassName As String) As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of skipped test cases that are currently logged for the given test class.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If r.TestCaseSkipped Then
		          
		          result = result + 1
		          
		        End If
		      End If
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountTestCases() As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of test cases that are currently logged.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  For Each d As Dictionary In myTestResults.Children
		    
		    result = result + d.Count
		    
		  Next
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountTestCases(testClassName As String) As Integer
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the total number of test cases that are currently logged.
		  
		  Dim result As Integer = 0
		  myLock.Enter
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then result = result + d.Count
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayResultsSummary(displaySuccess As Boolean = False)
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Displays a quick summary of the test results.
		  
		  If displaySuccess Or CountFailedTestCases > 0 Then
		    #if TargetHasGUI then
		      
		      MsgBox ReplaceLineEndings( PlaintextReport, EndOfLine )
		      
		    #else
		      
		      stderr.WriteLine PlaintextReport
		      
		    #endif
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteTests(subjects() As UnitTestBaseClassKFS)
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Adds the given test classes to the test queue,
		  // and runs the ChewOnQueue method.
		  
		  For Each subject As UnitTestBaseClassKFS In subjects
		    
		    myTestClassQueue.Append subject
		    
		  Next
		  
		  If Mode = Modes.Synchronous Then
		    
		    ChewOnQueue
		    
		  ElseIf Me.State = Thread.NotRunning Then
		    
		    Me.Run
		    
		  ElseIf Me.State = Thread.Suspended Or Me.State = Thread.Sleeping Then
		    
		    Me.Resume
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteTests(ParamArray subjects As UnitTestBaseClassKFS)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects synchronously.
		  
		  ExecuteTests subjects
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverallElapsedTime() As Double
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the overall elapsed time.
		  
		  Return myElapsedTime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseElapsedTime(testClassName As String, testCaseName As String) As Double
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the elapsed time for the given test case.
		  
		  Return TestCaseElapsedTime( testClassName, testCaseName, False, True, False )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseElapsedTime(testClassName As String, testCaseName As String, includeSetup As Boolean, includeCore As Boolean, includeTearDown As Boolean) As Double
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the elapsed time for the given test case.
		  
		  Dim r As UnitTestResultKFS = TestCaseResultContainer( testClassName, testCaseName )
		  Dim result As Double
		  
		  If r <> Nil Then
		    
		    If includeSetup Then result = result + r.t_Setup
		    
		    If includeCore Then result = result + r.t_Core
		    
		    If includeTearDown Then result = result + r.t_TearDown
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseExceptionMessages(testClassName As String, testCaseName As String) As String()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the list of messages for the exceptions for the given test case.
		  
		  Return TestCaseExceptionMessages( testClassName, testCaseName, False, True, False )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseExceptionMessages(testClassName As String, testCaseName As String, includeSetup As Boolean, includeCore As Boolean, includeTearDown As Boolean) As String()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the list of messages for the exceptions for the given test case.
		  
		  Dim result() As String
		  
		  For Each e As UnitTestExceptionKFS In TestCaseExceptions( testClassName, testCaseName, includeSetup, includeCore, includeTearDown )
		    
		    result.Append e.Message
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseExceptions(testClassName As String, testCaseName As String) As UnitTestExceptionKFS()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the list of exceptions for the given test case.
		  
		  Return TestCaseExceptions( testClassName, testCaseName, False, True, False )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseExceptions(testClassName As String, testCaseName As String, includeSetup As Boolean, includeCore As Boolean, includeTearDown As Boolean) As UnitTestExceptionKFS()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the list of exceptions for the given test case.
		  
		  Dim r As UnitTestResultKFS = TestCaseResultContainer( testClassName, testCaseName )
		  Dim result() As UnitTestExceptionKFS
		  
		  If r <> Nil Then
		    
		    If includeSetup Then
		      For Each e As UnitTestExceptionKFS In r.e_Setup
		        result.Append e
		      Next
		    End If
		    
		    If includeCore Then
		      For Each e As UnitTestExceptionKFS In r.e_Core
		        result.Append e
		      Next
		    End If
		    
		    If includeTearDown Then
		      For Each e As UnitTestExceptionKFS In r.e_TearDown
		        result.Append e
		      Next
		    End If
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseFailed(testClassName As String, testCaseName As String) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns whether or not the given test case failed.
		  
		  Dim r As UnitTestResultKFS = Me.TestCaseResultContainer( testClassName, testCaseName )
		  
		  If r <> Nil Then
		    If r.TestCaseFailed Then
		      Return True
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseNames(testClassName As String) As String()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns a list of all the test case method names currently logged for the given class.
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  Dim result() As String
		  myLock.Enter
		  
		  If d <> Nil Then
		    For Each v As Variant In d.Keys_Filtered( True, False )
		      
		      result.Append v
		      
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCasePassed(testClassName As String, testCaseName As String) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns whether or not the given test case passed.
		  
		  Dim r As UnitTestResultKFS = Me.TestCaseResultContainer( testClassName, testCaseName )
		  
		  If r <> Nil Then
		    If r.TestCasePassed Then
		      Return True
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseResultContainer(testClassName As String, testCaseName As String) As UnitTestResultKFS
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the overall elapsed time.
		  
		  myLock.Enter
		  Dim result As UnitTestResultKFS = myTestResults.Lookup_R( Nil, testClassName, testCaseName )
		  myLock.Leave
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseResultContainers(testClassName As String) As UnitTestResultKFS()
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Returns an array of the result containers for the given test class.
		  
		  Dim result() As UnitTestResultKFS
		  myLock.Enter
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      result.Append v
		      
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestCaseSkipped(testClassName As String, testCaseName As String) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns whether or not the given test case was skipped.
		  
		  Dim r As UnitTestResultKFS = Me.TestCaseResultContainer( testClassName, testCaseName )
		  
		  If r <> Nil Then
		    If r.TestCaseSkipped Then
		      Return True
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestClassElapsedTime(testClassName As String) As Double
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the elapsed time for the given test class.
		  
		  Return TestClassElapsedTime( testClassName, False, True, False )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestClassElapsedTime(testClassName As String, includeSetup As Boolean, includeCore As Boolean, includeTearDown As Boolean) As Double
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the elapsed time for the given test case.
		  
		  Dim result As Double = 0
		  myLock.Enter
		  
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        
		        If includeSetup Then result = result + r.t_Setup
		        
		        If includeCore Then result = result + r.t_Core
		        
		        If includeTearDown Then result = result + r.t_TearDown
		        
		      End If
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestClassNames() As String()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns a list of all the test class names currently logged.
		  
		  Dim result() As String
		  myLock.Enter
		  
		  For Each v As Variant In myTestResults.Keys_Filtered( False, True )
		    
		    result.Append v
		    
		  Next
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestClassSetupElapsedTime(testClassName As String) As Double
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Returns the amount of time it took for the
		  // class setup routine to run for the given class.
		  
		  myLock.Enter
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If UBound( r.e_ClassSetup ) > -1 Then
		          
		          myLock.Leave
		          Return r.t_ClassSetup
		          
		        End If
		      End If
		    Next
		  End If
		  
		  myLock.Leave
		  Return 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestClassSetupExceptions(testClassName As String) As UnitTestExceptionKFS()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns the list of exceptions for the given test class setup event.
		  
		  myLock.Enter
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  Dim result() As UnitTestExceptionKFS
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If UBound( r.e_ClassSetup ) > -1 Then
		          
		          For Each e As UnitTestExceptionKFS In r.e_ClassSetup
		            result.Append e
		          Next
		          
		          Exit
		          
		        End If
		      End If
		    Next
		  End If
		  
		  myLock.Leave
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestClassSetupPassed(testClassName As String) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Returns whether or not the given test class' setup event passed.
		  
		  myLock.Enter
		  Dim d As Dictionary = myTestResults.Lookup( testClassName, Nil )
		  
		  If d <> Nil Then
		    For Each v As Variant In d.NonChildren
		      
		      Dim r As UnitTestResultKFS = v
		      
		      If r <> Nil Then
		        If UBound( r.e_ClassSetup ) > -1 Then
		          
		          myLock.Leave
		          Return False
		          
		        End If
		      End If
		    Next
		    
		    myLock.Leave
		    Return True
		    
		  End If
		  
		  myLock.Leave
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestsAreRunning() As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Tells whether or not tests are still running.
		  
		  Return _tasr > 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TestsAreRunning(Assigns newValue As Boolean)
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Sets whether or not tests are still running.
		  
		  If newValue = True Then
		    
		    _tasr = _tasr + 1
		    
		  Else
		    
		    _tasr = _tasr - 1
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event TestFinished(testCaseObject As UnitTestResultKFS)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestRunnerFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestRunnerStarting()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestStarting(testClassName As String, testCaseName As String)
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
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


	#tag Property, Flags = &h0
		Mode As Modes
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myElapsedTime As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTestClassQueue As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTestResults As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/2/2010 by Andrew Keller
			  
			  // Returns a simple heading describing the results of the current tests.
			  
			  Dim result As String
			  Dim i As Integer
			  Dim d As Double
			  
			  If TestsAreRunning Then
			    result = "Unit test results so far: "
			  Else
			    result = "Unit test results: "
			  End If
			  
			  i = CountTestCases
			  result = result + str( i ) + " test"
			  If i <> 1 Then result = result + "s"
			  
			  If i > 0 Then
			    
			    i = CountSkippedTestCases
			    If i <> 0 Then
			      result = result + ", " + str( i ) + " skipped"
			    End If
			    
			    i = CountFailedTestCases
			    result = result + ", " + str( i ) + " failure"
			    If i <> 1 Then result = result + "s"
			    
			    d = OverallElapsedTime
			    result = result + ", " + str( d ) + " second"
			    If d <> 1 Then result = result + "s"
			    
			  End If
			  result = result + "."
			  
			  Return result
			  
			  // done.
			  
			End Get
		#tag EndGetter
		PlaintextHeading As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 5/10/2010 by Andrew Keller
			  
			  // Generates a quick summary of the test results.
			  
			  Dim msg(), testDesc As String
			  msg.Append Me.PlaintextHeading
			  
			  For Each tClass As String In TestClassNames
			    For Each tCase As String In TestCaseNames( tClass )
			      
			      Dim r As UnitTestResultKFS = TestCaseResultContainer( tClass, tCase )
			      
			      If r <> Nil Then
			        If r.TestCaseFailed Then
			          
			          testDesc = tClass + kClassTestDelimator + tCase
			          
			          If UBound( r.e_ClassSetup ) = 0 Then
			            msg.Append testDesc + " (Class Setup):" + EndOfLineKFS + r.e_ClassSetup(0).Message
			          ElseIf UBound( r.e_ClassSetup ) > 0 Then
			            msg.Append testDesc + " (Class Setup):"
			            For Each e As UnitTestExceptionKFS In r.e_ClassSetup
			              msg.Append e.Message
			            Next
			          End If
			          
			          If UBound( r.e_Setup ) = 0 Then
			            msg.Append testDesc + " (Setup):" + EndOfLineKFS + r.e_Setup(0).Message
			          ElseIf UBound( r.e_Setup ) > 0 Then
			            msg.Append testDesc + " (Setup):"
			            For Each e As UnitTestExceptionKFS In r.e_Setup
			              msg.Append e.Message
			            Next
			          End If
			          
			          If UBound( r.e_Core ) = 0 Then
			            msg.Append testDesc + ":" + EndOfLineKFS + r.e_Core(0).Message
			          ElseIf UBound( r.e_Core ) > 0 Then
			            msg.Append testDesc + ":"
			            For Each e As UnitTestExceptionKFS In r.e_Core
			              msg.Append e.Message
			            Next
			          End If
			          
			          If UBound( r.e_TearDown ) = 0 Then
			            msg.Append testDesc + " (Tear Down):" + EndOfLineKFS + r.e_TearDown(0).Message
			          ElseIf UBound( r.e_TearDown ) > 0 Then
			            msg.Append testDesc + " (Tear Down):"
			            For Each e As UnitTestExceptionKFS In r.e_TearDown
			              msg.Append e.Message
			            Next
			          End If
			          
			        End If
			      End If
			    Next
			  Next
			  
			  // Return the message.
			  
			  Return Join( msg, EndOfLineKFS + EndOfLineKFS )
			  
			  // done.
			  
			End Get
		#tag EndGetter
		PlaintextReport As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private _tasr As Integer
	#tag EndProperty


	#tag Constant, Name = kClassTestDelimator, Type = String, Dynamic = False, Default = \".", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Modes, Type = Integer, Flags = &h0
		Synchronous
		Asynchronous
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
