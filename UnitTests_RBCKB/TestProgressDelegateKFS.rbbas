#tag Class
Protected Class TestProgressDelegateKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub TestBasicChildrenDeallocation()
		  // Created 7/18/2011 by Andrew Keller
		  
		  // Make sure that children get deallocated correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  AssertZero p.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		  AssertZero UBound( p.Children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		  
		  AssertNoIssuesYet
		  
		  Dim c As ProgressDelegateKFS = p.SpawnChild
		  
		  AssertNotIsNil c, "SpawnChild should never return Nil.", False
		  AssertEquals 1, p.ChildCount, "Spawning a child should result in a ChildCount of 1.", False
		  Dim children() As ProgressDelegateKFS = p.Children
		  If PresumeEquals( 1, UBound( children ) +1, "Spawning a child should result in exactly one child." ) Then AssertSame c, children(0), "The new child does not equal the spawned child.", False
		  ReDim children( -1 )
		  
		  AssertNoIssuesYet
		  
		  c = Nil
		  
		  AssertZero p.ChildCount, "The last reference to the child was lost, but the parent still registers a ChildCount of non-zero.", False
		  AssertZero UBound( p.Children ) +1, "The last reference to the child was lost, but the parent still registers the child.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDefaultValues()
		  // Created 7/18/2011 by Andrew Keller
		  
		  // Makes sure that the default values are correct.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  AssertZero p.ChildCount, "ChildCount should start out at zero."
		  
		  Dim children() As ProgressDelegateKFS = p.Children
		  If PresumeNotIsNil( children, "Children should never return Nil." ) Then AssertZero children.Ubound +1, "The Children array should contain no items.", False
		  
		  Dim frequency As DurationKFS = p.Frequency
		  If PresumeNotIsNil( frequency, "Frequency should never return Nil." ) Then AssertEquals 0.5, frequency.Value, "The default Frequency should be 0.5 seconds.", False
		  
		  AssertTrue p.Indeterminate, "Indeterminate should be True by default.", False
		  
		  AssertEmptyString p.Message, "The Message should be an empty string by default.", False
		  
		  AssertIsNil p.Parent, "The Parent should be Nil by default.", False
		  
		  AssertFalse p.ShouldAutoUpdateObject( Nil ), "ShouldAutoUpdateObject should never return True for Nil.", False
		  
		  AssertFalse p.ShouldInvokeMessageChangedCallback( Nil ), "ShouldInvokeMessageChangedCallback should never return True for Nil.", False
		  
		  AssertFalse p.ShouldInvokeValueChangedCallback( Nil ), "ShouldInvokeValueChangedCallback should never return True for Nil.", False
		  
		  AssertFalse p.SigCancel, "SigCancel should be False by default.", False
		  
		  AssertFalse p.SigKill, "SigKill should be False by default.", False
		  
		  AssertEquals ProgressDelegateKFS.Signals.Normal, p.Signal, "The default signal should be Signals.Normal.", False
		  
		  AssertTrue p.SigNormal, "SigNormal should be True by default.", False
		  
		  AssertFalse p.SigPause, "SigPause should be False by default.", False
		  
		  // SpawnChild is tested in a different test case.
		  
		  AssertZero p.TotalWeightOfChildren, "The TotalWeightOfChildren property should be zero by default.", False
		  
		  AssertZero p.Value, "The default Value should be zero.", False
		  
		  AssertEquals 1, p.Weight, "The default Weight should be one.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIndeterminate()
		  // Created 9/1/2010 by Andrew Keller
		  
		  // Makes sure the Indeterminate logic works as expected.
		  
		  Dim p As New ProgressDelegateKFS
		  AssertTrue p.Indeterminate(False), "A new ProgressDelegateKFS object should have an indeterminate value."
		  
		  p.Message = "Hello, World!"
		  AssertTrue p.Indeterminate(False), "Setting the message should not cause the indeterminate state to become False."
		  
		  p.Weight = 12
		  AssertTrue p.Indeterminate(False), "Setting the weight should not cause the indeterminate state to become False."
		  
		  p.TotalWeightOfChildren = 4
		  AssertTrue p.Indeterminate(False), "Setting the expected child count should not cause the indeterminate state to become False."
		  
		  Dim c As ProgressDelegateKFS = p.SpawnChild
		  AssertTrue p.Indeterminate(False), "Spawning a child should not cause the indeterminate state to become False."
		  
		  c.Message = "Hello, World!"
		  AssertTrue c.Indeterminate(False), "Setting the message should not cause the indeterminate state to become False."
		  
		  c.Weight = 2
		  AssertTrue p.Indeterminate(False), "Setting the weight should not cause the indeterminate state to become False."
		  
		  p.TotalWeightOfChildren = 4
		  AssertTrue p.Indeterminate(False), "Setting the expected child count should not cause the indeterminate state to become False."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOutOfBoundsValues()
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Makes sure ProgressDelegateKFS sanitizes input data correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  p.Value = -2
		  AssertZero p.Value(False), "The Value property did not sanitize values below zero.", False
		  
		  p.Value = 1.8
		  AssertEquals 1, p.Value(False), "The Value property did not sanitize values above one.", False
		  
		  p.Weight = -4
		  AssertZero p.Weight, "The Weight property did not sanitize values below zero.", False
		  
		  p.Weight = 5
		  AssertEquals 5, p.Weight, "5 should be a valid value for the Weight property.", False
		  
		  p.Weight = 99999
		  AssertEquals 99999, p.Weight, "99999 should be a valid value for the Weight property.", False
		  
		  p.TotalWeightOfChildren = -4
		  AssertZero p.TotalWeightOfChildren, "The TotalWeightOfChildren property did not sanitize values below zero.", False
		  
		  p.Frequency = New DurationKFS(0)
		  Dim f As DurationKFS = p.Frequency
		  If PresumeNotIsNil( f, "The Frequency property should never return Nil." ) Then AssertEquals _
		  DurationKFS.NewFromValue( 1, DurationKFS.kMilliseconds ).MicrosecondsValue, _
		  f.MicrosecondsValue, _
		  "The Frequency property should have a minimum value of 1 millisecond.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTotalWeightOfChildren()
		  // Created 9/1/2010 by Andrew Keller
		  
		  // Makes sure the TotalWeightOfChildren property works correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals 0, p.TotalWeightOfChildren, "The TotalWeightOfChildren property should be zero by default (0)."
		  
		  Dim c1 As ProgressDelegateKFS = p.SpawnChild
		  
		  AssertNotIsNil c1, "The SpawnChild function should never return Nil (1)."
		  AssertEquals 1, p.TotalWeightOfChildren, "Adding a child should cause the TotalWeightOfChildrent to increment (1)."
		  AssertEquals 0, c1.TotalWeightOfChildren, "The TotalWeightOfChildren property should be zero by default (1)."
		  
		  Dim c2 As ProgressDelegateKFS = p.SpawnChild
		  
		  AssertNotIsNil c2, "The SpawnChild function should never return Nil (2)."
		  AssertEquals 2, p.TotalWeightOfChildren, "Adding a child should cause the TotalWeightOfChildrent to increment (2)."
		  AssertEquals 0, c1.TotalWeightOfChildren, "The TotalWeightOfChildren property should not be changed by an event in the parent (2)."
		  AssertEquals 0, c2.TotalWeightOfChildren, "The TotalWeightOfChildren property should be zero by default (2)."
		  
		  c1 = Nil
		  
		  AssertEquals 2, p.TotalWeightOfChildren, "Deleting a child should not cause the TotalWeightOfChildren property to decrease (3)."
		  AssertEquals 0, c2.TotalWeightOfChildren, "The TotalWeightOfChildren property should not be changed by an event in a sibling (3)."
		  
		  c1 = p.SpawnChild
		  
		  AssertNotIsNil c1, "The SpawnChild function should never return Nil (4)."
		  AssertEquals 2, p.TotalWeightOfChildren, "Adding a child should only change the TotalWeightOfChildrent property if the new total weight of all the children exceedes the value of the TotalWeightOfChildrent property (4)."
		  AssertEquals 0, c1.TotalWeightOfChildren, "The TotalWeightOfChildren property should be zero by default (4)."
		  AssertEquals 0, c2.TotalWeightOfChildren, "The TotalWeightOfChildren property should not be changed by an event in the parent (4)."
		  
		  Dim c3 As ProgressDelegateKFS = c1.SpawnChild(3)
		  
		  AssertNotIsNil c1, "The SpawnChild function should never return Nil (5)."
		  AssertEquals 2, p.TotalWeightOfChildren, "The TotalWeightOfChildren property should not be changed by an event in a child (5)."
		  AssertEquals 3, c1.TotalWeightOfChildren, "The TotalWeightOfChildren property should have been updated (5)."
		  AssertEquals 0, c2.TotalWeightOfChildren, "The TotalWeightOfChildren property should not be changed by an event in a sibling (5)."
		  AssertEquals 0, c3.TotalWeightOfChildren, "The TotalWeightOfChildren property should be zero by default (5)."
		  
		  c3.Weight = 0.5
		  
		  AssertEquals 2, p.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by a decrease in the weight of a grandchild (6)."
		  AssertEquals 3, c1.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by a decrease in the weight of a child (6)."
		  AssertEquals 0, c2.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by a decrease in the weight of a cousin (6)."
		  AssertEquals 0, c3.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by a change in the local weight (6)."
		  
		  c3.Weight = 7
		  
		  AssertEquals 2, p.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by an increase in the weight of a grandchild (7)."
		  AssertEquals 7, c1.TotalWeightOfChildren, "The TotalWeightOfChildren property should have gotten update after an increase in the weight of a child (7)."
		  AssertEquals 0, c2.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by an increase in the weight of a cousin (7)."
		  AssertEquals 0, c3.TotalWeightOfChildren, "The TotalWeightOfChildren property should not have been affected by a change in the local weight (7)."
		  
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
		  
		  AssertZero p.Value(False), "The value did not start out at zero."
		  AssertZero p.Value, "The overall value should be zero when starting with a bunch of new children."
		  
		  c(0).Value = .5
		  
		  AssertZero p.Value(False), "Modifying a child's value should not modify the parent's value (2)."
		  AssertEquals 1/8, p.Value, "The parent's overall value did not change as expected (2)."
		  
		  c(1).Value = .5
		  
		  AssertZero p.Value(False), "Modifying a child's value should not modify the parent's value (3)."
		  AssertEquals 1/4, p.Value, "The parent's overall value did not change as expected (3)."
		  
		  c(0) = Nil
		  
		  AssertEquals 0.25, p.Value(False), "Deallocating a child should cause the value of the parent to increment (4)."
		  AssertEquals 3/8, p.Value, "The parent's overall value did not change as expected (4)."
		  
		  c(1) = Nil
		  
		  AssertEquals 0.5, p.Value(False), "Deallocating a child should cause the value of the parent to increment (5)."
		  AssertEquals 0.5, p.Value, "The parent's overall value did not change as expected (5)."
		  
		  c(0) = c(2).SpawnChild
		  c(1) = c(2).SpawnChild
		  
		  AssertEquals 0.5, p.Value(False), "Adding another child should not cause the value to change (6)."
		  AssertEquals 0.5, p.Value, "Adding another child should not cause the overall value to change (6)."
		  
		  c(0).Value = .5
		  
		  AssertEquals 0.5, p.Value(False), "Modifying a child's value should not modify the parent's value (7)."
		  AssertEquals 0.5+1/16, p.Value, "The parent's overall value did not change as expected (7)."
		  
		  c(2) = Nil
		  
		  AssertEquals 0.5, p.Value(False), "Since ProgressDelegateKFS trees are downlinked, dropping c(2) should not have caused the value to change."
		  AssertEquals 0.5+1/16, p.Value, "Since ProgressDelegateKFS trees are downlinked, dropping c(2) should not have caused the overall value to change."
		  
		  c(1) = Nil
		  
		  AssertEquals 0.5, p.Value(False), "Dropping c(1) should not have changed the root value."
		  AssertEquals 0.5+3/16, p.Value, "Dropping c(1) should have bumped up the overall value a bit."
		  
		  c(0) = Nil
		  
		  AssertEquals 3/4, p.Value(False), "Dropping c(0) should have caused a cascade down to the parent, incrementing its value."
		  AssertEquals 3/4, p.Value, "Dropping c(0) should have bumped up the overall value a bit."
		  
		  c(3) = Nil
		  
		  AssertEquals 1, p.Value(False), "Dropping the last child should have caused the root node to get a value of 1."
		  AssertEquals 1, p.Value, "Dropping the last child should have caused the root node to get a overall value of 1."
		  
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
		  
		  AssertZero p.Value(False), "The value did not start out at zero."
		  AssertZero p.Value, "The overall value should be zero when starting with a bunch of new children."
		  
		  c(1).Weight = 2
		  c(0).Value = 0
		  
		  AssertZero p.Value(False), "Modifying a child's value should not modify the parent's value (2)."
		  
		  c(0).Value = 1
		  
		  AssertZero p.Value(False), "Modifying a child's value should not modify the parent's value (3)."
		  AssertEquals 1/4, p.Value, "The parent's overall value did not change as expected (3)."
		  
		  c(0).Value = 0
		  c(1).Value = 1
		  
		  AssertZero p.Value(False), "Modifying a child's value should not modify the parent's value (4)."
		  AssertEquals 1/2, p.Value, "The parent's overall value did not change as expected (4)."
		  
		  c(1).Value = 0
		  c(2).Value = 1
		  
		  AssertZero p.Value(False), "Modifying a child's value should not modify the parent's value (5)."
		  AssertEquals 1/4, p.Value, "The parent's overall value did not change as expected (5)."
		  
		  c(0) = Nil
		  
		  AssertEquals 1/4, p.Value(False), "Destroying a child did not add to the parent as expected (6)."
		  AssertEquals 1/2, p.Value, "The parent's overall value did not change as expected (6)."
		  
		  c(1) = Nil
		  
		  AssertEquals 3/4, p.Value(False), "Destroying a child did not add to the parent as expected (7)."
		  AssertEquals 1, p.Value, "The parent's overall value did not change as expected (7)."
		  
		  c(2) = Nil
		  
		  AssertEquals 1, p.Value(False), "Destroying a child did not add to the parent as expected (8)."
		  AssertEquals 1, p.Value, "The parent's overall value did not change as expected (8)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010-2011 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
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


	#tag Property, Flags = &h1
		Protected leaf As ProgressDelegateKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected root As ProgressDelegateKFS
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
