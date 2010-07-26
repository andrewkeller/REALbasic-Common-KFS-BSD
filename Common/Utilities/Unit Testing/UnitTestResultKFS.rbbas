#tag Class
Protected Class UnitTestResultKFS
	#tag Method, Flags = &h0
		Sub Constructor(subject As UnitTestBaseClassKFS, topic As Introspection.MethodInfo)
		  // Created 7/26/2010 by Andrew Keller
		  
		  // Executes the given test and stores the results locally.
		  
		  // Setup:
		  
		  TestClassName = subject.GetClassName
		  TestMethodName = topic.Name
		  
		  subject.AssertionCount = 0
		  ReDim subject._AssertionFailureStash( -1 )
		  ReDim subject._AssertionMessageStack( -1 )
		  
		  Dim terminalException As RuntimeException = Nil
		  
		  // Invoke the test method:
		  
		  Dim startTime As Double = Microseconds
		  Try
		    
		    topic.Invoke subject
		    
		  Catch err
		    terminalException = err
		  End Try
		  ElapsedTime = ( Microseconds - startTime ) / 1000000
		  
		  // Gather the results:
		  
		  For Each e As UnitTestExceptionKFS In subject._AssertionFailureStash
		    ExceptionsRaised.Append e
		  Next
		  
		  If terminalException <> Nil Then
		    ExceptionsRaised.Append UnitTestExceptionKFS.NewExceptionFromUncaughtException( subject, terminalException )
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ElapsedTime As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 7/26/2010 by Andrew Keller
			  
			  // Returns the number of exceptions currently store in this object.
			  
			  Return UBound( ExceptionsRaised ) + 1
			  
			  // done.
			  
			End Get
		#tag EndGetter
		ExceptionCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ExceptionsRaised() As UnitTestExceptionKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		TestClassName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TestMethodName As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ElapsedTime"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ExceptionCount"
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
			Name="TestClassName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestMethodName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
