#tag Class
Protected Class TestDurationKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Function MicrosecondsValueIncreases(d As DurationKFS, includeChildren As Boolean = True) As Boolean
		  // Created 8/21/2010 by Andrew Keller
		  
		  // Returns whether or not the MicrosecondsValue property is
		  // increasing over time in the given DurationKFS object.
		  
		  Dim startValue As UInt64 = d.MicrosecondsValue( includeChildren )
		  Dim startTime As UInt64 = Microseconds
		  
		  While Microseconds - startTime < kStopwatchObservationTimeout
		    
		    If d.MicrosecondsValue( includeChildren ) > startValue Then Return True
		    
		  Wend
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddition()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (+) operator works.
		  
		  Dim d1, d2, result As DurationKFS
		  
		  d1 = DurationKFS.NewFromValue( 4 )
		  d2 = DurationKFS.NewFromValue( 8 )
		  result = d1 + d2
		  
		  AssertEquals 12, result.Value, "Basic addition doesn't work."
		  
		  d1.MicrosecondsValue = -16
		  d2.MicrosecondsValue = 50
		  d1 = d1 + d2
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals DurationKFS.MaximumValue.MicrosecondsValue, i, "The addition operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToDate()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Date + DurationKFS => Date ) and ( DurationKFS + Date => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = DurationKFS.NewFromValue( 75 )
		  
		  result = da + du
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The Date + DurationKFS operator did not correctly calculate a new Date."
		  
		  result = du + da
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The DurationKFS + Date operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil + DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da + du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "DurationKFS + Nil should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( du + da ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToTimer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + DurationKFS => DurationKFS ) and ( DurationKFS + Timer => DurationKFS ) works.
		  
		  Dim r As New Random
		  Dim ti As New Timer
		  Dim du As New DurationKFS
		  Dim result As DurationKFS
		  
		  du = DurationKFS.NewFromValue( 75 )
		  ti.Period = 15000
		  
		  result = ti + du
		  AssertEquals 75 + 15, result.Value, "The Timer + DurationKFS operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  result = du + ti
		  AssertEquals 75 + 15, result.Value, "The DurationKFS + Timer operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  ti = Nil
		  
		  result = ti + du
		  AssertEquals 75 + 0, result.Value, "The Nil + DurationKFS operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  result = du + ti
		  AssertEquals 75 + 0, result.Value, "The DurationKFS + Nil operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChildrenIsRunning()
		  // Created 1/28/2011 by Andrew Keller
		  
		  // Makes sure that the IsRunning property behaves as expected when there are children.
		  
		  PushMessageStack "Stage 1: " // a new parent with 2 children
		  
		  Dim d As New DurationKFS
		  Dim c1 As DurationKFS = d.SpawnChild( False )
		  Dim c2 As DurationKFS = d.SpawnChild( False )
		  
		  AssertZero c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c1, False ), "The local value for c1 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c1, True ), "The overall value for c1 should not be increasing.", False
		  
		  AssertZero c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c2, False ), "The local value for c2 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c2, True ), "The overall value for c2 should not be increasing.", False
		  
		  AssertZero d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( d, False ), "The local value for d should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( d, True ), "The overall value for d should not be increasing.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 1."
		  PushMessageStack "Stage 2: " // add a nested child with the stopwatch running
		  
		  Dim c3 As DurationKFS = c1.SpawnChild( True )
		  
		  AssertNonNegative c3.MicrosecondsValue( False ), "c3.MicrosecondsValue( False ) is incorrect.", False
		  AssertNonNegative c3.MicrosecondsValue( True ), "c3.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertTrue c3.IsRunning( False ), "c3.IsRunning( False ) is incorrect.", False
		  AssertTrue c3.IsRunning( True ), "c3.IsRunning( True ) is incorrect.", False
		  
		  AssertTrue MicrosecondsValueIncreases( c3, False ), "The local value for c3 should be increasing.", False
		  AssertTrue MicrosecondsValueIncreases( c3, True ), "The overall value for c3 should be increasing.", False
		  
		  AssertZero c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertNonNegative c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertTrue c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c1, False ), "The local value for c1 should not be increasing.", False
		  AssertTrue MicrosecondsValueIncreases( c1, True ), "The overall value for c1 should be increasing.", False
		  
		  AssertZero c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c2, False ), "The local value for c2 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c2, True ), "The overall value for c2 should not be increasing.", False
		  
		  AssertZero d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertNonNegative d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertTrue d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( d, False ), "The local value for d should not be increasing.", False
		  AssertTrue MicrosecondsValueIncreases( d, True ), "The overall value for d should be increasing.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 2."
		  PushMessageStack "Stage 3: " // stop the nested child, and make sure everything returns to normal
		  
		  c3.Value = 1
		  
		  AssertEquals 1000000, c3.MicrosecondsValue( False ), "c3.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 1000000, c3.MicrosecondsValue( True ), "c3.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c3.IsRunning( False ), "c3.IsRunning( False ) is incorrect.", False
		  AssertFalse c3.IsRunning( True ), "c3.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c3, False ), "The local value for c3 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c3, True ), "The overall value for c3 should not be increasing.", False
		  
		  AssertZero c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 1000000, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c1, False ), "The local value for c1 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c1, True ), "The overall value for c1 should not be increasing.", False
		  
		  AssertZero c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c2, False ), "The local value for c2 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c2, True ), "The overall value for c2 should not be increasing.", False
		  
		  AssertZero d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 1000000, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( d, False ), "The local value for d should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( d, True ), "The overall value for d should not be increasing.", False
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChildrenValue()
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Makes sure that DurationKFS objects behave as expected when there are children.
		  
		  PushMessageStack "Stage 1: " // a new parent with no children
		  
		  Dim d As New DurationKFS
		  
		  AssertZero d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertZero d.Value( False ), "d.Value( False ) is incorrect.", False
		  AssertZero d.Value( True ), "d.Value( True ) is incorrect.", False
		  
		  AssertZero d.IntegerValue( False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertZero d.IntegerValue( True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 1."
		  PushMessageStack "Stage 2: " // add a nonzero value to the parent
		  
		  d.Value = 2
		  
		  AssertEquals 2000000, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 2000000, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 2, d.Value( False ), "d.Value( False ) is incorrect.", False
		  AssertEquals 2, d.Value( True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals 2, d.IntegerValue( False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals 2, d.IntegerValue( True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 2."
		  PushMessageStack "Stage 3: " // add a child to the parent
		  
		  Dim c1 As DurationKFS = d.SpawnChild( False )
		  
		  AssertZero c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertZero c1.Value( False ), "c1.Value( False ) is incorrect.", False
		  AssertZero c1.Value( True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertZero c1.IntegerValue( False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertZero c1.IntegerValue( True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 2000000, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 2000000, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 2, d.Value( False ), "d.Value( False ) is incorrect.", False
		  AssertEquals 2, d.Value( True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals 2, d.IntegerValue( False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals 2, d.IntegerValue( True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 3."
		  PushMessageStack "Stage 4: " // add a value to the child
		  
		  c1.Value = 7
		  
		  AssertEquals 7000000, c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 7000000, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 7, c1.Value( False ), "c1.Value( False ) is incorrect.", False
		  AssertEquals 7, c1.Value( True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertEquals 7, c1.IntegerValue( False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertEquals 7, c1.IntegerValue( True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 2000000, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 9000000, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 2, d.Value( False ), "d.Value( False ) is incorrect.", False
		  AssertEquals 9, d.Value( True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals 2, d.IntegerValue( False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals 9, d.IntegerValue( True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 4."
		  PushMessageStack "Stage 5: " // add a second child
		  
		  Dim c2 As DurationKFS = d.SpawnChild( False )
		  c2.Value = 3
		  
		  AssertEquals 7000000, c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 7000000, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 7, c1.Value( False ), "c1.Value( False ) is incorrect.", False
		  AssertEquals 7, c1.Value( True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertEquals 7, c1.IntegerValue( False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertEquals 7, c1.IntegerValue( True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 3000000, c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 3000000, c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 3, c2.Value( False ), "c2.Value( False ) is incorrect.", False
		  AssertEquals 3, c2.Value( True ), "c2.Value( True ) is incorrect.", False
		  
		  AssertEquals 3, c2.IntegerValue( False ), "c2.IntegerValue( False ) is incorrect.", False
		  AssertEquals 3, c2.IntegerValue( True ), "c2.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 2000000, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 12000000, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 2, d.Value( False ), "d.Value( False ) is incorrect.", False
		  AssertEquals 12, d.Value( True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals 2, d.IntegerValue( False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals 12, d.IntegerValue( True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 5."
		  PushMessageStack "Stage 6: " // add a third child (nested)
		  
		  Dim c3 As DurationKFS = c1.SpawnChild( False )
		  c3.Value = 5
		  
		  AssertEquals 5000000, c3.MicrosecondsValue( False ), "c3.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 5000000, c3.MicrosecondsValue( True ), "c3.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 5, c3.Value( False ), "c3.Value( False ) is incorrect.", False
		  AssertEquals 5, c3.Value( True ), "c3.Value( True ) is incorrect.", False
		  
		  AssertEquals 5, c3.IntegerValue( False ), "c3.IntegerValue( False ) is incorrect.", False
		  AssertEquals 5, c3.IntegerValue( True ), "c3.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c3.IsRunning( False ), "c3.IsRunning( False ) is incorrect.", False
		  AssertFalse c3.IsRunning( True ), "c3.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 7000000, c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 12000000, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 7, c1.Value( False ), "c1.Value( False ) is incorrect.", False
		  AssertEquals 12, c1.Value( True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertEquals 7, c1.IntegerValue( False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertEquals 12, c1.IntegerValue( True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 3000000, c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 3000000, c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 3, c2.Value( False ), "c2.Value( False ) is incorrect.", False
		  AssertEquals 3, c2.Value( True ), "c2.Value( True ) is incorrect.", False
		  
		  AssertEquals 3, c2.IntegerValue( False ), "c2.IntegerValue( False ) is incorrect.", False
		  AssertEquals 3, c2.IntegerValue( True ), "c2.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals 2000000, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals 17000000, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals 2, d.Value( False ), "d.Value( False ) is incorrect.", False
		  AssertEquals 17, d.Value( True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals 2, d.IntegerValue( False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals 17, d.IntegerValue( True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClear()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clear method works.
		  
		  Dim d As New DurationKFS( 4 )
		  
		  AssertNonZero d.MicrosecondsValue, "Operator_Convert didn't take an integer."
		  AssertFalse d.IsRunning, "The stopwatch should not be running (1)."
		  
		  d.Clear
		  
		  AssertZero d.MicrosecondsValue, "The Clear method did not set the microseconds to zero."
		  AssertFalse d.IsRunning, "The stopwatch should not be running (2)."
		  
		  d = DurationKFS.NewFromValue( 4 )
		  d.Start
		  
		  AssertNonZero d.MicrosecondsValue, "Operator_Convert didn't take an integer."
		  AssertTrue d.IsRunning, "The stopwatch should be running (3)."
		  
		  d.Clear
		  
		  AssertZero d.MicrosecondsValue, "The Clear method did not stop the stopwatch."
		  AssertFalse d.IsRunning, "The stopwatch should not be running (4)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClone()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clone operation works.
		  
		  // Full clone
		  
		  Dim d As New DurationKFS( 2 )
		  d = New DurationKFS( d, True )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertFalse d.IsRunning, "The clone constructor did not retain the state of the stopwatch (not running)."
		  AssertEquals 2, d.Value, "The clone constructor did not clone the value correctly (not running)."
		  
		  // Live clone of a stopwatch
		  
		  d = New DurationKFS( 2 )
		  d.Start
		  While d.MicrosecondsValue <= 2000000
		  Wend
		  d = New DurationKFS( d, True )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertTrue d.IsRunning, "The clone constructor did not retain the state of the stopwatch (running)."
		  AssertPositive d.MicrosecondsValue - 2000000, "The clone constructor did not perform a live clone correctly."
		  
		  // Dead clone of a stopwatch
		  
		  d = New DurationKFS( 2 )
		  d.Start
		  While d.MicrosecondsValue <= 2000000
		  Wend
		  d = New DurationKFS( d, False )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertFalse d.IsRunning, "The clone constructor did not clear the state of the stopwatch for a dead clone."
		  AssertPositive d.MicrosecondsValue - 2000000, "The clone constructor did not perform a dead clone correctly."
		  
		  // Full clone of Nil object
		  
		  d = Nil
		  Try
		    d = New DurationKFS( d, True )
		  Catch err As NilObjectException
		    AssertFailure "The clone constructor is not supposed to fail when given Nil."
		  End Try
		  
		  AssertNotIsNil d, "The clone constructor is not supposed to return Nil when given Nil."
		  AssertFalse d.IsRunning, "When cloning Nil, the stopwatch should not be running."
		  AssertZero d.Value, "When cloning Nil, the value should be zero."
		  
		  // Dead clone of Nil object
		  
		  d = Nil
		  Try
		    d = New DurationKFS( d, False )
		  Catch err As NilObjectException
		    AssertFailure "The clone constructor is not supposed to fail when given Nil."
		  End Try
		  
		  AssertNotIsNil d, "The clone constructor is not supposed to return Nil when given Nil."
		  AssertFalse d.IsRunning, "When cloning Nil, the stopwatch should not be running."
		  AssertZero d.Value, "When cloning Nil, the value should be zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCompare()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the compare operators work.
		  
		  Dim d, d2 As DurationKFS
		  
		  AssertTrue d = Nil, "The Operator_Compare method does not think that a Nil DurationKFS is Nil."
		  
		  d = DurationKFS.NewFromValue( 4 )
		  d2 = DurationKFS.NewFromValue( 4 )
		  
		  AssertFalse d = Nil, "The Operator_Compare method thinks that a non-Nil DurationKFS is Nil."
		  AssertTrue d = d2, "Either Operator_Convert did not take an integer correctly, or Operator_Compare did not compare correctly."
		  
		  // Make sure the compare operators respect the stopwatch.
		  
		  d.Start
		  
		  AssertTrue MicrosecondsValueIncreases( d ), "After starting the stopwatch, the MicrosecondsValue property did not begin to increase."
		  AssertTrue d > d2, "Either the stopwatch isn't working correctly, or Operator_Compare does not respect the stopwatch."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDateDifference()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the date difference constructor works.
		  
		  Dim r As New Random
		  Dim d1 As New Date
		  Dim d2 As New Date
		  Dim result As DurationKFS
		  
		  d1.TotalSeconds = r.InRange( d1.TotalSeconds - 1000, d1.TotalSeconds + 1000 )
		  d2.TotalSeconds = r.InRange( d2.TotalSeconds - 1000, d2.TotalSeconds + 1000 )
		  
		  result = DurationKFS.NewFromDateDifference( d1, d2 )
		  
		  AssertEquals d1.TotalSeconds - d2.TotalSeconds, result.Value, "The Date Difference constructor did not correctly calculate the difference."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Call DurationKFS.NewFromDateDifference( d1, Nil )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between d1 and Nil."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Call DurationKFS.NewFromDateDifference( Nil, d2 )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between Nil and d2."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDivision()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure division works.
		  
		  Dim d1 As New DurationKFS( 12 )
		  Dim d2 As New DurationKFS( 4 )
		  
		  AssertEquals 3, d1 / d2, "DurationKFS does not correctly calculate ratios of durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerDivision()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure integer division works.
		  
		  Dim d1 As New DurationKFS( 12 )
		  Dim d2 As New DurationKFS( 5 )
		  
		  AssertEquals 2, d1 \ d2, "DurationKFS does not correctly calculate integer ratios of durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInvalidUnit()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS fails when dealing with invalid units.
		  
		  Dim d As DurationKFS
		  Dim iu As Double = 4.8
		  
		  PushMessageStack "DurationKFS did not throw an exception when dealing with an invalid unit."
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "(via constructor)  Result was " + ObjectDescriptionKFS( New DurationKFS( 5, iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = New DurationKFS
		    d.Value( iu ) = 5
		    AssertFailure "(via setting Value property)  Result was " + ObjectDescriptionKFS( d ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = New DurationKFS
		    d.IntegerValue( iu ) = 5
		    AssertFailure "(via setting IntegerValue property)  Result was " + ObjectDescriptionKFS( d ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = DurationKFS.NewFromValue( 5 )
		    AssertFailure "(via getting Value property)  Result was " + ObjectDescriptionKFS( d.Value( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = DurationKFS.NewFromValue( 5 )
		    AssertFailure "(via getting IntegerValue property)  Result was " + ObjectDescriptionKFS( d.IntegerValue( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMaximumValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the MaximumValue constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.MaximumValue
		  
		  // The maximum value should be 18,446,744,073,709,551,615.
		  
		  Dim m As UInt64 = -1
		  AssertEquals m, d.MicrosecondsValue, "MaximumValue did not return a DurationKFS with the expected maximum value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMinimumValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the MinimumValue constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.MinimumValue
		  
		  // The maximum value should be 0.
		  
		  AssertEquals 0, d.MicrosecondsValue, "MinimumValue did not return a DurationKFS with the expected minimum value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestModulo()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure finding a remainder works.
		  
		  Dim d1 As New DurationKFS( 12 )
		  Dim d2 As New DurationKFS( 5 )
		  Dim expected As New DurationKFS( 2 )
		  
		  AssertTrue expected = d1 Mod d2, "DurationKFS does not correctly calculate a modulo of two durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMultiplyByScalar()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure multiplying by a scalar works.
		  
		  Dim d As New DurationKFS( 3 )
		  
		  AssertFalse d.IsRunning, "A new DurationKFS object apparently had the stopwatch running."
		  AssertEquals 3000000, d.MicrosecondsValue, "A DurationKFS did not acquire the requested value."
		  
		  d = d * 3
		  
		  AssertFalse d.IsRunning, "Multiplication by a scalar should not return a DurationKFS with the stopwatch running."
		  AssertEquals 9000000, d.MicrosecondsValue, "DurationKFS * Double did not work."
		  
		  d = 3 * d
		  
		  AssertFalse d.IsRunning, "Multiplication by a scalar should not return a DurationKFS with the stopwatch running."
		  AssertEquals 27000000, d.MicrosecondsValue, "Double * DurationKFS did not work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromMicrosecondsValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewFromMicrosecondsValue constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewFromMicroseconds( 1194832 )
		  
		  // The MicrosecondsValue of the object should be 1194832.
		  
		  AssertEquals 1194832, d.MicrosecondsValue, "NewFromMicrosecondsValue did not return a DurationKFS with the expected value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewStopwatchStartingNow()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewStopwatchStartingNow constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewStopwatchStartingNow
		  
		  // The MicrosecondsValue should be very low, but it is hard to definitively test for that.
		  
		  // In any case, the stopwatch should be running.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortHumanReadableString()
		  // Created 8/30/2010 by Andrew Keller
		  
		  // Make sure the ShortHumanReadableStringValue function works.
		  
		  Dim d As New DurationKFS
		  
		  PushMessageStack "ShortHumanReadableStringValue did not return an expected value."
		  
		  AssertEquals "0 us", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "0 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "0.00 ms", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "0.00 s", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "0.00 m", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  d.Value = 5
		  
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "0.08 m", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "5000000 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5000 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  
		  d.Value( DurationKFS.kCenturies ) = 5
		  
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "15778800000000000 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "15778800000000 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "15778800000 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  AssertEquals "262980000 m", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMinutes ), "", False
		  AssertEquals "4383000 h", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kHours ), "", False
		  AssertEquals "182625 d", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDays ), "", False
		  AssertEquals "26089 w", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kWeeks ), "", False
		  AssertEquals "6000 mon", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMonths ), "", False
		  AssertEquals "500 y", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kYears ), "", False
		  AssertEquals "50.0 dec", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kCenturies ), "", False
		  
		  d = DurationKFS.MaximumValue
		  
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "18446744073709551615 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "18446744073709552 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "18446744073710 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  AssertEquals "307445734562 m", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMinutes ), "", False
		  AssertEquals "5124095576 h", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kHours ), "", False
		  AssertEquals "213503982 d", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDays ), "", False
		  AssertEquals "30500569 w", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kWeeks ), "", False
		  AssertEquals "7014505 mon", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMonths ), "", False
		  AssertEquals "584542 y", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kYears ), "", False
		  AssertEquals "58454 dec", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kCenturies ), "", False
		  
		  PopMessageStack
		  
		  // Now, make sure that the ShortHumanReadableStringValue fails when it is supposed to.
		  
		  d.Value = 5
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( DurationKFS.kYears, DurationKFS.kSeconds )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when minUnit > maxUnit."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( 10, 15 )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when the requested units are above the range of the available units."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( -10, -7 )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when the requested units are below the range of the available units."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchCancel()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure canceling the stopwatch works.
		  
		  Dim d As New DurationKFS( 1 )
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "A DurationKFS did not acquire a value of one second."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue - 1000000, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  d.CancelStopwatch
		  
		  // The stopwatch should not be running anymore, and the value should be back to 1 second.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running anymore."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "The stopwatch value should be reverted when it is canceled."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchCancel_Dead()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure canceling the stopwatch works.
		  
		  Dim d As New DurationKFS( 1 )
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "A DurationKFS did not acquire a value of one second."
		  
		  d.CancelStopwatch
		  
		  // The stopwatch should still not be running, and the value should still be 1 second.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "The stopwatch value should never have changed."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchCancel_Implicit()
		  // Created 1/28/2011 by Andrew Keller
		  
		  // Make sure the stopwatch gets canceled when a value is set.
		  
		  Dim d As New DurationKFS( 2 )
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running.", False
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running.", False
		  AssertEquals 2000000, d.MicrosecondsValue, "A DurationKFS did not acquire a value of two seconds."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running.", False
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running.", False
		  AssertPositive d.MicrosecondsValue - 2000000, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  d.Value = 1
		  
		  AssertFalse d.IsRunning, "The stopwatch should be stopped now.", False
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running.", False
		  AssertEquals 1000000, d.MicrosecondsValue, "A DurationKFS did not acquire a value of one second."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchSplit()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure splitting the stopwatch works.
		  
		  Dim d As New DurationKFS
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  Dim d2 As DurationKFS = d.Split
		  
		  // The first stopwatch should not be running anymore, and the value should be slightly greater than zero.
		  
		  AssertFalse d.IsRunning, "The first stopwatch should not be running anymore (after calling Split)."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertPositive d.MicrosecondsValue, "The first stopwatch's value should not have been reverted when Split was called."
		  
		  // The Second stopwatch should be running, and the value should be slightly greater than zero.
		  
		  AssertNotIsNil d2, "Split should never return Nil."
		  AssertTrue d2.IsRunning, "The second stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d2 ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d2.MicrosecondsValue, "The second stopwatch should be adding to the pre-existing value when it is running."
		  
		  // Let's cancel the second stopwatch to see what the original value was (it has better be zero).
		  
		  d2.CancelStopwatch
		  
		  AssertFalse d2.IsRunning, "The second stopwatch should have no reason to not be able to cancel."
		  AssertFalse MicrosecondsValueIncreases( d2 ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d2.MicrosecondsValue, "The second stopwatch value should be reverted to zero if it is canceled."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchSplit_Dead()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure splitting the stopwatch works when the original was not actually working.
		  
		  Dim d As New DurationKFS
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  
		  Dim d2 As DurationKFS = d.Split
		  
		  // The first stopwatch should not be running anymore, and the value should be slightly greater than zero.
		  
		  AssertFalse d.IsRunning, "The first stopwatch should not be running (even after calling Split)."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "The first stopwatch should be still stuck at zero since it was not running."
		  
		  // The Second stopwatch should be running, and the value should be slightly greater than zero.
		  
		  AssertNotIsNil d2, "Split should never return Nil."
		  AssertTrue d2.IsRunning, "The second stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d2 ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d2.MicrosecondsValue, "The second stopwatch should be adding to the pre-existing value when it is running."
		  
		  // Let's cancel the second stopwatch to see what the original value was (it has better be zero).
		  
		  d2.CancelStopwatch
		  
		  AssertFalse d2.IsRunning, "The second stopwatch should have no reason to not be able to cancel."
		  AssertFalse MicrosecondsValueIncreases( d2 ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d2.MicrosecondsValue, "The second stopwatch value should be reverted to zero if it is canceled."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchStartStop()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure starting and stopping the stopwatch works.
		  
		  Dim d As New DurationKFS
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  d.Stop
		  
		  // The stopwatch should not be running anymore.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running anymore."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch value should not be reverted when it is stopped."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchStart_Live()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure starting and stopping the stopwatch works.
		  
		  Dim d As New DurationKFS
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  Dim valueShouldBeAtLeast As UInt64 = d.MicrosecondsValue
		  d.Start
		  
		  // The stopwatch should not have been affected at all.
		  
		  AssertTrue d.IsRunning, "The stopwatch should still be running after calling Start again."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue - valueShouldBeAtLeast, "Calling Start again should not affect the start time of the stopwatch."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchStop_Dead()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure starting and stopping the stopwatch works.
		  
		  Dim d As New DurationKFS
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  d.Stop
		  
		  // The stopwatch should not be running anymore.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running anymore."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch value should not be reverted when it is stopped."
		  
		  Dim valueShouldBe As UInt64 = d.MicrosecondsValue
		  d.Stop
		  
		  // The DurationKFS object should not have been affected at all.
		  
		  AssertFalse d.IsRunning, "The stopwatch should still not be running after calling Stop again."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals valueShouldBe, d.MicrosecondsValue, "The stopwatch value should not have changed after calling Stop again."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSubtractFromDate()
		  // Created 8/19/2010 by Andrew Keller
		  
		  // Make sure that ( Date - DurationKFS => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = DurationKFS.NewFromValue( 75 )
		  
		  result = da - du
		  AssertEquals da.TotalSeconds - du.Value, result.TotalSeconds, "The Date minus DurationKFS operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil minus DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da - du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSubtraction()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (-) operator works.
		  
		  Dim d1, d2, result As DurationKFS
		  
		  d1 = DurationKFS.NewFromValue( 8 )
		  d2 = DurationKFS.NewFromValue( 3 )
		  result = d1 - d2
		  
		  AssertEquals 5, result.Value, "Basic subtraction doesn't work."
		  
		  d1 = d2 - d1
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals 0, i, "The subtraction operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUInt64Underflow()
		  // Created 3/20/2011 by Andrew Keller
		  
		  // These test cases use an underflow to figure out
		  // the maximum value of a UInt64 varialbe.  This test
		  // case makes sure the underflow works as expected.
		  
		  Dim f As UInt64 = -1
		  Dim e As String = "18446744073709551615"
		  
		  AssertEquals e, Str( f ), "Underflowing a UInt64 variable did not work as expected."
		  AssertEquals e, Str( CType( -1, UInt64 ) ), "Underflowing a UInt64 variable did not work as expected."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnitConversions()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS can convert units correctly.
		  
		  TestUnits "microseconds", DurationKFS.kMicroseconds, 5, 5
		  TestUnits "milliseconds", DurationKFS.kMilliseconds, 5, 5000
		  TestUnits "seconds", DurationKFS.kSeconds, 5, 5000000
		  TestUnits "minutes", DurationKFS.kMinutes, 5, 300000000
		  TestUnits "hours", DurationKFS.kHours, 5, 18000000000
		  TestUnits "days", DurationKFS.kDays, 5, 432000000000
		  TestUnits "weeks", DurationKFS.kWeeks, 5, 3024000000000
		  TestUnits "months", DurationKFS.kMonths, 5, 13149000000000
		  TestUnits "years", DurationKFS.kYears, 5, 157788000000000
		  TestUnits "decades", DurationKFS.kDecades, 5, 1577880000000000
		  TestUnits "centuries", DurationKFS.kCenturies, 5, 15778800000000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnits(unitLabel As String, unitExponent As Double, inputValue As Double, expectedMicroseconds As UInt64)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS can handle <unitLabel> correctly.
		  
		  Dim d As DurationKFS
		  
		  PushMessageStack "DurationKFS was not able to take a value in " + unitLabel + "."
		  
		  d = New DurationKFS( inputValue, unitExponent )
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via constructor)"
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  d.Value = inputValue
		  If unitExponent = DurationKFS.kSeconds Then
		    AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via convert constructor)"
		  Else
		    AssertNotEqual expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "The convert constructor apparently had the idea that the default units are " + unitLabel + "."
		  End If
		  
		  d.Value( unitExponent ) = inputValue
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via Value property)"
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  d.IntegerValue( unitExponent ) = inputValue
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via IntegerValue property)"
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  PopMessageStack
		  PushMessageStack "DurationKFS was not able to return a value in " + unitLabel + "."
		  
		  AssertEquals inputValue, d.Value( unitExponent ), "(via the Value property)"
		  
		  AssertEquals inputValue, d.IntegerValue( unitExponent ), "(via the IntegerValue property)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2010, 2011 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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

	#tag Note, Name = WTF
		Okay, so I found a problem that I found rather interesting, but
		since it's not absolutely critical and I'm rather short on time
		at the moment, I'm going to place this one on the back burner.
		
		According to my tests on my 2.16 GHz MBP, the smallest I
		can get the difference between two successive reads of the
		Microseconds function is 3 microseconds.
		
		BUT...  somehow...  two successive reads of the MicrosecondsValue
		property of a DurationKFS object can return identical values.
		
		The following assertion has the ability to fail with a running stopwatch:
		
		AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		This is why assertions like that were replaced by:
		
		AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		The MicrosecondsValueIncreases function checks for a change
		over a longer period of time, so that changes are easier to find.
		
		This behavior is approximately 10% reproducible on my
		computer at the moment.  Just set the timeout in the
		MicrosecondsValueIncreases function to zero, and keep
		running the tests over and over again until something fails.
	#tag EndNote


	#tag Constant, Name = kStopwatchObservationTimeout, Type = Double, Dynamic = False, Default = \"30", Scope = Public
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
