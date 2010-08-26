#tag Class
Protected Class TestProgressDelegateKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestVeryBasics()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Tests the very basics of the ProgressDelegateKFS class.  No children, no weights.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  PushMessageStack "A new ProgressDelegateKFS object should "
		  
		  AssertEquals -1, p.Children.Ubound, "have no children."
		  AssertTrue p.IndeterminateValue, "have an indeterminate value."
		  AssertEmptyString p.Message, "have an empty string for a message."
		  AssertZero p.OverallValue, "have zero for its overall value."
		  AssertNil p.Parent, "have a Nil parent."
		  AssertEquals 1, p.SegmentCount, "have a SegmentCount of 1."
		  AssertZero p.Value, "have zero for its value."
		  AssertEquals 1, p.Weight, "have a weight of 1."
		  
		  PopMessageStack
		  
		  p.Value = .2
		  AssertEquals .2, p.Value, "Value did not reflect the value provided."
		  AssertFalse p.IndeterminateValue, "Setting the value did not set the indeterminate state to False."
		  AssertEquals .2, p.OverallValue, "OverallValue did not reflect the value that was provided."
		  
		  p.IndeterminateValue = True
		  AssertZero p.Value, "The Value property did not go back to zero when the indeterminate state was set to True."
		  AssertZero p.OverallValue, "The OverallValue property did not go back to zero when the indeterminate state was set to True."
		  
		  p.IndeterminateValue = False
		  AssertEquals .2, p.Value, "Setting the indeterminate state to True is only supposed to make the value look like it became zero.  It should not actually set it to zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
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
