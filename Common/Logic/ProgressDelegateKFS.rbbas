#tag Class
Protected Class ProgressDelegateKFS
	#tag Method, Flags = &h1
		Protected Sub async_clock_method(t As Timer)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // This method is the action of the timer used in InternalAsynchronous mode.
		  
		  // First thing's first: make we're still in InternalAsynchronous mode.
		  
		  If p_mode = Modes.InternalAsynchronous Then
		    
		    // Okay, so we still want periodical updates.
		    
		    // Let's go ahead with the updates.
		    
		    If p_last_update_time_msg + p_throttle <= Microseconds Then
		      receive_message Nil, "", False, False, True, False
		    End If
		    
		    If p_last_update_time_val + p_throttle <= Microseconds Then
		      receive_value Nil, 0, False, False, False, True, False
		    End If
		    
		    // And finally, set up the timer to execute again.
		    
		    t.Mode = Timer.ModeSingle
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub BasicEventMethod(pgd As ProgressDelegateKFS)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the number of nodes that are children of this node.
		  
		  Return p_children.Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children() As ProgressDelegateKFS()
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns an array of all the nodes that are children of this node.
		  
		  Dim v() As Variant
		  Dim c() As ProgressDelegateKFS
		  
		  v = p_children.Values
		  
		  Dim row, last As Integer
		  last = UBound( v )
		  ReDim c( last )
		  
		  Dim should_prune_item As Boolean
		  
		  For row = last DownTo 0
		    
		    should_prune_item = True
		    
		    If v( row ) IsA WeakRef Then
		      
		      Dim w As WeakRef = v( row )
		      
		      If w.Value IsA ProgressDelegateKFS Then
		        
		        c( row ) = ProgressDelegateKFS( w.Value )
		        
		        should_prune_item = False
		        
		      End If
		    End If
		    
		    If should_prune_item Then
		      
		      c.Remove row
		      v.Remove row
		      last = last -1
		      
		    End If
		    
		  Next
		  
		  Return c
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub child_add(id_hint As UInt64, c As ProgressDelegateKFS)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Adds the given object as a child of this node.
		  // Also makes sure that the TotalWeightOfChildren
		  // property is up-to-date.
		  
		  If Not ( c Is Nil ) Then
		    
		    p_children.Value( id_hint ) = New WeakRef( c )
		    
		    Call verify_children_weight
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub child_rm(id_hint As UInt64, c As ProgressDelegateKFS)
		  // Created 7/19/2011 by Andrew Keller
		  
		  // Removes the given child from this node.
		  // Also merges the child's data into this node.
		  
		  If p_children.HasKey( id_hint ) Then
		    
		    p_children.Remove id_hint
		    
		    If Not ( c Is Nil ) Then
		      
		      // Get the data from the child.
		      
		      // A nice convenience is (if everything is
		      // working correctly) the only reason to
		      // remove a child is because it is being
		      // deallocated, and the only reason it
		      // could be deallocated is if it's the last
		      // node in this branch.  That means we
		      // don't have to go through the standard
		      // getters - we can access the property
		      // directly to increase speed.
		      
		      // Oh, and we are accessing the class using
		      // a strong reference rather than the WeakRef
		      // because WeakRefs cannot be trusted *during*
		      // an object's Destructor...  see bug report:
		      //   <feedback://showreport?report_id=17657>
		      // Theoretically, the fix for this bug will
		      // be released with RB 2011r3, however I would
		      // prefer that this code be compatible with
		      // at least the last couple year's worth of
		      // versions of REAL Studio.
		      
		      If c.p_weight > 0 Then
		        
		        // This child has a non-zero weight.
		        // Let's add it in to this node.
		        
		        p_indeterminate = False
		        p_value = p_value + c.p_weight / p_childrenweight
		        
		        If p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		          
		          // If we already know we're in asynchronous mode, then
		          // there's no need to evaluate that massive If statement
		          // that's waiting around the corner (in receive_value).
		          
		          receive_value Nil, 0, False, False, False, False, False
		          
		        End If
		      End If
		      
		      If p_message = "" And c.p_message <> "" Then
		        
		        // This child had a message, and we did not have
		        // a message that overrode it, so in unlinking
		        // this child, the message may have changed.
		        
		        If p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		          
		          // If we already know we're in asynchronous mode, then
		          // there's no need to evaluate that massive If statement
		          // that's waiting around the corner (in receive_message).
		          
		          receive_message Nil, "", False, False, False, False
		          
		        End If
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub common_init()
		  // Created 7/21/2011 by Andrew Keller
		  
		  // Provides the initialization code that is common to all the Constructors.
		  
		  p_autoupdate_objects = New Dictionary
		  p_callback_msgch = New Dictionary
		  p_callback_sigch = New Dictionary
		  p_callback_valch = New Dictionary
		  p_children = New Dictionary
		  p_childrenweight = 0
		  p_frequency = New DurationKFS( kDefaultFrequency_Seconds )
		  p_id_hint = NewUniqueInteger
		  p_indeterminate = True
		  p_internal_clock = New Timer
		  p_internal_clock.Period = p_frequency.Value( DurationKFS.kMilliseconds )
		  AddHandler p_internal_clock.Action, WeakAddressOf async_clock_method
		  p_last_update_time_msg = 0
		  p_last_update_time_val = 0
		  p_message = ""
		  p_mode = Modes.FullSynchronous
		  p_parent = Nil
		  p_prev_childrenweight = 0
		  p_prev_indeterminate = True
		  p_prev_message = ""
		  p_prev_value = 0
		  p_prev_weight = 1
		  p_signal = Signals.Normal
		  p_throttle = p_frequency.MicrosecondsValue
		  p_value = 0
		  p_weight = 1
		  
		  update_cache_indeterminate False
		  update_cache_message False
		  update_cache_value False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Initializes this object.
		  
		  common_init
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(new_parent As ProgressDelegateKFS, new_weight As Double, new_value As Double, new_msg As String)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Initializes this object as a child of the given object.
		  
		  common_init
		  
		  // And, if the new parent is in fact non-Nil, we can go ahead with the child setup.
		  
		  If Not ( new_parent Is Nil Or new_parent Is Me ) Then
		    
		    // Set the local properties that are different:
		    
		    p_frequency = New DurationKFS( new_parent.p_frequency )
		    p_message = new_msg
		    p_mode = default_mode_from_parent( new_parent.p_mode )
		    p_parent = new_parent
		    p_signal = new_parent.p_signal
		    p_throttle = new_parent.p_throttle
		    p_value = new_value
		    p_weight = new_weight
		    
		    // And update the parent with the information it needs:
		    
		    new_parent.child_add p_id_hint, Me
		    
		    // Since adding a child does not change any values,
		    // there is no need to start a value changed event.
		    // If the TotalWeightOfChildren property changed in
		    // the parent, then the event will be raised, but
		    // that's a different scenario.
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function current_children_weight() As Double
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Returns the current total weight of all the children.
		  
		  Dim rslt As Double = 0
		  
		  For Each c As ProgressDelegateKFS In Children
		    If Not ( c Is Nil ) Then
		      
		      rslt = rslt + c.p_weight
		      
		    End If
		  Next
		  
		  Return rslt
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function default_mode_from_parent(parent_mode As Modes) As Modes
		  // Created 7/21/2011 by Andrew Keller
		  
		  // Returns what the default mode should be
		  // assuming that the parent has the given mode.
		  
		  If parent_mode = Modes.FullSynchronous Then
		    Return Modes.FullSynchronousCredulous
		    
		  ElseIf parent_mode = Modes.ThrottledSynchronous Then
		    Return Modes.ThrottledSynchronousCredulous
		    
		  ElseIf parent_mode = Modes.InternalAsynchronous Then
		    Return Modes.ExternalAsynchronous
		    
		  Else
		    Return parent_mode
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  // Created 7/17/2011 by Andrew Keller
		  
		  // This object is deallocating.  Unlink this object from
		  // the parent.  The parent will grab what it needs from
		  // this object before it has been deallocated.
		  
		  Dim p As ProgressDelegateKFS = Parent
		  
		  If Not ( p Is Nil ) Then
		    
		    p.child_rm p_id_hint, Me
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush(ignore_throttle As Boolean = False, ignore_diff As Boolean = False)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Forces value changed and message changed events
		  // from here all the way to the root node, with no
		  // regard to the mode of each node.
		  
		  // This is essentially a user-accessible alias for
		  // receive_message and receive_value.
		  
		  receive_message Me, "", ignore_throttle, True, True, ignore_diff
		  
		  receive_value Me, 0, False, ignore_throttle, True, True, ignore_diff
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Frequency() As DurationKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current frequency.
		  
		  Return p_frequency
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Frequency(Assigns new_value As DurationKFS)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets the frequency of this object.
		  
		  If new_value Is Nil Then new_value = New DurationKFS( kDefaultFrequency_Seconds )
		  
		  p_frequency = new_value
		  p_throttle = p_frequency.MicrosecondsValue
		  p_internal_clock.Period = p_frequency.Value( DurationKFS.kMilliseconds )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns new_value As Boolean)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets whether or not the value in this node is indeterminate.
		  
		  If p_indeterminate <> new_value Then
		    
		    p_indeterminate = new_value
		    
		    If p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		      
		      // If we already know we're in asynchronous mode, then
		      // there's no need to evaluate that massive If statement
		      // that's waiting around the corner (in receive_value).
		      
		      receive_value Nil, 0, False, False, False, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndeterminateValue(include_children As Boolean = True) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not this node has an indeterminate value,
		  // possibly taking into account the children nodes.
		  
		  If p_indeterminate And include_children Then
		    
		    // The indeterminate value property can be described as a
		    // "fragile True", meaning that all it takes is one child
		    // being False and the entire result is False.
		    
		    For Each c As ProgressDelegateKFS In Children
		      If Not ( c Is Nil ) Then
		        If Not c.IndeterminateValue( include_children ) Then
		          
		          Return False
		          
		        End If
		      End If
		    Next
		    
		  End If
		  
		  Return p_indeterminate
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns new_value As String)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets the message of this node.
		  
		  // If this code changes, don't forget to
		  // update child_rm.
		  
		  If p_message <> new_value Then
		    
		    p_message = new_value
		    
		    If p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		      
		      // If we already know we're in asynchronous mode, then
		      // there's no need to evaluate that massive If statement
		      // that's waiting around the corner (in receive_message).
		      
		      receive_message Nil, "", False, False, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message(search_harder_for_result As Boolean = True) As String
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns the message of this node.
		  
		  // If the local message is an empty string and
		  // search_harder_for_result is True, then the
		  // children are searched for a non-empty string
		  // using a breadth first search.
		  
		  If p_message = "" And search_harder_for_result Then
		    
		    Dim queue As New DataChainKFS
		    
		    For Each ch As ProgressDelegateKFS In Children
		      queue.Append ch
		    Next
		    
		    While Not queue.IsEmpty
		      
		      Dim c As ProgressDelegateKFS = ProgressDelegateKFS( queue.Pop.ObjectValue )
		      
		      If Not ( c Is Nil ) Then
		        
		        Dim rslt As String = c.p_message
		        
		        If rslt = "" Then
		          
		          For Each ch As ProgressDelegateKFS In c.Children
		            queue.Append ch
		          Next
		          
		        Else
		          
		          Return rslt
		          
		        End If
		      End If
		    Wend
		    
		  End If
		  
		  Return p_message
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub MessageEventMethod(pgd As ProgressDelegateKFS, new_message As String)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Mode() As Modes
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current mode.
		  
		  Return p_mode
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mode(Assigns new_value As Modes)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets the mode of this object.
		  
		  If new_value <> p_mode Then
		    
		    // Set the new mode:
		    
		    p_mode = new_value
		    
		    // Should the internal clock be running?
		    
		    If p_mode = Modes.InternalAsynchronous Then
		      
		      p_internal_clock.Mode = Timer.ModeSingle
		      
		    Else
		      
		      p_internal_clock.Mode = Timer.ModeOff
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function NewUniqueInteger() As UInt64
		  // Created 7/19/2011 by Andrew Keller
		  
		  // Returns an integer that is guaranteed to be unique throughout this whole class.
		  
		  // The numbers start at 1.  Zero is reserved for "no value".
		  
		  Static i As Integer = 0
		  
		  i = i + 1
		  
		  Return i
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub notify_message(ByRef data_is_set As Boolean, ByRef new_message As String)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Update the objects that that take a message.
		  
		  For Each v As Variant In p_autoupdate_objects.Keys
		    
		    If Not data_is_set Then
		      new_message = Message
		      data_is_set = True
		    End If
		    
		    update_object_message v.ObjectValue, new_message
		    
		  Next
		  
		  // Invoke the message changed callbacks.
		  
		  For Each v As Variant In p_callback_msgch.Keys
		    Dim d As MessageEventMethod = v
		    If Not ( d Is Nil ) Then
		      
		      If Not data_is_set Then
		        new_message = Message
		        data_is_set = True
		      End If
		      
		      d.Invoke Me, new_message
		      
		    End If
		  Next
		  
		  // And finally, raise the MessageChanged event.
		  
		  If data_is_set Then
		    
		    RaiseEvent MessageChanged new_message
		    
		  Else
		    
		    RaiseEvent MessageMayHaveChanged
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub notify_signal(new_signal As Signals)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Raises the events for a signal change.
		  
		  For Each v As Variant In p_callback_sigch.Keys
		    Dim d As SignalEventMethod = v
		    If Not ( d Is Nil ) Then
		      
		      d.Invoke Me, new_signal
		      
		    End If
		  Next
		  
		  RaiseEvent SignalChanged new_signal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub notify_value(ByRef data_is_set As Boolean, ByRef new_value As Double, ByRef new_indeterminatevalue As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Update the objects that that take a value.
		  
		  For Each v As Variant In p_autoupdate_objects.Keys
		    
		    If Not data_is_set Then
		      new_value = Value
		      new_indeterminatevalue = IndeterminateValue
		      data_is_set = True
		    End If
		    
		    update_object_value v.ObjectValue, new_value, new_indeterminatevalue
		    
		  Next
		  
		  // Invoke the value changed callbacks.
		  
		  For Each v As Variant In p_callback_valch.Keys
		    Dim d As ValueEventMethod = v
		    If Not ( d Is Nil ) Then
		      
		      If Not data_is_set Then
		        new_value = Value
		        new_indeterminatevalue = IndeterminateValue
		        data_is_set = True
		      End If
		      
		      d.Invoke Me, new_value, new_indeterminatevalue
		      
		    End If
		  Next
		  
		  // And finally, raise the ValueChanged event.
		  
		  If data_is_set Then
		    
		    RaiseEvent ValueChanged new_value, new_indeterminatevalue
		    
		  Else
		    
		    RaiseEvent ValueMayHaveChanged
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parent() As ProgressDelegateKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns a reference to the parent object.
		  
		  Return p_parent
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub receive_message(child_obj As ProgressDelegateKFS, child_message As String, ignore_throttle As Boolean, ignore_async As Boolean, ignore_async_once As Boolean, ignore_diff As Boolean)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // This method handles the propagation of synchronous
		  // message changed events.  For simplicity, this method
		  // also does the heavy lifting for the event propagation
		  // when in InternalAsynchronous mode.
		  
		  // This method assumes the following scenerio:
		  //   A message changed event has been raised.  We do
		  //   not know where it came from, however one of our
		  //   children may have given us its message, so se
		  //   do not have to fully recalculate the message in
		  //   that case.  Based on the mode of this object,
		  //   continue the chain of events.
		  
		  // In addition to the mode of this object, there are
		  // some environmental parameters that stick with this
		  // chain of events.  They include:
		  //   - whether or not to ignore the throttle
		  //   - whether or not to ignore async mode
		  //   - whether or not to ignore async mode just once
		  //   - whether or not to ignore the data diff
		  
		  Dim now As UInt64 = Microseconds
		  
		  If p_mode = Modes.FullSynchronous _
		    Or p_mode = Modes.FullSynchronousCredulous _
		    Or ( ( p_mode = Modes.ThrottledSynchronous Or p_mode = Modes.ThrottledSynchronousCredulous ) And ( ignore_throttle Or p_last_update_time_msg + p_throttle <= now ) ) _
		    Or ( ( ignore_async Or ignore_async_once ) And ( p_mode = Modes.InternalAsynchronous Or p_mode = Modes.ExternalAsynchronous ) ) Then
		    
		    // The mode and throttle are not preventing us from doing an update.
		    
		    // Will the data diff prevent us from doing an update?
		    
		    Dim data_is_set As Boolean = Not ( p_mode = Modes.FullSynchronousCredulous Or p_mode = Modes.ThrottledSynchronousCredulous )
		    Dim msg As String = ""
		    
		    If data_is_set Then
		      msg = Message // TODO: take advantage of child_message to optimize this
		    End If
		    
		    If ignore_diff Or Not data_is_set Or p_prev_message <> msg Then
		      
		      // The data diff did not prevent us from doing an update.
		      
		      // Remember the time.
		      
		      p_last_update_time_msg = now
		      
		      // Perform a UI update on this node.
		      
		      notify_message data_is_set, msg
		      
		      // Remember the values we just provided to the UI.
		      
		      p_prev_message = msg
		      
		      // Notify our parent of this event.
		      
		      Dim p As ProgressDelegateKFS = Parent
		      
		      If Not ( p Is Nil ) Then
		        If data_is_set Then
		          
		          p.receive_message Me, msg, ignore_throttle, ignore_async, False, ignore_diff
		        Else
		          p.receive_message Nil, "", ignore_throttle, ignore_async, False, ignore_diff
		          
		        End If
		      End If
		      
		    Else
		      p_last_update_time_msg = now
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub receive_value(child_obj As ProgressDelegateKFS, child_value As Double, child_indeterminatevalue As Boolean, ignore_throttle As Boolean, ignore_async As Boolean, ignore_async_once As Boolean, ignore_diff As Boolean)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // This method handles the propagation of synchronous
		  // message changed events.  For simplicity, this method
		  // also does the heavy lifting for the event propagation
		  // when in InternalAsynchronous mode.
		  
		  // This method assumes the following scenerio:
		  //   A message changed event has been raised.  We do
		  //   not know where it came from, however one of our
		  //   children may have given us its message, so se
		  //   do not have to fully recalculate the message in
		  //   that case.  Based on the mode of this object,
		  //   continue the chain of events.
		  
		  // In addition to the mode of this object, there are
		  // some environmental parameters that stick with this
		  // chain of events.  They include:
		  //   - whether or not to ignore the throttle
		  //   - whether or not to ignore async mode
		  //   - whether or not to ignore async mode just once
		  //   - whether or not to ignore the data diff
		  
		  Dim now As UInt64 = Microseconds
		  
		  If p_mode = Modes.FullSynchronous _
		    Or p_mode = Modes.FullSynchronousCredulous _
		    Or ( ( p_mode = Modes.ThrottledSynchronous Or p_mode = Modes.ThrottledSynchronousCredulous ) And ( ignore_throttle Or p_last_update_time_val + p_throttle <= now ) ) _
		    Or ( ( ignore_async Or ignore_async_once ) And ( p_mode = Modes.InternalAsynchronous Or p_mode = Modes.ExternalAsynchronous ) ) Then
		    
		    // The mode and throttle are not preventing us from doing an update.
		    
		    // Will the data diff prevent us from doing an update?
		    
		    Dim data_is_set As Boolean = Not ( p_mode = Modes.FullSynchronousCredulous Or p_mode = Modes.ThrottledSynchronousCredulous )
		    Dim v As Double = 0
		    Dim i As Boolean = True
		    Dim c As Double = 0
		    Dim w As Double = 0
		    
		    If data_is_set Then
		      v = Value // TODO: take advantage of child_value to optimize this
		      i = IndeterminateValue // TODO: take advantage of child_indeterminatevalue to optimize this
		      c = TotalWeightOfChildren
		      w = Weight
		    End If
		    
		    If ignore_diff Or Not data_is_set Or p_prev_value <> v Or p_prev_indeterminate <> i Or p_prev_childrenweight <> c Then
		      
		      // The data diff did not prevent us from doing an update.
		      
		      // Remember the time.
		      
		      p_last_update_time_val = now
		      
		      // Perform a UI update on this node.
		      
		      notify_value data_is_set, v, i
		      
		      // Remember the values we just provided to the UI.
		      
		      p_prev_value = v
		      p_prev_indeterminate = i
		      p_prev_childrenweight = c
		      p_prev_weight = w
		      
		      // Notify our parent of this event.
		      
		      Dim p As ProgressDelegateKFS = Parent
		      
		      If Not ( p Is Nil ) Then
		        If data_is_set Then
		          
		          p.receive_value Me, v, i, ignore_throttle, ignore_async, False, ignore_diff
		        Else
		          p.receive_value Nil, 0, True, ignore_throttle, ignore_async, False, ignore_diff
		          
		        End If
		      End If
		      
		    ElseIf p_prev_weight <> w Then
		      
		      // The data diff prevented us from doing an
		      // update on this node, however it also
		      // suggested that we should notify the parent
		      // due to a change in the weight here, rather
		      // than letting the event die here.
		      
		      // Remember the time.
		      
		      p_last_update_time_val = now
		      
		      // Remember the values we would have provided to the UI.
		      
		      p_prev_weight = w
		      
		      // Notify our parent of this event.
		      
		      Dim p As ProgressDelegateKFS = Parent
		      
		      If Not ( p Is Nil ) Then
		        If data_is_set Then
		          
		          p.receive_value Me, v, i, ignore_throttle, ignore_async, False, ignore_diff
		        Else
		          p.receive_value Nil, 0, True, ignore_throttle, ignore_async, False, ignore_diff
		          
		        End If
		      End If
		      
		    Else
		      
		      // The data diff prevented us from doing an
		      // update on this node.  This event dies here.
		      
		      // Remember the time.
		      
		      p_last_update_time_val = now
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub SetMessage(pgd As ProgressDelegateKFS, msg As String)
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Provides a way of setting the message of a ProgressDelegateKFS
		  // object without first verifying that the ProgressDelegateKFS
		  // object is in fact not Nil.  This sounds trivial, but it
		  // comes in handy in algorithms, where one more If statement
		  // really does make things more cluttered.
		  
		  If pgd Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    pgd.Message = msg
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub SetValue(pgd As ProgressDelegateKFS, v As Double)
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Provides a way of setting the value of a ProgressDelegateKFS
		  // object without first verifying that the ProgressDelegateKFS
		  // object is in fact not Nil.  This sounds trivial, but it
		  // comes in handy in algorithms, where one more If statement
		  // really does make things more cluttered.
		  
		  If pgd Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    pgd.Value = v
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldAutoUpdateObject(obj As Object) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given object is currently set to be automatically updated.
		  
		  Return p_autoupdate_objects.HasKey( obj )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldAutoUpdateObject(obj As Object, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given object is currently set to be automatically updated.
		  
		  If obj Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf new_value Then
		    
		    p_autoupdate_objects.Value( obj ) = True
		    
		    // Update the object for the first time:
		    
		    update_object_message obj, Message
		    update_object_value obj, Value, IndeterminateValue
		    
		  ElseIf p_autoupdate_objects.HasKey( obj ) Then
		    
		    p_autoupdate_objects.Remove obj
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeMessageChangedCallback(d As MessageEventMethod) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the message changes.
		  
		  Return p_callback_msgch.HasKey( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeMessageChangedCallback(d As MessageEventMethod, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the message changes.
		  
		  If d Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf new_value Then
		    
		    p_callback_msgch.Value( d ) = True
		    
		    // Invoke the delegate for the first time:
		    
		    d.Invoke Me, Message
		    
		  ElseIf p_callback_msgch.HasKey( d ) Then
		    
		    p_callback_msgch.Remove d
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeSignalChangedCallback(d As SignalEventMethod) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the signal changes.
		  
		  Return p_callback_sigch.HasKey( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeSignalChangedCallback(d As SignalEventMethod, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the signal changes.
		  
		  If d Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf new_value Then
		    
		    p_callback_sigch.Value( d ) = True
		    
		    // Invoke the delegate for the first time:
		    
		    d.Invoke Me, Signal
		    
		  ElseIf p_callback_sigch.HasKey( d ) Then
		    
		    p_callback_sigch.Remove d
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeValueChangedCallback(d As ValueEventMethod) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the value changes.
		  
		  Return p_callback_valch.HasKey( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeValueChangedCallback(d As ValueEventMethod, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the value changes.
		  
		  If d Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf new_value Then
		    
		    p_callback_valch.Value( d ) = True
		    
		    // Invoke the delegate for the first time:
		    
		    d.Invoke Me, Value, IndeterminateValue
		    
		  ElseIf p_callback_valch.HasKey( d ) Then
		    
		    p_callback_valch.Remove d
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigCancel() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigCancel is set.
		  
		  Return p_signal = Signals.Cancel
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigCancel(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigCancel should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Cancel
		    
		  Else
		    
		    Signal = Signals.Normal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigKill() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigKill is set.
		  
		  Return p_signal = Signals.Kill
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigKill(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigKill should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Kill
		    
		  Else
		    
		    Signal = Signals.Normal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Signal() As Signals
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the value of the current signal.
		  
		  Return p_signal
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Signal(Assigns new_value As Signals)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets the current signal, and propagates the new value up the tree.
		  // This method is designed to be recursive.
		  
		  // First, figure out whether or not this new value is different.
		  Dim is_different As Boolean = Not ( p_signal = new_value )
		  
		  // Next, set the value locally.
		  p_signal = new_value
		  
		  // Next, call this function for all the children.
		  
		  For Each c As ProgressDelegateKFS In Children
		    If Not ( c Is Nil ) Then
		      c.Signal = new_value
		    End If
		  Next
		  
		  // And finally, if the signal was different, then fire the signal changed events.
		  
		  If is_different Then
		    
		    notify_signal new_value
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub SignalEventMethod(pgd As ProgressDelegateKFS, new_signal As Signals)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function SigNormal() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigNormal is set.
		  
		  Return p_signal = Signals.Normal
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigNormal(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigNormal should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Normal
		    
		  Else
		    
		    // Do nothing.
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigPause() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigPause is set.
		  
		  Return p_signal = Signals.Pause
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigPause(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigPause should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Pause
		    
		  Else
		    
		    Signal = Signals.Normal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChild(new_weight As Double = 1, new_value As Double = 0, new_msg As String = "") As ProgressDelegateKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Spawns a new child off this node, and returns a reference to the object.
		  
		  Return New ProgressDelegateKFS( Me, new_weight, new_value, new_msg )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeightOfChildren() As Double
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the total weight of all the children.
		  
		  Return p_childrenweight
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TotalWeightOfChildren(Assigns new_value As Double)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets the TotalWeightOfChildren property of this node.
		  
		  If p_weight <> new_value Then
		    
		    p_childrenweight = new_value
		    
		    If verify_children_weight Then
		      
		      // The verification changed something,
		      // so we don't need to do anything else.
		      
		    ElseIf p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		      
		      // The verification did not change anything.
		      
		      // If we already know we're in asynchronous mode, then
		      // there's no need to evaluate that massive If statement
		      // that's waiting around the corner (in receive_value).
		      
		      receive_value Nil, 0, False, False, False, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_cache_indeterminate(recursive As Boolean)
		  // Created 7/21/2011 by Andrew Keller
		  
		  // Updates the local cache of the indeterminate state property.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_cache_message(recursive As Boolean)
		  // Created 7/21/2011 by Andrew Keller
		  
		  // Updates the local cache of the message.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_cache_value(recursive As Boolean)
		  // Created 7/21/2011 by Andrew Keller
		  
		  // Updates the local cache of the value.
		  
		  // General formula:
		  //    = local value
		  //    + child 0 value * ( child 0 weight / total children weight )
		  //    + child 1 value * ( child 1 weight / total children weight )
		  //    + ...
		  //    + child N value * ( child N weight / total children weight )
		  
		  // Note that the value completely ignores the indeterminate value property.
		  // The value and the indeterminate value are completely separate by design,
		  // allowing a user interface to ignore one and not get jerks and jumps in the other.
		  
		  Dim rslt As Double = p_value
		  
		  For Each c As ProgressDelegateKFS In Children
		    If Not ( c Is Nil ) Then
		      
		      rslt = rslt + ( c.Value * ( c.p_weight / p_childrenweight ) )
		      
		    End If
		  Next
		  
		  // Sanitize the result:
		  
		  If rslt > 1 Then
		    rslt = 1
		    
		  ElseIf rslt < 0 Then
		    rslt = 0
		    
		  End If
		  
		  // Save the result to the cache.
		  
		  p_cache_value = rslt
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_object_message(obj As Object, new_message As String)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Updates the given object to display the given message.
		  
		  #if TargetDesktop then
		    
		    If obj IsA Label Then
		      
		      Label( obj ).Text = new_message
		      
		    End If
		    
		  #endif
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_object_value(obj As Object, new_value As Double, new_indeterminatevalue As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Updates the given object to display the given value.
		  
		  #if TargetDesktop then
		    
		    If obj IsA ProgressBar Then
		      
		      Dim p As ProgressBar = ProgressBar( obj )
		      
		      If new_indeterminatevalue Then
		        p.Maximum = 0
		        
		      Else
		        p.Maximum = Max( p.Width, p.Height ) * 10
		        p.Value = new_value * p.Maximum
		      End If
		    End If
		    
		  #endif
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Assigns new_value As Double)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets the Value property of this node.
		  
		  // Don't really need to sanitize the input,
		  // because the getter sanitizes the result.
		  
		  // If this code changes, don't forget to
		  // update child_rm.
		  
		  If p_indeterminate = True Or p_value <> new_value Then
		    
		    p_indeterminate = False
		    p_value = new_value
		    
		    update_cache_value False
		    
		    If p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		      
		      // If we already know we're in asynchronous mode, then
		      // there's no need to evaluate that massive If statement
		      // that's waiting around the corner (in receive_value).
		      
		      receive_value Nil, 0, False, False, False, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(include_children As Boolean = True) As Double
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns the value of this node, possibly taking
		  // into account the values of the children.
		  
		  If include_children Then
		    
		    Return p_cache_value
		    
		  Else
		    
		    Return p_value
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ValueEventMethod(pgd As ProgressDelegateKFS, new_value As Double, new_indeterminatevalue As Boolean)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function verify_children_weight() As Boolean
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Makes sure the TotalWeightOfChildren property is still possibly correct.
		  
		  // Returns whether or not the value changed something.
		  
		  Dim min_allowed As Double = current_children_weight
		  
		  If p_childrenweight < min_allowed Then
		    
		    p_childrenweight = min_allowed
		    
		    receive_value Nil, 0, False, False, False, False, False
		    
		    Return True
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current weight of this node.
		  
		  Return p_weight
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Weight(Assigns new_value As Double)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets the Weight property of this node.
		  
		  // Weights *should* be positive, however there is
		  // really no reason why a weight *can't* be zero.
		  
		  If new_value < 0 Then new_value = 0
		  
		  If p_weight <> new_value Then
		    
		    p_weight = new_value
		    
		    // Notify the parent that our Weight changed.
		    
		    Dim p As ProgressDelegateKFS = Parent
		    
		    If p Is Nil Then
		      
		      // There is no parent.
		      
		      // Do nothing.
		      
		    ElseIf p.verify_children_weight Then
		      
		      // While fixing the TotalWeightOfChildren property of
		      // the parent, a value changed event was started.
		      // No need to start one again here.
		      
		      // Do nothing.
		      
		    ElseIf p_mode <> Modes.InternalAsynchronous And p_mode <> Modes.ExternalAsynchronous Then
		      
		      // If we already know we're in asynchronous mode, then
		      // there's no need to evaluate that massive If statement
		      // that's waiting around the corner (in receive_value).
		      
		      receive_value Nil, 0, False, False, False, False, False
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageChanged(new_message As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MessageMayHaveChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SignalChanged(new_signal As Signals)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged(new_value As Double, new_indeterminatevalue As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueMayHaveChanged()
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2009-2011 Andrew Keller.
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
		Protected p_autoupdate_objects As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_cache_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_cache_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_cache_value As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_callback_msgch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_callback_sigch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_callback_valch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_children As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_childrenweight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_frequency As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_id_hint As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_internal_clock As Timer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_last_update_time_msg As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_last_update_time_val As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_mode As Modes
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_parent As ProgressDelegateKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_prev_childrenweight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_prev_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_prev_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_prev_value As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_prev_weight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_signal As Signals
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_throttle As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_value As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_weight As Double
	#tag EndProperty


	#tag Constant, Name = kDefaultFrequency_Seconds, Type = Double, Dynamic = False, Default = \"0.5", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Modes, Flags = &h0
		FullSynchronous
		  FullSynchronousCredulous
		  ThrottledSynchronous
		  ThrottledSynchronousCredulous
		  InternalAsynchronous
		ExternalAsynchronous
	#tag EndEnum

	#tag Enum, Name = Signals, Flags = &h0
		Normal
		  Pause
		  Cancel
		Kill
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
