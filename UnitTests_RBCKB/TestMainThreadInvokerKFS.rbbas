#tag Class
Protected Class TestMainThreadInvokerKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Sets up this class for a test case.
		  
		  hook_invocations.Clear
		  ReDim obj_delay( -1 )
		  ReDim obj_elapsed( -1 )
		  ReDim obj_pool( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Initialize things for this class.
		  
		  hook_invocations = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub VerifyTestCase(testMethodName As String)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Make sure all the objects get deallocated.
		  
		  While UBound( obj_pool ) >= 0
		    
		    // First, verify the state of the object tracking data structure.
		    
		    Dim all_good As Boolean
		    
		    AssertNotIsNil obj_pool(0), "No cell in obj_pool should be Nil.", False
		    AssertNotIsNil obj_delay(0), "No cell in obj_delay should be Nil.", False
		    AssertNotIsNil obj_elapsed(0), "No cell in obj_elapsed should be Nil.", False
		    
		    all_good = Not ( obj_pool(0) Is Nil Or obj_delay(0) Is Nil Or obj_elapsed(0) Is Nil )
		    
		    // Next, make sure the WeakRef points to either
		    // nothing or a MainThreadInvokerKFS object.
		    
		    If obj_pool(0).Value Is Nil Then
		      
		      // This is valid.  Do nothing.
		      
		    ElseIf obj_pool(0).Value IsA MainThreadInvokerKFS Then
		      
		      // This is also valid.  Do nothing.
		      
		    Else
		      
		      // The object in this WeakRef is not valid.
		      
		      AssertIsNil obj_pool(0).Value, "An invalid object was found in the obj_pool node.", False
		      all_good = False
		      
		    End If
		    
		    // Continue with tests?
		    
		    If Not all_good Then _
		    AssertFailure "Bailing out because the state of the object tracking data structure has been compromised."
		    
		    
		    // Okay, it looks like the state of the object tracking data structure
		    // is just fine.  Check for items that should be gone by now.
		    
		    If obj_elapsed(0) > ( obj_delay(0) + DurationKFS.NewFromValue( kDelayGracePeriod, DurationKFS.kMilliseconds ) ) Then
		      
		      If obj_pool(0).Value Is Nil Then
		        
		        // This is good.  Do nothing.
		        
		      Else
		        
		        AssertFailure "A MainThreadInvokerKFS object did not deallocate after its delay expired.", False
		        
		      End If
		      
		      // Regardless of what happened, remove the item.
		      
		      obj_pool.Remove 0
		      obj_delay.Remove 0
		      obj_elapsed.Remove 0
		      
		    Else
		      
		      // The time for this object to deallocate has not yet come.
		      
		      App.YieldToNextThread
		      
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
		    
		    If hook_invocations.HasKey( hook_id ) Then
		      
		      AssertFailure "Hook "+Str(hook_id)+" was invoked more than once.  A hook can only be reused after AssertHookDidRun has been called.", _
		      "Expected no invocation record for hook "+Str(hook_id)+" but found one."
		      
		    Else
		      
		      hook_invocations.Value( hook_id ) = CType( Microseconds, Int64 )
		      
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
		  
		  Dim elapsed As DurationKFS = DurationKFS.NewStopwatchStartingNow
		  Dim max_delay As DurationKFS = DurationKFS.NewFromValue( delay + kDelayGracePeriod, DurationKFS.kMilliseconds )
		  
		  If msg = "" Then msg = "The hook was not supposed to fire."
		  
		  While elapsed < max_delay
		    
		    If hook_invocations.HasKey( hook_id ) Then
		      
		      // The hook ran.
		      
		      hook_invocations.Remove hook_id
		      
		      AssertFailure msg, "Expected that hook "+Str(hook_id)+" would not run, but it did.", is_terminal
		      
		      Return
		      
		    End If
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertHookDidRun(hook_id As Int64, delay As Integer, is_terminal As Boolean = True)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Raises an exception if the action hook does not run.
		  
		  delay = Max( delay, 1 )
		  
		  Dim now As Int64 = Microseconds
		  Dim elapsed As DurationKFS = DurationKFS.NewStopwatchStartingNow
		  Dim min_delay As DurationKFS = DurationKFS.NewFromValue( delay + kDelayOverhead, DurationKFS.kMilliseconds )
		  Dim max_delay As DurationKFS = DurationKFS.NewFromValue( delay + kDelayGracePeriod, DurationKFS.kMilliseconds )
		  
		  While elapsed < max_delay
		    
		    If hook_invocations.HasKey( hook_id ) Then
		      
		      // The hook ran.
		      
		      elapsed = DurationKFS.NewFromMicroseconds( hook_invocations.Value(hook_id) - now )
		      
		      hook_invocations.Remove hook_id
		      
		      If elapsed < min_delay Then
		        
		        AssertFailure "The hook was invoked too soon.", "Expected "+min_delay.ShortHumanReadableStringValue+" < t < "+max_delay.ShortHumanReadableStringValue+" but found "+elapsed.ShortHumanReadableStringValue+".", is_terminal
		        
		      ElseIf elapsed > max_delay Then
		        
		        AssertFailure "The hook was invoked too late.", "Expected "+min_delay.ShortHumanReadableStringValue+" < t < "+max_delay.ShortHumanReadableStringValue+" but found "+elapsed.ShortHumanReadableStringValue+".", is_terminal
		        
		      Else
		        
		        // The hook fired within the correct range of time.
		        
		      End If
		      
		      Return
		      
		    End If
		  Wend
		  
		  AssertFailure "The hook never fired, and I'm not waiting around for it.", is_terminal
		  
		  // done.
		  
		End Sub
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
		  
		  Dim m As New MainThreadInvokerKFS( d )
		  
		  TrackObject m, kDefaultDelay
		  
		  Return m
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeObject(d As PlainMethod, delay As Integer) As MainThreadInvokerKFS
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Creates, Tracks, and Returns a new MainThreadInvokerKFS
		  // object created using the given parameters.
		  
		  Dim m As New MainThreadInvokerKFS( d, delay )
		  
		  TrackObject m, delay
		  
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
		  
		  AssertHookDidRun tid, 0
		  
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
		Sub TestGetters_nil()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim m As MainThreadInvokerKFS = MakeObject( Nil )
		  
		  AssertEquals 1, m.Delay, "The delay of a new MainThreadInvokerKFS object should be 1 when not provided.", False
		  AssertFalse m.IsSet, "A new MainThreadInvokerKFS object with Nil as the target should not be set by default.", False
		  AssertIsNil m.Target, "A new MainThreadInvokerKFS object with Nil as the target should have Nil as the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_nil_n()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim m As MainThreadInvokerKFS = MakeObject( Nil, -100 )
		  
		  AssertEquals 1, m.Delay, "The delay of the MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A new MainThreadInvokerKFS object with Nil as the target should not be set by default.", False
		  AssertIsNil m.Target, "A new MainThreadInvokerKFS object with Nil as the target should have Nil as the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_nil_p()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim m As MainThreadInvokerKFS = MakeObject( Nil, 100 )
		  
		  AssertEquals 1, m.Delay, "The delay of the MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A new MainThreadInvokerKFS object with Nil as the target should not be set by default.", False
		  AssertIsNil m.Target, "A new MainThreadInvokerKFS object with Nil as the target should have Nil as the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_nil_z()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim m As MainThreadInvokerKFS = MakeObject( Nil, 0 )
		  
		  AssertEquals 1, m.Delay, "The delay of the MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A new MainThreadInvokerKFS object with Nil as the target should not be set by default.", False
		  AssertIsNil m.Target, "A new MainThreadInvokerKFS object with Nil as the target should have Nil as the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_postvalid()
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim tid As Int64
		  Dim t As PlainMethod = MakeHook(tid)
		  Dim m As MainThreadInvokerKFS = MakeObject( t )
		  
		  AssertHookDidRun tid, 1
		  
		  AssertEquals 1, m.Delay, "The delay of an expired MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A MainThreadInvokerKFS object should be unset after invoking its target.", False
		  AssertIsNil m.Target, "The target of a MainThreadInvokerKFS object should be Nil after invoking the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_postvalid_n()
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim tid As Int64
		  Dim t As PlainMethod = MakeHook(tid)
		  Dim m As MainThreadInvokerKFS = MakeObject( t, -100 )
		  
		  AssertHookDidRun tid, -100
		  
		  AssertEquals 1, m.Delay, "The delay of an expired MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A MainThreadInvokerKFS object should be unset after invoking its target.", False
		  AssertIsNil m.Target, "The target of a MainThreadInvokerKFS object should be Nil after invoking the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_postvalid_p()
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim tid As Int64
		  Dim t As PlainMethod = MakeHook(tid)
		  Dim m As MainThreadInvokerKFS = MakeObject( t, 100 )
		  
		  AssertHookDidRun tid, 100
		  
		  AssertEquals 1, m.Delay, "The delay of an expired MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A MainThreadInvokerKFS object should be unset after invoking its target.", False
		  AssertIsNil m.Target, "The target of a MainThreadInvokerKFS object should be Nil after invoking the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_postvalid_z()
		  // Created 8/8/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim tid As Int64
		  Dim t As PlainMethod = MakeHook(tid)
		  Dim m As MainThreadInvokerKFS = MakeObject( t, 0 )
		  
		  AssertHookDidRun tid, 0
		  
		  AssertEquals 1, m.Delay, "The delay of an expired MainThreadInvokerKFS object should be 1.", False
		  AssertFalse m.IsSet, "A MainThreadInvokerKFS object should be unset after invoking its target.", False
		  AssertIsNil m.Target, "The target of a MainThreadInvokerKFS object should be Nil after invoking the target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_valid()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim t As PlainMethod = MakeHook
		  Dim m As MainThreadInvokerKFS = MakeObject( t )
		  
		  AssertEquals 1, m.Delay, "The delay of a new MainThreadInvokerKFS object should be 1 when not provided.", False
		  AssertTrue m.IsSet, "A new MainThreadInvokerKFS object with a valid target should be set by default.", False
		  AssertSame t, m.Target, "A MainThreadInvokerKFS object should be able to return its target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_valid_n()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim t As PlainMethod = MakeHook
		  Dim m As MainThreadInvokerKFS = MakeObject( t, -100 )
		  
		  AssertEquals 1, m.Delay, "The delay of the MainThreadInvokerKFS object should be 1.", False
		  AssertTrue m.IsSet, "A new MainThreadInvokerKFS object with a valid target should be set by default.", False
		  AssertSame t, m.Target, "A MainThreadInvokerKFS object should be able to return its target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_valid_p()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim t As PlainMethod = MakeHook
		  Dim m As MainThreadInvokerKFS = MakeObject( t, 100 )
		  
		  AssertEquals 100, m.Delay, "The delay of the MainThreadInvokerKFS object should be 100.", False
		  AssertTrue m.IsSet, "A new MainThreadInvokerKFS object with a valid target should be set by default.", False
		  AssertSame t, m.Target, "A MainThreadInvokerKFS object should be able to return its target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetters_valid_z()
		  // Created 8/2/2011 by Andrew Keller
		  
		  // Makes sure the getters always work.
		  
		  Dim t As PlainMethod = MakeHook
		  Dim m As MainThreadInvokerKFS = MakeObject( t, 0 )
		  
		  AssertEquals 1, m.Delay, "The delay of the MainThreadInvokerKFS object should be 1.", False
		  AssertTrue m.IsSet, "A new MainThreadInvokerKFS object with a valid target should be set by default.", False
		  AssertSame t, m.Target, "A MainThreadInvokerKFS object should be able to return its target.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTimerPeriod_n()
		  // Created 8/4/2011 by Andrew Keller
		  
		  // Makes sure that REALbasic's Timer class sanitizes the Period property as expected.
		  
		  Dim t As New Timer
		  
		  t.Period = -15
		  
		  AssertEquals 1, t.Period, "REALbasic's Timer class was supposed to sanitize a Period of -15 to the value 1."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTimerPeriod_z()
		  // Created 8/4/2011 by Andrew Keller
		  
		  // Makes sure that REALbasic's Timer class sanitizes the Period property as expected.
		  
		  Dim t As New Timer
		  
		  t.Period = 0
		  
		  AssertEquals 1, t.Period, "REALbasic's Timer class was supposed to sanitize a Period of zero to the value 1."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TrackObject(obj As MainThreadInvokerKFS, delay As Integer)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Remembers the given object so that we can make sure it deallocates.
		  
		  If Not ( obj Is Nil ) Then
		    
		    obj_pool.Append New WeakRef( obj )
		    obj_delay.Append New DurationKFS( Max( delay, 0 ), DurationKFS.kMilliseconds )
		    obj_elapsed.Append DurationKFS.NewStopwatchStartingNow
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
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
		Protected hook_invocations As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected obj_delay() As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected obj_elapsed() As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected obj_pool() As WeakRef
	#tag EndProperty


	#tag Constant, Name = kDefaultDelay, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDelayGracePeriod, Type = Double, Dynamic = False, Default = \"500", Scope = Protected
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
