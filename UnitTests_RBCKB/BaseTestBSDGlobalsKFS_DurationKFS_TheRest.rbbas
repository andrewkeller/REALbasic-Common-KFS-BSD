#tag Class
Protected Class BaseTestBSDGlobalsKFS_DurationKFS_TheRest
Inherits UnitTests_RBCKB.BaseTestBSDGlobalsKFS_DurationKFS_Operators
	#tag Method, Flags = &h0
		Sub TestConcept_InvalidUnit()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure the DurationKFS class fails when dealing with invalid units.
		  
		  Dim d As DurationKFS
		  Dim iu As Double = 4.8
		  
		  PushMessageStack "DurationKFS did not throw an exception when dealing with an invalid unit."
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "(via constructor)  Result was " + ObjectDescriptionKFS( Factory_ConstructFromValue( 5, iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = Factory_NewWithValue( 5 )
		    AssertFailure "(via getting Value property)  Result was " + ObjectDescriptionKFS( d.Value( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = Factory_NewWithValue( 5 )
		    AssertFailure "(via getting IntegerValue property)  Result was " + ObjectDescriptionKFS( d.IntegerValue( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConcept_UnitConversions()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure the DurationKFS class can convert units correctly.
		  
		  TestConcept_Units "microseconds", DurationKFS.kMicroseconds, 5, 5
		  TestConcept_Units "milliseconds", DurationKFS.kMilliseconds, 5, 5000
		  TestConcept_Units "seconds", DurationKFS.kSeconds, 5, 5000000
		  TestConcept_Units "minutes", DurationKFS.kMinutes, 5, 300000000
		  TestConcept_Units "hours", DurationKFS.kHours, 5, 18000000000
		  TestConcept_Units "days", DurationKFS.kDays, 5, 432000000000
		  TestConcept_Units "weeks", DurationKFS.kWeeks, 5, 3024000000000
		  TestConcept_Units "months", DurationKFS.kMonths, 5, 13149000000000
		  TestConcept_Units "years", DurationKFS.kYears, 5, 157788000000000
		  TestConcept_Units "decades", DurationKFS.kDecades, 5, 1577880000000000
		  TestConcept_Units "centuries", DurationKFS.kCenturies, 5, 15778800000000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConcept_Units(unitLabel As String, unitExponent As Double, inputValue As Double, expectedMicroseconds As UInt64)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure the DurationKFS class can handle <unitLabel> correctly.
		  
		  Dim d(-1) As DurationKFS
		  Dim s(-1) As String
		  
		  d.Append Factory_ConstructFromValue( inputValue, unitExponent )
		  s.Append "(via constructor)"
		  
		  d.Append Factory_NewWithValue( inputValue, unitExponent )
		  s.Append "(via shared constructor)"
		  
		  PushMessageStack "DurationKFS was not able to take a value in " + unitLabel + "."
		  
		  For i As Integer = 0 To 1
		    
		    PushMessageStack s(i)
		    
		    If PresumeNotIsNil( d(i), "Uh, the factory method returned Nil.  Gotta fix that first." ) Then
		      AssertEquals expectedMicroseconds, d(i).MicrosecondsValue, "(problem detected with the MicrosecondsValue property)", False
		      AssertEquals expectedMicroseconds, d(i).Value( DurationKFS.kMicroseconds ), "(problem detected with the Value property)", False
		      AssertEquals expectedMicroseconds, d(i).IntegerValue( DurationKFS.kMicroseconds ), "(problem detected with the IntegerValue property)", False
		    End If
		    
		    PopMessageStack
		    
		  Next
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerValue_Double()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsInfinity()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsNegative()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsOverflow()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsPositive()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsUndefined()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsZero()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMicrosecondsValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNextUniqueID()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortHumanReadableStringValue()
		  // Created 8/30/2010 by Andrew Keller
		  
		  // Make sure the ShortHumanReadableStringValue function works.
		  
		  Dim d As New DurationKFS
		  
		  PushMessageStack "ShortHumanReadableStringValue did not return an expected value."
		  
		  AssertEquals "0 us", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "0 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "0.00 ms", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "0.00 s", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "0.00 m", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  d = New DurationKFS( 5 )
		  
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "0.08 m", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "5000000 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5000 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  
		  d = New DurationKFS( 5, DurationKFS.kCenturies )
		  
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "15778800000000000 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "15778800000000 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "15778800000 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  AssertEquals "262980000 m", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMinutes ), "", False
		  AssertEquals "4383000 h", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kHours ), "", False
		  AssertEquals "182625 d", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDays ), "", False
		  AssertEquals "26089 w", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kWeeks ), "", False
		  AssertEquals "6000 mon", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMonths ), "", False
		  AssertEquals "500 y", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kYears ), "", False
		  AssertEquals "50.0 dec", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kCenturies ), "", False
		  
		  d = DurationKFS.NewWithMaximum
		  
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "18446744073709551615 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "18446744073709552 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "18446744073710 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  AssertEquals "307445734562 m", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMinutes ), "", False
		  AssertEquals "5124095576 h", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kHours ), "", False
		  AssertEquals "213503982 d", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDays ), "", False
		  AssertEquals "30500569 w", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kWeeks ), "", False
		  AssertEquals "7014505 mon", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMonths ), "", False
		  AssertEquals "584542 y", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kYears ), "", False
		  AssertEquals "58454 dec", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kCenturies ), "", False
		  
		  PopMessageStack
		  
		  // Now, make sure that the ShortHumanReadableStringValue fails when it is supposed to.
		  
		  d = New DurationKFS( 5 )
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( DurationKFS.kYears, DurationKFS.kSeconds )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when minUnit > maxUnit."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( 10, 15 )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when the requested units are above the range of the available units."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( -10, -7 )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when the requested units are below the range of the available units."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue_Double()
		  
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
