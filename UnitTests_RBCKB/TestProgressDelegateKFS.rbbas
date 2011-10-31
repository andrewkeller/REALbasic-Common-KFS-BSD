#tag Class
Protected Class TestProgressDelegateKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestChildCountAndChildren()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDestructor()
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
		Sub TestFrequencyHasElapsed()
		  // Created 10/30/2011 by Andrew Keller
		  
		  // Makes sure that the FrequencyHasElapsed function works properly.
		  
		  Dim p As ProgressDelegateKFS
		  Dim freq As DurationKFS
		  Dim clock_before, clock_after As DurationKFS
		  Dim next_clock_before, next_clock_after As DurationKFS
		  
		  // Set up the ProgressDelegateKFS object:
		  
		  p = New ProgressDelegateKFS
		  freq = New DurationKFS( 0.01 )
		  p.Frequency = freq
		  
		  // The first time the function is accessed, it should always return True.
		  
		  next_clock_before = DurationKFS.NewStopwatchStartingNow
		  AssertTrue p.FrequencyHasElapsed, "The FrequencyHasElapsed function is supposed to return True the first time.", False
		  next_clock_after = DurationKFS.NewStopwatchStartingNow
		  
		  // In subsequent invocations, the function should return True when the Frequency elapses after the above invocation.
		  
		  For iteration As Integer = 1 To 3
		    
		    PushMessageStack "Iteration " + Str( iteration ) + ": "
		    
		    clock_before = next_clock_before
		    clock_after = next_clock_after
		    
		    Dim done As Boolean = False
		    Do
		      
		      next_clock_before = DurationKFS.NewStopwatchStartingNow
		      Dim b As Boolean = p.FrequencyHasElapsed
		      next_clock_after = DurationKFS.NewStopwatchStartingNow
		      
		      If b Then
		        
		        AssertTrue clock_before > freq, "The FrequencyHasElapsed function returned True, but the Frequency has not elapsed yet."
		        done = True
		        
		      ElseIf clock_after > freq Then
		        
		        next_clock_before = DurationKFS.NewStopwatchStartingNow
		        AssertTrue p.FrequencyHasElapsed, "The Frequency has elapsed, and the FrequencyHasElapsed function has not returned True."
		        next_clock_after = DurationKFS.NewStopwatchStartingNow
		        
		        done = True
		        
		      End If
		    Loop Until done
		    
		    PopMessageStack
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFrequency_default_child()
		  // Created 10/29/2011 by Andrew Keller
		  
		  // Makes sure the Frequency property has the correct default value when it is a child node.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim expected, found As DurationKFS
		  
		  expected = DurationKFS.NewFromValue( 7 )
		  p.Frequency = expected
		  
		  Dim c As New ProgressDelegateKFS( p, 1, 0, "Sample Message" )
		  found = c.Frequency
		  
		  If PresumeNotIsNil( found, "The Frequency property should never return Nil." ) Then
		    
		    AssertNotSame found, p.Frequency, "The Frequency property did not decouple the parent's value from what is uses internally.", False
		    
		    AssertEquals expected.MicrosecondsValue, found.MicrosecondsValue, _
		    "A child is supposed to inherit the parent's Frequency property.", False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFrequency_default_root()
		  // Created 10/29/2011 by Andrew Keller
		  
		  // Makes sure the Frequency property has the correct default value when it is a root node.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim expected, found As DurationKFS
		  
		  expected = DurationKFS.NewFromValue( 0.5 )
		  found = p.Frequency
		  
		  If PresumeNotIsNil( found, "The Frequency property should never return Nil." ) Then
		    
		    AssertEquals expected.MicrosecondsValue, found.MicrosecondsValue, _
		    "The Frequency property should default to 0.5 seconds.", False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFrequency_propagateToChild()
		  // Created 10/29/2011 by Andrew Keller
		  
		  // Makes sure setting Frequency property does not affect the children.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim expected_p, expected_c, found As DurationKFS
		  Dim c As New ProgressDelegateKFS( p, 1, 0, "Sample Message" )
		  
		  expected_p = DurationKFS.NewFromValue( 7 )
		  expected_c = DurationKFS.NewFromValue( 0.5 )
		  
		  found = p.Frequency
		  
		  If PresumeNotIsNil( found, "The Frequency property should never return Nil. (1)" ) Then
		    
		    If PresumeEquals( expected_c.MicrosecondsValue, found.MicrosecondsValue, _
		      "Setup error: the parent does not have a frequency of 0.5 seconds." ) Then
		      
		      found = c.Frequency
		      
		      If PresumeNotIsNil( found, "The Frequency property should never return Nil. (2)" ) Then
		        
		        If PresumeEquals( expected_c.MicrosecondsValue, found.MicrosecondsValue, _
		          "Setup error: the child does not have a frequency of 0.5 seconds." ) Then
		          
		          p.Frequency = expected_p
		          
		          found = p.Frequency
		          
		          If PresumeNotIsNil( found, "The Frequency property should never return Nil. (3)" ) Then
		            
		            AssertEquals expected_p.MicrosecondsValue, found.MicrosecondsValue, "The parent did not retain the new value.", False
		            
		          End If
		          
		          found = c.Frequency
		          
		          If PresumeNotIsNil( found, "The Frequency property should never return Nil. (4)" ) Then
		            
		            AssertEquals expected_c.MicrosecondsValue, found.MicrosecondsValue, "The child's Frequency property is not supposed to be affected when the parent's Frequency property gets changed.", False
		            
		          End If
		        End If
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFrequency_propagateToParent()
		  // Created 10/29/2011 by Andrew Keller
		  
		  // Makes sure setting Frequency property does not affect the parent.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim expected_p, expected_c, found As DurationKFS
		  Dim c As New ProgressDelegateKFS( p, 1, 0, "Sample Message" )
		  
		  expected_p = DurationKFS.NewFromValue( 0.5 )
		  expected_c = DurationKFS.NewFromValue( 7 )
		  
		  found = p.Frequency
		  
		  If PresumeNotIsNil( found, "The Frequency property should never return Nil. (1)" ) Then
		    
		    If PresumeEquals( expected_p.MicrosecondsValue, found.MicrosecondsValue, _
		      "Setup error: the parent does not have a frequency of 0.5 seconds." ) Then
		      
		      found = c.Frequency
		      
		      If PresumeNotIsNil( found, "The Frequency property should never return Nil. (2)" ) Then
		        
		        If PresumeEquals( expected_p.MicrosecondsValue, found.MicrosecondsValue, _
		          "Setup error: the child does not have a frequency of 0.5 seconds." ) Then
		          
		          c.Frequency = expected_c
		          
		          found = c.Frequency
		          
		          If PresumeNotIsNil( found, "The Frequency property should never return Nil. (3)" ) Then
		            
		            AssertEquals expected_c.MicrosecondsValue, found.MicrosecondsValue, "The child did not retain the new value.", False
		            
		          End If
		          
		          found = p.Frequency
		          
		          If PresumeNotIsNil( found, "The Frequency property should never return Nil. (4)" ) Then
		            
		            AssertEquals expected_p.MicrosecondsValue, found.MicrosecondsValue, "The parent's Frequency property is not supposed to be affected when the child's Frequency property gets changed.", False
		            
		          End If
		        End If
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFrequency_set_Nil()
		  // Created 10/29/2011 by Andrew Keller
		  
		  // Makes sure the Frequency property works properly when set to Nil.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim expected, found As DurationKFS
		  
		  expected = DurationKFS.NewFromValue( 0 )
		  p.Frequency = Nil
		  found = p.Frequency
		  
		  If PresumeNotIsNil( found, "The Frequency property should never return Nil." ) Then
		    
		    AssertEquals expected.MicrosecondsValue, found.MicrosecondsValue, _
		    "Setting the Frequency property to Nil should be the same as setting it to zero.", False
		    
		  End If
		  
		  // done.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFrequency_set_valid()
		  // Created 10/29/2011 by Andrew Keller
		  
		  // Makes sure the Frequency property can be get and set with valid values.
		  
		  For Each v As Double In Array( 7, 99999999, 0.3, 0 )
		    
		    Dim p As New ProgressDelegateKFS
		    Dim expected, found As DurationKFS
		    
		    expected = DurationKFS.NewFromValue( v )
		    p.Frequency = expected
		    found = p.Frequency
		    
		    If PresumeNotIsNil( found, "The Frequency property should never return Nil." ) Then
		      
		      AssertNotSame expected, found, "The Frequency property did not decouple the set value from what is uses internally.", False
		      
		      AssertEquals expected.MicrosecondsValue, found.MicrosecondsValue, _
		      "Tried to set the Frequency property to " + expected.ShortHumanReadableStringValue + _
		      ", but did not get " + expected.ShortHumanReadableStringValue + " back.", False
		      
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetFrequencyHasElapsed()
		  
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
		Sub TestLocalNotificationsEnabled()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMessage()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetMessage()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldAutoUpdateObject()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldInvokeMessageChangedCallback()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldInvokeValueChangedCallback()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigCancel()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigKill()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSignal()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigNormal()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigPause()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSpawnChild()
		  
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
		Sub TestValue_unweighted()
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
		Sub TestValue_weighted()
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

	#tag Method, Flags = &h0
		Sub TestWeight()
		  
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
