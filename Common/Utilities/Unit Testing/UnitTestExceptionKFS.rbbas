#tag Class
Class UnitTestExceptionKFS
Inherits RuntimeException
	#tag Method, Flags = &h1001
		Protected Sub Constructor()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Protected constructor.
		  
		End Sub
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
		  result.myExceptionWasCaught = True
		  result.myException_str = failure
		  result.myException_e = Nil
		  
		  For Each s As String In testClass._AssertionMessageStack
		    result.myMsg.Append s
		  Next
		  If msg <> "" Then result.myMsg.Append msg
		  
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
		  result.myExceptionWasCaught = True
		  result.myException_str = "Expected " + expectedValue.DescriptionKFS + " but found " + foundValue.DescriptionKFS + "."
		  result.myException_e = Nil
		  
		  For Each s As String In testClass._AssertionMessageStack
		    result.myMsg.Append s
		  Next
		  If msg <> "" Then result.myMsg.Append msg
		  
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
		    result.myMsg.Append msg
		    Return result
		    
		  End If
		  
		  result = New UnitTestExceptionKFS
		  
		  result.myAssertionNumber = testClass.AssertionCount
		  result.myExceptionWasCaught = True
		  result.myException_str = ""
		  result.myException_e = e
		  
		  For Each s As String In testClass._AssertionMessageStack
		    result.myMsg.Append s
		  Next
		  If msg <> "" Then result.myMsg.Append msg
		  
		  Return result
		  
		  // done.
		  
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
		    result.myMsg.Append msg
		    Return result
		    
		  End If
		  
		  result = New UnitTestExceptionKFS
		  
		  result.myAssertionNumber = testClass.AssertionCount
		  result.myExceptionWasCaught = False
		  result.myException_str = ""
		  result.myException_e = e
		  
		  For Each s As String In testClass._AssertionMessageStack
		    result.myMsg.Append s
		  Next
		  If msg <> "" Then result.myMsg.Append msg
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Stack() As String()
		  // Created 5/13/2010 by Andrew Keller
		  
		  // Returns the correct stack trace.
		  
		  // This class can be created to wrap another
		  // exception, or it can *be* an exception.
		  // In either case, a single stack trace exists.
		  // This function returns the correct one.
		  
		  If myException_e = Nil Then
		    
		    Return Super.Stack
		    
		  Else
		    
		    Return myException_e.Stack
		    
		  End If
		  
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


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 7/8/2010 by Andrew Keller
			  
			  // Returns the number of assertions that had been
			  // invoked by the time this exception was created.
			  
			  Return myAssertionNumber
			  
			  // done.
			  
			End Get
		#tag EndGetter
		AssertionNumber As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/11/2010 by Andrew Keller
			  
			  // Returns whether the exception was caught
			  
			  Return myExceptionWasCaught
			  
			  // done.
			  
			End Get
		#tag EndGetter
		ExceptionWasCaught As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 7/8/2010 by Andrew Keller
			  
			  // Returns the technical reason why this exception exists.
			  
			  If myException_e = Nil Then
			    
			    Return myException_str
			    
			  Else
			    
			    Dim result As String
			    
			    If ExceptionWasCaught Then
			      
			      result = "An exception of type " + Introspection.GetType( myException_e ).Name + " was caught"
			      
			      If Me.AssertionNumber > 0 Then
			        
			        result = result + " at assertion number " + Str( Me.AssertionNumber )
			        
			      End If
			      
			    Else
			      
			      result = "An uncaught " + Introspection.GetType( myException_e ).Name + " was raised"
			      
			      If Me.AssertionNumber = 0 Then
			        result = result + " sometime before the first assertion"
			        
			      ElseIf Me.AssertionNumber > 0 Then
			        result = result + " sometime after assertion number " + Str( Me.AssertionNumber )
			        
			      End If
			      
			    End If
			    
			    If myException_e.Message = "" Then
			      
			      result = result + "."
			      
			    Else
			      
			      result = result + ": " + myException_e.Message
			      
			    End If
			    
			    Return result
			    
			  End If
			  
			  // done.
			  
			End Get
		#tag EndGetter
		FailureMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 7/8/2010 by Andrew Keller
			  
			  // Returns whether this exception was caused by an assertion
			  // failure (True), or by an uncaught exception (False).
			  
			  Return myException_e = Nil
			  
			  // done.
			  
			End Get
		#tag EndGetter
		IsAFailedAssertion As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 7/8/2010 by Andrew Keller
			  
			  // Renders a human readable summary of why this test failed.
			  
			  Dim result As String
			  
			  If Me.IsAFailedAssertion Then
			    
			    result = Trim( Me.SituationalMessage + EndOfLineKFS + FailureMessage )
			    
			    If Me.AssertionNumber > 0 Then
			      
			      result = result + " (Assertion Number " + Str( Me.AssertionNumber ) + ")"
			      
			    End If
			    
			  Else
			    
			    result = FailureMessage
			    
			    Dim s As String = SituationalMessage
			    If s <> "" Then result = result + EndOfLineKFS + "Current message stack: " + s
			    
			  End If
			  
			  Return result
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Message As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected myAssertionNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExceptionWasCaught As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myException_e As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myException_str As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMsg() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 7/26/2010 by Andrew Keller
			  
			  // Returns the message array, flattened.
			  
			  Dim result, prev As String
			  
			  For Each s As String In myMsg
			    
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
			  
			End Get
		#tag EndGetter
		SituationalMessage As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionNumber"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailureMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsAFailedAssertion"
			Group="Behavior"
			Type="Boolean"
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
			Name="SituationalMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
