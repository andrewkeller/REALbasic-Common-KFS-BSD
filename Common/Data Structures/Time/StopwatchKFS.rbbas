#tag Class
Protected Class StopwatchKFS
Inherits DurationKFS
	#tag Method, Flags = &h0
		Sub CancelStopwatch()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Cancels the stopwatch.
		  
		  p_stopwatch_running = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Children() As StopwatchKFS()
		  // Created 1/8/2012 by Andrew Keller
		  
		  // Returns an array of all the children of this node.
		  
		  Dim result(-1) As StopwatchKFS
		  
		  For Each cw As WeakRef In p_children
		    If Not ( cw Is Nil ) Then
		      Dim co As Object = cw.Value
		      If co IsA StopwatchKFS Then
		        
		        result.Append StopwatchKFS( co )
		        
		      End If
		    End If
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(other As StopwatchKFS)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  If Not ( other Is Nil ) Then
		    
		    p_stopwatch_running = other.p_stopwatch_running
		    p_microseconds = other.p_microseconds
		    p_stopwatch_starttime = other.p_stopwatch_starttime
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Adds the value of of this instance to the parent, if one is set.
		  
		  If Not ( p_parent Is Nil ) Then
		    
		    p_parent.p_microseconds = p_parent.p_microseconds + Me.MicrosecondsValue
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Returns whether or not this stopwatch or any of the children are running.
		  
		  If p_stopwatch_running Then
		    
		    Return True
		    
		    For Each c As StopwatchKFS In Children
		      If c.IsRunningLocally Then
		        
		        Return True
		        
		      End If
		    Next
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunningLocally() As Boolean
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Returns whether or not just this stopwatch is running.
		  
		  Return p_stopwatch_running
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunningLocally(Assigns newValue As Boolean)
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
		 Shared Function MaximumValue() As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the maximum value allowed.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_microseconds = kMaxValueViaUInt64
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MaximumValueViaDouble() As StopwatchKFS
		  // Created 8/9/2010 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the maximum
		  // value accessable by a Double with perfect accuracy.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_microseconds = kMaxValueViaDouble
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MicrosecondsValue() As UInt64
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns the current value of p_microseconds, taking the stopwatch into account.
		  // Optionally takes any children into account.
		  
		  Dim myTime As UInt64 = Super.MicrosecondsValue
		  
		  If p_stopwatch_running Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    Dim elapsed As UInt64 = now - p_stopwatch_starttime
		    
		    Dim sum As UInt64 = myTime + elapsed
		    
		    If sum >= myTime And sum >= elapsed Then
		      
		      // The addition did not overflow.  Save the result.
		      
		      myTime = sum
		      
		    Else
		      
		      // It doesn't matter what the other components of
		      // time are, we have already overflowed the UInt64
		      // max.  Return the maximum value.
		      
		      Return MaximumValue.MicrosecondsValue
		      
		    End If
		  End If
		  
		  For Each c As StopwatchKFS In Children
		    
		    Dim add As UInt64 = c.MicrosecondsValue
		    
		    Dim sum As UInt64 = myTime + add
		    
		    If sum >= myTime And sum >= add Then
		      
		      // The addition did not overflow.  Save the result.
		      
		      myTime = sum
		      
		    Else
		      
		      // It doesn't matter what the other components of
		      // time are, we have already overflowed the UInt64
		      // max.  Return the maximum value.
		      
		      Return MaximumValue.MicrosecondsValue
		      
		    End If
		  Next
		  
		  Return myTime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MinimumValue() As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the minimum value allowed.
		  
		  Return New StopwatchKFS
		  
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
		 Shared Function NewFromMicroseconds(newValue As UInt64) As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that allows for passing a UInt64, rather than a Double.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_microseconds = newValue
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromSystemUptime() As StopwatchKFS
		  // Created 1/8/2012 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the current system uptime.
		  
		  Dim d As New StopwatchKFS
		  
		  d.p_stopwatch_running = True
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As StopwatchKFS
		  // Created 8/20/2010 by Andrew Keller
		  
		  // A constructor that allows for passing a Double, interpreted as powerOfTen.
		  
		  Return New StopwatchKFS( newValue, powerOfTen )
		  
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
		Function SpawnChild(childIsRunning As Boolean) As StopwatchKFS
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Returns a new StopwatchKFS object that is a child of this one.
		  
		  Dim d As New StopwatchKFS
		  d.p_parent = Me
		  p_children.Append New WeakRef( d )
		  
		  d.IsRunningLocally = childIsRunning
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Split() As StopwatchKFS
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch and returns a new one with the stopwatch started.
		  
		  If p_stopwatch_running Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    p_microseconds = p_microseconds + ( now - p_stopwatch_starttime )
		    p_stopwatch_running = False
		    
		    Dim d As New StopwatchKFS
		    d.p_stopwatch_starttime = now
		    d.p_stopwatch_running = True
		    
		    Return d
		    
		  Else
		    
		    Dim d As New StopwatchKFS
		    d.p_stopwatch_starttime = Microseconds
		    d.p_stopwatch_running = True
		    
		    Return d
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Starts the stopwatch.
		  
		  If Not p_stopwatch_running Then
		    
		    p_stopwatch_starttime = Microseconds
		    p_stopwatch_running = True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch.
		  
		  If p_stopwatch_running Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    p_microseconds = p_microseconds + ( now - p_stopwatch_starttime )
		    p_stopwatch_running = False
		    
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
		Protected p_children() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_parent As StopwatchKFS = Nil
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_stopwatch_running As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_stopwatch_starttime As UInt64
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
