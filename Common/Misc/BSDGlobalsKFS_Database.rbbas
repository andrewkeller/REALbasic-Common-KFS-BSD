#tag Module
Protected Module BSDGlobalsKFS_Database
	#tag Method, Flags = &h0
		Function AddConnectionKFS(Extends db As Database) As Boolean
		  // Created 6/23/2007 by Andrew Keller
		  
		  // Increments the number of requested connections for the
		  // given database, and makes sure the database is connected.
		  
		  If db.Connect Then
		    
		    If dDbConnectPool = Nil Then dDbConnectPool = New Dictionary
		    
		    dDbConnectPool.Value( db) = dDbConnectPool.Lookup( db, 0 ) +1
		    
		    dDbConnectPool.Remove( False, db, kDbCPkeyTimer )
		    
		    Return True
		    
		  Else
		    Return False
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DbDisconnectFollowThrough()
		  // Created 6/19/2010 by Andrew Keller
		  
		  // Disconnects all databases with an expired timer and a non-positive count.
		  
		  // This method is intended to be invoked by a DelegateTimerKFS instance
		  // created by ReleaseConnectionKFS, and nothing else.
		  
		  #pragma DisableBackgroundTasks
		  
		  For Each db As Database In dDbConnectPool.Keys
		    
		    Dim t As DelegateTimerKFS = dDbConnectPool.Lookup_R( Nil, db, kDbCPkeyTimer )
		    
		    If t <> Nil Then
		      
		      If t.Mode = 0 Then
		        
		        If dDbConnectPool.Lookup_R( 0, db, kDbCPkeyCount ) = 0 Then
		          
		          // Disconnect this database.
		          
		          db.Close
		          dDbConnectPool.Remove db
		          
		        End If
		      End If
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DisconnectAllDatabases()
		  // Created 6/19/2010 by Andrew Keller
		  
		  // Disconnects all tracked databases.
		  
		  #pragma DisableBackgroundTasks
		  
		  For Each db As Database In dDbConnectPool.Keys
		    
		    If db IsA REALSQLDatabase And REALSQLDatabase( db ).DatabaseFile = Nil Then
		      
		      // do not close this database.
		      
		    Else
		      db.Close
		    End If
		    
		    dDbConnectPool.Remove db
		    
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
		    If db <> Nil Then
		      If db.AddConnectionKFS Then
		        
		        Dim rs As RecordSet = db.TableSchema
		        
		        If rs <> Nil Then
		          
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
		Sub ReleaseConnectionKFS(Extends db As Database)
		  // Created 6/23/2007 by Andrew Keller
		  
		  // Decrements the number of requested connections for the given database,
		  // and if the connection count hits zero, the database is closed.
		  
		  // This method behaves just like Database.Close if the given database was
		  // never connected using AddConnectionKFS.
		  
		  If dDbConnectPool = Nil Then dDbConnectPool = New Dictionary
		  
		  If dDbConnectPool.HasKey( db ) Then
		    
		    // This database is being tracked.
		    
		    Dim iCount As Integer = dDbConnectPool.Lookup_R( 1, db, kDbCPkeyCount ) -1
		    
		    If iCount > 0 Then
		      
		      // It is not time to disconnect this database.
		      
		      // Remember the new decremented count.
		      
		      dDbConnectPool.Value( db, kDbCPkeyCount ) = iCount
		      
		    ElseIf db IsA REALSQLDatabase And REALSQLDatabase( db ).DatabaseFile = Nil Then
		      
		      // This is a memory-based REALSQLDatabase.  It should never be closed.
		      
		      dDbConnectPool.Remove db
		      
		    Else
		      
		      // It is time to close this database, and this is not a memory-based REALSQLDatabase.
		      
		      Dim dDelay As Double = dDbConnectPool.Lookup_R( 0, db, kDbCPkeyDelay )
		      
		      If dDelay > 0 Then
		        
		        // This database needs to be disconnected after a delay.
		        
		        // Configure a new DelegateTimerKFS to fire after the specified time.
		        
		        Dim t As New DelegateTimerKFS( dDelay * .001, AddressOf DbDisconnectFollowThrough )
		        dDbConnectPool.Value( db, kDbCPkeyTimer ) = t
		        
		      Else
		        
		        // This database should be closed immediately.
		        
		        // Close the database.
		        
		        db.Close
		        dDbConnectPool.Remove db
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReleaseConnectionKFS(Extends db As Database, disconnectDelay As Double)
		  // Created 6/19/2010 by Andrew Keller
		  
		  // A wrapper around Database.ReleaseConnectionKFS
		  // that allows for specifying a delayed closing time.
		  
		  If dDbConnectPool = Nil Then dDbConnectPool = New Dictionary
		  
		  dDbConnectPool.Value( db, kDbCPkeyDelay ) = Max( dDbConnectPool.Lookup_R( 0, db, kDbCPkeyDelay ), disconnectDelay )
		  
		  db.ReleaseConnectionKFS
		  
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
		Private dDbConnectPool As Dictionary
	#tag EndProperty


	#tag Constant, Name = kDbCPkeyCount, Type = String, Dynamic = False, Default = \"count", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kDbCPkeyDelay, Type = String, Dynamic = False, Default = \"delay", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kDbCPkeyTimer, Type = String, Dynamic = False, Default = \"timer", Scope = Private
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
End Module
#tag EndModule
