#tag Class
Class UnitTestException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(cause As RuntimeException, failureMsg As String)
		  // Created 5/12/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myCause = ""
		  myException = Nil
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(causeMsg As String, failureMsg As String)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myCause = causeMsg
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
			  
			  If myException = Nil Then
				
				Return myMsg + EndOfLineKFS + myCause
				
			  ElseIf myCause = "" Then
				
				Return myMsg
				
			  Else
				
				Return myMsg + EndOfLineKFS + myException.Message
				
			  End If
			  
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
