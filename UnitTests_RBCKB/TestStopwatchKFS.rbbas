#tag Class
Protected Class TestStopwatchKFS
Inherits UnitTests_RBCKB.TestDurationKFS
	#tag Method, Flags = &h0
		Function Factory_Construct() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return New StopwatchKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDateDifference(dLater As Date, dEarlier As Date) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return New StopwatchKFS( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromStopwatchKFS(other As StopwatchKFS) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return New StopwatchKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromTimer(other As Timer) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return New StopwatchKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromValue(newValue As Double, powerOfTen As Double = StopwatchKFS.kSeconds) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return New StopwatchKFS( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_ConstructFromWebTimer(other As WebTimer) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return New StopwatchKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_StopwatchKFS(d As StopwatchKFS) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewFromClone( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_Timer(t As Timer) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewFromClone( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_NewFromClone_WebTimer(t As WebTimer) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewFromClone( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromDateDifference(dLater As Date, dEarlier As Date) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewFromDateDifference( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromSystemUptime() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewFromSystemUptime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMaximum() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithMaximum
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMicroseconds(newValue As Int64) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithMicroseconds( newValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMinimum() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithMinimum
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeInfinity() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithNegativeInfinity
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeOverflow() As DurationKFS
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithNegativeOverflow
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveInfinity() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithPositiveInfinity
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveOverflow() As DurationKFS
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithPositiveOverflow
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithUndefined() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithUndefined
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithValue(newValue As Double, powerOfTen As Double = StopwatchKFS.kSeconds) As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithValue( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithZero() As StopwatchKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // StopwatchKFS class so that it can be overridden in a subclass.
		  
		  Return StopwatchKFS.NewWithZero
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListThisDurationClass() As String()
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Returns a list of classes that... includes only this class.
		  
		  Return Array( "StopwatchKFS" )
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2012 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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

	#tag Note, Name = WTF
		Okay, so I found a problem that I found rather interesting, but
		since it's not absolutely critical and I'm rather short on time
		at the moment, I'm going to place this one on the back burner.
		
		According to my tests on my 2.16 GHz MBP, the smallest I
		can get the difference between two successive reads of the
		Microseconds function is 3 microseconds.
		
		BUT...  somehow...  two successive reads of the MicrosecondsValue
		property of a StopwatchKFS object can return identical values.
		
		The following assertion has the ability to fail with a running stopwatch:
		
		AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		This is why assertions like that were replaced by:
		
		AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		The MicrosecondsValueIncreases function checks for a change
		over a longer period of time, so that changes are easier to find.
		
		This behavior is approximately 10% reproducible on my
		computer at the moment.  Just set the timeout in the
		MicrosecondsValueIncreases function to zero, and keep
		running the tests over and over again until something fails.
	#tag EndNote


	#tag Constant, Name = kStopwatchObservationTimeout, Type = Double, Dynamic = False, Default = \"30", Scope = Public
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
