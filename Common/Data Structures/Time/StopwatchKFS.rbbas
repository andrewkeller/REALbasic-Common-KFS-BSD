#tag Class
Protected Class StopwatchKFS
Inherits DurationKFS
	#tag Method, Flags = &h1
		Protected Sub AssimilateAllStopwatchesStartingWithNode(node As StopwatchKFS)
		  // Created 1/8/2011 by Andrew Keller
		  
		  // Searches and copies all the stopwatch data from the given node into this node.
		  
		  For Each stopwatch_start_time As Int64 In node.p_stopwatch_starttimes
		    p_stopwatch_starttimes.Append stopwatch_start_time
		  Next
		  
		  For Each c As StopwatchKFS In node.Children
		    AssimilateAllStopwatchesStartingWithNode c
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AttachChild(d_child As StopwatchKFS)
		  // Created 1/8/2012 by Andrew Keller
		  
		  // Attaches the given StopwatchKFS object as a child of this one.
		  
		  If Not ( d_child Is Nil ) Then
		    
		    If d_child.p_id = 0 Then d_child.p_id = NextUniqueID
		    
		    If p_children Is Nil Then p_children = New Dictionary
		    
		    p_children.Value( d_child.p_id ) = New WeakRef( d_child )
		    d_child.p_parent = Me
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CancelStopwatch()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Cancels the stopwatch.
		  
		  ReDim p_stopwatch_starttimes(-1)
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Children() As StopwatchKFS()
		  // Created 1/8/2012 by Andrew Keller
		  
		  // Returns an array of all the children of this node.
		  
		  Dim result(-1) As StopwatchKFS
		  
		  Dim all_good As Boolean
		  
		  If Not ( p_children Is Nil ) Then
		    For Each ck As Variant In p_children.Keys
		      all_good = False
		      
		      Dim cv As Variant = p_children.Lookup( ck, Nil )
		      If cv IsA WeakRef Then
		        
		        Dim cw As WeakRef = WeakRef( cv )
		        If Not ( cw Is Nil ) Then
		          
		          Dim co As Object = cw.Value
		          If co IsA StopwatchKFS Then
		            
		            result.Insert 0, StopwatchKFS( co )
		            all_good = True
		            
		          End If
		        End If
		      End If
		      
		      If Not all_good And p_children.HasKey( ck ) Then p_children.Remove ck
		    Next
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As StopwatchKFS)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  Super.Constructor( other )
		  
		  If Not ( other Is Nil ) Then
		    AssimilateAllStopwatchesStartingWithNode other
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Adds the value of of this instance to the parent, if one is set.
		  
		  If Not ( p_parent Is Nil ) Then
		    
		    p_parent.DetachChild Me
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DetachChild(d_child As StopwatchKFS)
		  // Created 1/8/2012 by Andrew Keller
		  
		  // Detaches the given StopwatchKFS object as a child of this one.
		  
		  If Not ( d_child Is Nil ) Then
		    If d_child.p_id <> 0 Then
		      
		      If Not ( p_children Is Nil ) And p_children.HasKey( d_child.p_id ) Then p_children.Remove( d_child.p_id )
		      d_child.p_parent = Nil
		      
		      p_microseconds = p_microseconds + d_child.MicrosecondsValue
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAChildThatIsRunning() As Boolean
		  // Created 1/9/2012 by Andrew Keller
		  
		  // Returns whether or not any of the children of this node are running.
		  
		  For Each c As StopwatchKFS In Children
		    If c.IsRunning Then
		      
		      Return True
		      
		    End If
		  Next
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Returns whether or not this stopwatch or any of the children are running.
		  
		  Return UBound( p_stopwatch_starttimes ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunning(Assigns newValue As Boolean)
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Sets whether or not just this stopwatch is running.
		  
		  If newValue Then
		    
		    Start
		    
		  Else
		    
		    Stop
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MicrosecondsValue() As Int64
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns the current value of p_microseconds, taking the stopwatch into account.
		  // Optionally takes any children into account.
		  
		  Dim myTime As Int64 = Super.MicrosecondsValue
		  Dim now As Int64 = Microseconds
		  
		  For Each swst As Int64 In p_stopwatch_starttimes
		    
		    Dim elapsed As Int64 = now - swst
		    
		    Dim sum As Int64 = myTime + elapsed
		    
		    If sum >= myTime And sum >= elapsed Then
		      
		      // The addition did not overflow.  Save the result.
		      
		      myTime = sum
		      
		    Else
		      
		      // It doesn't matter what the other components of
		      // time are, we have already overflowed the Int64
		      // max.  Return the maximum value.
		      
		      Return MaximumValue.MicrosecondsValue
		      
		    End If
		  Next
		  
		  For Each c As StopwatchKFS In Children
		    
		    Dim add As Int64 = c.MicrosecondsValue
		    
		    Dim sum As Int64 = myTime + add
		    
		    If sum >= myTime And sum >= add Then
		      
		      // The addition did not overflow.  Save the result.
		      
		      myTime = sum
		      
		    Else
		      
		      // It doesn't matter what the other components of
		      // time are, we have already overflowed the Int64
		      // max.  Return the maximum value.
		      
		      Return MaximumValue.MicrosecondsValue
		      
		    End If
		  Next
		  
		  Return myTime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromClone(d As DurationKFS) As StopwatchKFS
		  // Created 1/8/2012 by Andrew Keller
		  
		  // A constructor that returns a clone of the given object.
		  
		  Return New StopwatchKFS( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromClone(t As Timer) As StopwatchKFS
		  // Created 1/8/2012 by Andrew Keller
		  
		  // A constructor that returns a clone of the given object.
		  
		  Return New StopwatchKFS( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		 Shared Function NewFromClone(t As WebTimer) As StopwatchKFS
		  // Created 1/8/2012 by Andrew Keller
		  
		  // A constructor that returns a clone of the given object.
		  
		  Return New StopwatchKFS( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromDateDifference(dLater As Date, dEarlier As Date) As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that returns the duration between the given dates.
		  
		  Return New StopwatchKFS( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromSystemUptime() As StopwatchKFS
		  // Created 1/8/2012 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the current system uptime.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_stopwatch_starttimes.Append 0
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewStopwatchStartingNow() As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that generates a stopwatch that's already running.
		  
		  Dim d As New StopwatchKFS
		  
		  d.Start
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithMaximum() As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the maximum value allowed.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_microseconds = kValueMax
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithMicroseconds(newValue As Int64) As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that allows for passing a Int64, rather than a Double.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_microseconds = newValue
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithMinimum() As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the minimum value allowed.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_microseconds = kValueMin
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithNegativeInfinity() As StopwatchKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithPositiveInfinity() As StopwatchKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithUndefined() As StopwatchKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithValue(newValue As Double, powerOfTen As Double = StopwatchKFS.kSeconds) As StopwatchKFS
		  // Created 8/20/2010 by Andrew Keller
		  
		  // A constructor that allows for passing a Double, interpreted as powerOfTen.
		  
		  Return New StopwatchKFS( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewWithZero() As StopwatchKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChild(childIsRunning As Boolean) As StopwatchKFS
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Returns a new StopwatchKFS object that is a child of this one.
		  
		  Dim d As New StopwatchKFS
		  
		  AttachChild d
		  
		  If childIsRunning Then d.Start
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Split() As StopwatchKFS
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch and returns a new one with the stopwatch started.
		  
		  Dim now As Int64 = Microseconds
		  
		  Stop now
		  
		  Dim d As New StopwatchKFS
		  d.p_stopwatch_starttimes.Append now
		  
		  If Not ( p_parent Is Nil ) Then
		    p_parent.AttachChild d
		  End If
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Starts the stopwatch.
		  
		  If UBound( p_stopwatch_starttimes ) < 0 Then
		    
		    p_stopwatch_starttimes.Append Microseconds
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch.
		  
		  Stop Microseconds
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Stop(value_of_now As Int64)
		  // Created 1/9/2011 by Andrew Keller
		  
		  // A version of Stop that stops the stopwatch at the given time.
		  
		  If UBound( p_stopwatch_starttimes ) > -1 Then
		    
		    // Isolate the data we need so that
		    // other threads don't clobber our data:
		    
		    Dim empty_set(-1) As Int64
		    Dim full_set(-1) As Int64
		    
		    full_set = p_stopwatch_starttimes
		    p_stopwatch_starttimes = empty_set
		    
		    // Now we can take our time adding the
		    // stopwatch data to p_microseconds:
		    
		    For Each piece As Int64 In full_set
		      
		      p_microseconds = p_microseconds + ( value_of_now - piece )
		      
		    Next
		  End If
		  
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


	#tag Property, Flags = &h1
		Protected p_children As Dictionary = Nil
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_id As Int64 = 0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_parent As StopwatchKFS = Nil
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_stopwatch_starttimes() As Int64
	#tag EndProperty


	#tag ViewBehavior
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
