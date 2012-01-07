#tag Class
Protected Class TestStopwatchKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Function MicrosecondsValueIncreases(d As StopwatchKFS, includeChildren As Boolean = True) As Boolean
		  // Created 8/21/2010 by Andrew Keller
		  
		  // Returns whether or not the MicrosecondsValue property is
		  // increasing over time in the given StopwatchKFS object.
		  
		  Dim startValue As UInt64 = d.MicrosecondsValue( includeChildren )
		  Dim startTime As UInt64 = Microseconds
		  
		  Do
		    
		    If d.MicrosecondsValue( includeChildren ) > startValue Then Return True
		    
		  Loop Until Microseconds - startTime > kStopwatchObservationTimeout
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddition()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (+) operator works.
		  
		  Dim d1, d2, result As DurationKFS
		  
		  d1 = StopwatchKFS.NewFromValue( 4 )
		  d2 = StopwatchKFS.NewFromValue( 8 )
		  result = d1 + d2
		  
		  AssertEquals 12, result.Value, "Basic addition doesn't work."
		  
		  d1 = StopwatchKFS.NewFromMicroseconds( -16 )
		  d2 = StopwatchKFS.NewFromMicroseconds( 50 )
		  d1 = d1 + d2
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals StopwatchKFS.MaximumValue.MicrosecondsValue, i, "The addition operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToDate()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Date + StopwatchKFS => Date ) and ( StopwatchKFS + Date => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New StopwatchKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = StopwatchKFS.NewFromValue( 75 )
		  
		  result = da + du
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The Date + StopwatchKFS operator did not correctly calculate a new Date."
		  
		  result = du + da
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The StopwatchKFS + Date operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil + StopwatchKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da + du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "StopwatchKFS + Nil should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( du + da ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToTimer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + StopwatchKFS => StopwatchKFS ) and ( StopwatchKFS + Timer => StopwatchKFS ) works.
		  
		  Dim r As New Random
		  Dim ti As New Timer
		  Dim du As New StopwatchKFS
		  Dim result As DurationKFS
		  
		  du = StopwatchKFS.NewFromValue( 75 )
		  ti.Period = 15000
		  
		  result = ti + du
		  AssertEquals 75 + 15, result.Value, "The Timer + StopwatchKFS operator did not correctly calculate a new StopwatchKFS."
		  
		  result = du + ti
		  AssertEquals 75 + 15, result.Value, "The StopwatchKFS + Timer operator did not correctly calculate a new StopwatchKFS."
		  
		  ti = Nil
		  
		  result = ti + du
		  AssertEquals 75 + 0, result.Value, "The Nil + StopwatchKFS operator did not correctly calculate a new StopwatchKFS."
		  
		  result = du + ti
		  AssertEquals 75 + 0, result.Value, "The StopwatchKFS + Nil operator did not correctly calculate a new StopwatchKFS."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChildrenIsRunning()
		  // Created 1/28/2011 by Andrew Keller
		  
		  // Makes sure that the IsRunning property behaves as expected when there are children.
		  
		  PushMessageStack "Stage 1: " // a new parent with 2 children
		  
		  Dim d As New StopwatchKFS
		  Dim c1 As StopwatchKFS = d.SpawnChild( False )
		  Dim c2 As StopwatchKFS = d.SpawnChild( False )
		  
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
		  
		  Dim c3 As StopwatchKFS = c1.SpawnChild( True )
		  
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
		  
		  c3.Stop
		  Dim m As UInt64 = c3.MicrosecondsValue
		  
		  AssertEquals m, c3.MicrosecondsValue( False ), "c3.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m, c3.MicrosecondsValue( True ), "c3.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertFalse c3.IsRunning( False ), "c3.IsRunning( False ) is incorrect.", False
		  AssertFalse c3.IsRunning( True ), "c3.IsRunning( True ) is incorrect.", False
		  
		  AssertFalse MicrosecondsValueIncreases( c3, False ), "The local value for c3 should not be increasing.", False
		  AssertFalse MicrosecondsValueIncreases( c3, True ), "The overall value for c3 should not be increasing.", False
		  
		  AssertZero c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
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
		  AssertEquals m, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
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
		  
		  // Makes sure that StopwatchKFS objects behave as expected when there are children.
		  
		  PushMessageStack "Stage 1: " // a new parent with no children
		  
		  Dim d As New StopwatchKFS
		  
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
		  
		  d = New StopwatchKFS( 2 )
		  Dim m As UInt64 = d.MicrosecondsValue
		  
		  AssertEquals m, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, False ), "d.Value( False ) is incorrect.", False
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 2."
		  PushMessageStack "Stage 3: " // add a child to the parent
		  
		  Dim c1 As StopwatchKFS = d.SpawnChild( False )
		  
		  AssertZero c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertZero c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertZero c1.Value( False ), "c1.Value( False ) is incorrect.", False
		  AssertZero c1.Value( True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertZero c1.IntegerValue( False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertZero c1.IntegerValue( True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, False ), "d.Value( False ) is incorrect.", False
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 3."
		  PushMessageStack "Stage 4: " // add a value to the child
		  
		  c1.Start
		  App.CurrentThread.Sleep 42
		  c1.Stop
		  Dim m1 As UInt64 = c1.MicrosecondsValue
		  
		  AssertEquals m1, c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m1, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.Value( StopwatchKFS.kMicroseconds, False ), "c1.Value( False ) is incorrect.", False
		  AssertEquals m1, c1.Value( StopwatchKFS.kMicroseconds, True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.IntegerValue( StopwatchKFS.kMicroseconds, False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertEquals m1, c1.IntegerValue( StopwatchKFS.kMicroseconds, True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m+m1, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, False ), "d.Value( False ) is incorrect.", False
		  AssertEquals m+m1, d.Value( StopwatchKFS.kMicroseconds, True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals m+m1, d.IntegerValue( StopwatchKFS.kMicroseconds, True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 4."
		  PushMessageStack "Stage 5: " // add a second child
		  
		  Dim c2 As StopwatchKFS = d.SpawnChild( True )
		  App.CurrentThread.Sleep 12
		  c2.Stop
		  Dim m2 As UInt64 = c2.MicrosecondsValue
		  
		  AssertEquals m1, c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m1, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.Value( StopwatchKFS.kMicroseconds, False ), "c1.Value( False ) is incorrect.", False
		  AssertEquals m1, c1.Value( StopwatchKFS.kMicroseconds, True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.IntegerValue( StopwatchKFS.kMicroseconds, False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertEquals m1, c1.IntegerValue( StopwatchKFS.kMicroseconds, True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m2, c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m2, c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m2, c2.Value( StopwatchKFS.kMicroseconds, False ), "c2.Value( False ) is incorrect.", False
		  AssertEquals m2, c2.Value( StopwatchKFS.kMicroseconds, True ), "c2.Value( True ) is incorrect.", False
		  
		  AssertEquals m2, c2.IntegerValue( StopwatchKFS.kMicroseconds, False ), "c2.IntegerValue( False ) is incorrect.", False
		  AssertEquals m2, c2.IntegerValue( StopwatchKFS.kMicroseconds, True ), "c2.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m+m1+m2, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, False ), "d.Value( False ) is incorrect.", False
		  AssertEquals m+m1+m2, d.Value( StopwatchKFS.kMicroseconds, True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals m+m1+m2, d.IntegerValue( StopwatchKFS.kMicroseconds, True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  AssertNoIssuesYet "Bailing out after stage 5."
		  PushMessageStack "Stage 6: " // add a third child (nested)
		  
		  Dim c3 As StopwatchKFS = c1.SpawnChild( True )
		  App.CurrentThread.Sleep 55
		  c3.Stop
		  Dim m3 As UInt64 = c3.MicrosecondsValue
		  
		  AssertEquals m3, c3.MicrosecondsValue( False ), "c3.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m3, c3.MicrosecondsValue( True ), "c3.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m3, c3.Value( StopwatchKFS.kMicroseconds, False ), "c3.Value( False ) is incorrect.", False
		  AssertEquals m3, c3.Value( StopwatchKFS.kMicroseconds, True ), "c3.Value( True ) is incorrect.", False
		  
		  AssertEquals m3, c3.IntegerValue( StopwatchKFS.kMicroseconds, False ), "c3.IntegerValue( False ) is incorrect.", False
		  AssertEquals m3, c3.IntegerValue( StopwatchKFS.kMicroseconds, True ), "c3.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c3.IsRunning( False ), "c3.IsRunning( False ) is incorrect.", False
		  AssertFalse c3.IsRunning( True ), "c3.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.MicrosecondsValue( False ), "c1.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m1+m3, c1.MicrosecondsValue( True ), "c1.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.Value( StopwatchKFS.kMicroseconds, False ), "c1.Value( False ) is incorrect.", False
		  AssertEquals m1+m3, c1.Value( StopwatchKFS.kMicroseconds, True ), "c1.Value( True ) is incorrect.", False
		  
		  AssertEquals m1, c1.IntegerValue( StopwatchKFS.kMicroseconds, False ), "c1.IntegerValue( False ) is incorrect.", False
		  AssertEquals m1+m3, c1.IntegerValue( StopwatchKFS.kMicroseconds, True ), "c1.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c1.IsRunning( False ), "c1.IsRunning( False ) is incorrect.", False
		  AssertFalse c1.IsRunning( True ), "c1.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m2, c2.MicrosecondsValue( False ), "c2.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m2, c2.MicrosecondsValue( True ), "c2.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m2, c2.Value( StopwatchKFS.kMicroseconds, False ), "c2.Value( False ) is incorrect.", False
		  AssertEquals m2, c2.Value( StopwatchKFS.kMicroseconds, True ), "c2.Value( True ) is incorrect.", False
		  
		  AssertEquals m2, c2.IntegerValue( StopwatchKFS.kMicroseconds, False ), "c2.IntegerValue( False ) is incorrect.", False
		  AssertEquals m2, c2.IntegerValue( StopwatchKFS.kMicroseconds, True ), "c2.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse c2.IsRunning( False ), "c2.IsRunning( False ) is incorrect.", False
		  AssertFalse c2.IsRunning( True ), "c2.IsRunning( True ) is incorrect.", False
		  
		  AssertEquals m, d.MicrosecondsValue( False ), "d.MicrosecondsValue( False ) is incorrect.", False
		  AssertEquals m+m1+m2+m3, d.MicrosecondsValue( True ), "d.MicrosecondsValue( True ) is incorrect.", False
		  
		  AssertEquals m, d.Value( StopwatchKFS.kMicroseconds, False ), "d.Value( False ) is incorrect.", False
		  AssertEquals m+m1+m2+m3, d.Value( StopwatchKFS.kMicroseconds, True ), "d.Value( True ) is incorrect.", False
		  
		  AssertEquals m, d.IntegerValue( StopwatchKFS.kMicroseconds, False ), "d.IntegerValue( False ) is incorrect.", False
		  AssertEquals m+m1+m2+m3, d.IntegerValue( StopwatchKFS.kMicroseconds, True ), "d.IntegerValue( True ) is incorrect.", False
		  
		  AssertFalse d.IsRunning( False ), "d.IsRunning( False ) is incorrect.", False
		  AssertFalse d.IsRunning( True ), "d.IsRunning( True ) is incorrect.", False
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClone()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clone operation works.
		  
		  // Full clone
		  
		  Dim d As New StopwatchKFS( 2 )
		  d = New StopwatchKFS( d, True )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertFalse d.IsRunning, "The clone constructor did not retain the state of the stopwatch (not running)."
		  AssertEquals 2, d.Value, "The clone constructor did not clone the value correctly (not running)."
		  
		  // Live clone of a stopwatch
		  
		  d = New StopwatchKFS( 2 )
		  d.Start
		  While d.MicrosecondsValue <= 2000000
		  Wend
		  d = New StopwatchKFS( d, True )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertTrue d.IsRunning, "The clone constructor did not retain the state of the stopwatch (running)."
		  AssertPositive d.MicrosecondsValue - 2000000, "The clone constructor did not perform a live clone correctly."
		  
		  // Dead clone of a stopwatch
		  
		  d = New StopwatchKFS( 2 )
		  d.Start
		  While d.MicrosecondsValue <= 2000000
		  Wend
		  d = New StopwatchKFS( d, False )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertFalse d.IsRunning, "The clone constructor did not clear the state of the stopwatch for a dead clone."
		  AssertPositive d.MicrosecondsValue - 2000000, "The clone constructor did not perform a dead clone correctly."
		  
		  // Full clone of Nil object
		  
		  d = Nil
		  Try
		    d = New StopwatchKFS( d, True )
		  Catch err As NilObjectException
		    AssertFailure "The clone constructor is not supposed to fail when given Nil."
		  End Try
		  
		  AssertNotIsNil d, "The clone constructor is not supposed to return Nil when given Nil."
		  AssertFalse d.IsRunning, "When cloning Nil, the stopwatch should not be running."
		  AssertZero d.Value, "When cloning Nil, the value should be zero."
		  
		  // Dead clone of Nil object
		  
		  d = Nil
		  Try
		    d = New StopwatchKFS( d, False )
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
		  
		  Dim d, d2 As StopwatchKFS
		  
		  AssertTrue d = Nil, "The Operator_Compare method does not think that a Nil StopwatchKFS is Nil."
		  
		  d = StopwatchKFS.NewFromValue( 4 )
		  d2 = StopwatchKFS.NewFromValue( 4 )
		  
		  AssertFalse d = Nil, "The Operator_Compare method thinks that a non-Nil StopwatchKFS is Nil."
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
		  Dim result As StopwatchKFS
		  
		  d1.TotalSeconds = r.InRange( d1.TotalSeconds - 1000, d1.TotalSeconds + 1000 )
		  d2.TotalSeconds = r.InRange( d2.TotalSeconds - 1000, d2.TotalSeconds + 1000 )
		  
		  result = StopwatchKFS.NewFromDateDifference( d1, d2 )
		  
		  AssertEquals d1.TotalSeconds - d2.TotalSeconds, result.Value, "The Date Difference constructor did not correctly calculate the difference."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Call StopwatchKFS.NewFromDateDifference( d1, Nil )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between d1 and Nil."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Call StopwatchKFS.NewFromDateDifference( Nil, d2 )
		    
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
		  
		  Dim d1 As New StopwatchKFS( 12 )
		  Dim d2 As New StopwatchKFS( 4 )
		  
		  AssertEquals 3, d1 / d2, "StopwatchKFS does not correctly calculate ratios of durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerDivision()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure integer division works.
		  
		  Dim d1 As New StopwatchKFS( 12 )
		  Dim d2 As New StopwatchKFS( 5 )
		  
		  AssertEquals 2, d1 \ d2, "StopwatchKFS does not correctly calculate integer ratios of durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInvalidUnit()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure StopwatchKFS fails when dealing with invalid units.
		  
		  Dim d As StopwatchKFS
		  Dim iu As Double = 4.8
		  
		  PushMessageStack "StopwatchKFS did not throw an exception when dealing with an invalid unit."
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "(via constructor)  Result was " + ObjectDescriptionKFS( New StopwatchKFS( 5, iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = StopwatchKFS.NewFromValue( 5 )
		    AssertFailure "(via getting Value property)  Result was " + ObjectDescriptionKFS( d.Value( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = StopwatchKFS.NewFromValue( 5 )
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
		  
		  Dim d As StopwatchKFS = StopwatchKFS.MaximumValue
		  
		  // The maximum value should be 18,446,744,073,709,551,615.
		  
		  Dim m As UInt64 = -1
		  AssertEquals m, d.MicrosecondsValue, "MaximumValue did not return a StopwatchKFS with the expected maximum value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMinimumValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the MinimumValue constructor works.
		  
		  Dim d As StopwatchKFS = StopwatchKFS.MinimumValue
		  
		  // The maximum value should be 0.
		  
		  AssertEquals 0, d.MicrosecondsValue, "MinimumValue did not return a StopwatchKFS with the expected minimum value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestModulo()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure finding a remainder works.
		  
		  Dim d1 As New StopwatchKFS( 12 )
		  Dim d2 As New StopwatchKFS( 5 )
		  Dim expected As New StopwatchKFS( 2 )
		  
		  AssertTrue expected = d1 Mod d2, "StopwatchKFS does not correctly calculate a modulo of two durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMultiplyByScalar()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure multiplying by a scalar works.
		  
		  Dim d As DurationKFS = New StopwatchKFS( 3 )
		  
		  AssertFalse StopwatchKFS(d).IsRunning, "A new StopwatchKFS object apparently had the stopwatch running."
		  AssertEquals 3000000, d.MicrosecondsValue, "A StopwatchKFS did not acquire the requested value."
		  
		  d = d * 3
		  
		  AssertEquals 9000000, d.MicrosecondsValue, "StopwatchKFS * Double did not work."
		  
		  
		  d = New StopwatchKFS( 3 )
		  
		  AssertFalse StopwatchKFS(d).IsRunning, "A new StopwatchKFS object apparently had the stopwatch running."
		  AssertEquals 3000000, d.MicrosecondsValue, "A StopwatchKFS did not acquire the requested value."
		  
		  d = 3 * d
		  
		  AssertEquals 9000000, d.MicrosecondsValue, "Double * StopwatchKFS did not work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromMicrosecondsValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewFromMicrosecondsValue constructor works.
		  
		  Dim d As StopwatchKFS = StopwatchKFS.NewFromMicroseconds( 1194832 )
		  
		  // The MicrosecondsValue of the object should be 1194832.
		  
		  AssertEquals 1194832, d.MicrosecondsValue, "NewFromMicrosecondsValue did not return a StopwatchKFS with the expected value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewStopwatchStartingNow()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewStopwatchStartingNow constructor works.
		  
		  Dim d As StopwatchKFS = StopwatchKFS.NewStopwatchStartingNow
		  
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
		  
		  Dim d As New StopwatchKFS
		  
		  PushMessageStack "ShortHumanReadableStringValue did not return an expected value."
		  
		  AssertEquals "0 us", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "0 us", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "0.00 ms", d.ShortHumanReadableStringValue( StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "0.00 s", d.ShortHumanReadableStringValue( StopwatchKFS.kSeconds ), "", False
		  AssertEquals "0.00 m", d.ShortHumanReadableStringValue( StopwatchKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( StopwatchKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( StopwatchKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( StopwatchKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( StopwatchKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( StopwatchKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( StopwatchKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kCenturies ), "", False
		  
		  d = New StopwatchKFS( 5 )
		  
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( StopwatchKFS.kSeconds ), "", False
		  AssertEquals "0.08 m", d.ShortHumanReadableStringValue( StopwatchKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( StopwatchKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( StopwatchKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( StopwatchKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( StopwatchKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( StopwatchKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( StopwatchKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kCenturies ), "", False
		  
		  AssertEquals "5000000 us", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "5000 ms", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kSeconds ), "", False
		  
		  d = New StopwatchKFS( 5, StopwatchKFS.kCenturies )
		  
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kSeconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMinutes ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kHours ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kDays ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kWeeks ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMonths ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kYears ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kCenturies ), "", False
		  
		  AssertEquals "15778800000000000 us", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "15778800000000 ms", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "15778800000 s", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kSeconds ), "", False
		  AssertEquals "262980000 m", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMinutes ), "", False
		  AssertEquals "4383000 h", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kHours ), "", False
		  AssertEquals "182625 d", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kDays ), "", False
		  AssertEquals "26089 w", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kWeeks ), "", False
		  AssertEquals "6000 mon", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMonths ), "", False
		  AssertEquals "500 y", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kYears ), "", False
		  AssertEquals "50.0 dec", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kCenturies ), "", False
		  
		  d = StopwatchKFS.MaximumValue
		  
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kSeconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMinutes ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kHours ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kDays ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kWeeks ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMonths ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kYears ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kCenturies ), "", False
		  
		  AssertEquals "18446744073709551615 us", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMicroseconds ), "", False
		  AssertEquals "18446744073709552 ms", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMilliseconds ), "", False
		  AssertEquals "18446744073710 s", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kSeconds ), "", False
		  AssertEquals "307445734562 m", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMinutes ), "", False
		  AssertEquals "5124095576 h", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kHours ), "", False
		  AssertEquals "213503982 d", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kDays ), "", False
		  AssertEquals "30500569 w", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kWeeks ), "", False
		  AssertEquals "7014505 mon", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kMonths ), "", False
		  AssertEquals "584542 y", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kYears ), "", False
		  AssertEquals "58454 dec", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( StopwatchKFS.kMicroseconds, StopwatchKFS.kCenturies ), "", False
		  
		  PopMessageStack
		  
		  // Now, make sure that the ShortHumanReadableStringValue fails when it is supposed to.
		  
		  d = New StopwatchKFS( 5 )
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( StopwatchKFS.kYears, StopwatchKFS.kSeconds )
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
		  
		  Dim d As New StopwatchKFS( 1 )
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of one second."
		  
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
		  
		  Dim d As New StopwatchKFS( 1 )
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of one second."
		  
		  d.CancelStopwatch
		  
		  // The stopwatch should still not be running, and the value should still be 1 second.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals 1000000, d.MicrosecondsValue, "The stopwatch value should never have changed."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchSplit()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure splitting the stopwatch works.
		  
		  Dim d As New StopwatchKFS
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of zero."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return increasing results when the stopwatch is running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  
		  Dim d2 As StopwatchKFS = d.Split
		  
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
		  
		  Dim d As New StopwatchKFS
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of zero."
		  
		  Dim d2 As StopwatchKFS = d.Split
		  
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
		  
		  Dim d As New StopwatchKFS
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of zero."
		  
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
		  
		  Dim d As New StopwatchKFS
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of zero."
		  
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
		  
		  Dim d As New StopwatchKFS
		  
		  AssertFalse d.IsRunning, "A StopwatchKFS apparently was initialized with the stopwatch running."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertZero d.MicrosecondsValue, "A StopwatchKFS did not acquire a value of zero."
		  
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
		  
		  // The StopwatchKFS object should not have been affected at all.
		  
		  AssertFalse d.IsRunning, "The stopwatch should still not be running after calling Stop again."
		  AssertFalse MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  AssertEquals valueShouldBe, d.MicrosecondsValue, "The stopwatch value should not have changed after calling Stop again."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSubtractFromDate()
		  // Created 8/19/2010 by Andrew Keller
		  
		  // Make sure that ( Date - StopwatchKFS => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New StopwatchKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = StopwatchKFS.NewFromValue( 75 )
		  
		  result = da - du
		  AssertEquals da.TotalSeconds - du.Value, result.TotalSeconds, "The Date minus StopwatchKFS operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil minus StopwatchKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da - du ) + "."
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
		  
		  d1 = StopwatchKFS.NewFromValue( 8 )
		  d2 = StopwatchKFS.NewFromValue( 3 )
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
		  
		  // Makes sure StopwatchKFS can convert units correctly.
		  
		  TestUnits "microseconds", StopwatchKFS.kMicroseconds, 5, 5
		  TestUnits "milliseconds", StopwatchKFS.kMilliseconds, 5, 5000
		  TestUnits "seconds", StopwatchKFS.kSeconds, 5, 5000000
		  TestUnits "minutes", StopwatchKFS.kMinutes, 5, 300000000
		  TestUnits "hours", StopwatchKFS.kHours, 5, 18000000000
		  TestUnits "days", StopwatchKFS.kDays, 5, 432000000000
		  TestUnits "weeks", StopwatchKFS.kWeeks, 5, 3024000000000
		  TestUnits "months", StopwatchKFS.kMonths, 5, 13149000000000
		  TestUnits "years", StopwatchKFS.kYears, 5, 157788000000000
		  TestUnits "decades", StopwatchKFS.kDecades, 5, 1577880000000000
		  TestUnits "centuries", StopwatchKFS.kCenturies, 5, 15778800000000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnits(unitLabel As String, unitExponent As Double, inputValue As Double, expectedMicroseconds As UInt64)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure StopwatchKFS can handle <unitLabel> correctly.
		  
		  Dim d As StopwatchKFS
		  
		  PushMessageStack "StopwatchKFS was not able to take a value in " + unitLabel + "."
		  
		  d = New StopwatchKFS( inputValue, unitExponent )
		  AssertEquals expectedMicroseconds, d.Value( StopwatchKFS.kMicroseconds ), "(via constructor)"
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  d = New StopwatchKFS( inputValue )
		  If unitExponent = StopwatchKFS.kSeconds Then
		    AssertEquals expectedMicroseconds, d.Value( StopwatchKFS.kMicroseconds ), "(via convert constructor)"
		  Else
		    AssertNotEqual expectedMicroseconds, d.Value( StopwatchKFS.kMicroseconds ), "The convert constructor apparently had the idea that the default units are " + unitLabel + "."
		  End If
		  
		  PopMessageStack
		  PushMessageStack "StopwatchKFS was not able to return a value in " + unitLabel + "."
		  
		  AssertEquals inputValue, d.Value( unitExponent ), "(via the Value property)"
		  
		  AssertEquals inputValue, d.IntegerValue( unitExponent ), "(via the IntegerValue property)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2012 Andrew Keller.
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


	#tag Constant, Name = kStopwatchObservationTimeout, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant


End Class
#tag EndClass
