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

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Clears all the data in this object.
		  
		  bStopwatchRunning = False
		  myMicroseconds = 0
		  myStartTime = 0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Basic constructor.
		  
		  Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(dLater As Date, dEarlier As Date)
		  // Created 8/20/2010 by Andrew Keller
		  
		  // A constructor that returns the duration between the given dates.
		  
		  Me.Value( kSeconds ) = dLater.TotalSeconds - dEarlier.TotalSeconds
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A constructor that also sets the value.
		  
		  Me.Value( powerOfTen ) = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As StopwatchKFS, liveClone As Boolean = True)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  If other Is Nil Then
		    
		    Clear
		    
		  ElseIf liveClone = True And other IsA StopwatchKFS Then
		    
		    Dim s As StopwatchKFS = StopwatchKFS( other )
		    
		    bStopwatchRunning = s.bStopwatchRunning
		    myMicroseconds = s.myMicroseconds
		    myStartTime = s.myStartTime
		    
		  Else
		    
		    Me.MicrosecondsValue = other.MicrosecondsValue
		    
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
		  
		  // Returns the value of this object as an integer in the given units.
		  
		  Return IntegerValue( kSeconds, includeChildren )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(powerOfTen As Double = 0, includeChildren As Boolean = True) As UInt64
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Returns the value of this object as an integer in the given units.
		  
		  Dim result As UInt64 = MicrosecondsValue( includeChildren )
		  Dim p As Integer = powerOfTen
		  
		  If powerOfTen = kMicroseconds Then
		    
		    // This case exists for stability, not for speed.  If anything works
		    // in this class, it will be dealing with microseconds, because no
		    // math is involved.  This provides a good foothold for unit testing.
		    
		    result = result
		    
		  ElseIf p = powerOfTen Then
		    
		    // The exponent is a strict power of ten.
		    
		    result = result / ( 10 ^ ( p + 6 ))
		    
		  ElseIf powerOfTen = kMinutes Then
		    result = result / 60000000
		    
		  ElseIf powerOfTen = kHours Then
		    result = result / 3600000000
		    
		  ElseIf powerOfTen = kDays Then
		    result = result / 86400000000
		    
		  ElseIf powerOfTen = kWeeks Then
		    result = result / 604800000000
		    
		  ElseIf powerOfTen = kMonths Then
		    result = result / 2629800000000
		    
		  ElseIf powerOfTen = kYears Then
		    result = result / 31557600000000
		    
		  ElseIf powerOfTen = kDecades Then
		    result = result / 315576000000000
		    
		  ElseIf powerOfTen = kCenturies Then
		    result = result / 3155760000000000
		    
		  Else
		    Raise New UnsupportedFormatException
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerValue(powerOfTen As Double = 0, Assigns newValue As UInt64)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Sets the value of this object to the given value in the given units.
		  
		  Dim p As Integer = powerOfTen
		  
		  If powerOfTen = kMicroseconds Then
		    
		    // This case exists for stability, not for speed.  If anything works
		    // in this class, it will be dealing with microseconds, because no
		    // math is involved.  This provides a good foothold for unit testing.
		    
		    MicrosecondsValue = newValue
		    
		  ElseIf p = powerOfTen Then
		    
		    // The exponent is a strict power of ten.
		    
		    MicrosecondsValue = newValue * ( 10 ^ ( p + 6 ))
		    
		  ElseIf powerOfTen = kMinutes Then
		    MicrosecondsValue = newValue * 60000000
		    
		  ElseIf powerOfTen = kHours Then
		    MicrosecondsValue = newValue * 3600000000
		    
		  ElseIf powerOfTen = kDays Then
		    MicrosecondsValue = newValue * 86400000000
		    
		  ElseIf powerOfTen = kWeeks Then
		    MicrosecondsValue = newValue * 604800000000
		    
		  ElseIf powerOfTen = kMonths Then
		    MicrosecondsValue = newValue * 2629800000000
		    
		  ElseIf powerOfTen = kYears Then
		    MicrosecondsValue = newValue * 31557600000000
		    
		  ElseIf powerOfTen = kDecades Then
		    MicrosecondsValue = newValue * 315576000000000
		    
		  ElseIf powerOfTen = kCenturies Then
		    MicrosecondsValue = newValue * 3155760000000000
		    
		  Else
		    Raise New UnsupportedFormatException
		  End If
		  
		  // done.
		  
		End Sub
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
		  
		  d.myMicroseconds = -1
		  
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
		  
		  d.Value( kMicroseconds ) = MaximumValue.MicrosecondsValue
		  
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
		Sub MicrosecondsValue(Assigns newValue As UInt64)
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Stores the given value of microseconds.
		  
		  bStopwatchRunning = False
		  myMicroseconds = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MicrosecondsValue(includeChildren As Boolean) As UInt64
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns the current value of myMicroseconds, taking the stopwatch into account.
		  // Optionally takes any children into account.
		  
		  Dim myTime As UInt64 = myMicroseconds
		  
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
		  
		  d.MicrosecondsValue = newValue
		  
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
		    
		    Dim i As UInt64 = Microseconds
		    
		    myMicroseconds = myMicroseconds + ( i - myStartTime )
		    bStopwatchRunning = False
		    
		    Dim d As New StopwatchKFS
		    d.myStartTime = i
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
		    
		    MicrosecondsValue = MicrosecondsValue
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(includeChildren As Boolean) As Double
		  // Created 1/26/2011 by Andrew Keller
		  
		  // Returns the value of this object as a double in the given units.
		  
		  Return Value( kSeconds, includeChildren )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(powerOfTen As Double = 0, includeChildren As Boolean = True) As Double
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Returns the value of this object as a double in the given units.
		  
		  Dim mm As UInt64 = MicrosecondsValue( includeChildren )
		  Dim result As Double
		  Dim p As Integer = powerOfTen
		  
		  If powerOfTen = kMicroseconds Then
		    
		    // This case exists for stability, not for speed.  If anything works
		    // in this class, it will be dealing with microseconds, because no
		    // math is involved.  This provides a good foothold for unit testing.
		    
		    result = mm
		    
		  ElseIf p = powerOfTen Then
		    
		    // The exponent is a strict power of ten.
		    
		    result = mm / ( 10 ^ ( p + 6 ))
		    
		  ElseIf powerOfTen = kMinutes Then
		    result = mm / 60000000
		    
		  ElseIf powerOfTen = kHours Then
		    result = mm / 3600000000
		    
		  ElseIf powerOfTen = kDays Then
		    result = mm / 86400000000
		    
		  ElseIf powerOfTen = kWeeks Then
		    result = mm / 604800000000
		    
		  ElseIf powerOfTen = kMonths Then
		    result = mm / 2629800000000
		    
		  ElseIf powerOfTen = kYears Then
		    result = mm / 31557600000000
		    
		  ElseIf powerOfTen = kDecades Then
		    result = mm / 315576000000000
		    
		  ElseIf powerOfTen = kCenturies Then
		    result = mm / 3155760000000000
		    
		  Else
		    Raise New UnsupportedFormatException
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(powerOfTen As Double = 0, Assigns newValue As Double)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Sets the value of this object to the given value in the given units.
		  
		  Dim p As Integer = powerOfTen
		  
		  If powerOfTen = kMicroseconds Then
		    
		    // This case exists for stability, not for speed.  If anything works
		    // in this class, it will be dealing with microseconds, because no
		    // math is involved.  This provides a good foothold for unit testing.
		    
		    MicrosecondsValue = newValue
		    
		  ElseIf p = powerOfTen Then
		    
		    // The exponent is a strict power of ten.
		    
		    MicrosecondsValue = newValue * ( 10 ^ ( p + 6 ))
		    
		  ElseIf powerOfTen = kMinutes Then
		    MicrosecondsValue = newValue * 60000000
		    
		  ElseIf powerOfTen = kHours Then
		    MicrosecondsValue = newValue * 3600000000
		    
		  ElseIf powerOfTen = kDays Then
		    MicrosecondsValue = newValue * 86400000000
		    
		  ElseIf powerOfTen = kWeeks Then
		    MicrosecondsValue = newValue * 604800000000
		    
		  ElseIf powerOfTen = kMonths Then
		    MicrosecondsValue = newValue * 2629800000000
		    
		  ElseIf powerOfTen = kYears Then
		    MicrosecondsValue = newValue * 31557600000000
		    
		  ElseIf powerOfTen = kDecades Then
		    MicrosecondsValue = newValue * 315576000000000
		    
		  ElseIf powerOfTen = kCenturies Then
		    MicrosecondsValue = newValue * 3155760000000000
		    
		  Else
		    Raise New UnsupportedFormatException
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
		Protected bStopwatchRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myChildren() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParent As StopwatchKFS
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
