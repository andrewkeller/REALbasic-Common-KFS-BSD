#tag Class
Protected Class StatusLoggerKFS
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initialize properties
		  
		  myStartupTime = New Date
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DebugStatus() As Int8
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns the current debug status that this class is using
		  
		  If Initialize Then
		    
		    Return myDebugStatus
		    
		  Else
		    
		    Return -1
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DebugStatus(Assigns newStatus As Int8)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // sets the debug status that this class is using
		  
		  If InitDone Then
		    
		    myDebugStatus = newStatus
		    
		    Me.NewStatusReportKFS "StatusLoggerKFS.DebugStatus( Int8 )", 3, False, _
		    "Debug Status changed to " + str( myDebugStatus )
		    
		  Else
		    
		    Call Initialize( newStatus )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorCode() As Integer
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns the current error message, exactly the way it
		  // is, without checking the init status of the database
		  
		  Return myErrorCode
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorMessage() As String
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns the current error message, exactly the way it
		  // is, without checking the init status of the database
		  
		  Return myErrorMsg
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDBRef() As Database
		  // Created 4/6/2009 by Andrew Keller
		  
		  // returns a reference to the database,
		  // and makes sure it is initialized first
		  
		  If Initialize Then
		    
		    Return logDB
		    
		  End If
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLogTableSchema() As String()
		  // Created 4/6/2009 by Andrew Keller
		  // Modified 4/15/2009 --;
		  
		  // returns a real-time string array containing
		  // the fields in the main log table
		  
		  Dim result(-1) As String
		  
		  If logDB.AddConnectionRequestKFS Then
		    
		    Dim rs As RecordSet = logDB.FieldSchema( kLogDB_PL_TableName )
		    
		    If rs <> Nil Then
		      
		      While Not rs.EOF
		        
		        result.Append rs.Field( "ColumnName" ).StringValue
		        
		        rs.MoveNext
		        
		      Wend
		      
		    End If
		    
		    logDB.ReleaseConnectionRequestKFS
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize() As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If Not InitDone Then
		    
		    Return Initialize( Nil )
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize(databaseFile As FolderItem, databasePassword As String = "") As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If Not InitDone Then
		    
		    Return Initialize( kDefaultDebugLevel, databaseFile, databasePassword )
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize(debugLevel As Int8) As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // initializes this module with the default settings
		  
		  If Not InitDone Then
		    
		    Return Initialize( debugLevel, Nil )
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize(debugLevel As Int8, databaseFile As FolderItem, databasePassword As String = "") As Boolean
		  // Created 3/13/2008 by Andrew Keller
		  // Modified 4/15/2009 --;
		  // Modified 1/15/2010 --; now compiles in CLI apps
		  
		  // makes sure that this module is initialized
		  
		  If Not InitDone Then
		    
		    // set the debug level
		    
		    If debugLevel > -1 And debugLevel < 10 Then
		      
		      myDebugStatus = debugLevel
		      
		    Else
		      
		      #if DebugBuild then
		        myDebugStatus = 2
		      #else
		        myDebugStatus = kDefaultDebugLevel
		      #endif
		      
		    End If
		    
		    // make sure the database connection works
		    
		    logDB = New REALSQLDatabase
		    
		    If databaseFile <> Nil Then
		      
		      logDB.DatabaseFile = databaseFile
		      
		      If databasePassword <> "" Then logDB.EncryptionKey = databasePassword
		      
		      If databaseFile.Exists Then
		        If logDB.AddConnectionRequestKFS Then
		          
		          logDB.ReleaseConnectionRequestKFS
		          
		        else
		          
		          myErrorCode = logDB.ErrorCode
		          myErrorMsg = "Could not connect to the requested database."
		          
		          logDB = New REALSQLDatabase
		          
		        End If
		      Else
		        If logDB.CreateDatabaseFile Then
		          If logDB.AddConnectionRequestKFS Then
		            
		            logDB.ReleaseConnectionRequestKFS
		            
		          Else
		            
		            myErrorCode = logDB.ErrorCode
		            myErrorMsg = "Could not connect to the database after creating it in the specified location."
		            
		            logDB = New REALSQLDatabase
		            
		          End If
		        Else
		          
		          myErrorCode = logDB.ErrorCode
		          myErrorMsg = "Could not create the database at the requested location."
		          
		          logDB = New REALSQLDatabase
		          
		        End If
		      End If
		    End If
		    
		    // make sure the database has the proper tables
		    
		    If logDB.AddConnectionRequestKFS Then
		      If Not logDB.HasTableKFS( kLogDB_PL_TableName ) Then
		        
		        logDB.SQLExecute RenderTableInitCmd1
		        
		        If logDB.Error Then
		          #if TargetHasGUI then
		            MsgBox "An error occurred while adding the main tables to the logging database."
		          #else
		            stderr.WriteLine "StatusLoggerKFS: An error occurred while adding the main tables to the logging database."
		          #endif
		        End If
		        
		      End If
		      
		      If Not logDB.HasTableKFS( kLogDB_MSG_TableName ) Then
		        
		        logDB.SQLExecute RenderTableInitCmd2
		        
		        If logDB.Error Then
		          #if TargetHasGUI then
		            MsgBox "An error occurred while adding the main tables to the logging database."
		          #else
		            stderr.WriteLine "StatusLoggerKFS: An error occurred while adding the main tables to the logging database."
		          #endif
		        End If
		        
		      End If
		      
		      InitDone = True
		      
		      // add the current error code, if it is anything
		      
		      If myErrorCode <> 0 Then
		        
		        Me.NewStatusReportKFS "StatusLoggerKFS.Initialize( Int8, FolderItem, String )", 0, True, "An error of type " + _
		        str( myErrorCode ) + " occurred while initializing an instance of StatusLoggerKFS:", myErrorMsg
		        
		      End If
		      
		      Me.NewStatusReportKFS "StatusLoggerKFS.Initialize( Int8, FolderItem, String )", 3, False, _
		      "StatusLoggerKFS: Initialization complete.", "Debug Status set at " + str( myDebugStatus )
		      
		      logDB.ReleaseConnectionRequestKFS
		      
		    Else
		      
		      #if TargetHasGUI then
		        MsgBox "Big Fat Error: Could not connect to the logging database after supposedly setting it up specifically so everything would work just fine."
		      #else
		        stderr.WriteLine "StatusLoggerKFS: Big Fat Error: Could not connect to the logging database after supposedly setting it up specifically so everything would work just fine."
		      #endif
		      
		    End If
		    
		  End If
		  
		  Return InitDone
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewStatusReportKFS(sMethod As String, iDebugLevel As Int8, bError As Boolean, sMessages() As String)
		  // Created 7/3/2007 by Andrew Keller
		  // Modified 4/7/2009 --; now stores data in a REALSQLDatabase
		  // Modified 4/15/2009 --; converted from module to class
		  // Modified 1/15/2010 --; now compiles in CLI apps
		  
		  // logs the given message, and displays it if neccessary
		  
		  // for the debug level, 0 represents a "normal" message
		  // or error and 9 represents full debug status.
		  
		  // in order for a message to be displayed, the message's debug level
		  // must be less than or equal to the current debug status.
		  
		  If Initialize Then
		    
		    // only store the message if it is within the debug level
		    
		    If iDebugLevel <= DebugStatus Then
		      
		      Dim dNow As Date = New Date
		      Dim iNow As Int64 = Microseconds
		      
		      If logDB.AddConnectionRequestKFS Then
		        
		        // add this entry to the database
		        
		        Dim pk As Integer = NextPrimaryKey( kLogDB_PL_TableName )
		        
		        logDB.InsertRecord kLogDB_PL_TableName, RenderNewLogEntry( pk, dNow, iNow, sMethod, iDebugLevel, bError )
		        Dim addme() As DatabaseRecord = RenderNewMessageEntries( pk, sMessages )
		        For Each d As DatabaseRecord In addme
		          logDB.InsertRecord kLogDB_MSG_TableName, d
		        Next
		        
		        logDB.Commit
		        
		        // call refresh on all the query instances
		        
		        Dim row As Integer
		        
		        For row = UBound( queryInstances ) DownTo 0
		          If queryInstances( row ) <> Nil And queryInstances( row ).Value <> Nil Then
		            
		            StatusLogQueryKFS( queryInstances( row ).Value ).Refresh
		            
		          Else
		            
		            queryInstances.Remove row
		            
		          End If
		        Next
		        
		        logDB.ReleaseConnectionRequestKFS
		        
		      Else
		        
		        #if TargetHasGUI then
		          MsgBox "Big Fat Error:" + EndOfLine + EndOfLine + "Could not connect to the database for storing a new status report."
		        #else
		          stderr.WriteLine "StatusLoggerKFS: Big Fat Error: Could not connect to the database for storing a new status report."
		        #endif
		        
		      End If
		    End If
		  Else
		    
		    #if TargetHasGUI then
		      MsgBox "Big Fat Error:" + EndOfLine + EndOfLine + "Could not initialize the logging database."
		    #else
		      stderr.WriteLine "StatusLoggerKFS: Big Fat Error: Could not initialize the logging database."
		    #endif
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewStatusReportKFS(sMethod As String, iDebugLevel As Int8, bError As Boolean, ParamArray sMessage As String)
		  // Created 4/7/2009 by Andrew Keller
		  
		  // overloaded version of NewStatusReportKFS
		  
		  // accepts the message as a ParamArray
		  
		  NewStatusReportKFS sMethod, iDebugLevel, bError, sMessage
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextPrimaryKey(tableName As String) As Integer
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns a unique primary key value for
		  // the given table in this database
		  
		  Static cache As New Dictionary
		  Dim result As Integer = -1
		  
		  // get old value
		  
		  If cache.HasKey( tableName ) Then
		    
		    result = cache.Value( tableName )
		    
		  Else
		    
		    If logDB.AddConnectionRequestKFS Then
		      
		      Dim rs As RecordSet = logDB.SQLSelect( "select " + kLogDB_PL_FieldUID + " from " + kLogDB_PL_TableName + _
		      " order by " + kLogDB_PL_FieldUID + " desc limit 1" )
		      
		      If rs <> Nil Then
		        If Not rs.EOF Then
		          
		          result = rs.Field( kLogDB_PL_FieldUID ).IntegerValue
		          
		        End If
		      End If
		      
		      logDB.ReleaseConnectionRequestKFS
		      
		    End If
		  End If
		  
		  // increment
		  
		  result = result + 1
		  
		  // remember
		  
		  cache.Value( tableName ) = result
		  
		  // return result
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function qi_indexOf(ary() As WeakRef, search As StatusLogQueryKFS) As Integer
		  // Created 4/15/2009 by Andrew Keller
		  
		  // finds the first occurance of search in ary
		  
		  Dim row, last As Integer
		  
		  last = UBound( ary )
		  
		  For row = 0 To last
		    
		    If ary( row ) <> Nil Then
		      
		      If ary( row ).Value <> Nil Then
		        
		        If StatusLogQueryKFS( ary( row ).Value ) = search Then
		          
		          Return row
		          
		        End If
		        
		      End If
		      
		    End If
		    
		  Next
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterQueryObject(queryObject As StatusLogQueryKFS)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // registers an instance of StatusLoggerKFS with this class
		  
		  If qi_indexOf( queryInstances, queryObject ) = -1 Then
		    
		    queryInstances.Append New WeakRef( queryObject )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RenderNewLogEntry(pk As Integer, dTime As Date, ui64Time As Int64, sMethod As String, iDebugLevel As Int8, bError As Boolean) As DatabaseRecord
		  // Created 4/6/2009 by Andrew Keller
		  
		  // generates a DatabaseRecord for inserting a new log item
		  
		  Dim result As New DatabaseRecord
		  
		  result.IntegerColumn( kLogDB_PL_FieldUID ) = pk
		  result.DateColumn( kLogDB_PL_FieldTimestamp ) = dTime
		  result.Int64Column( kLogDB_PL_FieldMicroseconds ) = ui64Time
		  result.BlobColumn( kLogDB_PL_FieldCallingMethod ) = sMethod
		  result.IntegerColumn( kLogDB_PL_FieldDebugLevel ) = iDebugLevel
		  result.BooleanColumn( kLogDB_PL_FieldIsError ) = bError
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RenderNewMessageEntries(iLogEntryUID As Integer, sMessages() As String) As DatabaseRecord()
		  // Created 4/7/2009 by Andrew Keller
		  
		  // generates a DatabaseRecord array for inserting a list of messages
		  
		  Dim result( -1 ) As DatabaseRecord
		  Dim row, last As Integer
		  
		  last = UBound( sMessages )
		  
		  ReDim result( last )
		  
		  For row = 0 To last
		    
		    result( row ) = New DatabaseRecord
		    
		    result( row ).IntegerColumn( kLogDB_MSG_FieldLogUID ) = iLogEntryUID
		    result( row ).IntegerColumn( kLogDB_MSG_FieldIndex ) = row
		    result( row ).BlobColumn( kLogDB_MSG_FieldMessage ) = sMessages( row )
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RenderTableInitCmd1() As String
		  // Created 4/6/2009 by Andrew Keller
		  
		  // renders the SQL command that creates the primary log table
		  
		  Return "create table " + kLogDB_PL_TableName + "( " + _
		  kLogDB_PL_FieldUID + " Integer PRIMARY KEY NOT NULL, " + _
		  kLogDB_PL_FieldTimestamp + " TimeStamp, " + _
		  kLogDB_PL_FieldMicroseconds + " Int64, " + _
		  kLogDB_PL_FieldCallingMethod + " String, " + _
		  kLogDB_PL_FieldDebugLevel + " Integer, " + _
		  kLogDB_PL_FieldIsError + " Boolean )"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RenderTableInitCmd2() As String
		  // Created 4/7/2009 by Andrew Keller
		  
		  // renders the SQL command that creates the log messages table
		  
		  Return "create table " + kLogDB_MSG_TableName + "( " + _
		  kLogDB_MSG_FieldLogUID + " Integer, " + _
		  kLogDB_MSG_FieldIndex + " Integer, " + _
		  kLogDB_MSG_FieldMessage + " String )"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StartupTime() As Date
		  // Created 4/15/2009 by Andrew Keller
		  
		  // returns the startup time of this class
		  
		  Return myStartupTime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnregisterQueryObject(queryObject As StatusLogQueryKFS)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // unregisters an instance of StatusLoggerKFS with this class
		  
		  Dim row As Integer = qi_indexOf( queryInstances, queryObject )
		  
		  While row > -1
		    
		    queryInstances.Remove row
		    
		    row = qi_indexOf( queryInstances, queryObject )
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private InitDone As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected logDB As REALSQLDatabase
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myDebugStatus As Int8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myErrorMsg As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myStartupTime As Date
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected queryInstances() As WeakRef
	#tag EndProperty


	#tag Constant, Name = kDefaultDebugLevel, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_MSG_FieldIndex, Type = String, Dynamic = False, Default = \"findex", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_MSG_FieldLogUID, Type = String, Dynamic = False, Default = \"log_link", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_MSG_FieldMessage, Type = String, Dynamic = False, Default = \"message", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_MSG_TableName, Type = String, Dynamic = False, Default = \"log_messages", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_FieldCallingMethod, Type = String, Dynamic = False, Default = \"calling_method", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_FieldDebugLevel, Type = String, Dynamic = False, Default = \"debug_level", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_FieldIsError, Type = String, Dynamic = False, Default = \"is_error", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_FieldMicroseconds, Type = String, Dynamic = False, Default = \"microseconds", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_FieldTimestamp, Type = String, Dynamic = False, Default = \"timestamp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_FieldUID, Type = String, Dynamic = False, Default = \"id", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogDB_PL_TableName, Type = String, Dynamic = False, Default = \"primary_log", Scope = Public
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
End Class
#tag EndClass