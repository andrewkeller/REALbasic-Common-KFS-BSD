#tag Module
Protected Module UnitTestGlobalsKFS
	#tag Method, Flags = &h21
		Private Function DefaultTests() As UnitTestBaseClassKFS()
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns a list of the classes with test cases.
		  
		  Dim result() As UnitTestBaseClassKFS
		  
		  result.Append New TestHierarchalDictionaryFunctionsKFS
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DisplayResultsSummary(quietIfOkay As Boolean = True)
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Displays a quick summary of the test results.
		  
		  If Not quietIfOkay Or UBound( GetFailedTestNames ) > -1 Then
		    #if TargetHasGUI then
		      
		      MsgBox GetResultsSummary
		      
		    #else
		      
		      stderr.WriteLine GetResultsSummary
		      
		    #endif
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExecuteTest(subject As UnitTestBaseClassKFS, topic As Introspection.MethodInfo) As RuntimeException
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Executes tests in the given test class and returns any error that occurs.
		  
		  Try
		    
		    subject.AssertionCount = 0
		    
		    topic.Invoke subject
		    
		  Catch err
		    
		    If err IsA UnitTestExceptionKFS Then
		      
		      Return err
		      
		    Else
		      
		      Return New UnitTestExceptionKFS( err, "The test encountered an internal error.", subject.AssertionCount )
		      
		    End If
		    
		  End Try
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecuteTests(subjects() As UnitTestBaseClassKFS)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects.
		  
		  Dim startTime As Double = Microseconds
		  
		  If UBound( subjects ) < 0 Then
		    
		    // No objects were provided, so inject the list
		    // of objects for the testing of this library.
		    
		    subjects = DefaultTests
		    
		  End If
		  
		  // Execute the tests
		  
		  If TestResults = Nil Then TestResults = New Dictionary
		  
		  For Each subject As UnitTestBaseClassKFS In subjects
		    
		    For Each item As Introspection.MethodInfo In subject.GetTestMethods
		      
		      TestResults.Value( subject.GetClassName + "#" + item.Name ) = ExecuteTest( subject, item )
		      
		    Next
		    
		  Next
		  
		  ElapsedTime = ElapsedTime + ( Microseconds - startTime ) / 1000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecuteTests(ParamArray subjects As UnitTestBaseClassKFS)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects.
		  
		  ExecuteTests subjects
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetFailedTestNames(testPool As Dictionary = Nil) As String()
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Returns a list of the names of tests that failed.
		  
		  // If a test pool was not provided, then use the default.
		  
		  If testPool = Nil Then testPool = TestResults
		  
		  Dim result(-1) As String
		  
		  // Search for all failed tests.
		  
		  For Each key As Variant In testPool.Keys
		    
		    If testPool.Value( key ) <> Nil Then
		      
		      result.Append key
		      
		    End If
		    
		  Next
		  
		  // Return the result.
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultsSummary(testPool As Dictionary = Nil) As String
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Generates a quick summary of the test results.
		  
		  // If a test pool was not provided, then use the default.
		  
		  If testPool = Nil Then testPool = TestResults
		  If testPool = Nil Or testPool.Count = 0 Then Return "Unit Test Results: 0 tests, 0 failures."
		  Dim failedTests() As String = GetFailedTestNames( testPool )
		  
		  // Build the message.
		  
		  Dim msg As String = "Unit Test Results: "
		  
		  msg = msg + str( testPool.Count ) + " test"
		  If testPool.Count <> 1 Then msg = msg + "s"
		  msg = msg + ", " + str( failedTests.Ubound +1 ) + " failure"
		  If failedTests.Ubound <> 0 Then msg = msg + "s"
		  msg = msg + "."
		  
		  For Each test As String In failedTests
		    
		    msg = msg + EndOfLine + EndOfLine + test + ":" + EndOfLine + UnitTestExceptionKFS( testPool.Value( test ) ).Summary
		    
		  Next
		  
		  // Return the message.
		  
		  Return msg
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected ElapsedTime As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TestResults As Dictionary
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
