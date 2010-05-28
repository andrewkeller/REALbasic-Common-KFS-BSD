	#tag Class
	Protected Class TestClass
		#tag Method, Flags = &h0
			Sub AssertEquals(expected As Variant, found As Variant, failureMessage As String = "")
			  // Created 5/10/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given values are not equal.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If expected <> found Then Raise New UnitTestException( "Expected " + StrVariant( expected ) + " but found " + StrVariant( found ) + ".", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertFailure(failureMessage As String = "")
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Raises a UnitTestException manually.
			  
			  AssertionCount = AssertionCount + 1
			  
			  Raise New UnitTestException( "Unit test declared a failure.", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertFalse(value As Boolean, failureMessage As String = "")
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is true.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value = True Then Raise New UnitTestException( "Expected False but found True.", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertNegative(value As Integer, failureMessage As String = "")
			  // Created 5/27/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is non-negative.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value >= 0 Then Raise New UnitTestException( "Expected negative but found " + str( value ) + ".", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertNonNegative(value As Integer, failureMessage As String = "")
			  // Created 5/27/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is negative.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value < 0 Then Raise New UnitTestException( "Expected non-negative but found " + str( value ) + ".", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertNonPositive(value As Integer, failureMessage As String = "")
			  // Created 5/27/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is positive.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value > 0 Then Raise New UnitTestException( "Expected non-positive but found " + str( value ) + ".", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertNonZero(value As Integer, failureMessage As String = "")
			  // Created 5/27/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is zero.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value = 0 Then Raise New UnitTestException( "Expected non-zero but found zero.", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertPositive(value As Integer, failureMessage As String = "")
			  // Created 5/27/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is non-positive.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value <= 0 Then Raise New UnitTestException( "Expected positive but found " + str( value ) + ".", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertTrue(value As Boolean, failureMessage As String = "")
			  // Created 5/9/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is false.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value = False Then Raise New UnitTestException( "Expected True but found False.", failureMessage, AssertionCount )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub AssertZero(value As Integer, failureMessage As String = "")
			  // Created 5/27/2010 by Andrew Keller
			  
			  // Raises a UnitTestException if the given value is non-zero.
			  
			  AssertionCount = AssertionCount + 1
			  
			  If value <> 0 Then Raise New UnitTestException( "Expected zero but found " + str( value ) + ".", failureMessage, AssertionCount )
			  
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
			  
			  Return "'" + v + "'"
			  
			  // done.
			  
			End Function
		#tag EndMethod


		#tag Property, Flags = &h0
			AssertionCount As Integer
		#tag EndProperty


		#tag ViewBehavior
			#tag ViewProperty
				Name="AssertionCount"
				Group="Behavior"
				Type="Integer"
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
