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
		Sub MessageChangedHandler(pgd As ProgressDelegateKFS)
		  // Created 8/31/2010 by Andrew Keller
		  
		  // Logs the attributes of the given ProgressDelegateKFS object,
		  // assuming that this method was invoked via a ProgressChanged
		  // event callback through the given ProgressDelegateKFS object.
		  
		  ProgressChangedEventQueue.Append kPGHintMessage
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCallbacks()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Makes sure callbacks work correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  p.AddValueChangedCallback AddressOf ValueChangedHandler
		  p.AddMessageChangedCallback AddressOf MessageChangedHandler
		  
		  AssertZero ProgressChangedEventQueue.Count, "A new ProgressDelegateKFS object with a progress change callback method set should not have invoked the callback method yet."
		  
		  PushMessageStack "Setting the value of the object so that indeterminate becomes False..."
		  p.Value = 0
		  PushMessageStack "The value changed callback should have been invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintValue, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Setting the value again, with no change in the value..."
		  p.Value = 0
		  AssertEquals 0, ProgressChangedEventQueue.Count, "The value was set to the current value, aka the value did not change.  The callback should not have been invoked."
		  PopMessageStack
		  
		  PushMessageStack "Setting the value to a new value..."
		  p.Value = 0.5
		  PushMessageStack "The value changed callback should have been invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintValue, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Setting the indeterminate state to True..."
		  p.IndeterminateValue = True
		  PushMessageStack "The value changed callback should have been invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintValue, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Setting the message..."
		  p.Message = "Hello, World!"
		  PushMessageStack "The message changed callback should have been invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintMessage, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Spawnging a child..."
		  Dim c As ProgressDelegateKFS = p.SpawnChild
		  AssertTrue c.IndeterminateValue, "A freshly spawned child should have an indeterminate value by default."
		  AssertTrue p.IndeterminateValue, "Spawning a child should not cause the indeterminate state to become False."
		  AssertZero ProgressChangedEventQueue.Count, "Spawning a child should not cause an event handler to get invoked."
		  PopMessageStack
		  
		  PushMessageStack "Setting the value of a child..."
		  c.Value = 0.5
		  AssertFalse c.IndeterminateValue, "Setting the value of a child should cause the child to not be indeterminate anymore."
		  AssertFalse p.IndeterminateValue, "Setting the value of a child should cause the parent to not be indeterminate anymore."
		  PushMessageStack "The value changed callback should have been invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintValue, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Destroying a child..."
		  c = Nil
		  PushMessageStack "Should cause the value changed callback to get invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintValue, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  p.Value = 0
		  p.IndeterminateValue = True
		  ProgressChangedEventQueue.Clear
		  
		  PushMessageStack "Creating a child, setting its message, and destroying the child..."
		  p.SpawnChild.Message = "foo bar?"
		  PushMessageStack "Should the value changed callback to get invoked exactly once."
		  AssertEquals 1, ProgressChangedEventQueue.Count
		  AssertEquals kPGHintValue, ProgressChangedEventQueue.Pop
		  PopMessageStack
		  PopMessageStack
		  
		  // done.
		  
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
		  AssertZero p.ExpectedChildCount, "expect no children."
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
		  
		  p.IndeterminateValue = True
		  Dim c As ProgressDelegateKFS = p.SpawnChild
		  AssertTrue p.IndeterminateValue, "Spawning a child should not cause the indeterminate state to become False."
		  
		  c.Value = .5
		  AssertFalse p.IndeterminateValue, "Setting a child's value should cause the indeterminate state to become False."
		  
		  p.IndeterminateValue = False
		  c = Nil
		  AssertFalse p.IndeterminateValue, "Deallocating a child should cause the indeterminate state to become False."
		  
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

	#tag Method, Flags = &h0
		Sub ValueChangedHandler(pgd As ProgressDelegateKFS)
		  // Created 8/31/2010 by Andrew Keller
		  
		  // Logs the attributes of the given ProgressDelegateKFS object,
		  // assuming that this method was invoked via a ProgressChanged
		  // event callback through the given ProgressDelegateKFS object.
		  
		  ProgressChangedEventQueue.Append kPGHintValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ProgressChangedEventQueue As DataChainKFS
	#tag EndProperty


	#tag Constant, Name = kPGHintMessage, Type = String, Dynamic = False, Default = \"Message Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPGHintValue, Type = String, Dynamic = False, Default = \"Value Changed", Scope = Public
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
