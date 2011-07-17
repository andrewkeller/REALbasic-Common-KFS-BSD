#tag Class
Protected Class ProgressDelegateKFS
	#tag Method, Flags = &h1
		Protected Sub add_child(c As ProgressDelegateKFS)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Adds the given object as a child of this node.
		  // Also makes sure that the TotalWeightOfChildren
		  // property is up-to-date.
		  
		  p_children.Value( New WeakRef( c ) ) = True
		  
		  Call verify_children_weight
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub async_clock_method(t As Thread)
		  
		End Sub
	#tag EndMethod

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
		  
		  Dim h As New Dictionary
		  Dim cut_made As Boolean
		  
		  For Each w As Variant In p_children.Keys
		    cut_made = False
		    If w IsA WeakRef Then
		      If WeakRef( w ).Value IsA ProgressDelegateKFS Then
		        Dim p As ProgressDelegateKFS = ProgressDelegateKFS( WeakRef( w ).Value )
		        If Not ( p Is Nil ) Then
		          
		          h.Value( p ) = True
		          cut_made = True
		          
		        End If
		      End If
		    End If
		    If Not cut_made Then p_children.Remove w
		  Next
		  
		  Dim v() As Variant = h.Keys
		  Dim c() As ProgressDelegateKFS
		  
		  Dim i, l As Integer
		  l = UBound( v )
		  
		  ReDim c( l )
		  
		  For i = 0 to l
		    
		    c( i ) = ProgressDelegateKFS( v(i).ObjectValue )
		    
		  Next
		  
		  Return c
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Initializes this object.
		  
		  // If this code is modified, don't forget the other constructor.
		  
		  p_autoupdate_objects = New Dictionary
		  p_callback_msgch = New Dictionary
		  p_callback_sigch = New Dictionary
		  p_callback_valch = New Dictionary
		  p_children = New Dictionary
		  p_childrenweight = 0
		  p_frequency = New DurationKFS( kDefaultFrequency_Seconds )
		  p_indeterminate = True
		  p_internal_clock = New Thread
		  AddHandler p_internal_clock.Run, AddressOf async_clock_method
		  p_last_update_time_msg = 0
		  p_last_update_time_val = 0
		  p_message = ""
		  p_mode = Modes.ThrottledSynchronous
		  p_parent = Nil
		  p_signal = Signals.Normal
		  p_throttle = p_frequency.MicrosecondsValue
		  p_value = 0
		  p_weight = 1
		  
		  RaiseEvent Open
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(new_parent As ProgressDelegateKFS, new_weight As Double, new_value As Double, new_msg As String)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Initializes this object as a child of the given object.
		  
		  // The following is a copy of the primary constructor:
		  
		  p_autoupdate_objects = New Dictionary
		  p_callback_msgch = New Dictionary
		  p_callback_sigch = New Dictionary
		  p_callback_valch = New Dictionary
		  p_children = New Dictionary
		  p_childrenweight = 0
		  p_frequency = New DurationKFS( kDefaultFrequency_Seconds )
		  p_indeterminate = True
		  p_internal_clock = New Thread
		  AddHandler p_internal_clock.Run, AddressOf async_clock_method
		  p_last_update_time_msg = 0
		  p_last_update_time_val = 0
		  p_message = ""
		  p_mode = Modes.ThrottledSynchronous
		  p_parent = Nil
		  p_signal = Signals.Normal
		  p_throttle = p_frequency.MicrosecondsValue
		  p_value = 0
		  p_weight = 1
		  
		  // And, if the new parent is in fact non-Nil, we can go ahead with the child setup.
		  
		  If Not ( new_parent Is Nil ) Then
		    
		    // Set the local properties that are different:
		    
		    p_frequency = New DurationKFS( new_parent.p_frequency )
		    p_mode = new_parent.p_mode
		    If p_mode = Modes.InternalAsynchronous Then p_mode = Modes.ExternalAsynchronous
		    p_parent = new_parent
		    p_signal = new_parent.p_signal
		    p_throttle = new_parent.p_throttle
		    
		    // And update the parent with the information it needs:
		    
		    new_parent.add_child Me
		    
		    // Since adding a child does not change any values,
		    // there is no need to start a value changed event.
		    // If the TotalWeightOfChildren property changed in
		    // the parent, then the event will be raised, but
		    // that's a different scenario.
		    
		  End If
		  
		  RaiseEvent Open
		  
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

	#tag Method, Flags = &h0
		Sub Flush(ignore_throttle As Boolean = False, ignore_diff As Boolean = False)
		  
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
		  
		  wake_async_clock True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns new_value As Boolean)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets whether or not the value in this node is indeterminate.
		  
		  If p_indeterminate <> new_value Then
		    
		    p_indeterminate = new_value
		    
		    receive_value Nil, 0, False
		    
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
		  
		  If p_message <> new_value Then
		    
		    p_message = new_value
		    
		    receive_message Nil, ""
		    
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
		    
		    // Do we have to disable the internal clock?
		    // No, because the internal clock will disable itself.
		    
		    // Set the new mode:
		    
		    p_mode = new_value
		    
		    // Do we have to enable the internal clock?
		    
		    If p_mode = Modes.InternalAsynchronous Then
		      
		      // Yes, we have to enable the internal clock.
		      
		      wake_async_clock
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub notify_message(new_message As String)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Raises the events for a message change.
		  
		  RaiseEvent MessageChanged new_message
		  
		  For Each v As Variant In p_callback_msgch.Keys
		    Dim d As MessageEventMethod = v
		    If Not ( d Is Nil ) Then
		      
		      d.Invoke Me, new_message
		      
		    End If
		  Next
		  
		  // Also update the objects that that take a message.
		  
		  For Each v As Variant In p_autoupdate_objects.Keys
		    
		    update_object_message v.ObjectValue, new_message
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub notify_signal(new_signal As Signals)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Raises the events for a signal change.
		  
		  RaiseEvent SignalChanged new_signal
		  
		  For Each v As Variant In p_callback_sigch.Keys
		    Dim d As SignalEventMethod = v
		    If Not ( d Is Nil ) Then
		      
		      d.Invoke Me, new_signal
		      
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub notify_value(new_value As Double, new_indeterminatevalue As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Raises the events for a value change.
		  
		  RaiseEvent ValueChanged new_value, new_indeterminatevalue
		  
		  For Each v As Variant In p_callback_valch.Keys
		    Dim d As ValueEventMethod = v
		    If Not ( d Is Nil ) Then
		      
		      d.Invoke Me, new_value, new_indeterminatevalue
		      
		    End If
		  Next
		  
		  // Also update the objects that that take a value.
		  
		  For Each v As Variant In p_autoupdate_objects.Keys
		    
		    update_object_value v.ObjectValue, new_value, new_indeterminatevalue
		    
		  Next
		  
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
		Protected Sub receive_message(child_obj As ProgressDelegateKFS, child_message As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub receive_value(child_obj As ProgressDelegateKFS, child_value As Double, child_indeterminatevalue As Boolean)
		  
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
		  
		  p_childrenweight = new_value
		  
		  Call verify_children_weight
		  
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
		  
		  If p_value <> new_value Then
		    
		    p_value = new_value
		    
		    receive_value Nil, 0, False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(include_children As Boolean = True) As Double
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns the value of this node, possibly taking
		  // into account the values of the children.
		  
		  // General formula:
		  //    = local value
		  //    + child 0 value * ( child 0 weight / total children weight )
		  //    + child 1 value * ( child 1 weight / total children weight )
		  //    + ...
		  //    + child N value * ( child N weight / total children weight )
		  
		  // Note that this property completely ignores the indeterminate value property.
		  // The value and the indeterminate value are completely separate by design,
		  // allowing a user interface to ignore one and not get jerks and jumps in the other.
		  
		  Dim rslt As Double = p_value
		  
		  If include_children Then
		    For Each c As ProgressDelegateKFS In Children
		      If Not ( c Is Nil ) Then
		        
		        rslt = rslt + ( c.Value( include_children ) * ( c.p_weight / p_childrenweight ) )
		        
		      End If
		    Next
		  End If
		  
		  // Return the resut, making sure it is in the range [0,1].
		  
		  If rslt > 1 Then
		    Return 1
		    
		  ElseIf rslt < 0 Then
		    Return 0
		    
		  Else
		    Return rslt
		    
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
		    
		    receive_value Nil, 0, False
		    
		    Return True
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub wake_async_clock(nudge_only As Boolean = False)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // A convenience method that wakes the async clock.
		  
		  If p_internal_clock.State = Thread.Sleeping Or p_internal_clock.State = Thread.Suspended Then
		    
		    p_internal_clock.Resume
		    
		  ElseIf p_internal_clock.State = Thread.NotRunning And Not nudge_only Then
		    
		    p_internal_clock.Run
		    
		  End If
		  
		  // done.
		  
		End Sub
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
		    
		    // This change only affects the parent,
		    // so let's jump right there.
		    
		    Dim p As ProgressDelegateKFS = Parent
		    
		    If p Is Nil Then
		      
		      // There is no parent.
		      
		      // Do nothing.
		      
		    ElseIf p.verify_children_weight Then
		      
		      // When fixing the TotalWeightOfChildren property of
		      // the parent, a value changed event was started.
		      // No need to start one again here.
		      
		      // Do nothing.
		      
		    ElseIf p_mode = Modes.FullSynchronous Then
		      
		      // The parent does not realize the change yet.
		      
		      // We are in full synchronous mode, so notify the parent.
		      
		      p.receive_value Me, Value, IndeterminateValue
		      
		    ElseIf p_mode = Modes.ThrottledSynchronous Then
		      
		      // The parent does not realize the change yet.
		      
		      // We are in throttled synchronous mode, so
		      // notify the parent if the frequency has elapsed.
		      
		      Dim t As UInt64 = Microseconds
		      
		      If t - p_last_update_time_val >= p_throttle Then
		        
		        p_last_update_time_val = t
		        
		        p.receive_value Me, Value, IndeterminateValue
		        
		      End If
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageChanged(new_message As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SignalChanged(new_signal As Signals)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged(new_value As Double, new_indeterminatevalue As Boolean)
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
		Protected p_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_internal_clock As Thread
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


	#tag Constant, Name = kDefaultFrequency_Seconds, Type = Double, Dynamic = False, Default = \"2.5", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Modes, Flags = &h0
		FullSynchronous
		  ThrottledSynchronous
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
