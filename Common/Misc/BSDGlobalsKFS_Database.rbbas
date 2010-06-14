#tag Module
Protected Module BSDGlobalsKFS_Database
	#tag Method, Flags = &h0
		Function AddConnectionRequestKFS(Extends db As Database) As Boolean
		  // Created 6/23/2007 by Andrew Keller
		  
		  // increments the number of requested
		  // connections for the given database,
		  // and connects the database if necessary
		  
		  If dDbConReqHash = Nil Then
		    dDbConReqHash = New Dictionary
		  End If
		  
		  If db.Connect Then
		    
		    dDbConReqHash.Value( db ) = dDbConReqHash.Lookup( db, 0 ) +1
		    
		    Return True
		    
		  Else
		    Return False
		  End If
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasTableKFS(Extends db As Database, sTableName As String) As Boolean
		  // Created 6/23/2007 by Andrew Keller
		  
		  // determines whether or not the given
		  // database contains the given table
		  
		  If sTableName <> "" Then
		    If db <> Nil Then
		      If db.AddConnectionRequestKFS Then
		        
		        Dim rs As RecordSet = db.TableSchema
		        
		        If rs <> Nil Then
		          
		          While Not rs.EOF
		            
		            If rs.Field( "TableName" ).StringValue = sTableName Then
		              
		              db.ReleaseConnectionRequestKFS
		              
		              Return True
		              
		            End If
		            
		            rs.MoveNext
		            
		          Wend
		        End If
		        
		        db.ReleaseConnectionRequestKFS
		        
		      End If
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReleaseConnectionRequestKFS(Extends db As Database)
		  // Created 6/23/2007 by Andrew Keller
		  // Modified 4/6/2009 --; now does not close in-memory RSQLDB's
		  
		  // decrements the number of requested
		  // connections for the given database,
		  // and closes the database if necessary
		  
		  If dDbConReqHash <> Nil Then
		    
		    If dDbConReqHash.HasKey( db ) Then
		      
		      Dim iCount As Integer = dDbConReqHash.Lookup( db, 0 ) -1
		      
		      If iCount <= 0 Then
		        
		        dDbConReqHash.Remove db
		        
		        If db IsA REALSQLDatabase Then
		          
		          // REALSQLDatabases can be completely in memory.
		          // Closing the connection blows everything away.
		          
		          If REALSQLDatabase( db ).DatabaseFile = Nil Then
		            
		            // do not close the database
		            
		            Return
		            
		          End If
		        End If
		        
		        db.Close
		        
		      Else
		        
		        dDbConReqHash.Value( db ) = iCount
		        
		      End If
		      
		    Else
		      db.Close
		    End If
		  Else
		    db.Close
		  End If
		  
		  // done.
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
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
		#tag Note
			ConnectionRequestKFS and ReleaseConnectionRequestKFS
			
			Ad
		#tag EndNote
		Private dDbConReqHash As Dictionary
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
