#tag Class
Class UnitTestExceptionKFS
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(cause As RuntimeException, failureMsg As String, assertionNumber As Integer = 0)
		  // Created 5/12/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myAssertionNumber = assertionNumber
		  myCause = ""
		  myException = cause
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(failureMsg As String, assertionNumber As Integer = 0)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myAssertionNumber = assertionNumber
		  myCause = ""
		  myException = Nil
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(cause As String, failureMsg As String, assertionNumber As Integer = 0)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myAssertionNumber = assertionNumber
		  myCause = cause
		  myException = Nil
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Stack() As String()
		  // Created 5/13/2010 by Andrew Keller
		  
		  // Returns the correct stack trace.
		  
		  // This class can be created to wrap another
		  // exception, or it can *be* an exception.
		  // In either case, a single stack trace exists.
		  // This function returns the correct one.
		  
		  If myException = Nil Then
		    
		    Return Super.Stack
		    
		  Else
		    
		    Return myException.Stack
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected myAssertionNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myCause As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myException As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMsg As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 5/12/2010 by Andrew Keller
			  
			  // Returns a summary of this error.
			  
			  Dim result(2) As String
			  
			  result(0) = myMsg
			  If myAssertionNumber > 0 Then
			    result(1) = Join( Array( myCause, "(Assertion Number " + str(myAssertionNumber) + ")" ), "  " )
			  Else
			    result(1) = myCause
			  End If
			  If myException <> Nil Then result(2) = myException.Message
			  
			  For row As Integer = 2 DownTo 0
			    
			    If result(row) = "" Then result.Remove row
			    
			  Next
			  
			  Return Join( result, EndOfLineKFS )
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Summary As String
	#tag EndComputedProperty


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
			Name="Summary"
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
