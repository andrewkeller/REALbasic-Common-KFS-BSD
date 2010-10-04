#tag Module
Protected Module StatusLogGlobalsKFS
	#tag Method, Flags = &h1
		Protected Function DebugStatus() As Int8
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns the current debug status
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  Call myLog.Initialize
		  
		  Return myLog.DebugStatus
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DebugStatus(Assigns newValue As Int8)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // sets the debug status
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  If myLog.Initialize Then
		    
		    myLog.DebugStatus = newValue
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetLogRef() As StatusLoggerKFS
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns the log object
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  If myLog.Initialize Then
		    
		    Return myLog
		    
		  End If
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Initialize() As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  Return myLog.Initialize
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Initialize(databaseFile As FolderItem, databasePassword As String = "") As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  Return myLog.Initialize( databaseFile, databasePassword )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Initialize(debugLevel As Int8) As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  Return myLog.Initialize( debugLevel )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Initialize(debugLevel As Int8, databaseFile As FolderItem, databasePassword As String = "") As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  Return myLog.Initialize( debugLevel, databaseFile, databasePassword )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewStatusReportKFS(sMethod As String, iDebugLevel As Int8, bError As Boolean, sMessages() As String)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // add the given report to the log
		  
		  // for this function, we'll take the
		  // neglidgable speed increase of leaving
		  // initialization to the StatusLoggerKFS instance
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  myLog.NewStatusReportKFS( sMethod, iDebugLevel, bError, sMessages )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewStatusReportKFS(sMethod As String, iDebugLevel As Int8, bError As Boolean, ParamArray sMessage As String)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // add the given report to the log
		  
		  // for this function, we'll take the
		  // neglidgable speed increase of leaving
		  // initialization to the StatusLoggerKFS instance
		  
		  If myLog = Nil Then
		    
		    myLog = New StatusLoggerKFS
		    
		  End If
		  
		  myLog.NewStatusReportKFS( sMethod, iDebugLevel, bError, sMessage )
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This module is licensed as BSD.
		
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


	#tag Property, Flags = &h21
		Private myLog As StatusLoggerKFS
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
End Module
#tag EndModule
