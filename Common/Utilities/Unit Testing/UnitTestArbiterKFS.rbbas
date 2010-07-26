#tag Class
Protected Class UnitTestArbiterKFS
	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Clears the data in this instance.
		  
		  ElapsedTime = 0
		  TestResults = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisplayResultsSummary(displaySuccess As Boolean = False)
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Displays a quick summary of the test results.
		  
		  If displaySuccess Or UBound( GetFailedTestNames ) > -1 Then
		    #if TargetHasGUI then
		      
		      MsgBox ReplaceLineEndings( GetResultsSummary, EndOfLine )
		      
		    #else
		      
		      stderr.WriteLine GetResultsSummary
		      
		    #endif
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteTests(subjects() As UnitTestBaseClassKFS)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects.
		  
		  Dim startTime As Double = Microseconds
		  
		  // Execute the tests
		  
		  If TestResults = Nil Then TestResults = New Dictionary
		  
		  For Each subject As UnitTestBaseClassKFS In subjects
		    
		    For Each item As Introspection.MethodInfo In subject.GetTestMethods
		      
		      TestResults.Value( subject.GetClassName + kClassTestDelimator + item.Name ) = New UnitTestResultKFS( subject, item )
		      
		    Next
		    
		  Next
		  
		  ElapsedTime = ElapsedTime + ( Microseconds - startTime ) / 1000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExecuteTests(ParamArray subjects As UnitTestBaseClassKFS)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects.
		  
		  ExecuteTests subjects
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFailedTestNames(testPool As Dictionary = Nil) As String()
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Returns a list of the names of tests that failed.
		  
		  // If a test pool was not provided, then use the default.
		  
		  If testPool = Nil Then testPool = TestResults
		  
		  Dim result(-1) As String
		  
		  // Search for all failed tests.
		  
		  For Each key As Variant In testPool.Keys
		    
		    If UnitTestResultKFS( testPool.Value( key ) ).ExceptionCount > 0 Then
		      
		      result.Append key
		      
		    End If
		    
		  Next
		  
		  // Return the result.
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResultsSummary() As String
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Generates a quick summary of the test results.
		  
		  Dim testPool As Dictionary = TestResults
		  If testPool = Nil Or testPool.Count = 0 Then Return "Unit Test Results: 0 tests, 0 failures. (0 seconds)"
		  Dim failedTests() As String = GetFailedTestNames( testPool )
		  
		  // Build the message.
		  
		  Dim msg As String = "Unit Test Results: "
		  
		  msg = msg + str( testPool.Count ) + " test"
		  If testPool.Count <> 1 Then msg = msg + "s"
		  msg = msg + ", " + str( failedTests.Ubound +1 ) + " failure"
		  If failedTests.Ubound <> 0 Then msg = msg + "s"
		  msg = msg + " (" + str(ElapsedTime) + " seconds)."
		  
		  For Each test As String In failedTests
		    
		    msg = msg + EndOfLineKFS + EndOfLineKFS + test + ":"
		    
		    If UnitTestResultKFS( testPool.Value( test ) ).ExceptionCount = 1 Then
		      
		      msg = msg + EndOfLineKFS + UnitTestResultKFS( testPool.Value( test ) ).ExceptionsRaised(0).Message
		      
		    Else
		      
		      For Each problem As UnitTestExceptionKFS In UnitTestResultKFS( testPool.Value( test ) ).ExceptionsRaised
		        
		        msg = msg + EndOfLineKFS + EndOfLineKFS + problem.Message
		        
		      Next
		      
		    End If
		    
		  Next
		  
		  // Return the message.
		  
		  Return msg
		  
		  // done.
		  
		End Function
	#tag EndMethod


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


	#tag Property, Flags = &h1
		Protected ElapsedTime As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TestResults As Dictionary
	#tag EndProperty


	#tag Constant, Name = kClassTestDelimator, Type = String, Dynamic = False, Default = \".", Scope = Public
	#tag EndConstant


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
End Class
#tag EndClass
