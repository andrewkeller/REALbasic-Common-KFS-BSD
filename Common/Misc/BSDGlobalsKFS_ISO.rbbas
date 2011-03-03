#tag Module
Protected Module BSDGlobalsKFS_ISO
	#tag Method, Flags = &h0
		Function DeserializeISO8610StringAsDate(src As String, adjustToLocalTimeZone As Boolean = True) As Date
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
		          
		          d = New Date( Val( dp(0) ), Val( dp(1) ), Val( dp(2) ), Val( tp(0) ), Val( tp(1) ), Val( tp(2) ), 0 )
		          
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
