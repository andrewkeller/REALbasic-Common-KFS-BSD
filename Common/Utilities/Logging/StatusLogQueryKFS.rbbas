#tag Class
Protected Class StatusLogQueryKFS
	#tag Method, Flags = &h0
		Function BuildIncrementalSQLQuery() As String
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Renders the SQL query that will find any currently unknown log entries.
		  
		  If myQueryArgs = "" Then
		    
		    Return "select * from " + StatusLoggerKFS.kLogDB_PL_TableName + " where " + StatusLoggerKFS.kLogDB_PL_FieldUID + ">" + str( LatestMsgUIDExamined )
		    
		  Else
		    
		    Return "select * from " + StatusLoggerKFS.kLogDB_PL_TableName + " where ( " + myQueryArgs + ") AND " + StatusLoggerKFS.kLogDB_PL_FieldUID + ">" + str( LatestMsgUIDExamined )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Initialize variables.
		  
		  LatestMsgUIDExamined = -1
		  myErrorCode = 0
		  myErrorMsg = ""
		  p_myLogObject = Nil
		  myQueryArgs = ""
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Unregister with the log object.
		  
		  If Not ( p_myLogObject Is Nil ) Then
		    
		    p_myLogObject.UnregisterQueryObject Me
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorCode() As Integer
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Returns the current value of myLastErrorCode.
		  
		  Return myErrorCode
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorMessage() As String
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Returns the current value of myLastErrorMsg.
		  
		  Return myErrorMsg
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMessagesForEntry(iEntryUID As Integer) As String()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Checks the log database for any entries newer than
		  // LatestMsgUIDExamined, displays any messages that
		  // match the query, and updates LatestMsgUIDExamined.
		  
		  Dim db As Database = myLogObject.GetDBRef
		  Dim result( -1 ) As String
		  
		  If Not ( db Is Nil ) Then
		    If db.AddConnectionKFS Then
		      
		      Dim rs As RecordSet = db.SQLSelect( "select * from " + StatusLoggerKFS.kLogDB_MSG_TableName + _
		      " where " + StatusLoggerKFS.kLogDB_MSG_FieldLogUID + " = " + str( iEntryUID ) + _
		      " order by " + StatusLoggerKFS.kLogDB_MSG_FieldIndex )
		      
		      If Not ( rs Is Nil ) Then
		        
		        While Not rs.EOF
		          
		          result.Append rs.Field( StatusLoggerKFS.kLogDB_MSG_FieldMessage )
		          
		          rs.MoveNext
		          
		        Wend
		        
		        myErrorCode = 0
		        myErrorMsg = ""
		        
		      Else
		        
		        // an error may have occurred
		        
		        myErrorCode = db.ErrorCode
		        myErrorMsg = db.ErrorMessage
		        
		        QueryError( myErrorCode, myErrorMsg )
		        
		      End If
		      
		      db.ReleaseConnectionKFS
		      
		    End If
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogStartupTime() As Date
		  // Created 4/15/2009 by Andrew Keller
		  
		  // Returns the startup time of this class.
		  
		  Return myLogObject.StartupTime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MyLogObject() As StatusLoggerKFS
		  // Created 4/15/2009 by Andrew Keller
		  
		  // Returns the reference to the log object.
		  
		  If p_myLogObject Is Nil Then p_myLogObject = StatusLogGlobalsKFS.GetLogRef
		  
		  Return p_myLogObject
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MyLogObject(Assigns lo As StatusLoggerKFS)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // Sets the reference to the log object.
		  
		  p_myLogObject = lo
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QueryArgs() As String
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Returns the current query arguments.
		  
		  Return myQueryArgs
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QueryArgs(Assigns newQuery As String)
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Sets the query arguments to a new value.
		  
		  myQueryArgs = newQuery
		  
		  myLogObject.RegisterQueryObject Me
		  
		  RestartQuery
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Checks the log database for any entries newer than
		  // LatestMsgUIDExamined, displays any messages that
		  // match the query, and updates LatestMsgUIDExamined.
		  
		  Dim db As Database = myLogObject.GetDBRef
		  
		  If Not ( db Is Nil ) Then
		    If db.AddConnectionKFS Then
		      
		      Dim rs As RecordSet = db.SQLSelect( BuildIncrementalSQLQuery )
		      Dim uid As Integer
		      
		      If Not ( rs Is Nil ) Then
		        
		        While Not rs.EOF
		          
		          uid = rs.Field( StatusLoggerKFS.kLogDB_PL_FieldUID ).IntegerValue
		          If uid > LatestMsgUIDExamined Then LatestMsgUIDExamined = uid
		          
		          NewLogEntry New StatusLogEntryKFS( Me, _
		          rs.Field( StatusLoggerKFS.kLogDB_PL_FieldUID ).IntegerValue, _
		          rs.Field( StatusLoggerKFS.kLogDB_PL_FieldTimestamp ).DateValue, _
		          rs.Field( StatusLoggerKFS.kLogDB_PL_FieldMicroseconds ).Int64Value, _
		          rs.Field( StatusLoggerKFS.kLogDB_PL_FieldCallingMethod ).StringValue, _
		          rs.Field( StatusLoggerKFS.kLogDB_PL_FieldDebugLevel ).IntegerValue, _
		          rs.Field( StatusLoggerKFS.kLogDB_PL_FieldIsError ).BooleanValue )
		          
		          rs.MoveNext
		          
		        Wend
		        
		        QueryComplete
		        
		        myErrorCode = 0
		        myErrorMsg = ""
		        
		      Else
		        
		        // an error may have occurred
		        
		        myErrorCode = db.ErrorCode
		        myErrorMsg = db.ErrorMessage
		        
		        QueryError( myErrorCode, myErrorMsg )
		        
		      End If
		      
		      db.ReleaseConnectionKFS
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RestartQuery()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // Resets LatestMsgUIDExamined and refreshes all observers.
		  
		  LatestMsgUIDExamined = -1
		  
		  Refresh
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event NewLogEntry(entry As StatusLogEntryKFS)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event QueryComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event QueryError(iCode As Integer, sMsg As String)
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2009, 2010 Andrew Keller.
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


	#tag Property, Flags = &h1
		Protected LatestMsgUIDExamined As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myErrorMsg As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myQueryArgs As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_myLogObject As StatusLoggerKFS
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="2147483648"
			Type="Integer"
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
