#tag Class
Protected Class StopwatchKFS
Inherits DurationKFS
	#tag Method, Flags = &h0
		Sub CancelStopwatch()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Cancels the stopwatch.
		  
		  bStopwatchRunning = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(other As StopwatchKFS)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  If Not ( other Is Nil ) Then
		    
		    bStopwatchRunning = other.bStopwatchRunning
		    myMicroseconds = other.myMicroseconds
		    myStartTime = other.myStartTime
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As StopwatchKFS, liveClone As Boolean)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  If Not ( other Is Nil ) And liveClone Then
		    
		    bStopwatchRunning = other.bStopwatchRunning
		    myMicroseconds = other.myMicroseconds
		    myStartTime = other.myStartTime
		    
		  Else
		    
		    Super.Constructor( other )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Adds the value of of this instance to the parent, if one is set.
		  
		  If Not ( myParent Is Nil ) Then
		    
		    myParent.myMicroseconds = myParent.myMicroseconds + Me.MicrosecondsValue
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(includeChildren As Boolean) As UInt64
		  // Created 1/26/2011 by Andrew Keller
		  
		  // Returns the value of this object as an integer of seconds.
		  
		  Return convert_microseconds_to_uint64( MicrosecondsValue( includeChildren ), kSeconds )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(powerOfTen As Double, includeChildren As Boolean) As UInt64
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Returns the value of this object as an integer in the given units.
		  
		  Return convert_microseconds_to_uint64( MicrosecondsValue( includeChildren ), powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsRunning(Assigns newValue As Boolean)
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Sets whether or not the stopwatch is running.
		  
		  If newValue Then
		    
		    Start
		    
		  Else
		    
		    Stop
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning(includeChildren As Boolean = False) As Boolean
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Returns whether or not the stopwatch is running.
		  
		  If bStopwatchRunning Then
		    
		    Return True
		    
		  ElseIf includeChildren Then
		    
		    For Each cw As WeakRef In myChildren
		      If Not ( cw Is Nil ) Then
		        Dim c As StopwatchKFS = StopwatchKFS( cw.Value )
		        If Not ( c Is Nil ) Then
		          If c.IsRunning( includeChildren ) Then
		            
		            Return True
		            
		          End If
		        End If
		      End If
		    Next
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MaximumValue() As StopwatchKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a StopwatchKFS object containing the maximum value allowed.
		  
		  Dim d As New StopwatchKFS
		  
		  d.myMicroseconds = kMaxValueViaUInt64
		  
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
		  
		  d.myMicroseconds = kMaxValueViaDouble
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MicrosecondsValue() As UInt64
		  // Created 1/5/2012 by Andrew Keller
		  
		  // Overloaded version of MicrosecondsValue.
		  
		  Return MicrosecondsValue( True )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MicrosecondsValue(includeChildren As Boolean) As UInt64
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns the current value of myMicroseconds, taking the stopwatch into account.
		  // Optionally takes any children into account.
		  
		  Dim myTime As UInt64 = Super.MicrosecondsValue
		  
		  If bStopwatchRunning Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    Dim elapsed As UInt64 = now - myStartTime
		    
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
		  
		  If includeChildren Then
		    
		    For Each cw As WeakRef In myChildren
		      If Not ( cw Is Nil ) Then
		        Dim c As StopwatchKFS = StopwatchKFS( cw.Value )
		        If Not ( c Is Nil ) Then
		          
		          Dim add As UInt64 = c.MicrosecondsValue( includeChildren )
		          
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
		        End If
		      End If
		    Next
		  End If
		  
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
		  
		  d.myMicroseconds = newValue
		  
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
		  d.myParent = Me
		  myChildren.Append New WeakRef( d )
		  
		  d.IsRunning = childIsRunning
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Split() As StopwatchKFS
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch and returns a new one with the stopwatch started.
		  
		  If bStopwatchRunning Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    myMicroseconds = myMicroseconds + ( now - myStartTime )
		    bStopwatchRunning = False
		    
		    Dim d As New StopwatchKFS
		    d.myStartTime = now
		    d.bStopwatchRunning = True
		    
		    Return d
		    
		  Else
		    
		    Dim d As New StopwatchKFS
		    d.myStartTime = Microseconds
		    d.bStopwatchRunning = True
		    
		    Return d
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Starts the stopwatch.
		  
		  If Not bStopwatchRunning Then
		    
		    myStartTime = Microseconds
		    bStopwatchRunning = True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch.
		  
		  If bStopwatchRunning Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    myMicroseconds = myMicroseconds + ( now - myStartTime )
		    bStopwatchRunning = False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(includeChildren As Boolean) As Double
		  // Created 1/26/2011 by Andrew Keller
		  
		  // Returns the value of this object as a double of seconds.
		  
		  Return convert_microseconds_to_double( MicrosecondsValue( includeChildren ), kSeconds )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(powerOfTen As Double, includeChildren As Boolean) As Double
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Returns the value of this object as a double in the given units.
		  
		  Return convert_microseconds_to_double( MicrosecondsValue( includeChildren ), powerOfTen )
		  
		  // done.
		  
		End Function
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
		Protected bStopwatchRunning As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myChildren() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParent As StopwatchKFS = Nil
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myStartTime As UInt64
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
