#tag Class
Protected Class TestBSDGlobalsKFS_ISO
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestISO8601Parsing(str As String, adjustToLocalTimeZone As Boolean, ev As Date)
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure the DeserializeISO8610StringAsDateKFS function
		  // returns a result equal to the given expected value.
		  
		  // This particular method is not detected as a test case
		  // because it takes some parameters.  There are other test
		  // cases that run this method, supplying the parameters.
		  
		  Dim fv As Date = DeserializeISO8610StringAsDateKFS( str, adjustToLocalTimeZone )
		  
		  If ev Is Nil Then
		    
		    AssertIsNil fv, "The DeserializeISO8610StringAsDateKFS function was not supposed to be able to parse the string '"+str+"'.", False
		    
		  ElseIf PresumeNotIsNil( fv, "The DeserializeISO8610StringAsDateKFS function should have been able to parse the string '"+str+"'." ) Then
		    
		    AssertEquals ev.GMTOffset, fv.GMTOffset, "The DeserializeISO8610StringAsDateKFS function was supposed to return a Date with a GMT offset of "+ObjectDescriptionKFS(ev.GMTOffset)+".", False
		    AssertEquals ev, fv, "The DeserializeISO8610StringAsDateKFS function did not return the expected value.", False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Parsing_Invalid(adjustToLocalTimeZone As Boolean)
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure a variety of invalid ISO 8601 strings fail correctly
		  // when given to the DeserializeISO8610StringAsDateKFS function.
		  
		  // This particular method is not detected as a test case
		  // because it takes a parameter.  There are other test
		  // cases that run this method, supplying the parameter.
		  
		  Dim invalidStrings() As String = Array( _
		  "", _
		  " ", _
		  "foobar", _
		  "str", _
		  "2011foobar", _
		  "2011-15:12" )
		  
		  For Each str As String In invalidStrings
		    
		    TestISO8601Parsing str, adjustToLocalTimeZone, Nil
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Parsing_Invalid_NoShift()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure a variety of invalid ISO 8601 strings fail correctly
		  // when given to the DeserializeISO8610StringAsDateKFS function.
		  
		  TestISO8601Parsing_Invalid False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Parsing_Invalid_WithShift()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure a variety of invalid ISO 8601 strings fail correctly
		  // when given to the DeserializeISO8610StringAsDateKFS function.
		  
		  TestISO8601Parsing_Invalid True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Parsing_Valid(adjustToLocalTimeZone As Boolean)
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure a variety of valid ISO 8601 strings can be
		  // parsed by the DeserializeISO8610StringAsDateKFS function.
		  
		  // This particular method is not detected as a test case
		  // because it takes a parameter.  There are other test
		  // cases that run this method, supplying the parameter.
		  
		  Static newDate As New Date // used to get the local GMT offset.
		  Dim timeZone As Double = 0
		  If adjustToLocalTimeZone Then timeZone = newDate.GMTOffset
		  
		  Dim years() As Integer = Array( 1995, 2000, 2011 )
		  Dim months() As Integer = Array( 1, 6, 12 )
		  Dim days() As Integer = Array( 1, 12, 19 )
		  Dim hours() As Integer = Array( 0, 12, 23 )
		  Dim minutes() As Integer = Array( 0, 41, 59 )
		  Dim seconds() As Integer = Array( 0, 25, 59 )
		  
		  For Each y As Integer In years
		    For Each mon As Integer In months
		      For Each d As Integer In days
		        For Each h As Integer In hours
		          For Each m As Integer In minutes
		            For Each s As Integer In seconds
		              
		              Dim str As String _
		              = Format( y, "0000" ) + "-" _
		              + Format( mon, "00" ) + "-" _
		              + Format( d, "00" ) + "T" _
		              + Format( h, "00" ) + ":" _
		              + Format( m, "00" ) + ":" _
		              + Format( s, "00" ) + "Z"
		              
		              Dim ev As Date = NewDateKFS( y, mon, d, h, m, s, 0 )
		              ev.GMTOffset = timeZone
		              
		              TestISO8601Parsing str, adjustToLocalTimeZone, ev
		              
		              AssertNoIssuesYet "Bailing out to prevent a tsunami of errors."
		            Next
		          Next
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Parsing_Valid_NoShift()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure a variety of valid ISO 8601 strings can be
		  // parsed by the DeserializeISO8610StringAsDateKFS function.
		  
		  TestISO8601Parsing_Valid False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Parsing_Valid_WithShift()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Makes sure a variety of valid ISO 8601 strings can be
		  // parsed by the DeserializeISO8610StringAsDateKFS function.
		  
		  TestISO8601Parsing_Valid True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Rendering(src As Date, expectedValue As String, evDescription As String)
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Makes sure the SerializeISO8610DateKFS function works correctly.
		  
		  AssertEquals expectedValue, SerializeISO8610DateKFS( src ), "The SerializeISO8610DateKFS function did not return an expected result for the date "+evDescription+".", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Rendering_Invalid()
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Makes sure the SerializeISO8610DateKFS function handles Nil input correctly.
		  
		  TestISO8601Rendering Nil, "", "Nil"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestISO8601Rendering_Valid()
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Makes sure a variety of dates are rendered
		  // correctly by the SerializeISO8610DateKFS function.
		  
		  Dim years() As Integer = Array( 1995, 2000, 2011 )
		  Dim months() As Integer = Array( 1, 6, 12 )
		  Dim days() As Integer = Array( 1, 12, 19 )
		  Dim hours() As Integer = Array( 0, 12, 23 )
		  Dim minutes() As Integer = Array( 0, 41, 59 )
		  Dim seconds() As Integer = Array( 0, 25, 59 )
		  Dim gmtoffs() As Double = Array( 0.0, -4, -5, -9, 6, 8 )
		  
		  For Each y As Integer In years
		    For Each mon As Integer In months
		      For Each d As Integer In days
		        For Each h As Integer In hours
		          For Each m As Integer In minutes
		            For Each s As Integer In seconds
		              
		              Dim str As String _
		              = Format( y, "0000" ) + "-" _
		              + Format( mon, "00" ) + "-" _
		              + Format( d, "00" ) + "T" _
		              + Format( h, "00" ) + ":" _
		              + Format( m, "00" ) + ":" _
		              + Format( s, "00" ) + "Z"
		              
		              For Each g As Double In gmtoffs
		                
		                Dim t As Date = NewDateKFS( y, mon, d, h, m, s, 0 )
		                t.GMTOffset = g
		                
		                TestISO8601Rendering t, str, ObjectDescriptionKFS( t )
		                
		              Next
		              AssertNoIssuesYet "Bailing out to prevent a tsunami of errors."
		            Next
		          Next
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewDate_Clone()
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Makes sure the NewDateKFS function can clone a date object.
		  
		  Dim e As New Date
		  
		  Dim f As Date = NewDateKFS( Nil )
		  
		  AssertIsNil f, "The NewDateKFS function should return Nil for Nil input.", False
		  
		  f = NewDateKFS( e )
		  
		  If PresumeNotSame( e, f, "The NewDateKFS function should never return the same object." ) Then
		    If PresumeNotIsNil( f, "The NewDateKFS function should never return Nil for non-Nil input." ) Then
		      
		      AssertEquals e.Year, f.Year, "The cloned year is not correct.", False
		      AssertEquals e.Month, f.Month, "The cloned month is not correct.", False
		      AssertEquals e.Day, f.Day, "The cloned day is not correct.", False
		      AssertEquals e.Hour, f.Hour, "The cloned hour is not correct.", False
		      AssertEquals e.Minute, f.Minute, "The cloned minute is not correct.", False
		      AssertEquals e.Second, f.Second, "The cloned second is not correct.", False
		      AssertEquals e.GMTOffset, f.GMTOffset, "The cloned GMT offset is not correct.", False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewDate_Piecewise()
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Makes sure the NewDateKFS function can generate a date from the components.
		  
		  Dim f As Date = NewDateKFS( 2011, 3, 5, 8, 3, 1, 3 )
		  
		  If PresumeNotIsNil( f, "The NewDateKFS function should never return Nil for non-Nil input." ) Then
		    
		    AssertEquals 2011, f.Year, "The year is not correct.", False
		    AssertEquals 3, f.Month, "The month is not correct.", False
		    AssertEquals 5, f.Day, "The day is not correct.", False
		    AssertEquals 8, f.Hour, "The hour is not correct.", False
		    AssertEquals 3, f.Minute, "The minute is not correct.", False
		    AssertEquals 1, f.Second, "The second is not correct.", False
		    AssertEquals 3, f.GMTOffset, "The GMT offset is not correct.", False
		    
		  End If
		  
		  // done.
		  
		End Sub
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
		
		Copyright (c) 2011 Andrew Keller.
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
