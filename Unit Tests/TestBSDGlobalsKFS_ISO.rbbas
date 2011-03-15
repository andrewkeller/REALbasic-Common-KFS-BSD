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
		              
		              Dim ev As New Date( y, mon, d, h, m, s, 0 )
		              ev.GMTOffset = timeZone
		              
		              TestISO8601Parsing str, adjustToLocalTimeZone, ev
		              
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


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
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


End Class
#tag EndClass
