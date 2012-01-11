#tag Class
Protected Class TestProgressDelegateKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 11/21/2011 by Andrew Keller
		  
		  // Initialize things for this test case.
		  
		  ReDim p_expectations(-1)
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub AddExpectation(failureCode As Variant, failureMessage As String, group_with_previous_expectation As Boolean, additional_attrs As Dictionary)
		  // Created 11/22/2011 by Andrew Keller
		  
		  // Adds the given expectation to the list of expectations.
		  
		  Dim d As New Dictionary
		  
		  If Not ( additional_attrs Is Nil ) Then
		    For Each k As Variant In additional_attrs.Keys
		      d.Value( k ) = additional_attrs.Value( k )
		    Next
		  End If
		  
		  d.Value( kExpectationCoreTypeCodeKey ) = failureCode
		  
		  d.Value( kExpectationCoreFailureMessageKey ) = failureMessage
		  
		  d.Value( kExpectationCoreGroupWithPreviousExpectationKey ) = group_with_previous_expectation
		  
		  p_expectations.Append d
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddMessageChangedCallbackInvocationExpectation(group_with_previous_expectation As Boolean, parent_obj As ProgressDelegateKFS, throw_exception_within_handler As Boolean, failureMessage As String = kDefaultMessageChangedCallbackFailureMessage)
		  // Created 11/22/2011 by Andrew Keller
		  
		  // Adds an expectation that the MessageChanged callback should be invoked.
		  
		  AddExpectation kExpectationPGDTypeCodeMessageChanged, failureMessage, group_with_previous_expectation, New Dictionary( _
		  kExpectationCoreParentObjectKey : parent_obj )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddMessageOrValueChangedCallbackInvocationExpectation(group_with_previous_expectation As Boolean, parent_obj As ProgressDelegateKFS, throw_exception_within_handler As Boolean, failureMessage As String = kDefaultMessageChangedCallbackFailureMessage)
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Adds an expectation that the MessageOrValueChanged callback should be invoked.
		  
		  AddExpectation kExpectationPGDTypeCodeMessageOrValueChanged, failureMessage, group_with_previous_expectation, New Dictionary( _
		  kExpectationCoreParentObjectKey : parent_obj )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddValueChangedCallbackInvocationExpectation(group_with_previous_expectation As Boolean, parent_obj As ProgressDelegateKFS, throw_exception_within_handler As Boolean, failureMessage As String = kDefaultValueChangedCallbackFailureMessage)
		  // Created 11/22/2011 by Andrew Keller
		  
		  // Adds an expectation that the ValueChanged callback should be invoked.
		  
		  AddExpectation kExpectationPGDTypeCodeValueChanged, failureMessage, group_with_previous_expectation, New Dictionary( _
		  kExpectationCoreParentObjectKey : parent_obj )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AllExpectationsHaveBeenSatisfied() As Boolean
		  // Created 11/23/2011 by Andrew Keller
		  
		  // Returns whether or not all expectations have been satisfied.
		  
		  For Each d As Dictionary In p_expectations
		    If Not ( d Is Nil ) Then
		      If d.Lookup( kExpectationCoreSatisfactionCount, 0 ) < d.Lookup( kExpectationCoreRequiredSatisfactionCount, 1 ) Then
		        Return False
		      End If
		    End If
		  Next
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertAllExpectationsHaveBeenSatisfied(failureMessage As String = kDefaultUnsatisfiedExpectationsMessage, isTerminal As Boolean = True)
		  // Created 11/22/2011 by Andrew Keller
		  
		  // Asserts that all expectations have been satisfied.
		  
		  Dim msgs() As String
		  
		  For Each d As Dictionary In p_expectations
		    If Not ( d Is Nil ) Then
		      If d.Lookup( kExpectationCoreSatisfactionCount, 0 ) < d.Lookup( kExpectationCoreRequiredSatisfactionCount, 1 ) Then
		        msgs.Append d.Lookup( kExpectationCoreFailureMessageKey, "(undescribed expectation)" )
		      End If
		    End If
		  Next
		  
		  If UBound( msgs ) < 0 Then
		    
		    AssertionCount = AssertionCount + 1
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected no unsatisfied expectations but found:" + EndOfLineKFS + " * " + Join( msgs, EndOfLineKFS + " * " )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertExpectationIsExpected(expected_attrs As Dictionary, ByRef found_attrs As Dictionary, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/22/2011 by Andrew Keller
		  
		  // Asserts that the given expectation is currently expected, and
		  // returns the expectation specification through the found_attrs parameter.
		  
		  found_attrs = Nil
		  
		  If expected_attrs Is Nil Then
		    AssertNotIsNil expected_attrs, "Cannot assert that an expectation is expected if you pass Nil for the Expected Attributes parameter.", isTerminal
		  Else
		    
		    Dim relative_group_offset As Integer
		    found_attrs = GetExpectationSpecificationWithAttributes( expected_attrs, relative_group_offset )
		    
		    If failureMessage = "" Then
		      failureMessage = "Unexpected expectation."
		    Else
		      failureMessage = "Unexpected expectation: " + failureMessage
		    End If
		    
		    If found_attrs Is Nil Then
		      
		      AssertFailure failureMessage, "Expected an expected expectation, but found an expectation that I've never heard of.", isTerminal
		      
		    Else
		      
		      Dim required As Integer = found_attrs.Lookup( kExpectationCoreRequiredSatisfactionCount, 1 )
		      Dim found As Integer = found_attrs.Lookup( kExpectationCoreSatisfactionCount, 0 )
		      
		      found = found + 1
		      
		      found_attrs.Value( kExpectationCoreSatisfactionCount ) = found
		      
		      If relative_group_offset < 0 Then
		        
		        AssertFailure failureMessage, "Expected this expectation in the past, but found it now.", isTerminal
		        
		      ElseIf relative_group_offset > 0 Then
		        
		        AssertFailure failureMessage, "Expected this expectation in the future, but found it now.", isTerminal
		        
		      ElseIf found > required Then
		        
		        AssertFailure failureMessage, "Expected this expectation " + Str( required ) + " time(s), but this is invocation number " + Str( found ) + ".", isTerminal
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertExpectationIsExpected(expectation_attrs As Dictionary, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/22/2011 by Andrew Keller
		  
		  // An overloaded version of AssertExpectationIsExpected.
		  
		  Dim d As Dictionary
		  AssertExpectationIsExpected expectation_attrs, d, failureMessage, isTerminal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetExpectationSpecificationWithAttributes(attrs As Dictionary, ignore_satisfied_expectations As Boolean = False) As Dictionary
		  // Created 11/23/2011 by Andrew Keller
		  
		  // An overloaded version of GetExpectationSpecificationWithAttributes.
		  
		  Dim offset As Integer
		  Return GetExpectationSpecificationWithAttributes( attrs, offset, ignore_satisfied_expectations )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetExpectationSpecificationWithAttributes(attrs As Dictionary, ByRef relative_expectation_group_offset As Integer, ignore_satisfied_expectations As Boolean = False) As Dictionary
		  // Created 11/23/2011 by Andrew Keller
		  
		  // Finds the fist expectation with the given attributes, and
		  // determines its group offset from the currently expected group.
		  
		  Dim rslt As Dictionary = Nil
		  Dim offset As Integer = 0
		  relative_expectation_group_offset = 0
		  
		  Dim still_looking_for_the_current_group As Boolean = True
		  Dim still_looking_for_the_target As Boolean = True
		  Dim this_group_has_unsatisfied_expectations As Boolean = False
		  Dim first_iteration As Boolean = True
		  
		  For Each d As Dictionary In p_expectations
		    If Not ( d Is Nil ) Then
		      
		      If first_iteration Then
		        
		        first_iteration = False
		        
		      ElseIf d.Lookup( kExpectationCoreGroupWithPreviousExpectationKey, False ).BooleanValue = False Then
		        
		        If this_group_has_unsatisfied_expectations Then still_looking_for_the_current_group = False
		        
		        If still_looking_for_the_current_group Then offset = offset -1
		        If still_looking_for_the_target Then offset = offset + 1
		        
		        this_group_has_unsatisfied_expectations = False
		        
		      End If
		      
		      If d.Lookup( kExpectationCoreSatisfactionCount, 0 ) < d.Lookup( kExpectationCoreRequiredSatisfactionCount, 1 ) Then this_group_has_unsatisfied_expectations = True
		      
		      If still_looking_for_the_target Then
		        If ignore_satisfied_expectations Or d.Lookup( kExpectationCoreSatisfactionCount, 0 ) < d.Lookup( kExpectationCoreRequiredSatisfactionCount, 1 ) Then
		          
		          Dim this_is_the_one As Boolean = True
		          
		          For Each k As Variant In attrs.Keys
		            If Not ( d.HasKey( k ) And d.Value( k ) = attrs.Value( k ) ) Then
		              this_is_the_one = False
		              Exit
		            End If
		          Next
		          
		          If this_is_the_one Then
		            
		            still_looking_for_the_target = False
		            rslt = d
		            
		          End If
		        End If
		      End If
		    End If
		    If Not ( still_looking_for_the_current_group Or still_looking_for_the_target ) Then Exit
		  Next
		  
		  relative_expectation_group_offset = offset
		  Return rslt
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function IsPrime(i As Integer) As Boolean
		  // Created 12/5/2011 by Andrew Keller
		  
		  // Returns whether or not the given number is prime.
		  
		  If Abs( i ) < 4 Then Return True
		  
		  If i Mod 2 = 0 Then Return False
		  
		  Dim last As Integer = Floor(Sqrt(Abs( i )))
		  For test As Integer = 3 To last Step 2
		    
		    If i Mod test = 0 Then Return False
		    
		  Next
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function LookupSigCancel() As Integer
		  // Created 12/5/2011 by Andrew Keller
		  
		  // Returns the current ID of SigCancel.
		  
		  Return ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalCancel )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function LookupSigKill() As Integer
		  // Created 12/5/2011 by Andrew Keller
		  
		  // Returns the current ID of SigKill.
		  
		  Return ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalKill )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function LookupSigNormal() As Integer
		  // Created 12/5/2011 by Andrew Keller
		  
		  // Returns the current ID of SigNormal.
		  
		  Return 1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function LookupSigPause() As Integer
		  // Created 12/5/2011 by Andrew Keller
		  
		  // Returns the current ID of SigPause.
		  
		  Return ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalPause )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function LookupSigPauseAndCancel() As Integer
		  // Created 12/7/2011 by Andrew Keller
		  
		  // Returns the current ID of (SigPause & SigCancel).
		  
		  Return ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalPause ) * ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalCancel )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub MockMessageChangedCallback(pgd As ProgressDelegateKFS)
		  // Created 11/23/2011 by Andrew Keller
		  
		  // Asserts that this invocation was expected, and possibly throws an exception just for kicks.
		  
		  Dim attrs As Dictionary
		  AssertExpectationIsExpected New Dictionary( kExpectationCoreTypeCodeKey : kExpectationPGDTypeCodeMessageChanged ), attrs, "The MessageChanged callback was not expected to be called at this time.", False
		  
		  AssertIsNil App.CurrentThread, "The MessageChanged callback should always be called in the main thread.", False
		  
		  If Not ( attrs Is Nil ) Then
		    // Additional checks go here.
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub MockMessageOrValueChangedCallback(pgd As ProgressDelegateKFS)
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Asserts that this invocation was expected, and possibly throws an exception just for kicks.
		  
		  Dim attrs As Dictionary
		  AssertExpectationIsExpected New Dictionary( kExpectationCoreTypeCodeKey : kExpectationPGDTypeCodeMessageOrValueChanged ), attrs, "The MessageOrValueChanged callback was not expected to be called at this time.", False
		  
		  AssertIsNil App.CurrentThread, "The MessageChanged callback should always be called in the main thread.", False
		  
		  If Not ( attrs Is Nil ) Then
		    // Additional checks go here.
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub MockValueChangedCallback(pgd As ProgressDelegateKFS)
		  // Created 11/23/2011 by Andrew Keller
		  
		  // Asserts that this invocation was expected, and possibly throws an exception just for kicks.
		  
		  Dim attrs As Dictionary
		  AssertExpectationIsExpected New Dictionary( kExpectationCoreTypeCodeKey : kExpectationPGDTypeCodeValueChanged ), attrs, "The ValueChanged callback was not expected to be called at this time.", False
		  
		  AssertIsNil App.CurrentThread, "The MessageChanged callback should always be called in the main thread.", False
		  
		  If Not ( attrs Is Nil ) Then
		    // Additional checks go here.
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub SleepUntilAllTimersShouldHaveHadAChanceToFire()
		  // Created 1/1/2012 by Andrew Keller
		  
		  // Sleeps for an amount of time that should be sufficient for all timers to fire.
		  
		  App.CurrentThread.Sleep 80
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAutoUpdatePolicyForObject_BasicEventMethod()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the BasicEventMethod version of AutoUpdatePolicyForObject causes BasicEventMethods to get updated properly.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = AddressOf MockMessageOrValueChangedCallback
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation True, p, False, "The message or value changed callback was not invoked when it was added to the object."
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertTrue p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertTrue p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation True, p, False, "The message or value changed callback was not invoked when the message changed."
		  p.Message = "Foobar!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation True, p, False, "The message or value changed callback was not invoked when the value changed."
		  p.Value = 0.25
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation True, p, False, "The message or value changed callback was not invoked when the message and value changed at almost the same time."
		  p.Message = "New Message"
		  p.Value = 0.75
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAutoUpdatePolicyForObject_BasicEventMethod_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the BasicEventMethod version of AutoUpdatePolicyForObject ignores Nil.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should always return False when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestAutoUpdatePolicyForObject_Label()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the Label version of AutoUpdatePolicyForObject causes Labels to get updated properly.
		  
		  Dim obj As New Label
		  obj.Text = "Default Text"
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertTrue p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertTrue p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "0%", obj.Text, "The text of the Label should have been changed to the current message and value."
		  
		  obj.Text = "Default Text"
		  p.Message = "Foobar!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "Foobar!  -  0%", obj.Text, "The text of the Label should have been changed to the current message and value."
		  
		  obj.Text = "Default Text"
		  p.Value = 0.25
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "Foobar!  -  25%", obj.Text, "The text of the Label should have been changed to the current message and value."
		  
		  obj.Text = "Default Text"
		  p.Message = "New Message"
		  p.Value = 0.75
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "New Message  -  75%", obj.Text, "The text of the Label should have been changed to the current message and value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestAutoUpdatePolicyForObject_Label_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the Label version of AutoUpdatePolicyForObject ignores Nil.
		  
		  Dim obj As Label = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should always return False when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestAutoUpdatePolicyForObject_ProgressBar()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the ProgressBar version of AutoUpdatePolicyForObject causes ProgressBar to get updated properly.
		  
		  Dim obj As New ProgressBar
		  obj.Maximum = 42
		  obj.Value = 17
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertTrue p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "AutoUpdatePolicyForObject was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertZero obj.Maximum, "The Maximum property should be set to zero."
		  
		  obj.Maximum = 42
		  obj.Value = 17
		  
		  p.Value = 0.25
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  
		  If obj.Maximum <= 0 Then _
		  AssertFailure "The value of the ProgressBar should have been changed to the new value.", "Expected 25% but found Maximum = "+Str(obj.Maximum)+"."
		  If obj.Value / obj.Maximum <> p.Value Then _
		  AssertFailure "The value of the ProgressBar should have been changed to the new value.", "Expected 25% but found " + Format( obj.Value / obj.Maximum, "0%" ) + "."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestAutoUpdatePolicyForObject_ProgressBar_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the ProgressBar version of AutoUpdatePolicyForObject ignores Nil.
		  
		  Dim obj As ProgressBar = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "AutoUpdatePolicyForObject was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAutoUpdate_BasicEventMethod()
		  // Created 12/11/2011 by Andrew Keller
		  
		  // Makes sure BasicEventMethods are updated properly.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = AddressOf MockMessageOrValueChangedCallback
		  
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = DurationKFS.NewFromMicroseconds(0)
		  
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation False, p, False, _
		  "The callback was supposed to be invoked immediately after being added to the ProgressDelegateKFS object."
		  p.AutoUpdatePolicyForObject( obj ) = ProgressDelegateKFS.kAutoUpdatePolicyOnMessageAndValueChanged
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation False, p, False, _
		  "The callback was supposed to be invoked when the message was changed."
		  p.Message = "Foobar!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  
		  p.LocalNotificationsEnabled = False
		  p.Message = "Brid Dog!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  
		  AddMessageOrValueChangedCallbackInvocationExpectation False, p, False, _
		  "The callback was supposed to be invoked when LocalNotificationsEnabled was set to True."
		  p.LocalNotificationsEnabled = True
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = False
		  p.Message = "Cat Fish!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestAutoUpdate_Label()
		  // Created 11/16/2011 by Andrew Keller
		  
		  // Makes sure Labels are updated properly.
		  
		  Dim str1 As String = "This is the default label text."
		  Dim str2 As String = "Ha Ha!  New text!"
		  Dim str3 As String = "Cookies"
		  Dim str4 As String = "Tux"
		  
		  Dim obj As New Label
		  obj.Text = str1
		  AssertEquals str1, obj.Text, "The Label did not start out with the correct text."
		  
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = DurationKFS.NewFromMicroseconds(0)
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = True
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEmptyString obj.Text, "Adding a Label as an auto-updated object should immediately set the text."
		  
		  
		  p.Message = str2
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals str2, obj.Text, "Setting the message after the object has been added should update the text of the Label."
		  
		  
		  p.LocalNotificationsEnabled = False
		  p.Message = str3
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals str2, obj.Text, "Setting the message when p.LocalNotificationsEnabled is False should cause the object to not get updated."
		  
		  
		  p.LocalNotificationsEnabled = True
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals str3, obj.Text, "Setting p.LocalNotificationsEnabled to True should cause the object to get updated."
		  
		  
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = False
		  p.Message = str4
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals str3, obj.Text, "Removing the object from the auto-update list should cause the object to not get updated."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestAutoUpdate_ProgressBar()
		  // Created 11/16/2011 by Andrew Keller
		  
		  // Makes sure ProgressBars are updated properly.
		  
		  Dim val2 As Double = 0.25
		  Dim val4 As Double = 0.5
		  Dim val5 As Double  = 0.75
		  
		  Dim obj As New ProgressBar
		  obj.Width = 100
		  obj.Maximum = 1000
		  obj.Value = 9282
		  AssertEquals 100, obj.Width, "The ProgressBar did not start out with the correct Width."
		  AssertEquals 1000, obj.Maximum, "The ProgressBar did not start out with the correct Maximum."
		  AssertEquals 9282, obj.Value, "The ProgressBar did not start out with the correct Value."
		  
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = DurationKFS.NewFromMicroseconds(0)
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertZero obj.Maximum, "Adding a ProgressBar as an auto-updated object should immediately update the value and/or maximum."
		  
		  
		  p.Value = val2
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertPositive obj.Maximum, "Setting the value after the object has been added should update the Maximum to be positive."
		  AssertEquals val2, obj.Value / obj.Maximum, "Setting the value after the object has been added should update the Value."
		  
		  
		  p.Indeterminate = True
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertZero obj.Maximum, "Setting p.Indeterminate to True should cause the Maximum to become zero."
		  
		  
		  p.LocalNotificationsEnabled = False
		  p.Value = val4
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertZero obj.Maximum, "Setting the value when p.LocalNotificationsEnabled is False should cause the Maximum property to not get updated."
		  
		  
		  p.LocalNotificationsEnabled = True
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertPositive obj.Maximum, "Setting p.LocalNotificationsEnabled to True should have updated the object's Maximum property."
		  AssertEquals val4, obj.Value / obj.Maximum, "Setting p.LocalNotificationsEnabled to True should have updated the object's Value property."
		  
		  
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = False
		  p.Value = val5
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertPositive obj.Maximum, "Removing the object from the auto-update list should cause the object's Maximum to not get updated."
		  AssertEquals val4, obj.Value / obj.Maximum, "Removing the object from the auto-update list should cause the object's Value to not get updated."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChildCountAndChildren()
		  // Created 10/31/2011 by Andrew Keller
		  
		  // Makes sure the ChildCount and Children properties work.
		  
		  Dim p, p_1, p_2, p_1_1, p_1_2 As ProgressDelegateKFS
		  Dim children() As ProgressDelegateKFS
		  
		  // Create p:
		  PushMessageStack "Created p: "
		  
		  p = New ProgressDelegateKFS
		  
		  // Verify p:
		  PushMessageStack "Verifying p: "
		  
		  AssertIsNil p.Parent, "The root ProgressDelegateKFS object should always have a Nil Parent.", False
		  AssertZero p.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		  children = p.Children
		  If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		  AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		  
		  PopMessageStack
		  If PresumeNoIssuesYet( "Bailing out because the rest of this test won't matter much with the existing failures." ) Then
		    
		    // Create p_1:
		    PopMessageStack
		    PushMessageStack "Created p_1: "
		    
		    p_1 = p.SpawnChild
		    
		    If PresumeNotIsNil( p_1, "The SpawnChild function should never return Nil." ) Then
		      AssertNotSame p, p_1, "The SpawnChild function should never return the same object as the parent.", False
		      
		      // Verify p:
		      PushMessageStack "Verifying p: "
		      
		      AssertIsNil p.Parent, "The root ProgressDelegateKFS object should always have a Nil Parent.", False
		      AssertEquals 1, p.ChildCount, "I added a child to the root node using SpawnChild, but the ChildCount of the root node did not become 1.", False
		      children = p.Children
		      If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		        And PresumeEquals( 1, UBound( children ) + 1, "I added a child to the root node using SpawnChild, but Children did not return an array with the new child in it." ) Then
		        AssertSame p_1, children(0), "The root ProgressDelegateKFS object does not have p_1 as its only child.", False
		      End If
		      
		      // Verify p_1:
		      PopMessageStack
		      PushMessageStack "Verifying p_1: "
		      
		      AssertSame p, p_1.Parent, "p_1 should have p as its Parent.", False
		      AssertZero p_1.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		      children = p_1.Children
		      If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		      AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		      
		      PopMessageStack
		      If PresumeNoIssuesYet( "Bailing out because the rest of this test won't matter much with the existing failures." ) Then
		        
		        // Create p_1_1:
		        PopMessageStack
		        PushMessageStack "Created p_1_1: "
		        
		        p_1_1 = p_1.SpawnChild
		        
		        If PresumeNotIsNil( p_1_1, "The SpawnChild function should never return Nil." ) Then
		          AssertNotSame p, p_1, "The SpawnChild function should never return the same object as the parent.", False
		          AssertNotSame p, p_1_1, "The SpawnChild function should never return the same object as the grandparent.", False
		          
		          // Verify p:
		          PushMessageStack "Verifying p: "
		          
		          AssertIsNil p.Parent, "The root ProgressDelegateKFS object should always have a Nil Parent.", False
		          AssertEquals 1, p.ChildCount, "The root ProgressDelegateKFS object should still have a ChildCount of 1.", False
		          children = p.Children
		          If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		            And PresumeEquals( 1, UBound( children ) + 1, "The root ProgressDelegateKFS object should still have a single child." ) Then
		            AssertSame p_1, children(0), "The root ProgressDelegateKFS object does not have p_1 as its only child.", False
		          End If
		          
		          // Verify p_1:
		          PopMessageStack
		          PushMessageStack "Verifying p_1: "
		          
		          AssertSame p, p_1.Parent, "p_1 should have p as its Parent.", False
		          AssertEquals 1, p_1.ChildCount, "p_1 should now have a ChildCount of 1.", False
		          children = p_1.Children
		          If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		            And PresumeEquals( 1, UBound( children ) + 1, "p_1 should have a single child." ) Then
		            AssertSame p_1_1, children(0), "p_1 should have p_1_1 as its only child.", False
		          End If
		          
		          // Verify p_1_1:
		          PopMessageStack
		          PushMessageStack "Verifying p_1_1: "
		          
		          AssertSame p_1, p_1_1.Parent, "p_1_1 should have p_1 as its Parent.", False
		          AssertZero p_1_1.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		          children = p_1_1.Children
		          If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		          AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		          
		          PopMessageStack
		          If PresumeNoIssuesYet( "Bailing out because the rest of this test won't matter much with the existing failures." ) Then
		            
		            // Create p_2:
		            PopMessageStack
		            PushMessageStack "Created p_2: "
		            
		            p_2 = p.SpawnChild
		            
		            If PresumeNotIsNil( p_2, "The SpawnChild function should never return Nil." ) Then
		              AssertNotSame p, p_2, "The SpawnChild function should never return the same object as the parent.", False
		              AssertNotSame p_1, p_2, "The SpawnChild function should never return the same object as a sibling.", False
		              AssertNotSame p_1_1, p_2, "The SpawnChild function should never return the same object as a sibling's child.", False
		              
		              // Verify p:
		              PushMessageStack "Verifying p: "
		              
		              AssertIsNil p.Parent, "The root ProgressDelegateKFS object should always have a Nil Parent.", False
		              AssertEquals 2, p.ChildCount, "The root ProgressDelegateKFS object should now have a ChildCount of 2.", False
		              children = p.Children
		              If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		                And PresumeEquals( 2, UBound( children ) + 1, "The root ProgressDelegateKFS object should now have a single child." ) Then
		                AssertTrue p_1 Is children(0) Xor p_1 Is children(1), "The root ProgressDelegateKFS object should have p_1 as exactly one of its children.", False
		                AssertTrue p_2 Is children(0) Xor p_2 Is children(1), "The root ProgressDelegateKFS object should have p_2 as exactly one of its children.", False
		              End If
		              
		              // Verify p_1:
		              PopMessageStack
		              PushMessageStack "Verifying p_1: "
		              
		              AssertSame p, p_1.Parent, "p_1 should have p as its Parent.", False
		              AssertEquals 1, p_1.ChildCount, "p_1 should still have a ChildCount of 1.", False
		              children = p_1.Children
		              If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		                And PresumeEquals( 1, UBound( children ) + 1, "p_1 should have a single child." ) Then
		                AssertSame p_1_1, children(0), "p_1 should have p_1_1 as its only child.", False
		              End If
		              
		              // Verify p_2:
		              PopMessageStack
		              PushMessageStack "Verifying p_2: "
		              
		              AssertSame p, p_2.Parent, "p_2 should have p as its Parent.", False
		              AssertZero p_2.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		              children = p_2.Children
		              If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		              AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		              
		              // Verify p_1_1:
		              PopMessageStack
		              PushMessageStack "Verifying p_1_1: "
		              
		              AssertSame p_1, p_1_1.Parent, "p_1_1 should have p_1 as its Parent.", False
		              AssertZero p_1_1.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		              children = p_1_1.Children
		              If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		              AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		              
		              PopMessageStack
		              If PresumeNoIssuesYet( "Bailing out because the rest of this test won't matter much with the existing failures." ) Then
		                
		                // Create p_1_2:
		                PopMessageStack
		                PushMessageStack "Created p_1_2: "
		                
		                p_1_2 = p_1.SpawnChild
		                
		                If PresumeNotIsNil( p_1_2, "The SpawnChild function should never return Nil." ) Then
		                  AssertNotSame p, p_1_2, "The SpawnChild function should never return the same object as the grandparent.", False
		                  AssertNotSame p_1, p_1_2, "The SpawnChild function should never return the same object as the parent.", False
		                  AssertNotSame p_2, p_1_2, "The SpawnChild function should never return the same object as a sibling of the parent.", False
		                  AssertNotSame p_1_1, p_1_2, "The SpawnChild function should never return the same object as a sibling.", False
		                  
		                  // Verify p:
		                  PushMessageStack "Verifying p: "
		                  
		                  AssertIsNil p.Parent, "The root ProgressDelegateKFS object should always have a Nil Parent.", False
		                  AssertEquals 2, p.ChildCount, "The root ProgressDelegateKFS object should now have a ChildCount of 2.", False
		                  children = p.Children
		                  If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		                    And PresumeEquals( 2, UBound( children ) + 1, "The root ProgressDelegateKFS object should now have a single child." ) Then
		                    AssertTrue p_1 Is children(0) Xor p_1 Is children(1), "The root ProgressDelegateKFS object should have p_1 as exactly one of its children.", False
		                    AssertTrue p_2 Is children(0) Xor p_2 Is children(1), "The root ProgressDelegateKFS object should have p_2 as exactly one of its children.", False
		                  End If
		                  
		                  // Verify p_1:
		                  PopMessageStack
		                  PushMessageStack "Verifying p_1: "
		                  
		                  AssertSame p, p_1.Parent, "p_1 should have p as its Parent.", False
		                  AssertEquals 2, p_1.ChildCount, "p_1 should still have a ChildCount of 2.", False
		                  children = p_1.Children
		                  If PresumeNotIsNil( children, "The Children property should never return Nil." ) _
		                    And PresumeEquals( 2, UBound( children ) + 1, "p_1 should now have a single child." ) Then
		                    AssertTrue p_1_1 Is children(0) Xor p_1_1 Is children(1), "p_1 should have p_1_1 as exactly one of its children.", False
		                    AssertTrue p_1_2 Is children(0) Xor p_1_2 Is children(1), "p_1 should have p_1_2 as exactly one of its children.", False
		                  End If
		                  
		                  // Verify p_2:
		                  PopMessageStack
		                  PushMessageStack "Verifying p_2: "
		                  
		                  AssertSame p, p_2.Parent, "p_2 should have p as its Parent.", False
		                  AssertZero p_2.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		                  children = p_2.Children
		                  If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		                  AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		                  
		                  // Verify p_1_1:
		                  PopMessageStack
		                  PushMessageStack "Verifying p_1_1: "
		                  
		                  AssertSame p_1, p_1_1.Parent, "p_1_1 should have p_1 as its Parent.", False
		                  AssertZero p_1_1.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		                  children = p_1_1.Children
		                  If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		                  AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		                  
		                  // Verify p_1_2:
		                  PopMessageStack
		                  PushMessageStack "Verifying p_1_2: "
		                  
		                  AssertSame p_1, p_1_2.Parent, "p_1_2 should have p_1 as its Parent.", False
		                  AssertZero p_1_2.ChildCount, "A new ProgressDelegateKFS object should have a ChildCount of zero.", False
		                  children = p_1_2.Children
		                  If PresumeNotIsNil( children, "The Children property should never return Nil." ) Then _
		                  AssertZero UBound( children ) +1, "A new ProgressDelegateKFS object should have no children.", False
		                  
		                  PopMessageStack
		                End If
		              End If
		            End If
		          End If
		        End If
		      End If
		    End If
		  End If
		  
		  PopMessageStack
		  
		  // done.
		  
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
		  // Created 11/11/2011 by Andrew Keller
		  
		  // Makes sure the GetFrequencyHasElapsed function works properly.
		  
		  Dim p As ProgressDelegateKFS
		  Dim end_time, elapsed_time As DurationKFS
		  
		  p = New ProgressDelegateKFS
		  p.Frequency = New DurationKFS( 0.01 )
		  
		  end_time = DurationKFS.NewFromValue( 0.06 )
		  elapsed_time = DurationKFS.NewStopwatchStartingNow
		  
		  Do
		    
		    AssertFalse ProgressDelegateKFS.GetFrequencyHasElapsed( Nil ), _
		    "The GetFrequencyHasElapsed function should always return False when Nil is provided."
		    
		  Loop Until elapsed_time > end_time
		  
		  // The first time that a valid object is provided, it should return True.
		  
		  AssertTrue ProgressDelegateKFS.GetFrequencyHasElapsed( p ), _
		  "The GetFrequencyHasElapsed function should always return True the first time it is called."
		  
		  // Theoretically, TestFrequencyHasElapsed should take care of the rest.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetSpawnedChild()
		  // Created 1/10/2012 by Andrew Keller
		  
		  // Makes sure the GetSpawnedChild function works properly.
		  
		  AssertIsNil ProgressDelegateKFS.GetSpawnedChild( Nil ), "The GetSpawnedChild function should always return Nil when a Nil parent is provided.", False
		  
		  Dim p As New ProgressDelegateKFS
		  Dim c() As ProgressDelegateKFS = p.Children
		  
		  AssertIsNil p.Parent, "The Parent property should be Nil for a root node. (1)", False
		  If PresumeNotIsNil( c, "The Children function should never return Nil. (1)" ) Then _
		  AssertZero UBound( c ) + 1, "A new node should have no children. (1)", False
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    Dim p_1 As ProgressDelegateKFS = ProgressDelegateKFS.GetSpawnedChild( p )
		    
		    If PresumeNotIsNil( p_1, "The GetSpawnedChild function should never return Nil. (2)" ) Then
		      AssertNotSame p, p_1, "The GetSpawnedChild function should never return the same object as an existing object. (2)"
		      
		      AssertIsNil p.Parent, "The Parent property should be Nil for a root node. (2)", False
		      c = p.Children
		      If PresumeNotIsNil( c, "The Children function should never return Nil. (2)" ) Then
		        If PresumeEquals( 1, UBound( c ) + 1, "The root node should now have a single child. (2)" ) Then
		          AssertSame p_1, c(0), "The only child of the root node should be p_1. (2)", False
		        End If
		      End If
		      
		      AssertSame p, p_1.Parent, "The Parent property of p_1 should be p. (3)"
		      c = p_1.Children
		      If PresumeNotIsNil( c, "The Children function should never return Nil. (3)" ) Then _
		      AssertZero UBound( c ) + 1, "A new node should have no children. (3)", False
		      
		    End If
		  End If
		  
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
		Sub TestLocalNotificationsEnabled()
		  // Created 11/11/2011 by Andrew Keller
		  
		  // Makes sure the LocalNotificationsEnabled property works properly.
		  
		  // LocalNotificationsEnabled should default to True for
		  // the root node, and False for all children.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  AssertTrue p.LocalNotificationsEnabled, "The LocalNotificationsEnabled property should be True by default for the root node."
		  
		  Dim p_1 As ProgressDelegateKFS = p.SpawnChild
		  
		  AssertFalse p_1.LocalNotificationsEnabled, "The LocalNotificationsEnabled property should be False by default for non-root nodes."
		  
		  Dim p_1_1 As ProgressDelegateKFS = p_1.SpawnChild
		  
		  AssertFalse p_1_1.LocalNotificationsEnabled, "The LocalNotificationsEnabled property should be False by default for non-root nodes. (2)"
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    PushMessageStack "After setting p_1.LocalNotificationsEnabled to True: "
		    p_1.LocalNotificationsEnabled = True
		    AssertTrue p.LocalNotificationsEnabled, "p.LocalNotificationsEnabled should be True."
		    AssertTrue p_1.LocalNotificationsEnabled, "p_1.LocalNotificationsEnabled should be True."
		    AssertFalse p_1_1.LocalNotificationsEnabled, "p_1_1.LocalNotificationsEnabled should be False."
		    PopMessageStack
		    
		    If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		      
		      PushMessageStack "After setting p.LocalNotificationsEnabled to False: "
		      p.LocalNotificationsEnabled = False
		      AssertFalse p.LocalNotificationsEnabled, "p.LocalNotificationsEnabled should be False."
		      AssertTrue p_1.LocalNotificationsEnabled, "p_1.LocalNotificationsEnabled should be True."
		      AssertFalse p_1_1.LocalNotificationsEnabled, "p_1_1.LocalNotificationsEnabled should be False."
		      PopMessageStack
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLookupSignalID()
		  // Created 12/15/2011 by Andrew Keller
		  
		  // Makes sure that the custom signal generator works properly.
		  
		  // An empty string should be the number 1:
		  
		  AssertEquals 1, ProgressDelegateKFS.LookupSignalID( "" ), "A signal with a name being an empty string should have an ID of 1."
		  
		  // Not sure if this is a good idea, but at least for now, the generator is supposed
		  // to return some specific values for kSignalPause, kSignalCancel, and kSignalKill.
		  
		  Call ProgressDelegateKFS.LookupSignalID( "foobar" )
		  
		  AssertEquals 2, ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalPause ), "The ID of the signal kSignalPause should be 2."
		  AssertEquals 3, ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalCancel ), "The ID of the signal kSignalCancel should be 3."
		  AssertEquals 5, ProgressDelegateKFS.LookupSignalID( ProgressDelegateKFS.kSignalKill ), "The ID of the signal kSignalKill should be 5."
		  
		  // Make sure some new IDs are both unique and prime.
		  
		  Dim pool As New Dictionary
		  
		  While pool.Count < 100
		    
		    Dim k As String
		    Do
		      k = "key-" + Format( Rnd * 10000, "0000" )
		    Loop Until Not pool.HasKey( k )
		    
		    Dim v As Integer = ProgressDelegateKFS.LookupSignalID( k )
		    If pool.HasKey( v ) Then AssertFailure "LookupSignalID returned a non-unique ID.", "Expected anything but " + Str(v) + " (used by '" + pool.Value(v).StringValue + "'), but found " + Str(v) + "."
		    
		    AssertTrue v > 5, "LookupSignalID returned an ID that was not greater than 5.", False
		    AssertTrue IsPrime( v ), "LookupSignalID returned a non-prime ID.", False
		    
		    pool.Value( k ) = v
		    pool.Value( v ) = k
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMessage()
		  // Created 11/12/2011 by Andrew Keller
		  
		  // Makes sure the Message property works properly.
		  
		  Dim p, p_1, p_2, p_1_1, p_1_2, p_1_1_1 As ProgressDelegateKFS
		  
		  p = New ProgressDelegateKFS
		  p_1 = p.SpawnChild
		  p_2 = p.SpawnChild
		  p_1_1 = p_1.SpawnChild
		  p_1_2 = p_1.SpawnChild
		  p_1_1_1 = p_1_1.SpawnChild
		  
		  For Each i As ProgressDelegateKFS In Array( p, p_1, p_2, p_1_1, p_1_2, p_1_1_1 )
		    For Each b As Boolean In Array( False, True )
		      AssertEmptyString p.Message(b), "The Message property should default to an empty string."
		    Next
		  Next
		  
		  PushMessageStack "Set the message of p_1_1: "
		  
		  Dim msg_1_1 As String = "msg_1_1"
		  p_1_1.Message = msg_1_1
		  
		  AssertEmptyString p.Message(False), "p.Message(False) should be an empty string."
		  AssertEquals msg_1_1, p.Message(True), "p.Message(True) should be 'msg_1_1'."
		  
		  AssertEmptyString p_1.Message(False), "p_1.Message(False) should be an empty string."
		  AssertEquals msg_1_1, p_1.Message(True), "p_1.Message(True) should be 'msg_1_1'."
		  
		  AssertEmptyString p_2.Message(False), "p_2.Message(False) should be an empty string."
		  AssertEmptyString p_2.Message(True), "p_2.Message(True) should be an empty string."
		  
		  AssertEquals msg_1_1, p_1_1.Message(False), "p_1_1.Message(False) should be 'msg_1_1'."
		  AssertEquals msg_1_1, p_1_1.Message(True), "p_1_1.Message(True) should be 'msg_1_1'."
		  
		  AssertEmptyString p_1_2.Message(False), "p_1_2.Message(False) should be an empty string."
		  AssertEmptyString p_1_2.Message(True), "p_1_2.Message(True) should be an empty string."
		  
		  AssertEmptyString p_1_1_1.Message(False), "p_1_1_1.Message(False) should be an empty string."
		  AssertEmptyString p_1_1_1.Message(True), "p_1_1_1.Message(True) should be an empty string."
		  
		  PopMessageStack
		  
		  PushMessageStack "Set the message of p_2: "
		  
		  Dim msg_2 As String = "msg_2"
		  p_2.Message = msg_2
		  
		  AssertEmptyString p.Message(False), "p.Message(False) should be an empty string."
		  AssertEquals msg_2, p.Message(True), "p.Message(True) should be 'msg_2'."
		  
		  AssertEmptyString p_1.Message(False), "p_1.Message(False) should be an empty string."
		  AssertEquals msg_1_1, p_1.Message(True), "p_1.Message(True) should be 'msg_1_1'."
		  
		  AssertEquals msg_2, p_2.Message(False), "p_2.Message(False) should be 'msg_2'."
		  AssertEquals msg_2, p_2.Message(True), "p_2.Message(True) should be 'msg_2'."
		  
		  AssertEquals msg_1_1, p_1_1.Message(False), "p_1_1.Message(False) should be 'msg_1_1'."
		  AssertEquals msg_1_1, p_1_1.Message(True), "p_1_1.Message(True) should be 'msg_1_1'."
		  
		  AssertEmptyString p_1_2.Message(False), "p_1_2.Message(False) should be an empty string."
		  AssertEmptyString p_1_2.Message(True), "p_1_2.Message(True) should be an empty string."
		  
		  AssertEmptyString p_1_1_1.Message(False), "p_1_1_1.Message(False) should be an empty string."
		  AssertEmptyString p_1_1_1.Message(True), "p_1_1_1.Message(True) should be an empty string."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetMessage()
		  // Created 11/11/2011 by Andrew Keller
		  
		  // Makes sure the SetMessage method works properly.
		  
		  // Invoking the method with Nil should not cause a problem.
		  
		  Dim sample_string As String = "Hello, World!"
		  
		  ProgressDelegateKFS.SetMessage( Nil, sample_string )
		  
		  // Invoking the method with a valid object should set the message.
		  
		  Dim p As New ProgressDelegateKFS
		  AssertEmptyString p.Message(False), "The default Message should be an empty string."
		  
		  ProgressDelegateKFS.SetMessage( p, sample_string )
		  AssertEquals sample_string, p.Message(False), "The SetMessage method did not set the message in the provided object.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetValue()
		  // Created 11/11/2011 by Andrew Keller
		  
		  // Makes sure the SetValue method works properly.
		  
		  // Invoking the method with Nil should not cause a problem.
		  
		  Dim sample_value As Double = 0.25
		  
		  ProgressDelegateKFS.SetValue( Nil, sample_value )
		  
		  // Invoking the method with a valid object should set the value.
		  
		  Dim p As New ProgressDelegateKFS
		  AssertZero p.Value(False), "The default Value should be zero."
		  
		  ProgressDelegateKFS.SetValue( p, sample_value )
		  AssertEquals sample_value, p.Value(False), "The SetValue method did not set the value in the provided object.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldAutoUpdateObjectOnMessageChanged_BasicEventMethod()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the BasicEventMethod version of ShouldAutoUpdateObjectOnMessageChanged causes BasicEventMethods to get updated properly.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = AddressOf MockMessageChangedCallback
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  AddMessageChangedCallbackInvocationExpectation True, p, False, "The message changed callback was not invoked when it was added to the object."
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnMessageChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertTrue p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should not have been affected by ShouldAutoUpdateObjectOnMessageChanged."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  AddMessageChangedCallbackInvocationExpectation True, p, False, "The message changed callback was not invoked when the message changed."
		  p.Message = "Foobar!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldAutoUpdateObjectOnMessageChanged_BasicEventMethod_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the BasicEventMethod version of ShouldAutoUpdateObjectOnMessageChanged ignores Nil.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should always return False when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should never be affected by a change to ShouldAutoUpdateObjectOnMessageChanged."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestShouldAutoUpdateObjectOnMessageChanged_Label()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the Label version of ShouldAutoUpdateObjectOnMessageChanged causes Labels to get updated properly.
		  
		  Dim obj As New Label
		  obj.Text = "Default Text"
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnMessageChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertTrue p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should not have been affected by ShouldAutoUpdateObjectOnMessageChanged."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "", obj.Text, "The text of the Label should have been changed to the current message."
		  
		  p.Message = "Foobar!"
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "Foobar!", obj.Text, "The text of the Label should have been changed to the new message."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestShouldAutoUpdateObjectOnMessageChanged_Label_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the Label version of ShouldAutoUpdateObjectOnMessageChanged ignores Nil.
		  
		  Dim obj As Label = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should always return False when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.ShouldAutoUpdateObjectOnMessageChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnMessageChanged)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should never be affected by a change to ShouldAutoUpdateObjectOnMessageChanged."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldAutoUpdateObjectOnValueChanged_BasicEventMethod()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the BasicEventMethod version of ShouldAutoUpdateObjectOnValueChanged causes BasicEventMethods to get updated properly.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = AddressOf MockValueChangedCallback
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  AddValueChangedCallbackInvocationExpectation True, p, False, "The value changed callback was not invoked when it was added to the object."
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnValueChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should not have been affected by ShouldAutoUpdateObjectOnValueChanged."
		  AssertTrue p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  AddValueChangedCallbackInvocationExpectation True, p, False, "The value changed callback was not invoked when the value changed."
		  p.Value = 0.25
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertAllExpectationsHaveBeenSatisfied
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShouldAutoUpdateObjectOnValueChanged_BasicEventMethod_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the BasicEventMethod version of ShouldAutoUpdateObjectOnValueChanged ignores Nil.
		  
		  Dim obj As ProgressDelegateKFS.BasicEventMethod = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should always return False when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should never be affected by a change to ShouldAutoUpdateObjectOnValueChanged."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestShouldAutoUpdateObjectOnValueChanged_Label()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the Label version of ShouldAutoUpdateObjectOnValueChanged causes Labels to get updated properly.
		  
		  Dim obj As New Label
		  obj.Text = "Default Text"
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnValueChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should not have been affected by ShouldAutoUpdateObjectOnValueChanged."
		  AssertTrue p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "0%", obj.Text, "The text of the Label should have been changed to the current value."
		  
		  p.Value = 0.25
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals "25%", obj.Text, "The text of the Label should have been changed to the current value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestShouldAutoUpdateObjectOnValueChanged_Label_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the Label version of ShouldAutoUpdateObjectOnValueChanged ignores Nil.
		  
		  Dim obj As Label = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should always return False when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnMessageChanged( obj ), _
		  "ShouldAutoUpdateObjectOnMessageChanged should never be affected by a change to ShouldAutoUpdateObjectOnValueChanged."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestShouldAutoUpdateObjectOnValueChanged_ProgressBar()
		  // Created 12/10/2011 by Andrew Keller
		  
		  // Makes sure the ProgressBar version of ShouldAutoUpdateObjectOnValueChanged causes ProgressBars to get updated properly.
		  
		  Dim obj As New ProgressBar
		  obj.Maximum = 42
		  obj.Value = 17
		  Dim p As New ProgressDelegateKFS
		  p.Frequency = New DurationKFS
		  
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyOnValueChanged, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was supposed to set the auto update policy for the object (lack of new value detected by AutoUpdatePolicyForObject)."
		  AssertTrue p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was supposed to set the auto update policy for the object (lack of new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  AssertEquals 0, obj.Maximum, "The Maximum property should be set to zero."
		  
		  p.Value = 0.25
		  
		  SleepUntilAllTimersShouldHaveHadAChanceToFire
		  If obj.Maximum <= 0 Then _
		  AssertFailure "The value of the ProgressBar should have been changed to the new value.", "Expected 25% but found Maximum = "+Str(obj.Maximum)+"."
		  If obj.Value / obj.Maximum <> p.Value Then _
		  AssertFailure "The value of the ProgressBar should have been changed to the new value.", "Expected 25% but found " + Format( obj.Value / obj.Maximum, "0%" ) + "."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub TestShouldAutoUpdateObjectOnValueChanged_ProgressBar_Nil()
		  // Created 12/9/2011 by Andrew Keller
		  
		  // Makes sure the ProgressBar version of ShouldAutoUpdateObjectOnValueChanged ignores Nil.
		  
		  Dim obj As ProgressBar = Nil
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "AutoUpdatePolicyForObject should always return kAutoUpdatePolicyNone when the parameter is Nil."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged should always return False when the parameter is Nil."
		  
		  p.ShouldAutoUpdateObjectOnValueChanged( obj ) = True
		  
		  AssertEquals ProgressDelegateKFS.kAutoUpdatePolicyNone, p.AutoUpdatePolicyForObject( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by AutoUpdatePolicyForObject)."
		  AssertFalse p.ShouldAutoUpdateObjectOnValueChanged( obj ), _
		  "ShouldAutoUpdateObjectOnValueChanged was not supposed to do anything when setting a new auto update policy for an object (new value detected by ShouldAutoUpdateObjectOnValueChanged)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigCancel()
		  // Created 11/12/2011 by Andrew Keller
		  
		  // Makes sure the SigCancel property works.
		  
		  Dim p, p_1, p_1_1, p_1_2 As ProgressDelegateKFS
		  
		  p = New ProgressDelegateKFS
		  p_1 = p.SpawnChild
		  p_1_1 = p_1.SpawnChild
		  p_1_2 = p_1.SpawnChild
		  
		  For Each i As ProgressDelegateKFS In Array( p, p_1, p_1_1, p_1_2 )
		    AssertEquals LookupSigNormal, i.Signal, "The Signal property should be Normal by default."
		    AssertFalse i.SigCancel, "The SigCancel property should be False by default."
		  Next
		  
		  // Set SigCancel to True.
		  
		  p_1.SigCancel = True
		  
		  AssertEquals LookupSigNormal, p.Signal, "p.Signal should be SigNormal."
		  AssertFalse p.SigCancel, "p.SigCancel should be False."
		  
		  AssertEquals LookupSigCancel, p_1.Signal, "p_1.Signal should be SigCancel."
		  AssertTrue p_1.SigCancel, "p_1.SigCancel should be True."
		  
		  AssertEquals LookupSigCancel, p_1_1.Signal, "p_1_1.Signal should be SigCancel."
		  AssertTrue p_1_1.SigCancel, "p_1_1.SigCancel should be True."
		  
		  AssertEquals LookupSigCancel, p_1_2.Signal, "p_1_2.Signal should be SigCancel."
		  AssertTrue p_1_2.SigCancel, "p_1_2.SigCancel should be True."
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    // Set SigCancel to False.
		    
		    p_1.SigCancel = False
		    
		    PushMessageStack "Setting SigCancel to False should remove the Cancel component of the signal, in this case bringing it to SigNormal."
		    
		    AssertEquals LookupSigNormal, p.Signal, "(p.Signal should still be SigNormal)"
		    AssertFalse p.SigCancel, "p.SigCancel should still be False."
		    
		    AssertEquals LookupSigNormal, p_1.Signal, "(p_1.Signal should now be SigNormal)"
		    AssertFalse p_1.SigCancel, "p_1.SigCancel should now be False."
		    
		    AssertEquals LookupSigNormal, p_1_1.Signal, "(p_1_1.Signal should now be SigNormal)"
		    AssertFalse p_1_1.SigCancel, "p_1_1.SigCancel should now be False."
		    
		    AssertEquals LookupSigNormal, p_1_2.Signal, "(p_1_2.Signal should now be SigNormal)"
		    AssertFalse p_1_2.SigCancel, "p_1_2.SigCancel should now be False."
		    
		    PopMessageStack
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigKill()
		  // Created 11/12/2011 by Andrew Keller
		  
		  // Makes sure the SigKill property works.
		  
		  Dim p, p_1, p_1_1, p_1_2 As ProgressDelegateKFS
		  
		  p = New ProgressDelegateKFS
		  p_1 = p.SpawnChild
		  p_1_1 = p_1.SpawnChild
		  p_1_2 = p_1.SpawnChild
		  
		  For Each i As ProgressDelegateKFS In Array( p, p_1, p_1_1, p_1_2 )
		    AssertEquals LookupSigNormal, i.Signal, "The Signal property should be Normal by default."
		    AssertFalse i.SigKill, "The SigKill property should be False by default."
		  Next
		  
		  // Set SigKill to True.
		  
		  p_1.SigKill = True
		  
		  AssertEquals LookupSigNormal, p.Signal, "p.Signal should be SigNormal."
		  AssertFalse p.SigKill, "p.SigKill should be False."
		  
		  AssertEquals LookupSigKill, p_1.Signal, "p_1.Signal should be SigKill."
		  AssertTrue p_1.SigKill, "p_1.SigKill should be True."
		  
		  AssertEquals LookupSigKill, p_1_1.Signal, "p_1_1.Signal should be SigKill."
		  AssertTrue p_1_1.SigKill, "p_1_1.SigKill should be True."
		  
		  AssertEquals LookupSigKill, p_1_2.Signal, "p_1_2.Signal should be SigKill."
		  AssertTrue p_1_2.SigKill, "p_1_2.SigKill should be True."
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    // Set SigKill to False.
		    
		    p_1.SigKill = False
		    
		    PushMessageStack "Setting SigKill to False should remove the Kill component of the signal, in this case bringing it to SigNormal."
		    
		    AssertEquals LookupSigNormal, p.Signal, "(p.Signal should still be SigNormal)"
		    AssertFalse p.SigKill, "p.SigKill should still be False."
		    
		    AssertEquals LookupSigNormal, p_1.Signal, "(p_1.Signal should now be SigNormal)"
		    AssertFalse p_1.SigKill, "p_1.SigKill should now be False."
		    
		    AssertEquals LookupSigNormal, p_1_1.Signal, "(p_1_1.Signal should now be SigNormal)"
		    AssertFalse p_1_1.SigKill, "p_1_1.SigKill should now be False."
		    
		    AssertEquals LookupSigNormal, p_1_2.Signal, "(p_1_2.Signal should now be SigNormal)"
		    AssertFalse p_1_2.SigKill, "p_1_2.SigKill should now be False."
		    
		    PopMessageStack
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSignal()
		  // Created 11/12/2011 by Andrew Keller
		  
		  // Makes sure the Signal property works.
		  
		  Dim p, p_1, p_1_1, p_1_1_1, p_1_1_2 As ProgressDelegateKFS
		  
		  p = New ProgressDelegateKFS
		  p_1 = p.SpawnChild
		  p_1_1 = p_1.SpawnChild
		  p_1_1_1 = p_1_1.SpawnChild
		  p_1_1_2 = p_1_1.SpawnChild
		  
		  For Each i As ProgressDelegateKFS In Array( p, p_1, p_1_1, p_1_1_1, p_1_1_2 )
		    AssertEquals LookupSigNormal, i.Signal, "The Signal property should be Normal by default."
		  Next
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    // Engage SigCancel on p_1.
		    
		    PushMessageStack "After engaging SigCancel on p_1: "
		    
		    p_1.Signal = LookupSigCancel
		    
		    AssertEquals LookupSigNormal, p.Signal, "p.Signal should be SigNormal.", False
		    AssertEquals LookupSigCancel, p_1.Signal, "p_1.Signal should be SigCancel.", False
		    AssertEquals LookupSigCancel, p_1_1.Signal, "p_1_1.Signal should be SigCancel.", False
		    AssertEquals LookupSigCancel, p_1_1_1.Signal, "p_1_1_1.Signal should be SigCancel.", False
		    AssertEquals LookupSigCancel, p_1_1_2.Signal, "p_1_1_2.Signal should be SigCancel.", False
		    
		    PopMessageStack
		  End If
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    // Engage SigPause on p_1_1 using the component Integer setter.
		    
		    PushMessageStack "After engaging SigPause on p_1_1: "
		    
		    p_1_1.Signal( LookupSigPause ) = True
		    
		    AssertEquals LookupSigNormal, p.Signal, "p.Signal should be SigNormal.", False
		    AssertFalse p.Signal( LookupSigPause ), "p.Signal( LookupSigPause ) should be False.", False
		    AssertFalse p.Signal( LookupSigCancel ), "p.Signal( LookupSigCancel ) should be False.", False
		    
		    AssertEquals LookupSigCancel, p_1.Signal, "p_1.Signal should be SigCancel.", False
		    AssertFalse p_1.Signal( LookupSigPause ), "p_1.Signal( LookupSigPause ) should be False.", False
		    AssertTrue p_1.Signal( LookupSigCancel ), "p_1.Signal( LookupSigCancel ) should be True.", False
		    
		    AssertEquals LookupSigPauseAndCancel, p_1_1.Signal, "p_1_1.Signal should be SigPause & SigCancel.", False
		    AssertTrue p_1_1.Signal( LookupSigPause ), "p_1_1.Signal( LookupSigPause ) should be True.", False
		    AssertTrue p_1_1.Signal( LookupSigCancel ), "p_1_1.Signal( LookupSigCancel ) should be True.", False
		    
		    AssertEquals LookupSigPauseAndCancel, p_1_1_1.Signal, "p_1_1_1.Signal should be SigPause & SigCancel.", False
		    AssertTrue p_1_1_1.Signal( LookupSigPause ), "p_1_1_1.Signal( LookupSigPause ) should be True.", False
		    AssertTrue p_1_1_1.Signal( LookupSigCancel ), "p_1_1_1.Signal( LookupSigCancel ) should be True.", False
		    
		    AssertEquals LookupSigPauseAndCancel, p_1_1_2.Signal, "p_1_1_2.Signal should be SigPause & SigCancel.", False
		    AssertTrue p_1_1_2.Signal( LookupSigPause ), "p_1_1_2.Signal( LookupSigPause ) should be True.", False
		    AssertTrue p_1_1_2.Signal( LookupSigCancel ), "p_1_1_2.Signal( LookupSigCancel ) should be True.", False
		    
		    PopMessageStack
		  End If
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    // Disengage SigPause on p using the component String setter.
		    
		    PushMessageStack "After disengaging SigPause on p: "
		    
		    p.Signal( ProgressDelegateKFS.kSignalPause ) = False
		    
		    AssertEquals LookupSigNormal, p.Signal, "p.Signal should be SigNormal.", False
		    AssertFalse p.Signal( LookupSigPause ), "p.Signal( LookupSigPause ) should be False.", False
		    AssertFalse p.Signal( LookupSigCancel ), "p.Signal( LookupSigCancel ) should be False.", False
		    
		    AssertEquals LookupSigCancel, p_1.Signal, "p_1.Signal should be SigCancel.", False
		    AssertFalse p_1.Signal( LookupSigPause ), "p_1.Signal( LookupSigPause ) should be False.", False
		    AssertTrue p_1.Signal( LookupSigCancel ), "p_1.Signal( LookupSigCancel ) should be True.", False
		    
		    AssertEquals LookupSigCancel, p_1_1.Signal, "p_1_1.Signal should be SigCancel.", False
		    AssertFalse p_1_1.Signal( LookupSigPause ), "p_1_1.Signal( LookupSigPause ) should be False.", False
		    AssertTrue p_1_1.Signal( LookupSigCancel ), "p_1_1.Signal( LookupSigCancel ) should be True.", False
		    
		    AssertEquals LookupSigCancel, p_1_1_1.Signal, "p_1_1_1.Signal should be SigCancel.", False
		    AssertFalse p_1_1_1.Signal( LookupSigPause ), "p_1_1_1.Signal( LookupSigPause ) should be False.", False
		    AssertTrue p_1_1_1.Signal( LookupSigCancel ), "p_1_1_1.Signal( LookupSigCancel ) should be True.", False
		    
		    AssertEquals LookupSigCancel, p_1_1_2.Signal, "p_1_1_2.Signal should be SigCancel.", False
		    AssertFalse p_1_1_2.Signal( LookupSigPause ), "p_1_1_2.Signal( LookupSigPause ) should be False.", False
		    AssertTrue p_1_1_2.Signal( LookupSigCancel ), "p_1_1_2.Signal( LookupSigCancel ) should be True.", False
		    
		    PopMessageStack
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSigPause()
		  // Created 11/12/2011 by Andrew Keller
		  
		  // Makes sure the SigPause property works.
		  
		  Dim p, p_1, p_1_1, p_1_2 As ProgressDelegateKFS
		  
		  p = New ProgressDelegateKFS
		  p_1 = p.SpawnChild
		  p_1_1 = p_1.SpawnChild
		  p_1_2 = p_1.SpawnChild
		  
		  For Each i As ProgressDelegateKFS In Array( p, p_1, p_1_1, p_1_2 )
		    AssertEquals LookupSigNormal, i.Signal, "The Signal property should be Normal by default."
		    AssertFalse i.SigPause, "The SigPause property should be False by default."
		  Next
		  
		  // Set SigPause to True.
		  
		  p_1.SigPause = True
		  
		  AssertEquals LookupSigNormal, p.Signal, "p.Signal should be Signals.Normal."
		  AssertFalse p.SigPause, "p.SigPause should be False."
		  
		  AssertEquals LookupSigPause, p_1.Signal, "p_1.Signal should be Signals.Pause."
		  AssertTrue p_1.SigPause, "p_1.SigPause should be True."
		  
		  AssertEquals LookupSigPause, p_1_1.Signal, "p_1_1.Signal should be Signals.Pause."
		  AssertTrue p_1_1.SigPause, "p_1_1.SigPause should be True."
		  
		  AssertEquals LookupSigPause, p_1_2.Signal, "p_1_2.Signal should be Signals.Pause."
		  AssertTrue p_1_2.SigPause, "p_1_2.SigPause should be True."
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    // Set SigPause to False.
		    
		    p_1.SigPause = False
		    
		    PushMessageStack "Setting SigPause to False should remove the Pause component of the signal, in this case bringing it to SigNormal."
		    
		    AssertEquals LookupSigNormal, p.Signal, "(p.Signal should still be SigNormal)"
		    AssertFalse p.SigPause, "p.SigPause should still be False."
		    
		    AssertEquals LookupSigNormal, p_1.Signal, "(p_1.Signal should now be SigNormal)"
		    AssertFalse p_1.SigPause, "p_1.SigPause should now be False."
		    
		    AssertEquals LookupSigNormal, p_1_1.Signal, "(p_1_1.Signal should now be SigNormal)"
		    AssertFalse p_1_1.SigPause, "p_1_1.SigPause should now be False."
		    
		    AssertEquals LookupSigNormal, p_1_2.Signal, "(p_1_2.Signal should now be SigNormal)"
		    AssertFalse p_1_2.SigPause, "p_1_2.SigPause should now be False."
		    
		    PopMessageStack
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSpawnChild()
		  // Created 11/11/2011 by Andrew Keller
		  
		  // Makes sure that the SpawnChild function works properly.
		  
		  Dim p As New ProgressDelegateKFS
		  Dim c() As ProgressDelegateKFS = p.Children
		  
		  AssertIsNil p.Parent, "The Parent property should be Nil for a root node. (1)", False
		  If PresumeNotIsNil( c, "The Children function should never return Nil. (1)" ) Then _
		  AssertZero UBound( c ) + 1, "A new node should have no children. (1)", False
		  
		  If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		    
		    Dim p_1 As ProgressDelegateKFS = p.SpawnChild
		    
		    If PresumeNotIsNil( p_1, "The SpawnChild function should never return Nil. (2)" ) Then
		      AssertNotSame p, p_1, "The SpawnChild function should never return the same object as an existing object. (2)"
		      
		      AssertIsNil p.Parent, "The Parent property should be Nil for a root node. (2)", False
		      c = p.Children
		      If PresumeNotIsNil( c, "The Children function should never return Nil. (2)" ) Then
		        If PresumeEquals( 1, UBound( c ) + 1, "The root node should now have a single child. (2)" ) Then
		          AssertSame p_1, c(0), "The only child of the root node should be p_1. (2)", False
		        End If
		      End If
		      
		      AssertSame p, p_1.Parent, "The Parent property of p_1 should be p. (3)"
		      c = p_1.Children
		      If PresumeNotIsNil( c, "The Children function should never return Nil. (3)" ) Then _
		      AssertZero UBound( c ) + 1, "A new node should have no children. (3)", False
		    End If
		    
		    If PresumeNoIssuesYet( "Bailing out because existing failures may have compromised the integrity of this test." ) Then
		      
		      Dim p_2 As ProgressDelegateKFS = p.SpawnChild
		      
		      If PresumeNotIsNil( p_2, "The SpawnChild function should never return Nil. (4)" ) Then
		        AssertNotSame p, p_2, "The SpawnChild function should never return the same object as an existing object. (4.1)"
		        AssertNotSame p_1, p_2, "The SpawnChild function should never return the same object as an existing object. (4.1)"
		        
		        AssertIsNil p.Parent, "The Parent property should be Nil for a root node. (4)", False
		        c = p.Children
		        If PresumeNotIsNil( c, "The Children function should never return Nil. (4)" ) Then
		          If PresumeEquals( 2, UBound( c ) + 1, "The root node should now have a single child. (4)" ) Then
		            AssertTrue p_1 Is c(0) Xor p_1 Is c(1), "p_1 should be one of p's children. (4)", False
		            AssertTrue p_2 Is c(0) Xor p_2 Is c(1), "p_2 should be one of p's children. (4)", False
		          End If
		        End If
		        
		        AssertSame p, p_2.Parent, "The Parent property of p_2 should be p. (5)"
		        c = p_2.Children
		        If PresumeNotIsNil( c, "The Children function should never return Nil. (5)" ) Then _
		        AssertZero UBound( c ) + 1, "A new node should have no children. (5)", False
		        
		        AssertSame p, p_2.Parent, "The Parent property of p_2 should be p. (6)"
		        c = p_2.Children
		        If PresumeNotIsNil( c, "The Children function should never return Nil. (6)" ) Then _
		        AssertZero UBound( c ) + 1, "A new node should have no children. (6)", False
		      End If
		    End If
		  End If
		  
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
		Sub TestTotalWeightOfChildren_OutOfBounds()
		  // Created 11/14/2011 by Andrew Keller
		  
		  // Makes sure the TotalWeightOfChildren property sanitizes out of bounds values correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  AssertEquals 0, p.TotalWeightOfChildren, "p.TotalWeightOfChildren should be zero by default."
		  
		  PushMessageStack "After setting the TotalWeightOfChildren property to -1: "
		  
		  p.TotalWeightOfChildren = -1
		  AssertEquals 0, p.TotalWeightOfChildren, "p.TotalWeightOfChildren should still be zero.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "After adding a child: "
		  
		  Dim p_1 As ProgressDelegateKFS = p.SpawnChild( -2, 0.25 )
		  AssertEquals 0, p.TotalWeightOfChildren, "p.TotalWeightOfChildren should still be zero.", False
		  
		  PushMessageStack "After setting the TotalWeightOfChildren property to -3: "
		  
		  p.TotalWeightOfChildren = -3
		  AssertEquals 0, p.TotalWeightOfChildren, "p.TotalWeightOfChildren should still be zero.", False
		  
		  PopMessageStack
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
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
		Sub TestValue_OutOfBounds()
		  // Created 11/14/2011 by Andrew Keller
		  
		  // Makes sure the Value property sanitizes out of bounds values correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  p.Value = 2
		  AssertEquals 1, p.Value(False), "The Value property did not sanitize a local value above 1.", False
		  AssertEquals 1, p.Value(True), "The Value property did not sanitize an overall value above 1.", False
		  
		  p.Value = -1
		  AssertEquals 0, p.Value(False), "The Value property did not sanitize a local value below zero.", False
		  AssertEquals 0, p.Value(True), "The Value property did not sanitize an overall value below zero.", False
		  
		  PushMessageStack "After adding a child: "
		  
		  Dim p_1 As ProgressDelegateKFS = p.SpawnChild( 1, -1 )
		  
		  AssertEquals 0, p.Value(False), "The Value property did not sanitize a local value below zero.", False
		  AssertEquals 0, p.Value(True), "The Value property did not sanitize an overall value below zero.", False
		  
		  p.Value = 1
		  p_1.Value = 1
		  
		  AssertEquals 1, p.Value(False), "The Value property did not sanitize a local value above 1.", False
		  AssertEquals 1, p.Value(True), "The Value property did not sanitize an overall value above 1.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "After adding and removing two children: "
		  
		  p = New ProgressDelegateKFS
		  p_1 = p.SpawnChild( 0.75 )
		  Dim p_2 As ProgressDelegateKFS = p.SpawnChild( 0.75 )
		  
		  AssertEquals 0, p.Value(False), "p.Value did not start out with the expected value.", False
		  
		  p_1 = Nil
		  p_2 = Nil
		  
		  AssertEquals 1, p.Value(False), "p.Value did not get 1 after adding 0.75 + 0.75.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestWeight()
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
		Sub TestWeight_OutOfBounds()
		  // Created 11/14/2011 by Andrew Keller
		  
		  // Makes sure the Weight property sanitizes out of bounds values correctly.
		  
		  Dim p As New ProgressDelegateKFS
		  
		  p.Weight = -1
		  AssertEquals 0, p.Weight, "The Weight property did not sanitize a value below 1.", False
		  AssertEquals 0, p.Value, "p did not start out with the expected value."
		  
		  PushMessageStack "After adding a child: "
		  
		  Dim p_1 As ProgressDelegateKFS = p.SpawnChild( -1, 0.25 )
		  
		  AssertEquals 0, p_1.Weight, "The Weight property did not sanitize a value below 1.", False
		  
		  AssertEquals 0, p.TotalWeightOfChildren, "p.TotalWeightOfChildren should be zero.", False
		  AssertEquals 0, p.Value, "p should still have a Value of zero.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010-2012 Andrew Keller.
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
		Protected p_expectations() As Dictionary
	#tag EndProperty


	#tag Constant, Name = kDefaultMessageChangedCallbackFailureMessage, Type = String, Dynamic = False, Default = \"The MessageChanged callback was supposed to have been invoked.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDefaultUnsatisfiedExpectationsMessage, Type = String, Dynamic = False, Default = \"Some expectations were not satisfied.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDefaultValueChangedCallbackFailureMessage, Type = String, Dynamic = False, Default = \"The ValueChanged callback was supposed to have been invoked.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreFailureMessageKey, Type = String, Dynamic = False, Default = \"expectation failure message", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreGroupWithPreviousExpectationKey, Type = String, Dynamic = False, Default = \"group with previous", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreMessageKey, Type = String, Dynamic = False, Default = \"expectation message", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreParentObjectKey, Type = String, Dynamic = False, Default = \"parent object", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreRequiredSatisfactionCount, Type = String, Dynamic = False, Default = \"required satisfaction count", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreSatisfactionCount, Type = String, Dynamic = False, Default = \"satisfaction count", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationCoreTypeCodeKey, Type = String, Dynamic = False, Default = \"expectation type code", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationPGDTypeCodeMessageChanged, Type = String, Dynamic = False, Default = \"message changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationPGDTypeCodeMessageOrValueChanged, Type = String, Dynamic = False, Default = \"message or value changed", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kExpectationPGDTypeCodeValueChanged, Type = String, Dynamic = False, Default = \"value changed", Scope = Protected
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
