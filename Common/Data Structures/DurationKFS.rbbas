#tag Class
Protected Class DurationKFS
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
		Sub Constructor(other As DurationKFS, parallelClone As Boolean = True)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  If other = Nil Then
		    
		    Clear
		    
		  ElseIf parallelClone = False Then
		    
		    Me.MicrosecondsValue = other.MicrosecondsValue
		    
		  Else
		    
		    bStopwatchRunning = other.bStopwatchRunning
		    myMicroseconds = other.myMicroseconds
		    myStartTime = other.myStartTime
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(powerOfTen As Double = 0) As UInt64
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Returns the value of this object as an integer in the given units.
		  
		  Dim result As UInt64 = MicrosecondsValue
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
		 Shared Function MaximumValue() As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a DurationKFS object containing the maximum value allowed.
		  
		  Dim d As New DurationKFS
		  
		  d.myMicroseconds = -1
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MaximumValueViaDouble() As DurationKFS
		  // Created 8/9/2010 by Andrew Keller
		  
		  // Returns a DurationKFS object containing the maximum
		  // value accessable by a Double with perfect accuracy.
		  
		  Dim d As New DurationKFS
		  
		  d.Value( kMicroseconds ) = MaximumValue.MicrosecondsValue
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MinimumValue() As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a DurationKFS object containing the minimum value allowed.
		  
		  Return New DurationKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that returns the duration between the given dates.
		  
		  Return New DurationKFS( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromMicroseconds(newValue As UInt64) As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that allows for passing a UInt64, rather than a Double.
		  
		  Dim d As New DurationKFS
		  
		  d.MicrosecondsValue = newValue
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewFromValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 8/20/2010 by Andrew Keller
		  
		  // A constructor that allows for passing a Double, interpreted as powerOfTen.
		  
		  Return New DurationKFS( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewStopwatchStartingNow() As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A constructor that generates a stopwatch that's already running.
		  
		  Dim d As New DurationKFS
		  
		  d.Start
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(other As Date) As Date
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a date that is this far in the future from the given date.
		  
		  Dim d As New Date
		  
		  d.TotalSeconds = other.TotalSeconds + Me.Value( kSeconds )
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(other As DurationKFS) As DurationKFS
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Defining the (+) operator.
		  
		  Dim v1, v2, t As UInt64
		  
		  v1 = Me.MicrosecondsValue
		  If other <> Nil Then v2 = other.MicrosecondsValue
		  
		  t = v1 + v2
		  
		  If t >= v1 And t >= v2 Then
		    
		    Return NewFromMicroseconds( t )
		    
		  Else
		    
		    Return MaximumValue
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_AddRight(other As Date) As Date
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a date that is this far in the future from the given date.
		  
		  Dim d As New Date
		  
		  d.TotalSeconds = other.TotalSeconds + Me.Value( kSeconds )
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_AddRight(other As DurationKFS) As DurationKFS
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Defining the (+) operator.
		  
		  Return Operator_Add( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(other As DurationKFS) As Integer
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Defining the compare operators.
		  
		  If other = Nil Then Return 1
		  
		  Dim v1, v2 As UInt64
		  
		  v1 = Me.MicrosecondsValue
		  v2 = other.MicrosecondsValue
		  
		  If v1 < v2 Then
		    
		    Return -1
		    
		  ElseIf v1 > v2 Then
		    
		    Return 1
		    
		  Else
		    
		    Return 0
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(newValue As Timer)
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A convert constructor that takes the period of the given Timer.
		  
		  If newValue = Nil Then
		    
		    Clear
		    
		  ElseIf newValue <> Nil Then
		    
		    Me.Value( kMilliseconds ) = newValue.Period
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(other As DurationKFS) As Double
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Defining the (/) operator.
		  
		  Dim n, d As Double
		  
		  n = Me.MicrosecondsValue
		  If other <> Nil Then d = other.MicrosecondsValue
		  
		  Return n/d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_IntegerDivide(other As DurationKFS) As UInt64
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Defining the (\) operator.
		  
		  Dim n, d As Double
		  
		  n = Me.MicrosecondsValue
		  If other <> Nil Then d = other.MicrosecondsValue
		  
		  Return n\d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Modulo(other As DurationKFS) As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Defining the (\) operator.
		  
		  Dim n, d As UInt64
		  
		  n = Me.MicrosecondsValue
		  If other <> Nil Then d = other.MicrosecondsValue
		  
		  Return NewFromMicroseconds( n Mod d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(scalar As Double) As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Defining the (*) operator.
		  
		  Dim i, j, k As UInt64
		  
		  i = Me.MicrosecondsValue
		  j = -1
		  k = Ceil( Abs( scalar ) )
		  
		  If scalar <= j / i Then
		    
		    Return NewFromMicroseconds( i * scalar )
		    
		  End If
		  
		  Return MaximumValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_MultiplyRight(scalar As Double) As DurationKFS
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Defining the (*) operator.
		  
		  Return Operator_Multiply( scalar )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(other As DurationKFS) As DurationKFS
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Defining the (-) operator.
		  
		  Dim v1, v2 As UInt64
		  
		  v1 = Me.MicrosecondsValue
		  If other <> Nil Then v2 = other.MicrosecondsValue
		  
		  If v1 > v2 Then
		    
		    Return NewFromMicroseconds( v1 - v2 )
		    
		  Else
		    
		    Return MinimumValue
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_SubtractRight(other As Date) As Date
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns a date that is this far in the past from the given date.
		  
		  Dim d As New Date
		  
		  d.TotalSeconds = other.TotalSeconds - Me.Value( kSeconds )
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Split() As DurationKFS
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Stops the stopwatch and returns a new one with the stopwatch started.
		  
		  If bStopwatchRunning Then
		    
		    Dim i As UInt64 = Microseconds
		    
		    myMicroseconds = myMicroseconds + ( i - myStartTime )
		    bStopwatchRunning = False
		    
		    Dim d As New DurationKFS
		    d.myStartTime = i
		    d.bStopwatchRunning = True
		    
		    Return d
		    
		  Else
		    
		    Dim d As New DurationKFS
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
		Function Value(powerOfTen As Double = 0) As Double
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Returns the value of this object as a double in the given units.
		  
		  Dim mm As UInt64 = MicrosecondsValue
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


	#tag Property, Flags = &h1
		Protected bStopwatchRunning As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/18/2010 by Andrew Keller
			  
			  // Returns whether or not the stopwatch is running.
			  
			  Return bStopwatchRunning
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/18/2010 by Andrew Keller
			  
			  // Sets whether or not the stopwatch is running.
			  
			  If value Then
			    
			    Start
			    
			  Else
			    
			    Stop
			    
			  End If
			  
			  // done.
			  
			End Set
		#tag EndSetter
		IsRunning As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/7/2010 by Andrew Keller
			  
			  // Returns the current value of myMicroseconds, taking the stopwatch into account.
			  
			  Dim result As UInt64 = myMicroseconds
			  
			  If bStopwatchRunning Then
			    
			    Dim now As UInt64 = Microseconds
			    
			    now = now - myStartTime
			    
			    Dim sum As UInt64 = result + now
			    
			    If sum >= result And sum >= now Then
			      
			      Return sum
			      
			    Else
			      
			      Return -1 // Rolls over to the Max value of a UInt64 variable.
			      
			    End If
			    
			  Else
			    
			    Return myMicroseconds
			    
			  End If
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/7/2010 by Andrew Keller
			  
			  // Stores the given value of microseconds.
			  
			  bStopwatchRunning = False
			  myMicroseconds = value
			  
			  // done.
			  
			End Set
		#tag EndSetter
		MicrosecondsValue As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected myMicroseconds As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myStartTime As UInt64
	#tag EndProperty


	#tag Constant, Name = kCenturies, Type = Double, Dynamic = False, Default = \"9.499", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDays, Type = Double, Dynamic = False, Default = \"4.937", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDecades, Type = Double, Dynamic = False, Default = \"8.499", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kHours, Type = Double, Dynamic = False, Default = \"3.556", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMicroseconds, Type = Double, Dynamic = False, Default = \"-6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMilliseconds, Type = Double, Dynamic = False, Default = \"-3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMinutes, Type = Double, Dynamic = False, Default = \"1.778", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMonths, Type = Double, Dynamic = False, Default = \"6.420", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSeconds, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWeeks, Type = Double, Dynamic = False, Default = \"5.782", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kYears, Type = Double, Dynamic = False, Default = \"7.499", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsRunning"
			Group="Behavior"
			Type="Boolean"
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