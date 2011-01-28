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
		Sub Constructor(other As DurationKFS, liveClone As Boolean = True)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // A clone constructor.
		  
		  If other Is Nil Then
		    
		    Clear
		    
		  ElseIf liveClone = False Then
		    
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
		        Dim c As DurationKFS = DurationKFS( cw.Value )
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
		Sub MicrosecondsValue(Assigns newValue As UInt64)
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Stores the given value of microseconds.
		  
		  bStopwatchRunning = False
		  myMicroseconds = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MicrosecondsValue(includeChildren As Boolean = True) As UInt64
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Returns the current value of myMicroseconds, taking the stopwatch into account.
		  // Optionally takes any children into account.
		  
		  If bStopwatchRunning Then
		    
		    Dim now As UInt64 = Microseconds
		    
		    now = now - myStartTime
		    
		    Dim sum As UInt64 = myMicroseconds + now
		    
		    If sum >= myMicroseconds And sum >= now Then
		      
		      If includeChildren Then
		        For Each cw As WeakRef In myChildren
		          If Not ( cw Is Nil ) Then
		            Dim c As DurationKFS = DurationKFS( cw.Value )
		            If Not ( c Is Nil ) Then
		              
		              Dim add As UInt64 = c.MicrosecondsValue( includeChildren )
		              Dim check As UInt64 = sum
		              
		              sum = sum + add
		              
		              If sum < check Or sum < add Then
		                
		                Return -1 // Rolls over to the Max value of a UInt64 variable.
		                
		              End If
		            End If
		          End If
		        Next
		      End If
		      
		      Return sum
		      
		    Else
		      
		      Return -1 // Rolls over to the Max value of a UInt64 variable.
		      
		    End If
		    
		  Else
		    
		    Return myMicroseconds
		    
		  End If
		  
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
		  If Not ( other Is Nil ) Then v2 = other.MicrosecondsValue
		  
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
		  
		  If other Is Nil Then Return 1
		  
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
		Function Operator_Convert() As String
		  // Created 8/30/2010 by Andrew Keller
		  
		  // An outgoing convert constructor that converts to a String.
		  
		  Return ShortHumanReadableStringValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(newValue As Timer)
		  // Created 8/7/2010 by Andrew Keller
		  
		  // A convert constructor that takes the period of the given Timer.
		  
		  If newValue Is Nil Then
		    
		    Clear
		    
		  Else
		    
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
		  If Not ( other Is Nil ) Then d = other.MicrosecondsValue
		  
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
		  If Not ( other Is Nil ) Then d = other.MicrosecondsValue
		  
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
		  If Not ( other Is Nil ) Then d = other.MicrosecondsValue
		  
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
		  If Not ( other Is Nil ) Then v2 = other.MicrosecondsValue
		  
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
		Function ShortHumanReadableStringValue(minUnit As Double = DurationKFS.kMicroseconds, maxUnit As Double = DurationKFS.kCenturies) As String
		  // Created 8/30/2010 by Andrew Keller
		  
		  // Returns a short human readable string that describes this value.
		  
		  Dim m, v As Double
		  
		  If kCenturies <= maxUnit And kCenturies >= minUnit Then
		    
		    v = Me.Value( kCenturies )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \c\e\n" )
		    If m >= 1 Then Return Format( v, "0.0\ \c\e\n" )
		    If m > 0 Or kDecades < minUnit Then Return Format( v, "0.00\ \c\e\n" )
		    
		  End If
		  
		  If kDecades <= maxUnit And kDecades >= minUnit Then
		    
		    v = Me.Value( kDecades )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \d\e\c" )
		    If m >= 1 Then Return Format( v, "0.0\ \d\e\c" )
		    If m > 0 Or kYears < minUnit Then Return Format( v, "0.00\ \d\e\c" )
		    
		  End If
		  
		  If kYears <= maxUnit And kYears >= minUnit Then
		    
		    v = Me.Value( kYears )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \y" )
		    If m >= 1 Then Return Format( v, "0.0\ \y" )
		    If m > 0 Or kMonths < minUnit Then Return Format( v, "0.00\ \y" )
		    
		  End If
		  
		  If kMonths <= maxUnit And kMonths >= minUnit Then
		    
		    v = Me.Value( kMonths )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \m\o\n" )
		    If m >= 1 Then Return Format( v, "0.0\ \m\o\n" )
		    If m > 0 Or kWeeks < minUnit Then Return Format( v, "0.00\ \m\o\n" )
		    
		  End If
		  
		  If kWeeks <= maxUnit And kWeeks >= minUnit Then
		    
		    v = Me.Value( kWeeks )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \w" )
		    If m >= 1 Then Return Format( v, "0.0\ \w" )
		    If m > 0 Or kDays < minUnit Then Return Format( v, "0.00\ \w" )
		    
		  End If
		  
		  If kDays <= maxUnit And kDays >= minUnit Then
		    
		    v = Me.Value( kDays )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \d" )
		    If m >= 1 Then Return Format( v, "0.0\ \d" )
		    If m > 0 Or kHours < minUnit Then Return Format( v, "0.00\ \d" )
		    
		  End If
		  
		  If kHours <= maxUnit And kHours >= minUnit Then
		    
		    v = Me.Value( kHours )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \h" )
		    If m >= 1 Then Return Format( v, "0.0\ \h" )
		    If m > 0 Or kMinutes < minUnit Then Return Format( v, "0.00\ \h" )
		    
		  End If
		  
		  If kMinutes <= maxUnit And kMinutes >= minUnit Then
		    
		    v = Me.Value( kMinutes )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \m" )
		    If m >= 1 Then Return Format( v, "0.0\ \m" )
		    If m > 0 Or kSeconds < minUnit Then Return Format( v, "0.00\ \m" )
		    
		  End If
		  
		  If kSeconds <= maxUnit And kSeconds >= minUnit Then
		    
		    v = Me.Value( kSeconds )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \s" )
		    If m >= 1 Then Return Format( v, "0.0\ \s" )
		    If m > 0 Or kMilliseconds < minUnit Then Return Format( v, "0.00\ \s" )
		    
		  End If
		  
		  If kMilliseconds <= maxUnit And kMilliseconds >= minUnit Then
		    
		    v = Me.Value( kMilliseconds )
		    If v > 0 Then
		      m = log( v ) / log( 10 )
		    Else
		      m = 0
		    End If
		    
		    If m >= 2 Then Return Format( v, "0\ \m\s" )
		    If m >= 1 Then Return Format( v, "0.0\ \m\s" )
		    If m > 0 Or kMicroseconds < minUnit Then Return Format( v, "0.00\ \m\s" )
		    
		  End If
		  
		  If kMicroseconds <= maxUnit And kMicroseconds >= minUnit Then
		    
		    Return Format( Me.IntegerValue( kMicroseconds ), "0\ \u\s" )
		    
		  End If
		  
		  Raise New UnsupportedFormatException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChild(childIsRunning As Boolean) As DurationKFS
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Returns a new DurationKFS object that is a child of this one.
		  
		  Dim d As New DurationKFS
		  d.myParent = Me
		  myChildren.Append New WeakRef( d )
		  
		  d.IsRunning = childIsRunning
		  
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
		
		Copyright (c) 2010, Andrew Keller, et al.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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
		Protected myMicroseconds As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParent As DurationKFS
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
