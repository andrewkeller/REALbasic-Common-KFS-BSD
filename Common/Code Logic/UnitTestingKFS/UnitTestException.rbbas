	#tag Class
	Protected Class UnitTestException
	Inherits RuntimeException
		#tag Method, Flags = &h0
			Function Cause() As String
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Returns the cause of this error.
			  
			  Return myCause
			  
			  // done.
			  
			End Function
		#tag EndMethod

		#tag Method, Flags = &h1000
			Sub Constructor(causeMsg As String, failureMsg As String)
			  // Created 5/9/2010 by Andrew Keller
			  
			  // A simple constructor that takes situational data.
			  
			  myCause = causeMsg
			  myMsg = failureMsg
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Function Message() As String
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Returns the message of this error.
			  
			  Return myMsg
			  
			  // done.
			  
			End Function
		#tag EndMethod


		#tag Property, Flags = &h1
			Protected myCause As String
		#tag EndProperty

		#tag Property, Flags = &h1
			Protected myMsg As String
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
