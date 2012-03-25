#tag Module
Protected Module BSDGlobalsKFS_ISO
	#tag Method, Flags = &h0
		Function DeserializeISO8610StringAsDateKFS(src As String, adjustToLocalTimeZone As Boolean = True) As Date
		  // Created 3/2/2011 by Andrew Keller
		  
		  // Returns a Date object based on the given ISO 8601 string.
		  // Returns Nil if the given string does not conform to ISO 8601.
		  
		  // Currently, this function can only parse dates that look like this:
		  //     2010-01-01T09:10:11Z
		  
		  Dim d As Date
		  
		  If Right( src, 1 ) = "Z" Then
		    
		    src = Left( src, Len( src ) -1 )
		    
		    Dim dt() As String = Split( src, "T" )
		    
		    If UBound( dt ) = 1 Then
		      
		      Dim dp() As String = Split( dt(0), "-" )
		      
		      If UBound( dp ) = 2 Then
		        
		        Dim tp() As String = Split( dt(1), ":" )
		        
		        If UBound( tp ) = 2 Then
		          
		          d = NewDateKFS( Val( dp(0) ), Val( dp(1) ), Val( dp(2) ), Val( tp(0) ), Val( tp(1) ), Val( tp(2) ), 0 )
		          
		        End If
		      End If
		    End If
		  End If
		  
		  If d Is Nil Then Return Nil
		  
		  If adjustToLocalTimeZone Then
		    
		    Static newDate As New Date
		    
		    d.GMTOffset = newDate.GMTOffset
		    
		  End If
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewDateKFS(other As Date) As Date
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Returns a date with the same characteristics as the given date.
		  
		  If other Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return NewDateKFS( other.Year, other.Month, other.Day, other.Hour, other.Minute, other.Second, other.GMTOffset )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewDateKFS(y As Integer, mon As Integer, d As Integer, h As Integer, m As Integer, s As Integer, g As Double) As Date
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Returns a date with the given characteristics.
		  
		  Dim t As New Date
		  
		  t.GMTOffset = g
		  t.Year = y
		  t.Month = mon
		  t.Day = d
		  t.Hour = h
		  t.Minute = m
		  t.Second = s
		  
		  Return t
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializeISO8610DateKFS(src As Date) As String
		  // Created 3/15/2011 by Andrew Keller
		  
		  // Returns an ISO-8601 formatted string that represents the value of the given date.
		  
		  // Currently, such a string is of the form: 2010-01-01T09:10:11Z
		  
		  // Returns an empty string if the given date is Nil.
		  
		  If src Is Nil Then
		    
		    Return ""
		    
		  Else
		    
		    // Clone the date so that we can adjust the
		    // GMT offset without affecting the original:
		    
		    src = NewDateKFS( src )
		    src.GMTOffset = 0
		    
		    Return Join( Array( Format(src.Year,"0000"), Format(src.Month,"00"), Format(src.Day,"00") ), "-" ) + "T" _
		    + Join( Array( Format(src.Hour,"00"), Format(src.Minute,"00"), Format(src.Second,"00") ), ":" ) + "Z"
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This module is licensed as BSD.  This generally means you may do
		whatever you want with this module so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this module does NOT require
		your work to inherit the license of this module.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this module.
		
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
End Module
#tag EndModule
