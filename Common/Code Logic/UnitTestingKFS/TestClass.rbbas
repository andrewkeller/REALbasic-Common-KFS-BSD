	#tag Class
	Protected Class TestClass
		#tag Method, Flags = &h0
			Sub AssertEquals(expected As Variant, found As Variant, failureMessage As String = "")
			  // Created 5/10/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given values are not equal.
			  
			  If expected <> found Then Raise New UnitTestException( "Expected " + StrVariant( expected ) + " but found " + StrVariant( found ) + ".", failureMessage )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertFalse(value As Boolean, failureMessage As String = "")
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is true.
			  
			  If value = True Then Raise New UnitTestException( "Expected False but found True.", failureMessage )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertTrue(value As Boolean, failureMessage As String = "")
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is false.
			  
			  If value = False Then Raise New UnitTestException( "Expected True but found False.", failureMessage )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Function GetClassName() As String
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Returns the name of this class.
			  
			  Return Introspection.GetType(Me).Name
			  
			  // done.
			  
			End Function
		#tag EndMethod

		#tag Method, Flags = &h0
			Function GetTestMethods() As Introspection.MethodInfo()
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Returns a list of the test functions in this class.
			  
			  Dim myMethods() As Introspection.MethodInfo = Introspection.GetType(Me).GetMethods
			  
			  For row As Integer = UBound( myMethods ) DownTo 0
				
				If left( myMethods(row).Name, 4 ) <> "Test" Then
				  
				  myMethods.Remove row
				  
				End If
				
			  Next
			  
			  Return myMethods
			  
			  // done.
			  
			End Function
		#tag EndMethod

		#tag Method, Flags = &h21
			Private Function StrVariant(v As Variant) As String
			  // Created 5/12/2010 by Andrew Keller
			  
			  // Returns a textual representation of the given Variant.
			  
			  If v = Nil Then Return "Nil"
			  
			  If v.IsNull Then Return "Null"
			  
			  If v.IsNumeric Then Return v.StringValue
			  
			  Return "'" + v.StringValue + "'"
			  
			  // done.
			  
			End Function
		#tag EndMethod


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
