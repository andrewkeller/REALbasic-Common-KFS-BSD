#tag Module
Protected Module BSDGlobalsKFS_Database
	#tag Method, Flags = &h0
		Function AddConnectionKFS(Extends db As Database) As Boolean
		  // Created 6/23/2007 by Andrew Keller
		  
		  // Increments the number of requested connections for the
		  // given database, and makes sure the database is connected.
		  
		  If db.Connect Then
		    
		    DbInit
		    
		    dDbRetainCounts.Value( db ) = dDbRetainCounts.Lookup( db, 0 ).IntegerValue +1
		    
		    Return True
		    
		  Else
		    Return False
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DbDisconnectHook(t As Timer)
		  // Created 6/19/2010 by Andrew Keller
		  
		  // Disconnects all databases with an expired timer and a non-positive count.
		  
		  // This method is intended to be invoked by a Timer,
		  // and automatically sets the Timer going again if necessary.
		  
		  Dim timeOfNextDisconnect As Int64 = 0
		  Dim timeUntilNextDisconnect As Int64 = 0
		  
		  Do
		    
		    For Each db As Database In dDbRetainCounts.Keys
		      
		      // Lookup the current retain count.
		      
		      If dDbRetainCounts.Lookup( db, 1 ).Int64Value <= 0 Then
		        
		        // This database has been flagged for being disconnected.
		        
		        // When?
		        
		        Dim dt As Int64 = dDbReleaseTimes.Lookup( db, 0 ).Int64Value
		        
		        If dt <= Microseconds Then
		          
		          // Now.
		          
		          DbDisconnectNow db
		          
		          If dDbReleaseTimes.HasKey( db ) Then dDbReleaseTimes.Remove db
		          If dDbRetainCounts.HasKey( db ) Then dDbRetainCounts.Remove db
		          
		        ElseIf timeOfNextDisconnect = 0 Then
		          
		          timeOfNextDisconnect = dt
		          
		        ElseIf timeOfNextDisconnect > dt Then
		          
		          timeOfNextDisconnect = dt
		          
		        End If
		      End If
		    Next
		    
		    timeUntilNextDisconnect = timeOfNextDisconnect - Microseconds
		    
		  Loop Until ( timeOfNextDisconnect > 0 And timeUntilNextDisconnect > 0 ) Or timeOfNextDisconnect = 0
		  
		  If timeOfNextDisconnect > 0 And t.Mode = Timer.ModeOff Then
		    
		    t.Period = timeUntilNextDisconnect / 1000
		    t.Mode = 1
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DbDisconnectNow(db As Database)
		  // Created 3/2/2011 by Andrew Keller
		  
		  // Disconnects the given database.
		  
		  If db Is Nil Then
		    
		    // Do nothing.
		    
		  ElseIf db IsA REALSQLDatabase Then
		    If REALSQLDatabase( db ).DatabaseFile Is Nil Then
		      
		      // Do nothing.
		      
		    Else
		      
		      db.Close
		      
		    End If
		  Else
		    
		    db.Close
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DbInit()
		  // Created 3/2/2011 by Andrew Keller
		  
		  // Initializes the properties used by the database connection helper functions.
		  
		  If dDbReleaseTimes Is Nil Then dDbReleaseTimes = New Dictionary
		  If dDbRetainCounts Is Nil Then dDbRetainCounts = New Dictionary
		  
		  If tDbReleaseTimer Is Nil Then
		    
		    tDbReleaseTimer = New Timer
		    AddHandler tDbReleaseTimer.Action, AddressOf DbDisconnectHook
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DisconnectAllDatabases()
		  // Created 6/19/2010 by Andrew Keller
		  
		  // Disconnects all tracked databases.
		  
		  DbInit
		  
		  For Each db As Database In dDbRetainCounts.Keys
		    
		    DbDisconnectNow db
		    
		    If dDbReleaseTimes.HasKey( db ) Then dDbReleaseTimes.Remove db
		    If dDbRetainCounts.HasKey( db ) Then dDbRetainCounts.Remove db
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasTableKFS(Extends db As Database, sTableName As String) As Boolean
		  // Created 6/23/2007 by Andrew Keller
		  
		  // Determines whether or not the given
		  // database contains the given table.
		  
		  If sTableName <> "" Then
		    If Not ( db Is Nil ) Then
		      If db.AddConnectionKFS Then
		        
		        Dim rs As RecordSet = db.TableSchema
		        
		        If Not ( rs Is Nil ) Then
		          
		          While Not rs.EOF
		            
		            If rs.Field( "TableName" ).StringValue = sTableName Then
		              
		              db.ReleaseConnectionKFS
		              
		              Return True
		              
		            End If
		            
		            rs.MoveNext
		            
		          Wend
		        End If
		        
		        db.ReleaseConnectionKFS
		        
		      End If
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReleaseConnectionKFS(Extends db As Database, disconnectDelay As DurationKFS = Nil)
		  // Created 6/19/2010 by Andrew Keller
		  
		  // Decrements the number of requested connections for the given database,
		  // and if the connection count hits zero, the database is closed.
		  
		  // This method can optionally disconnect the database a given period after
		  // this method was actually called.
		  
		  // This method behaves just like Database.Close if the given database was
		  // never connected using AddConnectionKFS.
		  
		  If Not ( db Is Nil ) Then
		    
		    DbInit
		    
		    // Regardless of what we're going to do later, let's store the disconnect delay.
		    
		    If Not ( disconnectDelay Is Nil ) Then
		      
		      Dim t As Int64 = dDbReleaseTimes.Lookup( db, 0 )
		      Dim t2 As Int64 = Microseconds + disconnectDelay.MicrosecondsValue
		      
		      If t2 > t Then t = t2
		      
		      dDbReleaseTimes.Value( db ) = t
		      
		    End If
		    
		    // Decrement the reatin count:
		    
		    dDbRetainCounts.Value( db ) = dDbRetainCounts.Lookup( db, 0 ) -1
		    
		    // Okay, now let's see whether or not the retain
		    // count of this database has reached zero.
		    
		    If dDbRetainCounts.Lookup( db, 0 ).IntegerValue <= 0 Then
		      
		      // This database should be disconnected.
		      
		      Dim t As Int64 = dDbReleaseTimes.Lookup( db, 0 ) - Microseconds
		      
		      If t <= 0 Then
		        
		        // The user wants this database closed immediately.
		        
		        db.Close
		        
		        If dDbReleaseTimes.HasKey( db ) Then dDbReleaseTimes.Remove db
		        If dDbRetainCounts.HasKey( db ) Then dDbRetainCounts.Remove db
		        
		      Else
		        
		        // The user wants this database disconnected in the future.
		        
		        If tDbReleaseTimer.Mode = 0 Then
		          
		          tDbReleaseTimer.Period = t / 1000
		          tDbReleaseTimer.Mode = Timer.ModeSingle
		          
		        End If
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
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
		
		Copyright (c) 2007-2011 Andrew Keller.
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


	#tag Property, Flags = &h21
		Private dDbReleaseTimes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dDbRetainCounts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tDbReleaseTimer As Timer
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
