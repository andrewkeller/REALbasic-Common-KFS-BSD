#tag Class
Protected Class TestMainThreadInvokerKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Sets up this class for a test case.
		  
		  p_hook_invocations.Clear
		  ReDim p_obj_delay( -1 )
		  ReDim p_obj_elapsed( -1 )
		  ReDim p_obj_pool( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Initialize things for this class.
		  
		  p_hook_invocations = New Dictionary
		  
		  // Add the virtual test cases.
		  
		  Call DefineVirtualTestCase "TestGetters_nil", _
		  ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestGetters_nil, New Dictionary )
		  
		  Call DefineVirtualTestCase "TestGetters_postvalid", _
		  ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestGetters_postvalid, New Dictionary )
		  
		  Call DefineVirtualTestCase "TestGetters_valid", _
		  ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestGetters_valid, New Dictionary )
		  
		  Dim suffix_fmt As String = "\_\p0;\_\n0;\_\z"
		  
		  For Each udelay As Int64 In Array( -100, -1, 0, 1, 2, 100 )
		    
		    Dim options As New Dictionary( "udelay" : udelay )
		    
		    Call DefineVirtualTestCase "TestGetters_nil" + Format( udelay, suffix_fmt ), _
		    ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestGetters_nil, options )
		    
		    Call DefineVirtualTestCase "TestGetters_postvalid" + Format( udelay, suffix_fmt ), _
		    ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestGetters_postvalid, options )
		    
		    Call DefineVirtualTestCase "TestGetters_valid" + Format( udelay, suffix_fmt ), _
		    ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestGetters_valid, options )
		    
		    Call DefineVirtualTestCase "TestTimerPeriod" + Format( udelay, suffix_fmt ), _
		    ClosuresKFS.NewClosure_From_Int64( AddressOf TestTimerPeriod, udelay )
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub VerifyTestCase(testMethodName As String)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Make sure all the objects get deallocated.
		  
		  Dim grace_cycles As Integer = 0
		  
		  While UBound( p_obj_pool ) >= 0
		    
		    // First, verify the state of the object tracking data structure.
		    
		    Dim all_good As Boolean
		    
		    AssertNotIsNil p_obj_pool(0), "No cell in p_obj_pool should be Nil.", False
		    AssertNotIsNil p_obj_delay(0), "No cell in p_obj_delay should be Nil.", False
		    AssertNotIsNil p_obj_elapsed(0), "No cell in p_obj_elapsed should be Nil.", False
		    
		    all_good = Not ( p_obj_pool(0) Is Nil Or p_obj_delay(0) Is Nil Or p_obj_elapsed(0) Is Nil )
		    
		    // Next, make sure the WeakRef points to either
		    // nothing or a MainThreadInvokerKFS object.
		    
		    If p_obj_pool(0).Value Is Nil Then
		      
		      // This is valid.  Do nothing.
		      
		    ElseIf p_obj_pool(0).Value IsA MainThreadInvokerKFS Then
		      
		      // This is also valid.  Do nothing.
		      
		    Else
		      
		      // The object in this WeakRef is not valid.
		      
		      AssertIsNil p_obj_pool(0).Value, "An invalid object was found in the p_obj_pool node.", False
		      all_good = False
		      
		    End If
		    
		    // Continue with tests?
		    
		    If Not all_good Then _
		    AssertFailure "Bailing out because the state of the object tracking data structure has been compromised."
		    
		    
		    // Okay, it looks like the state of the object tracking data structure
		    // is just fine.  Check for items that should be gone by now.
		    
		    If p_obj_pool(0).Value Is Nil Then
		      
		      // This is good.  Remove the item from the pool.
		      
		      p_obj_pool.Remove 0
		      p_obj_delay.Remove 0
		      p_obj_elapsed.Remove 0
		      grace_cycles = 0
		      
		    ElseIf p_obj_elapsed(0) > p_obj_delay(0) Then
		      
		      // The base delay has expired.  Have the grace cycles expired?
		      
		      If grace_cycles > kDelayGraceCycles Then
		        
		        // The delay has expired, and the object has not deallocated yet.
		        
		        AssertFailure "A MainThreadInvokerKFS object did not deallocate after its delay expired.", False
		        
		        p_obj_pool.Remove 0
		        p_obj_delay.Remove 0
		        p_obj_elapsed.Remove 0
		        grace_cycles = 0
		        
		      Else
		        grace_cycles = grace_cycles + 1
		      End If
		      
		    Else
		      
		      // This object has not deallocated yet, however there is still time.
		      
		    End If
		    
		    // And repeat until everything is accounted for.
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub action_hook(hook_id As Int64)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // A method that records that this method was called.
		  // Useful as an action hook for the MainThreadInvokerKFS class.
		  
		  If hook_id > 0 Then
		    
		    // Evidence of this invocation should be recorded.
		    
		    If p_hook_invocations.HasKey( hook_id ) Then
		      
		      AssertFailure "Hook "+Str(hook_id)+" was invoked more than once.  A hook can only be reused after AssertHookDidRun has been called.", _
		      "Expected no invocation record for hook "+Str(hook_id)+" but found one."
		      
		    Else
		      
		      p_hook_invocations.Value( hook_id ) = CType( Microseconds, Int64 )
		      
		    End If
		  Else
		    
		    // Evidence of this invocation should not be recorded.
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertHookDidNotRun(hook_id As Int64, delay As Integer, msg As String, is_terminal As Boolean = True)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Raises an exception if the action hook runs.
		  
		  delay = Max( delay, 1 )
		  
		  Dim elapsed As DurationKFS = StopwatchKFS.NewStopwatchStartingNow
		  Dim max_delay As DurationKFS = DurationKFS.NewWithValue( delay, DurationKFS.kMilliseconds )
		  Dim grace_cycles As Integer = 0
		  
		  If msg = "" Then msg = "Hook "+Str(hook_id)+" was not supposed to fire."
		  
		  Do
		    If p_hook_invocations.HasKey( hook_id ) Then
		      
		      // The hook ran.
		      
		      p_hook_invocations.Remove hook_id
		      
		      AssertFailure msg, "Expected that hook "+Str(hook_id)+" would not run, but it did.", is_terminal
		      
		      Return
		      
		    Else
		      App.YieldToNextThread
		    End If
		    
		    If elapsed > max_delay Then
		      
		      grace_cycles = grace_cycles + 1
		      
		      If grace_cycles > kDelayGraceCycles Then
		        
		        Exit
		        
		      End If
		    End If
		  Loop
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertHookDidRun(hook_id As Int64, delay As Integer, is_terminal As Boolean = True)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Raises an exception if the action hook does not run.
		  
		  delay = Max( delay, 1 )
		  
		  Dim now As Int64 = Microseconds
		  Dim elapsed As DurationKFS = StopwatchKFS.NewStopwatchStartingNow
		  Dim min_delay As DurationKFS = DurationKFS.NewWithValue( delay + kDelayOverhead, DurationKFS.kMilliseconds )
		  Dim max_delay As DurationKFS = DurationKFS.NewWithValue( delay, DurationKFS.kMilliseconds )
		  Dim grace_cycles As Integer = 0
		  
		  Do
		    If p_hook_invocations.HasKey( hook_id ) Then
		      
		      // The hook ran.
		      
		      elapsed = DurationKFS.NewWithMicroseconds( p_hook_invocations.Value(hook_id) - now )
		      
		      p_hook_invocations.Remove hook_id
		      
		      If elapsed < min_delay Then
		        
		        AssertFailure "Hook "+Str(hook_id)+" was invoked too soon.", "Expected "+min_delay.ShortHumanReadableStringValue+" < t < "+max_delay.ShortHumanReadableStringValue+" but found t = "+elapsed.ShortHumanReadableStringValue+".", is_terminal
		        
		      ElseIf elapsed > max_delay And grace_cycles > kDelayGraceCycles Then
		        
		        AssertFailure "Hook "+Str(hook_id)+" was invoked too late.", "Expected "+min_delay.ShortHumanReadableStringValue+" < t < "+max_delay.ShortHumanReadableStringValue+" but found t = "+elapsed.ShortHumanReadableStringValue+".", is_terminal
		        
		      Else
		        
		        // The hook fired within the correct range of time.
		        
		      End If
		      
		      Return
		      
		    Else
		      App.YieldToNextThread
		    End If
		    
		    If elapsed > max_delay Then
		      
		      grace_cycles = grace_cycles + 1
		      
		      If grace_cycles > kDelayGraceCycles Then
		        
		        Exit
		        
		      End If
		    End If
		  Loop
		  
		  AssertFailure "It's "+DurationKFS( elapsed - max_delay ).ShortHumanReadableStringValue(DurationKFS.kMilliseconds) _
		  +" after the delay ("+DurationKFS.NewWithValue( delay, DurationKFS.kMilliseconds ).ShortHumanReadableStringValue(DurationKFS.kMilliseconds) _
		  +"), hook "+Str(hook_id)+" has not fired, and I'm not waiting around for it.", is_terminal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetExpectedDelay(target_is_active As Boolean, delay As Integer) As Integer
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Returns the expected delay for the given target and unsanitized delay.
		  
		  If target_is_active Then
		    
		    Return Max( 1, delay )
		    
		  Else
		    
		    Return 1
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeHook() As PlainMethod
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Returns a new hook to invoke with a generic (untracked) ID.
		  
		  Return ClosuresKFS.NewClosure_From_Int64( AddressOf action_hook, 0 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeHook(ByRef hook_id As Int64) As PlainMethod
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Returns a new hook to invoke, and the ID associated with it.
		  
		  Static counter As Int64 = 0
		  
		  counter = counter + 1
		  hook_id = counter
		  
		  Return ClosuresKFS.NewClosure_From_Int64( AddressOf action_hook, counter )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeObject(d As PlainMethod) As MainThreadInvokerKFS
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Creates, Tracks, and Returns a new MainThreadInvokerKFS
		  // object created using the given parameter.
		  
		  Dim life_time As DurationKFS = StopwatchKFS.NewStopwatchStartingNow
		  Dim m As New MainThreadInvokerKFS( d )
		  
		  TrackObject m, kDefaultDelay, life_time
		  
		  Return m
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeObject(d As PlainMethod, delay As Integer) As MainThreadInvokerKFS
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Creates, Tracks, and Returns a new MainThreadInvokerKFS
		  // object created using the given parameters.
		  
		  Dim life_time As DurationKFS = StopwatchKFS.NewStopwatchStartingNow
		  Dim m As New MainThreadInvokerKFS( d, delay )
		  
		  TrackObject m, delay, life_time
		  
		  Return m
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub PlainMethod()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub TestCancel_nil()
		  // Created 8/5/2011 by Andrew Keller
		  
		  // Makes sure the Cancel method works when the object is not set.
		  
		  Dim m As MainThreadInvokerKFS = MakeObject( Nil )
		  
		  Try
		    
		    m.Cancel
		    
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    
		    AssertFailure err, "The cancel method should never fail (an exception should not have been raised).", False
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCancel_postvalid()
		  // Created 8/5/2011 by Andrew Keller
		  
		  // Makes sure the Cancel method works when the object is not set.
		  
		  Dim tid As Int64
		  Dim m As MainThreadInvokerKFS = MakeObject( MakeHook(tid) )
		  
		  AssertHookDidRun tid, 1
		  
		  Try
		    
		    m.Cancel
		    
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    
		    AssertFailure err, "The cancel method should never fail (an exception should not have been raised).", False
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCancel_valid()
		  // Created 8/5/2011 by Andrew Keller
		  
		  // Makes sure the Cancel method works when the object is not set.
		  
		  Dim m As MainThreadInvokerKFS = MakeObject( MakeHook, 100 )
		  
		  Try
		    
		    m.Cancel
		    
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    
		    AssertFailure err, "The cancel method should never fail (an exception should not have been raised).", False
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor()
		  // Created 8/1/2011 by Andrew Keller
		  
		  // Makes sure the constructor works.
		  
		  // Unfortunately, we have no way to verify the state of the data
		  // inside a MainThreadInvokerKFS object, except through the getters,
		  // which may or may not work.  Additionally, testing the getters
		  // transitively suggests that the constructor works at least well
		  // enough.  So, just about the only thing we can test here is that
		  // the constructor does not crash with any input.
		  
		  Dim m As MainThreadInvokerKFS
		  
		  // The constructor should never crash, even with the following inputs.
		  
		  PushMessageStack "While initializing a new MainThreadInvokerKFS object with "
		  
		  PushMessageStack "a valid delegate"
		  m = MakeObject( MakeHook )
		  PopMessageStack
		  
		  PushMessageStack "an invalid delegate"
		  m = MakeObject( Nil )
		  PopMessageStack
		  
		  PushMessageStack "a valid delegate and a delay of 10"
		  m = MakeObject( MakeHook, 10 )
		  PopMessageStack
		  
		  PushMessageStack "a valid delegate and a delay of 0"
		  m = MakeObject( MakeHook, 0 )
		  PopMessageStack
		  
		  PushMessageStack "a valid delegate and a delay of -10"
		  m = MakeObject( MakeHook, -10 )
		  PopMessageStack
		  
		  PushMessageStack "an invalid delegate and a delay of 10"
		  m = MakeObject( Nil, 10 )
		  PopMessageStack
		  
		  PushMessageStack "an invalid delegate and a delay of 0"
		  m = MakeObject( Nil, 0 )
		  PopMessageStack
		  
		  PushMessageStack "an invalid delegate and a delay of -10"
		  m = MakeObject( Nil, -10 )
		  PopMessageStack
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_nil(options As Dictionary)
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim provide_delay As Boolean = options.HasKey( "udelay" )
		  Dim udelay As Integer = options.Lookup( "udelay", 1 )
		  Dim sdelay As Integer = GetExpectedDelay( False, udelay )
		  
		  Dim m As MainThreadInvokerKFS
		  If provide_delay Then
		    
		    m = MakeObject( Nil, udelay )
		    
		  Else
		    
		    m = MakeObject( Nil )
		    
		  End If
		  
		  AssertEquals sdelay, m.Delay, "The delay of the MainThreadInvokerKFS object should be "+Str(sdelay)+".", False
		  AssertFalse m.IsSet, "A new MainThreadInvokerKFS object with Nil as the target should not be set by default.", False
		  AssertIsNil m.Target, "A new MainThreadInvokerKFS object with Nil as the target should have Nil as the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_postvalid(options As Dictionary)
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim provide_delay As Boolean = options.HasKey( "udelay" )
		  Dim udelay As Integer = options.Lookup( "udelay", 1 )
		  Dim sdelay As Integer = GetExpectedDelay( False, udelay )
		  
		  Dim tid As Int64
		  Dim t As PlainMethod = MakeHook(tid)
		  Dim m As MainThreadInvokerKFS
		  If provide_delay Then
		    
		    m = MakeObject( t, udelay )
		    
		  Else
		    
		    m = MakeObject( t )
		    
		  End If
		  
		  AssertHookDidRun tid, udelay
		  
		  AssertEquals sdelay, m.Delay, "The delay of an expired MainThreadInvokerKFS object should be "+Str(sdelay)+".", False
		  AssertFalse m.IsSet, "A MainThreadInvokerKFS object should be unset after invoking its target.", False
		  AssertIsNil m.Target, "The target of a MainThreadInvokerKFS object should be Nil after invoking the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_valid(options As Dictionary)
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim provide_delay As Boolean = options.HasKey( "udelay" )
		  Dim udelay As Integer = options.Lookup( "udelay", 1 )
		  Dim sdelay As Integer = GetExpectedDelay( True, udelay )
		  
		  Dim t As PlainMethod = MakeHook
		  Dim m As MainThreadInvokerKFS
		  If provide_delay Then
		    
		    m = MakeObject( t, udelay )
		    
		  Else
		    
		    m = MakeObject( t )
		    
		  End If
		  
		  AssertEquals sdelay, m.Delay, "The delay of the MainThreadInvokerKFS object should be "+Str(sdelay)+".", False
		  AssertTrue m.IsSet, "A new MainThreadInvokerKFS object with a valid target should be set by default.", False
		  AssertSame t, m.Target, "A MainThreadInvokerKFS object should be able to return its target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTimerPeriod(unsanitized_delay As Int64)
		  // Created 8/4/2011 by Andrew Keller
		  
		  // Makes sure that REALbasic's Timer class sanitizes the Period property as expected.
		  
		  Dim sdelay As Integer = GetExpectedDelay( True, unsanitized_delay )
		  
		  Dim t As New Timer
		  
		  t.Period = unsanitized_delay
		  
		  AssertEquals sdelay, t.Period, "REALbasic's Timer class was supposed to sanitize a Period of "+Str(unsanitized_delay)+" to the value "+Str(sdelay)+"."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TrackObject(obj As MainThreadInvokerKFS, delay As Integer, life_time As DurationKFS)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Remembers the given object so that we can make sure it deallocates.
		  
		  If Not ( obj Is Nil ) Then
		    
		    p_obj_pool.Append New WeakRef( obj )
		    p_obj_delay.Append New DurationKFS( Max( delay, 0 ), DurationKFS.kMilliseconds )
		    p_obj_elapsed.Append life_time
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011, 2012 Andrew Keller.
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
		Protected p_hook_invocations As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_obj_delay() As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_obj_elapsed() As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_obj_pool() As WeakRef
	#tag EndProperty


	#tag Constant, Name = kDefaultDelay, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDelayGraceCycles, Type = Double, Dynamic = False, Default = \"1000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDelayOverhead, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
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
