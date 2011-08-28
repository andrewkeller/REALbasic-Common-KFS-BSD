#tag Class
Protected Class ProgressDelegateKFS
	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub BasicEventMethod(pgd As ProgressDelegateKFS)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the number of nodes that are children of this node.
		  
		  Return p_local_children.Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children() As ProgressDelegateKFS()
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns an array of all the nodes that are children of this node.
		  
		  Dim v() As Variant
		  Dim c() As ProgressDelegateKFS
		  
		  v = p_local_children.Values
		  
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
		Protected Sub child_add(c As ProgressDelegateKFS)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Adds the given object as a child of this node.
		  // Also makes sure that the TotalWeightOfChildren
		  // property is up-to-date.
		  
		  If Not ( c Is Nil ) Then
		    
		    p_local_children.Value( c.p_local_uid ) = New WeakRef( c )
		    
		    Call verify_children_weight
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub child_rm(c As ProgressDelegateKFS)
		  // Created 7/19/2011 by Andrew Keller
		  
		  // Removes the given child from this node.
		  // Also merges the child's data into this node.
		  
		  If p_local_children.HasKey( c.p_local_uid ) Then
		    
		    If Not ( c Is Nil ) Then
		      
		      p_local_children.Remove c.p_local_uid
		      
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
		      
		      Dim mc, vc, ic As Boolean = False
		      
		      If p_local_message = "" And c.p_local_message <> "" Then
		        
		        // This child had a message, and we did not have
		        // a message that overrode it, so in unlinking
		        // this child, the message may have changed.
		        
		        mc = True
		        
		      End If
		      
		      If c.p_local_weight > 0 Then
		        
		        // This child has a non-zero weight.
		        // Let's add it in to this node.
		        
		        p_local_value = Min( Max( p_local_value + c.p_local_weight / p_local_childrenweight, 0 ), 1 )
		        p_local_indeterminate = False
		        vc = True
		        ic = True
		        
		      End If
		      
		      If p_local_indeterminate = True And c.p_local_indeterminate = False Then
		        
		        // This child knew what its value was, and we don't.
		        // Therefore, indeterminate may have just become True.
		        
		        ic = True
		        
		      End If
		      
		      If mc or vc or ic Then Invalidate mc, vc, ic
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub common_init()
		  // Created 7/21/2011 by Andrew Keller
		  
		  // Provides the initialization code that is common to all the Constructors.
		  
		  p_cache_indeterminate = True
		  p_cache_message = ""
		  p_cache_messagedepth = 0
		  p_cache_value = 0
		  p_invalidate_indeterminate = False
		  p_invalidate_message = False
		  p_invalidate_value = False
		  p_local_autoupdate_objects = New Dictionary
		  p_local_callback_msgch = New Dictionary
		  p_local_callback_valch = New Dictionary
		  p_local_children = New Dictionary
		  p_local_childrenweight = 0
		  p_local_indeterminate = True
		  p_local_message = ""
		  p_local_notifications_enabled = True
		  p_local_notifytimer = New Timer
		  AddHandler p_local_notifytimer.Action, WeakAddressOf hook_notify
		  p_local_notifytimer.Period = DurationKFS.NewFromValue(kDefaultFrequency_Seconds).Value(DurationKFS.kMilliseconds)
		  p_local_parent = Nil
		  p_local_signal = Signals.Normal
		  p_local_uid = NewUniqueInteger
		  p_local_value = 0
		  p_local_weight = 1
		  
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
		Attributes( Hidden = True )  Sub Constructor(new_parent As ProgressDelegateKFS, new_weight As Double, new_value As Double, new_message As String)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Initializes this object as a child of the given object.
		  
		  common_init
		  
		  // And, if the new parent is in fact non-Nil, we can go ahead with the child setup.
		  
		  If Not ( new_parent Is Nil Or new_parent Is Me ) Then
		    
		    // Set the local properties that are different:
		    
		    p_local_message = new_message
		    p_local_notifications_enabled = False
		    p_local_parent = new_parent
		    p_local_signal = new_parent.p_local_signal
		    p_local_value = new_value
		    p_local_weight = new_weight
		    
		    // And update the parent with the information it needs:
		    
		    new_parent.child_add Me
		    
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
		      
		      rslt = rslt + c.p_local_weight
		      
		    End If
		  Next
		  
		  Return rslt
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  // Created 7/17/2011 by Andrew Keller
		  
		  // This object is deallocating.  Unlink this object from
		  // the parent.  The parent will grab what it needs from
		  // this object before it has been deallocated.
		  
		  If Not ( p_local_parent Is Nil ) Then
		    
		    p_local_parent.child_rm Me
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Frequency() As DurationKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current frequency.
		  
		  Return p_local_notifytimer
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Frequency(Assigns new_value As DurationKFS)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets the frequency of this object.
		  
		  If new_value Is Nil Then
		    
		    p_local_notifytimer.Period = 1
		    
		  Else
		    
		    p_local_notifytimer.Period = new_value.Value( DurationKFS.kMilliseconds )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub hook_notify(t As Timer)
		  // Created 8/28/2011 by Andrew Keller
		  
		  // Raises the data changed events.
		  
		  If p_local_notifications_enabled Then
		    
		    Dim im As Boolean = p_invalidate_message
		    Dim iv As Boolean = p_invalidate_value Or p_invalidate_indeterminate
		    
		    If im Then
		      
		      // Update the objects that that take a message.
		      
		      For Each v As Variant In p_local_autoupdate_objects.Keys
		        
		        update_object_message v.ObjectValue, Message
		        
		      Next
		      
		      // Invoke the message changed callbacks.
		      
		      For Each v As Variant In p_local_callback_msgch.Keys
		        Dim d As BasicEventMethod = v
		        If Not ( d Is Nil ) Then
		          
		          d.Invoke Me
		          
		        End If
		      Next
		      
		      // And finally, raise the MessageChanged event.
		      
		      RaiseEvent MessageChanged
		      
		    End If
		    
		    If iv Then
		      
		      // Update the objects that that take a value.
		      
		      For Each v As Variant In p_local_autoupdate_objects.Keys
		        
		        update_object_value v.ObjectValue, Value, IndeterminateValue
		        
		      Next
		      
		      // Invoke the value changed callbacks.
		      
		      For Each v As Variant In p_local_callback_valch.Keys
		        Dim d As BasicEventMethod = v
		        If Not ( d Is Nil ) Then
		          
		          d.Invoke Me
		          
		        End If
		      Next
		      
		      // And finally, raise the ValueChanged event.
		      
		      RaiseEvent ValueChanged
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns new_value As Boolean)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets whether or not the value in this node is indeterminate.
		  
		  If p_local_indeterminate <> new_value Then
		    
		    p_local_indeterminate = new_value
		    
		    Invalidate False, False, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndeterminateValue(include_children As Boolean = True) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not this node has an indeterminate value,
		  // possibly taking into account the children nodes.
		  
		  If include_children Then
		    
		    If p_invalidate_indeterminate Then update_cache_indeterminate
		    
		    Return p_cache_indeterminate
		    
		  Else
		    
		    Return p_local_indeterminate
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Invalidate(invalidate_message As Boolean, invalidate_value As Boolean, invalidate_indeterminate As Boolean)
		  // Created 8/27/2011 by Andrew Keller
		  
		  // Invalidates all caches between this node and the root.
		  
		  Dim cursor As ProgressDelegateKFS = Me
		  
		  While ( invalidate_message Or invalidate_value Or invalidate_indeterminate ) And Not ( cursor Is Nil )
		    
		    If invalidate_message Then
		      If cursor.p_invalidate_message Then
		        
		        invalidate_message = False
		        
		      Else
		        
		        cursor.p_invalidate_message = True
		        
		      End If
		    End If
		    
		    If invalidate_value Then
		      If cursor.p_invalidate_value Then
		        
		        invalidate_value = False
		        
		      Else
		        
		        cursor.p_invalidate_value = True
		        
		      End If
		    End If
		    
		    If invalidate_indeterminate Then
		      If cursor.p_invalidate_indeterminate Then
		        
		        invalidate_indeterminate = False
		        
		      Else
		        
		        cursor.p_invalidate_indeterminate = True
		        
		      End If
		    End If
		    
		    Notify
		    
		    cursor = cursor.p_local_parent
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LocalNotificationsEnabled() As Boolean
		  // Created 8/28/2011 by Andrew Keller
		  
		  // Returns whether or not local notifications are enabled.
		  
		  Return p_local_notifications_enabled
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalNotificationsEnabled(Assigns new_value As Boolean)
		  // Created 8/28/2011 by Andrew Keller
		  
		  // Sets whether or not local notifications should be enabled.
		  
		  p_local_notifications_enabled = new_value
		  
		  Notify
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns new_value As String)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets the message of this node.
		  
		  If p_local_message <> new_value Then
		    
		    p_local_message = new_value
		    
		    Invalidate True, False, False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message(include_children As Boolean = True) As String
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns the message of this node.
		  
		  // If the local message is an empty string and
		  // include_children is True, then the children
		  // are searched for a non-empty string using a
		  // breadth first search.
		  
		  If include_children Then
		    
		    If p_invalidate_message Then update_cache_message
		    
		    Return p_cache_message
		    
		  Else
		    
		    Return p_local_message
		    
		  End If
		  
		  // done.
		  
		End Function
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
		Protected Sub Notify()
		  // Created 8/28/2011 by Andrew Keller
		  
		  // Sets up the internal timer to invoke the hook_notify method.
		  
		  If p_local_notifications_enabled Then
		    If p_invalidate_message Or p_invalidate_value Or p_invalidate_indeterminate Then
		      If p_local_notifytimer.Mode = Timer.ModeOff Then
		        
		        p_local_notifytimer.Mode = Timer.ModeSingle
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parent() As ProgressDelegateKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns a reference to the parent object.
		  
		  Return p_local_parent
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub SetMessage(pgd As ProgressDelegateKFS, new_message As String)
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Provides a way of setting the message of a ProgressDelegateKFS
		  // object without first verifying that the ProgressDelegateKFS
		  // object is in fact not Nil.  This sounds trivial, but it
		  // comes in handy in algorithms, where one more If statement
		  // really does make things more cluttered.
		  
		  If pgd Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    pgd.Message = new_message
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub SetValue(pgd As ProgressDelegateKFS, new_value As Double)
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Provides a way of setting the value of a ProgressDelegateKFS
		  // object without first verifying that the ProgressDelegateKFS
		  // object is in fact not Nil.  This sounds trivial, but it
		  // comes in handy in algorithms, where one more If statement
		  // really does make things more cluttered.
		  
		  If pgd Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    pgd.Value = new_value
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldAutoUpdateObject(obj As Object) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given object is currently set to be automatically updated.
		  
		  Return p_local_autoupdate_objects.HasKey( obj )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldAutoUpdateObject(obj As Object, Assigns should_update As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given object is currently set to be automatically updated.
		  
		  If obj Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf should_update Then
		    
		    p_local_autoupdate_objects.Value( obj ) = True
		    
		    // Update the object for the first time:
		    
		    update_object_message obj, Message
		    update_object_value obj, Value, IndeterminateValue
		    
		  ElseIf p_local_autoupdate_objects.HasKey( obj ) Then
		    
		    p_local_autoupdate_objects.Remove obj
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeMessageChangedCallback(callback As BasicEventMethod) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the message changes.
		  
		  Return p_local_callback_msgch.HasKey( callback )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeMessageChangedCallback(callback As BasicEventMethod, Assigns should_invoke As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the message changes.
		  
		  If callback Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf should_invoke Then
		    
		    p_local_callback_msgch.Value( callback ) = True
		    
		    // Invoke the delegate for the first time:
		    
		    callback.Invoke Me
		    
		  ElseIf p_local_callback_msgch.HasKey( callback ) Then
		    
		    p_local_callback_msgch.Remove callback
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeValueChangedCallback(callback As BasicEventMethod) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the value changes.
		  
		  Return p_local_callback_valch.HasKey( callback )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeValueChangedCallback(callback As BasicEventMethod, Assigns should_invoke As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the value changes.
		  
		  If callback Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf should_invoke Then
		    
		    p_local_callback_valch.Value( callback ) = True
		    
		    // Invoke the delegate for the first time:
		    
		    callback.Invoke Me
		    
		  ElseIf p_local_callback_valch.HasKey( callback ) Then
		    
		    p_local_callback_valch.Remove callback
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigCancel() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigCancel is set.
		  
		  Return p_local_signal = Signals.Cancel
		  
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
		  
		  Return p_local_signal = Signals.Kill
		  
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
		  
		  Return p_local_signal
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Signal(Assigns new_value As Signals)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets the current signal, and propagates the new value up the tree.
		  // This method is designed to be recursive.
		  
		  // First, figure out whether or not this new value is different.
		  
		  Dim is_different As Boolean = Not ( p_local_signal = new_value )
		  
		  // Next, set the value locally.
		  
		  p_local_signal = new_value
		  
		  // Next, call this function for all the children.
		  
		  For Each c As ProgressDelegateKFS In Children
		    c.Signal = new_value
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigNormal() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigNormal is set.
		  
		  Return p_local_signal = Signals.Normal
		  
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
		  
		  Return p_local_signal = Signals.Pause
		  
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
		Function SpawnChild(new_weight As Double = 1, new_value As Double = 0, new_message As String = "") As ProgressDelegateKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Spawns a new child off this node, and returns a reference to the object.
		  
		  Return New ProgressDelegateKFS( Me, new_weight, new_value, new_message )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeightOfChildren() As Double
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the total weight of all the children.
		  
		  Return p_local_childrenweight
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TotalWeightOfChildren(Assigns new_value As Double)
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Sets the TotalWeightOfChildren property of this node.
		  
		  If p_local_childrenweight <> new_value Then
		    
		    p_local_childrenweight = new_value
		    
		    If verify_children_weight Then
		      
		      // While fixing the TotalWeightOfChildren
		      // property, a value changed event was started.
		      // No need to start one again here.
		      
		      // Do nothing.
		      
		    Else
		      
		      // The total children weight did change, which means the
		      // value also changed.  Start a value changed event.
		      
		      Invalidate False, True, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_cache_indeterminate()
		  // Created 8/27/2011 by Andrew Keller
		  
		  // Updates the cache of the IndeterminateValue property.
		  
		  If p_invalidate_indeterminate Then
		    
		    For Each c As ProgressDelegateKFS In Children
		      
		      c.update_cache_indeterminate
		      
		      If c.p_cache_indeterminate = False Then
		        
		        p_cache_indeterminate = False
		        p_invalidate_indeterminate = False
		        Return
		        
		      End If
		    Next
		    
		    p_cache_indeterminate = p_local_indeterminate
		    p_invalidate_indeterminate = False
		    Return
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_cache_message()
		  // Created 8/27/2011 by Andrew Keller
		  
		  // Updates the cache of the IndeterminateValue property.
		  
		  If p_invalidate_message Then
		    
		    Dim rslt As String = p_local_message
		    Dim depth As Integer = 0
		    
		    If rslt = "" Then
		      For Each c As ProgressDelegateKFS In Children
		        
		        c.update_cache_message
		        
		        If rslt = "" Or ( c.p_cache_message <> "" And c.p_cache_messagedepth +1 < depth ) Then
		          
		          rslt = c.p_cache_message
		          depth = c.p_cache_messagedepth +1
		          
		          If rslt <> "" And depth = 1 Then Exit
		          
		        End If
		      Next
		    End If
		    
		    p_cache_message = rslt
		    p_cache_messagedepth = depth
		    p_invalidate_message = False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_cache_value()
		  // Created 8/27/2011 by Andrew Keller
		  
		  // Updates the cache of the Value property.
		  
		  If p_invalidate_value Then
		    
		    Dim rslt As Double = p_local_value
		    
		    For Each c As ProgressDelegateKFS In Children
		      
		      c.update_cache_value
		      
		      rslt = rslt + ( c.p_cache_value * ( c.p_local_weight / p_local_childrenweight ) )
		      
		    Next
		    
		    p_cache_value = rslt
		    p_invalidate_value = False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub update_object_message(obj As Object, new_message As String)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Updates the given object to display the given message.
		  
		  #if TargetDesktop then
		    
		    If obj IsA Label Then
		      
		      If Label( obj ).Text <> new_message Then
		        
		        Label( obj ).Text = new_message
		        
		      End If
		      
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
		        
		        If p.Maximum <> 0 Then
		          p.Maximum = 0
		        End If
		        
		      Else
		        
		        Dim m As Integer = Max( p.Width, p.Height ) * 10
		        Dim v As Integer = new_value * m
		        
		        If p.Value <> v Or p.Maximum <> m Then
		          
		          p.Maximum = m
		          p.Value = v
		          
		        End If
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
		  
		  Dim iv As Boolean = p_local_value <> new_value
		  Dim ii As Boolean = p_local_indeterminate <> False
		  
		  If iv Or ii Then
		    
		    p_local_value = new_value
		    p_local_indeterminate = False
		    
		    Invalidate False, iv, ii
		    
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
		    
		    If p_invalidate_value Then update_cache_value
		    
		    Return p_cache_value
		    
		  Else
		    
		    Return p_local_value
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function verify_children_weight() As Boolean
		  // Created 7/17/2011 by Andrew Keller
		  
		  // Makes sure the TotalWeightOfChildren property is still possibly correct.
		  
		  // Returns whether or not the value changed something.
		  
		  Dim min_allowed As Double = current_children_weight
		  
		  If p_local_childrenweight < min_allowed Then
		    
		    p_local_childrenweight = min_allowed
		    
		    Invalidate False, True, False
		    
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
		  
		  Return p_local_weight
		  
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
		  
		  If p_local_weight <> new_value Then
		    
		    p_local_weight = new_value
		    
		    // Notify the parent that our Weight changed.
		    
		    If p_local_parent Is Nil Then
		      
		      // There is no parent.
		      
		      // Do nothing.
		      
		    ElseIf p_local_parent.verify_children_weight Then
		      
		      // While fixing the TotalWeightOfChildren property of
		      // the parent, a value changed event was started.
		      // No need to start one again here.
		      
		      // Do nothing.
		      
		    Else
		      
		      // The weight did change, which means the value changed.
		      // Start a value changed event in the parent.
		      
		      p_local_parent.Invalidate False, True, False
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
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
		Protected p_cache_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_cache_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_cache_messagedepth As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_cache_value As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_invalidate_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_invalidate_message As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_invalidate_value As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_autoupdate_objects As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_callback_msgch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_callback_valch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_children As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_childrenweight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_notifications_enabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_notifytimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_parent As ProgressDelegateKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_signal As Signals
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_uid As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_value As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_local_weight As Double
	#tag EndProperty


	#tag Constant, Name = kDefaultFrequency_Seconds, Type = Double, Dynamic = False, Default = \"0.5", Scope = Protected
	#tag EndConstant


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
