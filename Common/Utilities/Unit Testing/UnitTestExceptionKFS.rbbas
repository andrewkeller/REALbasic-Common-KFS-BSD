#tag Class
Class UnitTestExceptionKFS
Inherits RuntimeException
	#tag Method, Flags = &h0
		Function AssertionNumber() As Integer
		  // Created 7/8/2010 by Andrew Keller
		  
		  // Returns the number of assertions that had been
		  // invoked by the time this exception was created.
		  
		  Return myAssertionNumber
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Protected constructor, to prevent any other
		  // classes from creating an instance of this class.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Criteria() As String
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Returns the technical reason why this exception exists.
		  
		  If ScenarioType = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    Return FormatCriteria( ScenarioType, ExceptionClassType, myCriteria, ErrorNumber, AssertionNumber )
		    
		  ElseIf myExceptionObject Is Nil Then
		    
		    Return FormatCriteria( ScenarioType, ExceptionClassType, myCriteria, ErrorNumber, AssertionNumber )
		    
		  Else
		    
		    Return FormatCriteria( ScenarioType, ExceptionClassType, myExceptionObject.Message, ErrorNumber, AssertionNumber )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorNumber() As Integer
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Returns the error number of this exception.
		  
		  If ScenarioType = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    Return 0
		    
		  ElseIf myExceptionObject Is Nil Then
		    
		    Return 0
		    
		  Else
		    
		    Return myExceptionObject.ErrorNumber
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExceptionClassType() As String
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns the class type of this exception.
		  
		  If ScenarioType = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    Return Introspection.GetType( Me ).Name
		    
		  ElseIf myExceptionObject Is Nil Then
		    
		    Return "Nil"
		    
		  Else
		    
		    Return Introspection.GetType( myExceptionObject ).Name
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explanation() As String
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Returns the message array, flattened.
		  
		  Dim result, prev As String
		  
		  For Each s As String In myExplanation
		    
		    If s <> "" Then
		      
		      If Right( prev, 1 ) = "." Then
		        
		        result = result + "  " + s
		        
		      ElseIf Right( prev, 2 ) = ". " Then
		        
		        result = result + " " + s
		        
		      ElseIf Right( prev, 1 ) = "!" Then
		        
		        result = result + "  " + s
		        
		      ElseIf Right( prev, 2 ) = "! " Then
		        
		        result = result + " " + s
		        
		      ElseIf Right( prev, 1 ) = ":" Then
		        
		        result = result + " " + s
		        
		      ElseIf Right( prev, 1 ) = ";" Then
		        
		        result = result + " " + s
		        
		      ElseIf Right( prev, 1 ) = ")" Then
		        
		        result = result + "  " + s
		        
		      ElseIf Right( prev, 2 ) = ") " Then
		        
		        result = result + " " + s
		        
		      Else
		        
		        result = result + s
		        
		      End If
		      
		      prev = s
		      
		    End If
		  Next
		  
		  Return Trim( result )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FormatCriteria(scenario As UnitTestArbiterKFS.UnitTestExceptionScenarios, className As String, raw_criteria As String, errNumber As Integer, assNum As Integer) As String
		  // Created 7/8/2010 by Andrew Keller
		  
		  // Returns the technical reason why this exception exists.
		  
		  If scenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    // This is an assertion failure, so the criteria has already been set.
		    
		    Return raw_criteria
		    
		  Else
		    
		    // This is a failure via another exception.
		    
		    // The criteria is that the other exception exists, and to be helpful, we'll throw in the exception's message, too.
		    
		    Dim result As String
		    
		    If scenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.CaughtException Then
		      
		      result = "An exception of type " + className + " was caught"
		      
		      If assNum > 0 Then
		        
		        result = result + " at assertion number " + Str( assNum )
		        
		      End If
		      
		    Else
		      
		      result = "An uncaught " + className + " was raised"
		      
		      If assNum = 0 Then
		        result = result + " sometime before the first assertion"
		        
		      ElseIf assNum > 0 Then
		        result = result + " sometime after assertion number " + Str( assNum )
		        
		      End If
		      
		    End If
		    
		    If raw_criteria = "" Then
		      
		      result = result + "."
		      
		    Else
		      
		      result = result + ": " + raw_criteria
		      
		    End If
		    
		    Return result
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FormatMessage(scenario As UnitTestArbiterKFS.UnitTestExceptionScenarios, className As String, raw_criteria As String, errNumber As Integer, expln As String, assNum As Integer) As String
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns a summary of the given information.
		  
		  Dim result As String
		  
		  If scenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    result = Trim( expln + EndOfLineKFS + raw_criteria )
		    
		    If assNum > 0 Then
		      
		      result = result + " (Assertion Number " + Str( assNum ) + ")"
		      
		    End If
		    
		  Else
		    
		    result = FormatCriteria( scenario, className, raw_criteria, errNumber, assNum )
		    
		    Dim s As String = expln
		    If s <> "" Then result = result + EndOfLineKFS + "Current message stack: " + s
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetComponentData(ByRef scenario As UnitTestArbiterKFS.UnitTestExceptionScenarios, ByRef className As String, ByRef raw_criteria As String, ByRef errNumber As Integer, ByRef expln As String, ByRef assNum As Integer)
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Returns the uninterpreted component data of this exception through the given parameters.
		  
		  scenario = ScenarioType
		  className = ExceptionClassType
		  errNumber = ErrorNumber
		  expln = Explanation
		  assNum = AssertionNumber
		  
		  If ScenarioType = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    raw_criteria = myCriteria
		    
		  ElseIf myExceptionObject Is Nil Then
		    
		    raw_criteria = myCriteria
		    
		  Else
		    
		    raw_criteria = myExceptionObject.Message
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Renders a human readable summary of why this test failed.
		  
		  If ScenarioType = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    Return FormatMessage( ScenarioType, ExceptionClassType, myCriteria, ErrorNumber, Explanation, AssertionNumber )
		    
		  ElseIf myExceptionObject Is Nil Then
		    
		    Return FormatMessage( ScenarioType, ExceptionClassType, myCriteria, ErrorNumber, Explanation, AssertionNumber )
		    
		  Else
		    
		    Return FormatMessage( ScenarioType, ExceptionClassType, myExceptionObject.Message, ErrorNumber, Explanation, AssertionNumber )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewExceptionFromAssertionFailure(testClass As UnitTestBaseClassKFS, failure As String, msg As String = "") As UnitTestExceptionKFS
		  // Created 5/26/2010 by Andrew Keller
		  
		  // Initializes this exception with the given situational data.
		  
		  // There are 3 general ways that errors occur:
		  //   1) An exception is raised.
		  //   2) An assertion failed (expected x but found y)
		  //   3) Something generally bad happened (just because)
		  
		  // This constructor handles situation 3.
		  
		  Dim result As New UnitTestExceptionKFS
		  
		  result.myAssertionNumber = testClass.AssertionCount
		  result.myCriteria = failure
		  result.myExceptionObject = Nil
		  result.myExceptionScenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure
		  
		  For Each s As String In testClass.AssertionMessageStack
		    result.myExplanation.Append s
		  Next
		  If msg <> "" Then result.myExplanation.Append msg
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewExceptionFromAssertionFailure(testClass As UnitTestBaseClassKFS, expectedValue As Variant, foundValue As Variant, msg As String = "") As UnitTestExceptionKFS
		  // Created 5/26/2010 by Andrew Keller
		  
		  // Initializes this exception with the given situational data.
		  
		  // There are 3 general ways that errors occur:
		  //   1) An exception is raised.
		  //   2) An assertion failed (expected x but found y)
		  //   3) Something generally bad happened (just because)
		  
		  // This constructor handles situation 2.
		  
		  Dim result As New UnitTestExceptionKFS
		  
		  result.myAssertionNumber = testClass.AssertionCount
		  result.myCriteria = "Expected " + expectedValue.DescriptionKFS + " but found " + foundValue.DescriptionKFS + "."
		  result.myExceptionObject = Nil
		  result.myExceptionScenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure
		  
		  For Each s As String In testClass.AssertionMessageStack
		    result.myExplanation.Append s
		  Next
		  If msg <> "" Then result.myExplanation.Append msg
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewExceptionFromException(testClass As UnitTestBaseClassKFS, e As RuntimeException, msg As String = "") As UnitTestExceptionKFS
		  // Created 5/26/2010 by Andrew Keller
		  
		  // Initializes this exception with the given situational data.
		  
		  // There are 3 general ways that errors occur:
		  //   1) An exception is raised.
		  //   2) An assertion failed (expected x but found y)
		  //   3) Something generally bad happened (just because)
		  
		  // This constructor handles situation 1.
		  
		  Dim result As UnitTestExceptionKFS
		  
		  If e IsA UnitTestExceptionKFS Then
		    
		    result = UnitTestExceptionKFS( e )
		    If msg <> "" Then result.myExplanation.Append msg
		    Return result
		    
		  End If
		  
		  result = New UnitTestExceptionKFS
		  
		  result.myAssertionNumber = testClass.AssertionCount
		  result.myCriteria = ""
		  result.myExceptionObject = e
		  result.myExceptionScenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.CaughtException
		  
		  For Each s As String In testClass.AssertionMessageStack
		    result.myExplanation.Append s
		  Next
		  If msg <> "" Then result.myExplanation.Append msg
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewExceptionFromUncaughtException(testClass As UnitTestBaseClassKFS, e As RuntimeException, msg As String = "") As UnitTestExceptionKFS
		  // Created 5/26/2010 by Andrew Keller
		  
		  // Initializes this exception with the given situational data.
		  
		  // There are 3 general ways that errors occur:
		  //   1) An exception is raised.
		  //   2) An assertion failed (expected x but found y)
		  //   3) Something generally bad happened (just because)
		  
		  // This constructor handles situation 1.
		  
		  Dim result As UnitTestExceptionKFS
		  
		  If e IsA UnitTestExceptionKFS Then
		    
		    result = UnitTestExceptionKFS( e )
		    If msg <> "" Then result.myExplanation.Append msg
		    Return result
		    
		  End If
		  
		  result = New UnitTestExceptionKFS
		  
		  result.myAssertionNumber = testClass.AssertionCount
		  result.myCriteria = ""
		  result.myExceptionObject = e
		  result.myExceptionScenario = UnitTestArbiterKFS.UnitTestExceptionScenarios.UncaughtException
		  
		  For Each s As String In testClass.AssertionMessageStack
		    result.myExplanation.Append s
		  Next
		  If msg <> "" Then result.myExplanation.Append msg
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScenarioType() As UnitTestArbiterKFS.UnitTestExceptionScenarios
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Returns the current scenario type.
		  
		  Return myExceptionScenario
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Stack() As String()
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Returns the correct stack trace.
		  
		  // This class can be created to wrap another
		  // exception, or it can *be* an exception.
		  // In either case, a single stack trace exists.
		  // This function returns the correct one.
		  
		  If ScenarioType = UnitTestArbiterKFS.UnitTestExceptionScenarios.AssertionFailure Then
		    
		    Return Super.Stack
		    
		  ElseIf myExceptionObject Is Nil Then
		    
		    Return Super.Stack
		    
		  Else
		    
		    Return myExceptionObject.Stack
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, 2011 Andrew Keller.
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
		Protected myAssertionNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myCriteria As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExceptionObject As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExceptionScenario As UnitTestArbiterKFS.UnitTestExceptionScenarios
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExplanation() As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
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
