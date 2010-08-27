#tag Class
Protected Class TestProgressDelegateKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub AfterTestCase(methodName As String)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Clear ProgressChangedEventQueue:
		  
		  ProgressChangedEventQueue.Clear
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Initialize ProgressChangedEventQueue:
		  
		  ProgressChangedEventQueue = New DataChainKFS
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ProgressChangedEventLogger(pgd As ProgressDelegateKFS, valueChanged As Boolean, messageChanged As Boolean, stackChanged As Boolean)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Logs the attributes of the given ProgressDelegateKFS object,
		  // assuming that this method was invoked via a ProgressChanged
		  // event callback through the given ProgressDelegateKFS object.
		  
		  ProgressChangedEventQueue.Append New Dictionary( _
		  kPGHintValueChanged : valueChanged, _
		  kPGHintMessageChanged : messageChanged, _
		  kPGHintStackChanged : stackChanged )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCallbacks()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Makes sure callbacks work correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  p.AddProgressChangeEventCallback AddressOf ProgressChangedEventLogger
		  
		  AssertZero ProgressChangedEventQueue.Count, "A new ProgressDelegateKFS object with a progress change callback method set should not have invoked the callback method yet."
		  
		  p.Value = 0
		  
		  AssertEquals 1, ProgressChangedEventQueue.Count, "Setting the value of the object should have invoked the callback method exactly once."
		  Dim d As Dictionary = ProgressChangedEventQueue.Pop
		  AssertTrue d.Value( kPGHintValueChanged ), "Setting the value of the object should have resulted in a value changed hint."
		  AssertFalse d.Value( kPGHintMessageChanged ), "Setting the value of the object should not have resulted in a message changed hint."
		  AssertFalse d.Value( kPGHintStackChanged ), "Setting the value of the object should not have resulted in a stack changed hint."
		  
		  p.Value = 0
		  
		  AssertEquals 0, ProgressChangedEventQueue.Count, "The value was set to the current value, aka the value did not change.  The callback should not have been invoked."
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOutOfBoundsValues()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Makes sure ProgressDelegateKFS sanitizes input data correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  p.Value = -2
		  AssertZero p.Value, "The Value property did not sanitize values below zero."
		  
		  p.Value = 1.8
		  AssertEquals 1, p.Value, "The Value property did not sanitize values above one."
		  
		  p.Weight = -4
		  AssertZero p.Weight, "The Weight property did not sanitize values below zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnweightedMath()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Makes sure math with children works with the default weights.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim c() As ProgressDelegateKFS
		  c.Append p.SpawnChild
		  c.Append p.SpawnChild
		  c.Append p.SpawnChild
		  c.Append p.SpawnChild
		  
		  AssertZero p.Value, "The value did not start out at zero."
		  AssertZero p.OverallValue, "The overall value should be zero when starting with a bunch of new children."
		  
		  c(0).Value = .5
		  
		  AssertZero p.Value, "Modifying a child's value should not modify the parent's value (2)."
		  AssertEquals 1/8, p.OverallValue, "The parent's overall value did not change as expected (2)."
		  
		  c(1).Value = .5
		  
		  AssertZero p.Value, "Modifying a child's value should not modify the parent's value (3)."
		  AssertEquals 1/4, p.OverallValue, "The parent's overall value did not change as expected (3)."
		  
		  c(0) = Nil
		  
		  AssertEquals 0.25, p.Value, "Deallocating a child should cause the value of the parent to increment (4)."
		  AssertEquals 3/8, p.OverallValue, "The parent's overall value did not change as expected (4)."
		  
		  c(1) = Nil
		  
		  AssertEquals 0.5, p.Value, "Deallocating a child should cause the value of the parent to increment (5)."
		  AssertEquals 0.5, p.OverallValue, "The parent's overall value did not change as expected (5)."
		  
		  c(0) = c(2).SpawnChild
		  c(1) = c(2).SpawnChild
		  
		  AssertEquals 0.5, p.Value, "Adding another child should not cause the value to change (6)."
		  AssertEquals 0.5, p.OverallValue, "Adding another child should not cause the overall value to change (6)."
		  
		  c(0).Value = .5
		  
		  AssertEquals 0.5, p.Value, "Modifying a child's value should not modify the parent's value (7)."
		  AssertEquals 0.5+1/16, p.OverallValue, "The parent's overall value did not change as expected (7)."
		  
		  c(2) = Nil
		  
		  AssertEquals 0.5, p.Value, "Since ProgressDelegateKFS trees are downlinked, dropping c(2) should not have caused the value to change."
		  AssertEquals 0.5+1/16, p.OverallValue, "Since ProgressDelegateKFS trees are downlinked, dropping c(2) should not have caused the overall value to change."
		  
		  c(1) = Nil
		  
		  AssertEquals 0.5, p.Value, "Dropping c(1) should not have changed the root value."
		  AssertEquals 0.5+3/16, p.OverallValue, "Dropping c(1) should have bumped up the overall value a bit."
		  
		  c(0) = Nil
		  
		  AssertEquals 3/4, p.Value, "Dropping c(0) should have caused a cascade down to the parent, incrementing its value."
		  AssertEquals 3/4, p.OverallValue, "Dropping c(0) should have bumped up the overall value a bit."
		  
		  c(3) = Nil
		  
		  AssertEquals 1, p.Value, "Dropping the last child should have caused the root node to get a value of 1."
		  AssertEquals 1, p.OverallValue, "Dropping the last child should have caused the root node to get a overall value of 1."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

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
		  AssertZero p.SegmentCount, "have a SegmentCount of 1."
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

	#tag Method, Flags = &h0
		Sub TestWeightedMath()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Makes sure math with children works with modified weights.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim c() As ProgressDelegateKFS
		  c.Append p.SpawnChild
		  c.Append p.SpawnChild
		  c.Append p.SpawnChild
		  
		  AssertZero p.Value, "The value did not start out at zero."
		  AssertZero p.OverallValue, "The overall value should be zero when starting with a bunch of new children."
		  
		  c(1).Weight = 2
		  c(0).Value = 0
		  
		  AssertZero p.Value, "Modifying a child's value should not modify the parent's value (2)."
		  
		  c(0).Value = 1
		  
		  AssertZero p.Value, "Modifying a child's value should not modify the parent's value (3)."
		  AssertEquals 1/4, p.OverallValue, "The parent's overall value did not change as expected (3)."
		  
		  c(0).Value = 0
		  c(1).Value = 1
		  
		  AssertZero p.Value, "Modifying a child's value should not modify the parent's value (4)."
		  AssertEquals 1/2, p.OverallValue, "The parent's overall value did not change as expected (4)."
		  
		  c(1).Value = 0
		  c(2).Value = 1
		  
		  AssertZero p.Value, "Modifying a child's value should not modify the parent's value (5)."
		  AssertEquals 1/4, p.OverallValue, "The parent's overall value did not change as expected (5)."
		  
		  c(0) = Nil
		  
		  AssertEquals 1/4, p.Value, "Destroying a child did not add to the parent as expected (6)."
		  AssertEquals 1/2, p.OverallValue, "The parent's overall value did not change as expected (6)."
		  
		  c(1) = Nil
		  
		  AssertEquals 3/4, p.Value, "Destroying a child did not add to the parent as expected (7)."
		  AssertEquals 1, p.OverallValue, "The parent's overall value did not change as expected (7)."
		  
		  c(2) = Nil
		  
		  AssertEquals 1, p.Value, "Destroying a child did not add to the parent as expected (8)."
		  AssertEquals 1, p.OverallValue, "The parent's overall value did not change as expected (8)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ProgressChangedEventQueue As DataChainKFS
	#tag EndProperty


	#tag Constant, Name = kPGHintMessageChanged, Type = String, Dynamic = False, Default = \"msg_changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPGHintStackChanged, Type = String, Dynamic = False, Default = \"stack_changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPGHintValueChanged, Type = String, Dynamic = False, Default = \"value_changed", Scope = Public
	#tag EndConstant


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
