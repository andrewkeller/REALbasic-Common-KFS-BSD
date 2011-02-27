#tag Class
Protected Class UnitTestArbiterKFS
Inherits Thread
	#tag Event
		Sub Run()
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Processes the next test case until there are no test cases left to process.
		  
		  // Returns silently if automatic local processing is disabled.
		  
		  While EnableAutomaticProcessing And ProcessNextTestCase
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub CommitExceptions(e_list() As UnitTestExceptionKFS, stage As StageCodes, rslt_id As Int64)
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Copies each exception into the database as new exception,
		  // and associates them with the given result ID.
		  
		  Dim rec As DatabaseRecord
		  
		  Dim e_indx, last As Integer
		  last = UBound( e_list )
		  For e_indx = 0 To last
		    
		    // Create an exception ID:
		    
		    Dim e_id As UInt64 = UniqueInteger
		    
		    // Get the component data from the exception:
		    
		    Dim scenario As UnitTestArbiterKFS.UnitTestExceptionScenarios
		    Dim className As String
		    Dim raw_criteria As String
		    Dim errNumber As Integer
		    Dim expln As String
		    Dim assNum As Integer
		    e_list(e_indx).GetComponentData scenario, className, raw_criteria, errNumber, expln, assNum
		    
		    // Insert the new data:
		    
		    rec = New DatabaseRecord
		    
		    rec.Int64Column( kDB_Exception_ID ) = e_id
		    rec.Int64Column( kDB_Exception_ModDate ) = CurrentTimeCode
		    rec.Int64Column( kDB_Exception_ResultID ) = rslt_id
		    rec.IntegerColumn( kDB_Exception_StageCode ) = Integer( stage )
		    rec.IntegerColumn( kDB_Exception_Index ) = e_indx
		    rec.IntegerColumn( kDB_Exception_Scenario ) = Integer( scenario )
		    rec.Column( kDB_Exception_ClassName ) = className
		    rec.IntegerColumn( kDB_Exception_ErrorCode ) = errNumber
		    rec.Column( kDB_Exception_Criteria ) = raw_criteria
		    rec.Column( kDB_Exception_Explanation ) = expln
		    rec.IntegerColumn( kDB_Exception_AssertionNumber ) = assNum
		    
		    mydb.InsertRecord kDB_Exceptions, rec
		    
		    
		    // Insert the stack records:
		    
		    Dim e_stack() As String = e_list(e_indx).Stack
		    For e_stack_indx As Integer = 0 To UBound( e_stack )
		      
		      // Insert the stack data:
		      
		      rec = New DatabaseRecord
		      
		      rec.Int64Column( kDB_ExceptionStack_ExceptionID ) = e_id
		      rec.IntegerColumn( kDB_ExceptionStack_Index ) = e_stack_indx
		      rec.Int64Column( kDB_ExceptionStack_ModDate ) = CurrentTimeCode
		      rec.Column( kDB_ExceptionStack_Text ) = e_stack( e_stack_indx )
		      
		      mydb.InsertRecord kDB_ExceptionStacks, rec
		      
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Attributes( Hidden = True )  Sub Constructor()
		  // Created 1/29/2011 by Andrew Keller
		  
		  // Basic constructor.
		  
		  // Initialize the database:
		  
		  Dim db As New REALSQLDatabase
		  If Not db.Connect Then
		    Dim e As RuntimeException
		    e.Message = "Could not initialize a new REALSQLDatabase object."
		    Raise e
		  End If
		  
		  dbinit( db )
		  
		  mydb = db
		  
		  // Initialize the object pool:
		  
		  myObjPool = New Dictionary
		  
		  // Initialize properties:
		  
		  ge_time_cases = 0
		  ge_time_classes = 0
		  ge_time_results = 0
		  goForAutoProcess = True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateJobsForTestClass(class_id As UInt64)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Creates new jobs for each test case in the given loaded test class.
		  
		  // This routine runs the DataAvailable hook.
		  
		  // For each case ID in the given class:
		  
		  For Each case_id As Int64 In q_ListTestCasesInClass( class_id )
		    
		    // Get an ID for a new result record:
		    
		    Dim rslt_id As Int64 = UniqueInteger
		    
		    // Add a locking helper to the object pool:
		    
		    myObjPool.Value( rslt_id ) = True
		    
		    // Add the result record in the database:
		    
		    Dim dbr As New DatabaseRecord
		    dbr.Int64Column( kDB_TestResult_ID ) = rslt_id
		    dbr.Int64Column( kDB_TestResult_ModDate ) = CurrentTimeCode
		    dbr.Int64Column( kDB_TestResult_CaseID ) = case_id
		    dbr.IntegerColumn( kDB_TestResult_Status ) = Integer( StatusCodes.Created )
		    dbr.IntegerColumn( kDB_TestResult_Status_Setup ) = Integer( StatusCodes.Created )
		    dbr.IntegerColumn( kDB_TestResult_Status_Core ) = Integer( StatusCodes.Created )
		    dbr.IntegerColumn( kDB_TestResult_Status_Verification ) = Integer( StatusCodes.Created )
		    dbr.IntegerColumn( kDB_TestResult_Status_TearDown ) = Integer( StatusCodes.Created )
		    
		    mydb.InsertRecord kDB_TestResults, dbr
		    
		  Next
		  
		  MakeLocalThreadRun
		  
		  RunDataAvailableHook
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateJobsForTestClass(c As UnitTestBaseClassKFS)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Loads and processes all of the test cases in the given test class.
		  
		  CreateJobsForTestClass LoadTestClass( c )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CurrentTimeCode() As Int64
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Returns the current time code.
		  
		  Return Microseconds
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dbexec(sql As String)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Executes the given SQL statement, and catches any error.
		  
		  mydb.SQLExecute sql
		  
		  If mydb.Error Then
		    
		    Dim e As New UnsupportedFormatException
		    e.ErrorNumber = mydb.ErrorCode
		    e.Message = mydb.ErrorMessage
		    Raise e
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dbinit(db As Database)
		  // Created 1/29/2011 by Andrew Keller
		  
		  // Sets up the database for use with this class.
		  
		  // NOTE: this method assumes that the database
		  // has NOT already been initialized.
		  
		  // NOTE: this method only supports SQLite.
		  
		  Dim table_defs() As String
		  
		  table_defs.Append "create table "+kDB_TestClasses+" ( " _
		  + kDB_TestClass_ID + " integer, " _
		  + kDB_TestClass_ModDate + " integer, " _
		  + kDB_TestClass_Name + " varchar, " _
		  + "primary key ( " + kDB_TestClass_ID + " ) )"
		  
		  table_defs.Append "create table "+kDB_TestCases+" ( " _
		  + kDB_TestCase_ID + " integer, " _
		  + kDB_TestCase_ModDate + " integer, " _
		  + kDB_TestCase_TestType + " integer, " _
		  + kDB_TestCase_ClassID + " integer, " _
		  + kDB_TestCase_Name + " varchar, " _
		  + "primary key ( " + kDB_TestCase_ID + " ) )"
		  
		  table_defs.Append "create table "+kDB_TestCaseDependencies+" ( " _
		  + kDB_TestCaseDependency_CaseID + " integer, " _
		  + kDB_TestCaseDependency_ModDate + " integer, " _
		  + kDB_TestCaseDependency_RequiresCaseID + " integer )"
		  
		  table_defs.Append "create table "+kDB_TestResults+" ( " _
		  + kDB_TestResult_ID + " integer, " _
		  + kDB_TestResult_ModDate + " integer, " _
		  + kDB_TestResult_CaseID + " integer, " _
		  + kDB_TestResult_Status + " integer, " _
		  + kDB_TestResult_Status_Setup + " integer, " _
		  + kDB_TestResult_Status_Core + " integer, " _
		  + kDB_TestResult_Status_Verification + " integer, " _
		  + kDB_TestResult_Status_TearDown + " integer, " _
		  + kDB_TestResult_Time_Setup + " integer, " _
		  + kDB_TestResult_Time_Core + " integer, " _
		  + kDB_TestResult_Time_Verification + " integer, " _
		  + kDB_TestResult_Time_TearDown + " integer, " _
		  + "primary key ( " + kDB_TestResult_ID + " ) )"
		  
		  table_defs.Append "create table "+kDB_Exceptions+" ( " _
		  + kDB_Exception_ID + " integer, " _
		  + kDB_Exception_ModDate + " integer, " _
		  + kDB_Exception_ResultID + " integer, " _
		  + kDB_Exception_StageCode + " integer, " _
		  + kDB_Exception_Index + " integer, " _
		  + kDB_Exception_Scenario + " integer, " _
		  + kDB_Exception_ClassName + " varchar, " _
		  + kDB_Exception_ErrorCode + " integer, " _
		  + kDB_Exception_Criteria + " varchar, " _
		  + kDB_Exception_Explanation + " varchar, " _
		  + kDB_Exception_AssertionNumber + " integer, " _
		  + "primary key ( " + kDB_Exception_ID + " ) )"
		  
		  table_defs.Append "create table "+kDB_ExceptionStacks+" ( " _
		  + kDB_ExceptionStack_ExceptionID + " integer, " _
		  + kDB_ExceptionStack_Index + " integer, " _
		  + kDB_ExceptionStack_ModDate + " integer, " _
		  + kDB_ExceptionStack_Text + " integer, " _
		  + "primary key ( " + kDB_ExceptionStack_ExceptionID + ", " + kDB_ExceptionStack_Index + " ) )"
		  
		  For Each def As String In table_defs
		    
		    db.SQLExecute def
		    
		    If db.Error Then
		      Dim e As New UnsupportedFormatException
		      e.ErrorNumber = db.ErrorCode
		      e.Message = db.ErrorMessage
		      Raise e
		    End If
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dbsel(sql As String) As RecordSet
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Executes the given SQL statement, and catches any error.
		  
		  Dim rs As RecordSet = mydb.SQLSelect( sql )
		  
		  If mydb.Error Then
		    
		    Dim e As New UnsupportedFormatException
		    e.ErrorNumber = mydb.ErrorCode
		    e.Message = mydb.ErrorMessage
		    Raise e
		    
		  End If
		  
		  Return rs
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Clean things up.
		  
		  If Not ( mydb Is Nil ) Then
		    
		    mydb.Close
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EnableAutomaticProcessing() As Boolean
		  // Created 1/29/2011 by Andrew Keller
		  
		  // Returns whether or not this class is set to automatically process new test cases.
		  
		  Return goForAutoProcess
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableAutomaticProcessing(Assigns newValue As Boolean)
		  // Created 1/29/2011 by Andrew Keller
		  
		  // Sets whether or not this class is set to automatically process new test cases.
		  
		  goForAutoProcess = newValue
		  
		  MakeLocalThreadRun
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatStatusBlurb(totalCount As Integer, failureCount As Integer, skippedCount As Integer, remainingCount As Integer) As String
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Returns a simple blurb describing the given parameters.
		  
		  If failureCount = 0 And skippedCount = 0 Then
		    
		    If remainingCount = totalCount Then
		      
		      Return "Waiting"
		      
		    ElseIf remainingCount = 0 Then
		      
		      Return "Passed"
		      
		    Else
		      
		      Return "Passed so far"
		      
		    End If
		    
		  Else
		    
		    Dim s() As String
		    
		    If failureCount > 0 Then s.Append Str(failureCount) + " Failed"
		    
		    If skippedCount > 0 Then s.Append Str(skippedCount) + " Skipped"
		    
		    Return Join( s, ", " )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatStatusBlurb(totalCount As Integer, failureCount As Integer, skippedCount As Integer, remainingCount As Integer, elapsedTime As DurationKFS) As String
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Returns a simple blurb describing the given parameters.
		  
		  // The count remaining does not factor in the
		  // count skipped, so let's account for that here:
		  
		  remainingCount = Max( remainingCount - skippedCount, 0 )
		  
		  // Build the result:
		  
		  Dim result As String
		  Dim i As Integer
		  Dim d As Double
		  
		  i = totalCount
		  result = result + str( i ) + " test"
		  If i <> 1 Then result = result + "s"
		  
		  If i > 0 Then
		    
		    i = failureCount
		    result = result + ", " + str( i ) + " failure"
		    If i <> 1 Then result = result + "s"
		    
		    i = skippedCount
		    If i <> 0 Then
		      result = result + ", " + str( i ) + " skipped"
		    End If
		    
		    i = remainingCount
		    If i <> 0 Then
		      result = result + ", " + str( i ) + " remaining"
		    End If
		    
		    d = elapsedTime.Value
		    result = result + ", " + str( d ) + " second"
		    If d <> 1 Then result = result + "s"
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GatherEvents()
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Fires the TestClassUpdated, TestCaseUpdated, and TestResultUpdated events
		  // for every database record that has been updated since timeCodeCache.
		  
		  RaiseEvent EventGatheringStarted
		  
		  // Get any new results:
		  
		  Dim ntc_results, ntc_cases, ntc_classes As Int64
		  Dim rs_results, rs_cases, rs_classes As RecordSet
		  
		  Do
		    
		    // Get any new results:
		    
		    ntc_results = CurrentTimeCode
		    rs_results = dbsel( pq_ResultsModifiedSinceLastUpdate )
		    
		    // Get any new test cases:
		    
		    ntc_cases = CurrentTimeCode
		    rs_cases = dbsel( pq_CaseSpecificationsModifiedSinceLastUpdate )
		    
		    // Get any new test classes:
		    
		    ntc_classes = CurrentTimeCode
		    rs_classes = dbsel( pq_ClassSpecificationsModifiedSinceLastUpdate )
		    
		    // Fire the TestClassUpdated event for each of the updated classes:
		    
		    While Not rs_classes.EOF
		      
		      RaiseEvent TestClassUpdated _
		      rs_results.Field( "class_id" ).Int64Value, _
		      rs_results.Field( "class_name" ).StringValue
		      
		      rs_classes.MoveNext
		      
		    Wend
		    
		    // Fire the TestCaseUpdated event for each of the updated cases:
		    
		    While Not rs_cases.EOF
		      
		      RaiseEvent TestCaseUpdated _
		      rs_results.Field( "class_id" ).Int64Value, _
		      rs_results.Field( "class_name" ).StringValue, _
		      rs_results.Field( "case_id" ).Int64Value, _
		      rs_results.Field( "case_name" ).StringValue
		      
		      rs_cases.MoveNext
		      
		    Wend
		    
		    // Fire the TestResultUpdated event for each of the found records:
		    
		    While Not rs_results.EOF
		      
		      Dim setup_t, core_t, teardown_t As DurationKFS
		      
		      If Not rs_results.Field( kDB_TestResult_Time_Setup ).Value.IsNull Then setup_t = DurationKFS.NewFromMicroseconds( rs_results.Field( kDB_TestResult_Time_Setup ).Int64Value )
		      If Not rs_results.Field( kDB_TestResult_Time_Core ).Value.IsNull Then core_t = DurationKFS.NewFromMicroseconds( rs_results.Field( kDB_TestResult_Time_Core ).Int64Value )
		      If Not rs_results.Field( kDB_TestResult_Time_TearDown ).Value.IsNull Then teardown_t = DurationKFS.NewFromMicroseconds( rs_results.Field( kDB_TestResult_Time_TearDown ).Int64Value )
		      
		      RaiseEvent TestResultUpdated _
		      rs_results.Field( "rslt_id" ).Int64Value, _
		      rs_results.Field( "class_id" ).Int64Value, _
		      rs_results.Field( "class_name" ).StringValue, _
		      rs_results.Field( "case_id" ).Int64Value, _
		      rs_results.Field( "case_name" ).StringValue, _
		      StatusCodes( rs_results.Field( "rslt_status" ).IntegerValue ), _
		      setup_t, _
		      core_t, _
		      teardown_t
		      
		      rs_results.MoveNext
		      
		    Wend
		    
		    // Update the time code caches:
		    
		    ge_time_classes = ntc_classes
		    ge_time_cases = ntc_cases
		    ge_time_results = ntc_results
		    
		  Loop Until rs_classes.RecordCount = 0 And rs_cases.RecordCount = 0 And rs_results.RecordCount = 0
		  
		  RaiseEvent EventGatheringFinished
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GatherExceptionsFromTestClass(subject As UnitTestBaseClassKFS, terminalError As RuntimeException = Nil) As UnitTestExceptionKFS()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Gathers the exceptions in the exception stash, and the given uncaught exception
		  // into a single array, and returns it.  Also clears the subject's exception stash.
		  
		  // Assumes the subject is already locked.
		  
		  Dim result() As UnitTestExceptionKFS
		  
		  For Each e As UnitTestExceptionKFS In subject.AssertionFailureStash
		    result.Append e
		  Next
		  
		  If Not ( terminalError Is Nil ) Then
		    result.Append UnitTestExceptionKFS.NewExceptionFromUncaughtException( subject, terminalError )
		  End If
		  
		  ReDim subject.AssertionFailureStash( -1 )
		  ReDim subject.AssertionMessageStack( -1 )
		  subject.AssertionCount = 0
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetAndLockNextTestResult(ByRef rslt_id As Int64) As Boolean
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Searches for a doable, undelegated job, and tries to get a lock on it.
		  // Upon a successful lock, the ID of the test case is returned through the
		  // rslt_id parameter.  Returns whether or not a lock was successfully obtained.
		  
		  // This routine runs the DataAvailable hook.
		  
		  Do
		    
		    rslt_id = kReservedID_Null
		    
		    For Each rslt_id In q_ListTestResultsWaitingForProcessing
		      
		      // We've got our hands on a job ID.
		      // Try to get a lock:
		      
		      Dim bLockObtained As Boolean = True
		      Try
		        myObjPool.Remove rslt_id
		      Catch err As KeyNotFoundException
		        // Darn, another thread got the lock before us.
		        bLockObtained = False
		      End Try
		      
		      If bLockObtained Then
		        
		        // Yay!  We got the lock.  Update the record for
		        // this result so no other threads try to get this job.
		        
		        Dim rs As Recordset = dbsel( _
		        "SELECT "+kDB_TestResult_Status+", "+kDB_TestResult_ModDate _
		        +" FROM "+kDB_TestResults _
		        +" WHERE "+kDB_TestResult_ID+" = "+Str(rslt_id) )
		        
		        rs.Edit
		        If Not mydb.Error Then
		          
		          rs.Field( kDB_TestResult_Status ).Int64Value = Integer( StatusCodes.Delegated )
		          rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		          rs.Update
		          mydb.Commit
		          
		          RunDataAvailableHook
		          
		          Return True
		          
		        End If
		      End If
		    Next
		    
		  Loop Until rslt_id = kReservedID_Null
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetComponentTestCaseTypes() As UnitTestArbiterKFS.TestCaseTypes()
		  // Created 2/17/2011 by Andrew Keller
		  
		  // Returns an array of all of the component test case types
		  // (not any of the combinations; used for Mod testing).
		  
		  Return Array( _
		  TestCaseTypes.TestCaseRequiringSetup, _
		  TestCaseTypes.TestCaseWithoutFixture, _
		  TestCaseTypes.TestCaseRequiringVerification, _
		  TestCaseTypes.TestCaseRequiringTearDown )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInt64ArrayFromRecordSetField(rs As RecordSet, indx As Integer) As Int64()
		  // Created 2/7/2011 by Andrew Keller
		  
		  // Returns an Int64 array of the values in the given field in the given RecordSet.
		  
		  Dim result( -1 ) As Int64
		  Dim row, last As Integer
		  last = rs.RecordCount -1
		  
		  If last < 0 Then Return result
		  
		  ReDim result( last )
		  rs.MoveFirst
		  
		  For row = 0 To last
		    
		    result( row ) = rs.IdxField( indx ).Int64Value
		    
		    rs.MoveNext
		    
		  Next
		  
		  // Return the array.
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub GetStringArraysFromExceptionsInRecordSet(rs As RecordSet, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Populates the given arrays with the data in the given recordset.
		  
		  // This is basically the common section of the q_ListExceptionSummaries* functions.
		  
		  
		  // Clear the arrays?
		  
		  If clearArrays Then
		    
		    ReDim caseLabels( -1 )
		    ReDim caseExceptionSummaries( -1 )
		    
		  End If
		  
		  // Add the data:
		  
		  While Not rs.EOF
		    
		    Dim stage As StageCodes = StageCodes( rs.Field( kDB_Exception_StageCode ).IntegerValue )
		    
		    Dim label As String = rs.Field( "class_name" ).StringValue + kClassTestDelimiter + rs.Field( "case_name" ).StringValue
		    
		    If stage = StageCodes.Setup Then label = label + " (Setup)"
		    If stage = StageCodes.Verification Then label = label + " (Verification)"
		    If stage = StageCodes.TearDown Then label = label + " (Tear Down)"
		    
		    caseLabels.Append label
		    
		    caseExceptionSummaries.Append UnitTestExceptionKFS.FormatMessage( _
		    UnitTestExceptionScenarios( rs.Field( kDB_Exception_Scenario ).IntegerValue ), _
		    rs.Field( kDB_Exception_ClassName ).StringValue, _
		    rs.Field( kDB_Exception_Criteria ).StringValue, _
		    rs.Field( kDB_Exception_ErrorCode ).IntegerValue, _
		    rs.Field( kDB_Exception_Explanation ).StringValue, _
		    rs.Field( kDB_Exception_AssertionNumber ).IntegerValue )
		    
		    rs.MoveNext
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadAndProcessTestClasses(c() As UnitTestBaseClassKFS)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Loads and processes all of the test cases in the given test classes.
		  
		  For Each utc As UnitTestBaseClassKFS In c
		    If Not ( utc Is Nil ) Then
		      
		      CreateJobsForTestClass utc
		      
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadAndProcessTestClasses(ParamArray c As UnitTestBaseClassKFS)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Loads and processes all of the test cases in the given test classes.
		  
		  LoadAndProcessTestClasses c
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadTestClass(c As UnitTestBaseClassKFS) As Integer
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Loads the given test class into the database.
		  
		  Dim testCaseMethods() As Introspection.MethodInfo = c.GetTestMethods
		  Dim classConstructor As Introspection.MethodInfo = testCaseMethods(0)
		  testCaseMethods.Remove 0
		  Dim tm_type As TestCaseTypes
		  Dim class_id As Int64
		  Dim cnstr_id As Int64
		  Dim tc_id As Int64
		  
		  // Get an ID for the class:
		  
		  class_id = UniqueInteger
		  
		  // Store the class into the object bucket:
		  
		  myObjPool.Value( class_id ) = c
		  
		  // Add the class to the database:
		  
		  dbexec "insert into "+kDB_TestClasses+" ( "+kDB_TestClass_ID+", "+kDB_TestClass_ModDate+", "+kDB_TestClass_Name+" ) values ( "+Str(class_id)+", "+Str(CurrentTimeCode)+", '"+c.ClassName+"' )"
		  
		  If Not ( classConstructor Is Nil ) Then
		    
		    // Get an ID for the class constructor:
		    
		    cnstr_id = UniqueInteger
		    
		    // Store the class constructor into the object bucket:
		    
		    myObjPool.Value( cnstr_id ) = classConstructor
		    
		    // Add the class constructor to the database:
		    
		    dbexec "insert into "+kDB_TestCases+" ( "+kDB_TestCase_ID+", "+kDB_TestCase_ModDate+", "+kDB_TestCase_TestType+", "+kDB_TestCase_ClassID+", "+kDB_TestCase_Name+" ) values ( "+Str(cnstr_id)+", "+Str(CurrentTimeCode)+", "+Str(Integer(TestCaseTypes.TestCaseWithoutFixture))+", "+Str(class_id)+", 'Constructor' )"
		    
		  End If
		  
		  // Figure out what kind of test methods are in the class:
		  
		  tm_type = TestCaseTypes.TestCaseWithoutFixture
		  If c.SetupEventWasImplemented Then tm_type = tm_type * TestCaseTypes.TestCaseRequiringSetup
		  If c.VerificationEventWasImplemented Then tm_type = tm_type * TestCaseTypes.TestCaseRequiringVerification
		  If c.TearDownEventWasImplemented Then tm_type = tm_type * TestCaseTypes.TestCaseRequiringTearDown
		  
		  // Add the rest of the test cases to the database:
		  
		  For Each tc As Introspection.MethodInfo In testCaseMethods
		    If Not ( tc Is Nil ) Then
		      
		      // Get an ID for the test case:
		      
		      tc_id = UniqueInteger
		      
		      // Store the test case into the object bucket:
		      
		      myObjPool.Value( tc_id ) = tc
		      
		      If Not ( classConstructor Is Nil ) Then
		        
		        // Add a dependency on the constructor to the database:
		        
		        dbexec "insert into "+kDB_TestCaseDependencies+" ( "+kDB_TestCaseDependency_CaseID+", "+kDB_TestCaseDependency_ModDate+", "+kDB_TestCaseDependency_RequiresCaseID+" ) values ( "+Str(tc_id)+", "+Str(CurrentTimeCode)+", "+Str(cnstr_id)+" )"
		        
		      End If
		      
		      // Add the test case to the database:
		      
		      dbexec "insert into "+kDB_TestCases+" ( "+kDB_TestCase_ID+", "+kDB_TestCase_ModDate+", "+kDB_TestCase_TestType+", "+kDB_TestCase_ClassID+", "+kDB_TestCase_Name+" ) values ( "+Str(tc_id)+", "+Str(CurrentTimeCode)+", "+Str(Integer(tm_type))+", "+Str(class_id)+", '"+tc.Name+"' )"
		      
		    End If
		  Next
		  
		  Return class_id
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub MakeLocalThreadRun(respectAutoProcess As Boolean = True)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Makes the local thread run, if it is not already.
		  
		  If respectAutoProcess = False Or goForAutoProcess = True Then
		    If Me.State = Thread.NotRunning Then
		      
		      Me.Run
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_CasesOfType(type As TestCaseTypes, exclusive As Boolean = True) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all test cases of the given type.
		  
		  // The exclusive parameter refers to whether or not subsets of the
		  // given type should be excluded.  Exclusive = True means require
		  // exact matches, and Exclusive = False means to include subsets.
		  
		  // The query reutrns a recordset with a single column being the test case ID.
		  // The actual name of the column is currently undefined.
		  
		  If type = TestCaseTypes.TestCaseWithoutFixture Or exclusive Then
		    
		    Return "SELECT DISTINCT "+kDB_TestCase_ID _
		    + " FROM "+kDB_TestCases _
		    + " WHERE "+kDB_TestCase_TestType+" = "+Str(Integer(type)) _
		    + " ORDER BY "+kDB_TestCase_ID+" ASC"
		    
		  Else
		    
		    Dim inserts() As String
		    For Each component As TestCaseTypes In GetComponentTestCaseTypes
		      If Integer( type ) Mod Integer( component ) = 0 Then
		        
		        inserts.Append kDB_TestCase_TestType+" % "+Str(Integer(component))+" = 0"
		        
		      End If
		    Next
		    
		    Return "SELECT DISTINCT "+kDB_TestCase_ID _
		    + " FROM "+kDB_TestCases _
		    + " WHERE "+Join( inserts, " AND " ) _
		    + " ORDER BY "+kDB_TestCase_ID+" ASC"
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_CaseSpecificationsModifiedSinceLastUpdate() As String
		  // Created 2/7/2011 by Andrew Keller
		  
		  // Returns the query for finding updated test cases.
		  
		  Dim tcc As Int64 = ge_time_cases
		  
		  // Get a list of the dependencies that have been updated:
		  
		  Dim new_dep As String _
		  = "SELECT DISTINCT "+kDB_TestCaseDependency_CaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_ModDate+" >= "+Str(tcc)
		  
		  // Get all the overall class id / case id records that have changed:
		  
		  Return "SELECT "+kDB_TestClasses+"."+kDB_TestClass_ID+", "+kDB_TestClasses+"."+kDB_TestClass_Name+", "+kDB_TestCases+"."+kDB_TestCase_ID+", "+kDB_TestCases+"."+kDB_TestCase_Name _
		  +" FROM "+kDB_TestCases+" LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  +" WHERE "+kDB_TestCases+"."+kDB_TestCase_ModDate+" >= "+Str(tcc) _
		  +" OR "+kDB_TestCases+"."+kDB_TestCase_ID+" IN ( "+new_dep+" )"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_CasesThatCauseInaccessibilityOfType(inaccessibilityType As StatusCodes) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all test cases
		  // that can cause an inaccessibility of the given type.
		  
		  // The query reutrns a recordset with a single column being the test case ID.
		  // The actual name of the column is currently undefined.
		  
		  If inaccessibilityType = StatusCodes.Category_Inaccessible Then
		    
		    Return "SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		    + " FROM "+kDB_TestCaseDependencies _
		    + " WHERE "+kDB_TestCaseDependency_RequiresCaseID+" NOT IN ( "+pq_CasesWithStatus(StatusCodes.Passed)+" )"
		    
		  ElseIf inaccessibilityType = StatusCodes.Category_InaccessibleDueToMissingPrerequisites Then
		    
		    Return "SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		    + " FROM "+kDB_TestCaseDependencies _
		    + " WHERE "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+pq_CasesWithStatus(StatusCodes.Category_Incomplete)+" )"
		    
		  ElseIf inaccessibilityType = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    Return "SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		    + " FROM "+kDB_TestCaseDependencies _
		    + " WHERE "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+pq_CasesWithStatus(StatusCodes.Failed)+" )"
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "The "+CurrentMethodName+" function does not support a status code of "+Str(Integer(inaccessibilityType))
		    Raise e
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_CasesWithStatus(status As StatusCodes) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all test cases with the given status.
		  
		  // The query reutrns a recordset with a single column being the test case ID.
		  // The actual name of the column is currently undefined.
		  
		  If status = StatusCodes.Null Then
		    
		    Return "SELECT "+kDB_TestCase_ID _
		    + " FROM "+kDB_TestCases _
		    + " WHERE "+kDB_TestCase_ID+" NOT IN (" _
		    + " SELECT DISTINCT "+kDB_TestResult_CaseID _
		    + " FROM "+kDB_TestResults _
		    + " )"
		    
		  ElseIf status = StatusCodes.Created _
		    Or status = StatusCodes.Delegated _
		    Or status = StatusCodes.Category_Incomplete _
		    Or status = StatusCodes.Passed _
		    Or status = StatusCodes.Failed Then
		    
		    Dim op As String = " = "
		    If status = StatusCodes.Category_Incomplete Then op = " <= "
		    
		    Return "SELECT "+kDB_TestResult_CaseID _
		    + " FROM (" _
		    + " SELECT "+kDB_TestResult_CaseID+", max( "+kDB_TestResult_Status+" ) AS ms" _
		    + " FROM "+kDB_TestResults _
		    + " GROUP BY "+kDB_TestResult_CaseID _
		    + " ) WHERE ms"+op+Str(Integer(status))
		    
		  ElseIf status = StatusCodes.Category_Inaccessible _
		    Or status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites _
		    Or status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    Return "SELECT DISTINCT "+kDB_TestCaseDependency_CaseID _
		    + " FROM "+kDB_TestCaseDependencies _
		    + " WHERE "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+pq_CasesThatCauseInaccessibilityOfType(status)+" )"
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "The "+CurrentMethodName+" function does not support a status code of "+Str(Integer(status))
		    Raise e
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ClassesWithStatus(status As StatusCodes) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all test classes with the given status.
		  
		  // The query reutrns a recordset with a single column being the test class ID.
		  // The actual name of the column is currently undefined.
		  
		  If status = StatusCodes.Null Then
		    
		    Return "SELECT "+kDB_TestClass_ID _
		    + " FROM "+kDB_TestClasses _
		    + " WHERE "+kDB_TestClass_ID+" NOT IN (" _
		    + " SELECT DISTINCT "+kDB_TestCases+"."+kDB_TestCase_ClassID _
		    + " FROM "+kDB_TestResults _
		    + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		    + " )"
		    
		  ElseIf status = StatusCodes.Created _
		    Or status = StatusCodes.Delegated _
		    Or status = StatusCodes.Category_Incomplete _
		    Or status = StatusCodes.Passed _
		    Or status = StatusCodes.Failed Then
		    
		    Dim op As String = " = "
		    If status = StatusCodes.Category_Incomplete Then op = " <= "
		    
		    Return "SELECT "+kDB_TestCase_ClassID _
		    + " FROM ( " _
		    + " SELECT "+kDB_TestCases+"."+kDB_TestCase_ClassID+", max( "+kDB_TestResults+"."+kDB_TestResult_Status+" ) AS ms" _
		    + " FROM "+kDB_TestResults _
		    + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		    + " GROUP BY "+kDB_TestCases+"."+kDB_TestCase_ClassID _
		    + " ) WHERE ms"+op+Str(Integer(status))
		    
		  ElseIf status = StatusCodes.Category_Inaccessible _
		    Or status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites _
		    Or status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    Return Str( kReservedID_Null )
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "The "+CurrentMethodName+" function does not support a status code of "+Str(Integer(status))
		    Raise e
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ClassSpecificationsModifiedSinceLastUpdate() As String
		  // Created 2/7/2011 by Andrew Keller
		  
		  // Returns the query for finding updated test classes.
		  
		  Dim tcc As Int64 = ge_time_cases
		  
		  // Get all the overall class id records that have changed:
		  
		  Return "SELECT "+kDB_TestClass_ID+", "+kDB_TestClass_Name _
		  +" FROM "+kDB_TestClasses _
		  +" WHERE "+kDB_TestClass_ModDate+" >= "+Str(tcc)
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_Exceptions() As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all exceptions.
		  
		  // The query reutrns a recordset with a single column being the exception ID.
		  // The actual name of the column is currently undefined.
		  
		  Return "SELECT DISTINCT "+kDB_Exception_ID _
		  + " FROM "+kDB_Exceptions
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ExceptionsForCase(case_id As Int64) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all exceptions for the given test case.
		  
		  // The query reutrns a recordset with a single column being the exception ID.
		  // The actual name of the column is currently undefined.
		  
		  Return "SELECT DISTINCT "+kDB_Exceptions+"."+kDB_Exception_ID _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id)
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ExceptionsForCaseDuringStage(case_id As Int64, stage As StageCodes) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all exceptions for the given test case during the given stage.
		  
		  // The query reutrns a recordset with a single column being the exception ID.
		  // The actual name of the column is currently undefined.
		  
		  Return "SELECT DISTINCT "+kDB_Exceptions+"."+kDB_Exception_ID _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_Exception_StageCode+" = "+Str(Integer(stage))
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ExceptionsForClass(class_id As Int64) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all exceptions for the given test class.
		  
		  // The query reutrns a recordset with a single column being the exception ID.
		  // The actual name of the column is currently undefined.
		  
		  Return "SELECT DISTINCT "+kDB_Exceptions+"."+kDB_Exception_ID _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id)
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ExceptionsForResult(result_id As Int64) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all exceptions for the given result.
		  
		  // The query reutrns a recordset with a single column being the exception ID.
		  // The actual name of the column is currently undefined.
		  
		  Return "SELECT DISTINCT "+kDB_Exception_ID _
		  + " FROM "+kDB_Exceptions _
		  + " WHERE "+kDB_Exception_ResultID+" = "+Str(result_id)
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ExceptionsForResultDuringStage(result_id As Int64, stage As StageCodes) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all exceptions for the given result during the given stage.
		  
		  // The query reutrns a recordset with a single column being the exception ID.
		  // The actual name of the column is currently undefined.
		  
		  Return "SELECT DISTINCT "+kDB_Exception_ID _
		  + " FROM "+kDB_Exceptions _
		  + " WHERE "+kDB_Exception_ResultID+" = "+Str(result_id) _
		  + " AND "+kDB_Exception_StageCode+" = "+Str(Integer(stage))
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ResultsModifiedSinceLastUpdate() As String
		  // Created 2/7/2011 by Andrew Keller
		  
		  // Returns the query for finding new events.
		  
		  Dim mod_results, failed_cases As String
		  Dim tcc As Int64 = ge_time_results
		  
		  // Get all the exception stack records that have changed:
		  
		  mod_results = "SELECT "+kDB_ExceptionStack_ExceptionID+" FROM "+kDB_ExceptionStacks+" WHERE "+kDB_ExceptionStack_ModDate+" >= "+Str(tcc)
		  
		  // Get all the exceptions records that have changed:
		  
		  mod_results = "SELECT "+kDB_Exception_ResultID+" FROM "+kDB_Exceptions+" WHERE "+kDB_Exception_ModDate+" >= "+Str(tcc)+" OR "+kDB_Exception_ID+" IN ( " + chr(10)+mod_results+chr(10) + " )"
		  
		  // Get all the result records that have changed:
		  
		  mod_results = "SELECT "+kDB_TestResult_ID+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_ModDate+" >= "+Str(tcc)+" OR "+kDB_TestResult_ID+" IN ( " + chr(10)+mod_results+chr(10) + " )"
		  
		  // Get all the result records that are now inaccessible due to newly discovered failed results:
		  
		  failed_cases = "SELECT DISTINCT "+kDB_TestResult_CaseID+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_ModDate+" >= "+Str(tcc)+" AND "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Failed))
		  
		  failed_cases = "SELECT DISTINCT "+kDB_TestCaseDependency_CaseID+" FROM "+kDB_TestCaseDependencies+" WHERE "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+failed_cases+" )"
		  
		  mod_results = mod_results + " OR "+kDB_TestResult_CaseID+" IN ( "+failed_cases+" )"
		  
		  // Get all the overall class id / case id records that have changed:
		  
		  Return "SELECT "+kDB_TestResults+"."+kDB_TestResult_ID+" AS rslt_id, "+kDB_TestCases+"."+kDB_TestCase_ClassID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name, "+kDB_TestResults+"."+kDB_TestResult_CaseID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestResults+"."+kDB_TestResult_Status+" AS rslt_status, "+kDB_TestResult_Time_Setup+", "+kDB_TestResult_Time_Core+", "+kDB_TestResult_Time_TearDown _
		  +" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+".id LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCase_ClassID+" = classes.id" _
		  +" WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+mod_results+" )"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ResultsOfType(type As TestCaseTypes, exclusive As Boolean = True) As String
		  // Created 2/13/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all test results of the given test type.
		  
		  // The exclusive parameter refers to whether or not subsets of the
		  // given type should be excluded.  Exclusive = True means require
		  // exact matches, and Exclusive = False means to include subsets.
		  
		  // The query reutrns a recordset with a single column being the result ID.
		  // The actual name of the column is currently undefined.
		  
		  If type = TestCaseTypes.TestCaseWithoutFixture Or exclusive Then
		    
		    Return "SELECT DISTINCT "+kDB_TestResult_ID _
		    + " FROM "+kDB_TestResults _
		    + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		    + " WHERE "+kDB_TestCase_TestType+" = "+Str(Integer(type)) _
		    + " ORDER BY "+kDB_TestCase_ID+" ASC"
		    
		  Else
		    
		    Dim inserts() As String
		    For Each component As TestCaseTypes In GetComponentTestCaseTypes
		      If Integer( type ) Mod Integer( component ) = 0 Then
		        
		        inserts.Append kDB_TestCase_TestType+" % "+Str(Integer(component))+" = 0"
		        
		      End If
		    Next
		    
		    Return "SELECT DISTINCT "+kDB_TestResult_ID _
		    + " FROM "+kDB_TestResults _
		    + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		    + " WHERE "+Join( inserts, " AND " ) _
		    + " ORDER BY "+kDB_TestCase_ID+" ASC"
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ResultsWaitingForProcessing() As String
		  // Created 2/24/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all results ready for processing, sorted
		  // by some attributes, with the intention that cases are not first-pick if the
		  // class may currently be locked, or if nothing depends on them.
		  
		  // The query reutrns a recordset with a single column being the result ID.
		  // The actual name of the column is currently "rslt_id".
		  
		  // Get the counts of currently delegated test results per test class:
		  
		  Dim del_cnt As String _
		  = "SELECT "+kDB_TestCases+"."+kDB_TestCase_ClassID+" AS del_id, count( "+kDB_TestResults+"."+kDB_TestResult_ID+" ) AS del_cnt" _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Delegated)) _
		  + " GROUP BY "+kDB_TestCase_ClassID
		  
		  // Get the counts of dependencies of test cases:
		  
		  Dim dep_cnt As String _
		  = "SELECT "+kDB_TestCaseDependency_RequiresCaseID+" AS dep_id, count( "+kDB_TestCaseDependency_CaseID+" ) AS dep_cnt" _
		  + " FROM "+kDB_TestCaseDependencies _
		  + " GROUP BY "+kDB_TestCaseDependency_RequiresCaseID
		  
		  // Get the list of test cases that are inaccessible due to failed prerequisites:
		  
		  Dim inaccessible_cases As String _
		  = pq_CasesWithStatus( StatusCodes.Category_InaccessibleDueToFailedPrerequisites )
		  
		  // Get the list of results that are not yet delegated, have all prerequisites satisfied,
		  // and sort by the number of test results delegated per class, and by how many
		  // test cases depend on the given test case.
		  
		  Return "SELECT "+kDB_TestResults+"."+kDB_TestResult_ID+" AS rslt_id" _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN ( "+del_cnt+" ) ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = del_id" _
		  + " LEFT JOIN ( "+dep_cnt+" ) ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = dep_id" _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Created)) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_CaseID+" NOT IN ( "+inaccessible_cases+" )" _
		  + " ORDER BY del_cnt ASC, dep_cnt DESC, rslt_id ASC"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pq_ResultsWithStatus(status As StatusCodes) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A preset query that gets the set of all results with the given status.
		  
		  // The query reutrns a recordset with a single column being the result ID.
		  // The actual name of the column is currently undefined.
		  
		  If status = StatusCodes.Null Then
		    
		    Return Str( kReservedID_Null )
		    
		  ElseIf status = StatusCodes.Created _
		    Or status = StatusCodes.Delegated _
		    Or status = StatusCodes.Category_Incomplete _
		    Or status = StatusCodes.Passed _
		    Or status = StatusCodes.Failed Then
		    
		    Dim op As String = " = "
		    If status = StatusCodes.Category_Incomplete Then op = " <= "
		    
		    Return "SELECT "+kDB_TestResult_ID+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_Status+op+Str(Integer(status))
		    
		  ElseIf status = StatusCodes.Category_Inaccessible _
		    Or status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites _
		    Or status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    Return "SELECT "+kDB_TestResult_ID _
		    + " FROM "+kDB_TestResults _
		    + " WHERE "+kDB_TestResult_CaseID+" IN ( "+pq_CasesWithStatus(status)+" )"
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "The "+CurrentMethodName+" function does not support a status code of "+Str(Integer(status))
		    Raise e
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProcessNextTestCase() As Boolean
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Acquires, locks, and processes the next test case.
		  
		  Dim rslt_id As Int64
		  
		  If GetAndLockNextTestResult( rslt_id ) Then
		    
		    // We now have a lock on a test case.
		    
		    // Process it.
		    
		    ProcessTestCase rslt_id
		    
		    Return True
		    
		  Else
		    
		    // A lock could not be obtained on a job,
		    // most likely because there are no jobs left.
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessTestCase(rslt_id As Int64)
		  // Created 2/1/2011 by Andrew Keller
		  
		  // Processes the given test case, REGARDLESS of dependencies.
		  // All results pertaining to the given result are deleted before
		  // the test is run.  If you wanted to create a new result, record,
		  // then you should have done that before calling this routine.
		  
		  // This routine runs the DataAvailable hook.
		  
		  // Set up the common queries we'll be using.
		  
		  Dim rslt_master_sql As String _
		  = "SELECT * FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_ID+" = "+Str(rslt_id)
		  
		  Dim rslt_info_sql As String _
		  = "SELECT "+kDB_TestResults+"."+kDB_TestResult_ID+" AS rslt_id, "+kDB_TestCases+"."+kDB_TestCase_ClassID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name, "+kDB_TestResults+"."+kDB_TestResult_CaseID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestCases+"."+kDB_TestCase_TestType+" AS case_type " _
		  + "FROM ( "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID+" ) LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID+" " _
		  + "WHERE rslt_id = "+Str(rslt_id)
		  
		  
		  // First, make sure the result record exists and is not ambiguous.
		  
		  Dim rs As RecordSet = dbsel( rslt_master_sql )
		  
		  If rs.RecordCount < 1 Then
		    
		    Dim e As New RuntimeException
		    e.Message = "Cannot process result number "+str(rslt_id)+" because it does not exist."
		    Raise e
		    
		  ElseIf rs.RecordCount > 1 Then
		    
		    Dim e As New RuntimeException
		    e.Message = "Cannot process result number "+str(rslt_id)+" because there are multiple result records with that ID."
		    Raise e
		    
		  End If
		  
		  
		  // Next, gather the information we need to run the test.
		  
		  rs = dbsel( rslt_info_sql )
		  Dim class_id As Int64 = rs.Field( "class_id" ).Int64Value
		  Dim class_name As String = rs.Field( "class_name" ).StringValue
		  Dim case_id As Int64 = rs.Field( "case_id" ).Int64Value
		  Dim case_name As String = rs.Field( "case_name" ).StringValue
		  Dim case_type As TestCaseTypes = TestCaseTypes( rs.Field( "case_type" ).IntegerValue )
		  
		  If Not myObjPool.HasKey( class_id ) Then
		    Dim e As New KeyNotFoundException
		    e.Message = "The class object for this test case is missing.  Cannot proceed with test."
		    Raise e
		  ElseIf Not ( myObjPool.Value( class_id ) IsA UnitTestBaseClassKFS ) Then
		    Dim e As RuntimeException
		    e.Message = "The class object for this test case is an unexpected type.  Cannot proceed with test."
		    Raise e
		  End If
		  Dim tc As UnitTestBaseClassKFS = UnitTestBaseClassKFS( myObjPool.Value( class_id ) )
		  
		  If Not myObjPool.HasKey( case_id ) Then
		    Dim e As New KeyNotFoundException
		    e.Message = "The test method object for this test case is missing.  Cannot proceed with test."
		    Raise e
		  ElseIf Not ( myObjPool.Value( case_id ) IsA Introspection.MethodInfo ) Then
		    Dim e As RuntimeException
		    e.Message = "The test method object for this test case is an unexpected type.  Cannot proceed with test."
		    Raise e
		  End If
		  Dim tm As Introspection.MethodInfo = Introspection.MethodInfo( myObjPool.Value( case_id ) )
		  
		  
		  // Next, clear out any existing results.
		  
		  dbexec "DELETE FROM "+kDB_ExceptionStacks+" WHERE "+kDB_ExceptionStack_ExceptionID+" IN ( SELECT "+kDB_Exception_ID+" FROM "+kDB_Exceptions+" WHERE "+kDB_Exception_ResultID+" = "+Str(rslt_id)+" )"
		  dbexec "DELETE FROM "+kDB_Exceptions+" WHERE "+kDB_Exception_ResultID+" = "+Str(rslt_id)
		  rs = dbsel( rslt_master_sql )
		  rs.Edit
		  rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		  rs.Field( kDB_TestResult_Status ).IntegerValue = Integer( StatusCodes.Delegated )
		  rs.Field( kDB_TestResult_Status_Setup ).Value = Integer( StatusCodes.Created )
		  rs.Field( kDB_TestResult_Status_Core ).Value = Integer( StatusCodes.Created )
		  rs.Field( kDB_TestResult_Status_Verification ).Value = Integer( StatusCodes.Created )
		  rs.Field( kDB_TestResult_Status_TearDown ).Value = Integer( StatusCodes.Created )
		  rs.Field( kDB_TestResult_Time_Setup ).Value = Nil
		  rs.Field( kDB_TestResult_Time_Core ).Value = Nil
		  rs.Field( kDB_TestResult_Time_Verification ).Value = Nil
		  rs.Field( kDB_TestResult_Time_TearDown ).Value = Nil
		  rs.Update
		  mydb.Commit
		  
		  
		  // And finally, run the test.
		  
		  Dim t As DurationKFS
		  Dim e() As UnitTestExceptionKFS
		  Dim e_term As RuntimeException
		  
		  // Lock the test class itself:
		  tc.Lock.Enter
		  Dim unlock As New AutoreleaseStubKFS( AddressOf tc.Lock.Leave )
		  
		  // Clear the status data structures in the test class:
		  Call GatherExceptionsFromTestClass( tc )
		  
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringSetup ) = 0 Then
		    
		    // Execute the test case setup method:
		    
		    rs.Edit
		    rs.Field( kDB_TestResult_Status_Setup ).IntegerValue = Integer( StatusCodes.Delegated )
		    rs.Update
		    mydb.Commit
		    t = DurationKFS.NewStopwatchStartingNow
		    Try
		      tc.InvokeTestCaseSetup case_name
		    Catch err As RuntimeException
		      e_term = err
		    End Try
		    t.Stop
		    e = GatherExceptionsFromTestClass( tc, e_term )
		    e_term = Nil
		    CommitExceptions e, StageCodes.Setup, rslt_id
		    rs.Edit
		    If UBound( e ) < 0 Then
		      rs.Field( kDB_TestResult_Status_Setup ).IntegerValue = Integer( StatusCodes.Passed )
		    Else
		      rs.Field( kDB_TestResult_Status_Setup ).IntegerValue = Integer( StatusCodes.Failed )
		    End If
		    rs.Field( kDB_TestResult_Time_Setup ).Int64Value = t.MicrosecondsValue
		    rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		    rs.Update
		    mydb.Commit
		    
		  End If
		  
		  If UBound( e ) < 0 And Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseWithoutFixture ) = 0 Then
		    
		    // Execute the test case core method:
		    
		    rs.Edit
		    rs.Field( kDB_TestResult_Status_Core ).IntegerValue = Integer( StatusCodes.Delegated )
		    rs.Update
		    mydb.Commit
		    t = DurationKFS.NewStopwatchStartingNow
		    Try
		      tm.Invoke tc
		    Catch err As RuntimeException
		      e_term = err
		    End Try
		    t.Stop
		    e = GatherExceptionsFromTestClass( tc, e_term )
		    e_term = Nil
		    CommitExceptions e, StageCodes.Core, rslt_id
		    rs.Edit
		    If UBound( e ) < 0 Then
		      rs.Field( kDB_TestResult_Status_Core ).IntegerValue = Integer( StatusCodes.Passed )
		    Else
		      rs.Field( kDB_TestResult_Status_Core ).IntegerValue = Integer( StatusCodes.Failed )
		    End If
		    rs.Field( kDB_TestResult_Time_Core ).Int64Value = t.MicrosecondsValue
		    rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		    rs.Update
		    mydb.Commit
		    
		    If UBound( e ) < 0 And Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringVerification ) = 0 Then
		      
		      // Execute the test case verification method:
		      
		      rs.Edit
		      rs.Field( kDB_TestResult_Status_Verification ).IntegerValue = Integer( StatusCodes.Delegated )
		      rs.Update
		      mydb.Commit
		      t = DurationKFS.NewStopwatchStartingNow
		      Try
		        tc.InvokeTestCaseVerification case_name
		      Catch err As RuntimeException
		        e_term = err
		      End Try
		      t.Stop
		      e = GatherExceptionsFromTestClass( tc, e_term )
		      e_term = Nil
		      CommitExceptions e, StageCodes.Core, rslt_id
		      rs.Edit
		      If UBound( e ) < 0 Then
		        rs.Field( kDB_TestResult_Status_Verification ).IntegerValue = Integer( StatusCodes.Passed )
		      Else
		        rs.Field( kDB_TestResult_Status_Verification ).IntegerValue = Integer( StatusCodes.Failed )
		      End If
		      rs.Field( kDB_TestResult_Time_Verification ).Int64Value = t.MicrosecondsValue
		      rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		      rs.Update
		      mydb.Commit
		      
		    End If
		  End If
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringTearDown ) = 0 Then
		    
		    // Execute the test case tear down method:
		    
		    rs.Edit
		    rs.Field( kDB_TestResult_Status_TearDown ).IntegerValue = Integer( StatusCodes.Delegated )
		    rs.Update
		    mydb.Commit
		    t = DurationKFS.NewStopwatchStartingNow
		    Try
		      tc.InvokeTestCaseTearDown case_name
		    Catch err As RuntimeException
		      e_term = err
		    End Try
		    t.Stop
		    e = GatherExceptionsFromTestClass( tc, e_term )
		    e_term = Nil
		    CommitExceptions e, StageCodes.TearDown, rslt_id
		    rs.Edit
		    If UBound( e ) < 0 Then
		      rs.Field( kDB_TestResult_Status_TearDown ).IntegerValue = Integer( StatusCodes.Passed )
		    Else
		      rs.Field( kDB_TestResult_Status_TearDown ).IntegerValue = Integer( StatusCodes.Failed )
		    End If
		    rs.Field( kDB_TestResult_Time_TearDown ).Int64Value = t.MicrosecondsValue
		    rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		    rs.Update
		    mydb.Commit
		    
		  End If
		  
		  // Release the lock on the test class:
		  unlock = Nil
		  
		  
		  // Update the staus field of the result record:
		  
		  rs.Edit
		  If UBound( e ) < 0 Then
		    rs.Field( kDB_TestResult_Status ).IntegerValue = Integer( StatusCodes.Passed )
		  Else
		    rs.Field( kDB_TestResult_Status ).IntegerValue = Integer( StatusCodes.Failed )
		  End If
		  rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		  rs.Update
		  mydb.Commit
		  
		  
		  // Run the DataAvailable hook.
		  
		  RunDataAvailableHook
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountDependenciesOfTestCase(case_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of cases that depend on the given case.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCaseDependency_CaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_RequiresCaseID+" = "+Str(case_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountDependenciesOfTestCaseWithStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of cases that depend on the given case and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCaseDependency_CaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_RequiresCaseID+" = "+Str(case_id) _
		  +" AND "+kDB_TestCaseDependency_CaseID+" IN ( "+pq_CasesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountExceptions() As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of exceptions currently logged.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( "+pq_Exceptions+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountExceptionsForCase(case_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of exceptions currently logged for the given test case.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( "+pq_ExceptionsForCase(case_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountExceptionsForCaseDuringStage(case_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of exceptions currently logged for the given test case during the given stage.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( "+pq_ExceptionsForCaseDuringStage(case_id,stage)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountExceptionsForClass(class_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of exceptions currently logged for the given test class.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( "+pq_ExceptionsForClass(class_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountExceptionsForResult(result_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of exceptions currently logged for the given test result.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( "+pq_ExceptionsForResult(result_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountExceptionsForResultDuringStage(result_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of exceptions currently logged for the given test result during the given stage.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( "+pq_ExceptionsForResultDuringStage(result_id,stage)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountPrerequisitesOfTestCase(case_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of cases that are required for the given case to run.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_CaseID+" = "+Str(case_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountPrerequisitesOfTestCaseWithStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of cases that are required for the given case to run and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_CaseID+" = "+Str(case_id) _
		  +" AND "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+pq_CasesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountStagesOfTestCase(case_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of stage codes applicable to the given test case.
		  
		  // Figure out what kind of test case this is:
		  
		  Dim case_type As TestCaseTypes
		  q_GetTestCaseInfo case_id, case_type
		  
		  
		  // Build the result:
		  
		  Dim result As Integer = 0
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringSetup ) = 0 Then _
		  result = result + 1
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseWithoutFixture ) = 0 Then _
		  result = result + 1
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringVerification ) = 0 Then _
		  result = result + 1
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringTearDown ) = 0 Then _
		  result = result + 1
		  
		  
		  // Return the result:
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountStagesOfTestResult(result_id As Int64) As Integer
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the number of stage codes applicable to the given test result.
		  
		  // Figure out what kind of test case this is:
		  
		  Dim case_type As TestCaseTypes
		  q_GetTestResultInfo result_id, case_type
		  
		  
		  // Build the result:
		  
		  Dim result As Integer = 0
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringSetup ) = 0 Then _
		  result = result + 1
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseWithoutFixture ) = 0 Then _
		  result = result + 1
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringVerification ) = 0 Then _
		  result = result + 1
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringTearDown ) = 0 Then _
		  result = result + 1
		  
		  
		  // Return the result:
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCases() As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded in this arbiter.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesInClass(class_id As Int64) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded
		  // in this arbiter that are members of the given class.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesInClassWithStatus(class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded in this arbiter
		  // that are members of the given class and conform to the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesOfType(type As UnitTestArbiterKFS.TestCaseTypes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded
		  // in this arbiter that conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesOfTypeInClass(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded in this arbiter that
		  // are members of the given class and conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesOfTypeInClassWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded in this arbiter that are members
		  // of the given class, conform to the given test type, and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" )" _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesOfTypeWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded in this arbiter
		  // that conform to the given test type and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" )" _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestCasesWithStatus(status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently
		  // loaded in this arbiter that have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestClasses() As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test classes currently loaded in this arbiter.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestClass_ID _
		  +" FROM "+kDB_TestClasses+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestClassesWithStatus(status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test classes currently
		  // loaded in this arbiter that have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestClass_ID _
		  +" FROM "+kDB_TestClasses _
		  +" WHERE "+kDB_TestClass_ID+" IN ( "+pq_ClassesWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResults() As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently loaded in this arbiter.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsInCase(case_id As Int64) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently loaded
		  // in this arbiter that are members of the given test case.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsInCaseWithStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the
		  // given test case and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsInClass(class_id As Int64) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the given class.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id)+" )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsInClassWithStatus(class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the
		  // given class and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsOfType(type As UnitTestArbiterKFS.TestCaseTypes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsOfTypeInCase(type As UnitTestArbiterKFS.TestCaseTypes, case_id As Int64) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the given
		  // test case and conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsOfTypeInCaseWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the given test case,
		  // conform to the given test type, and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsOfTypeInClass(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the
		  // given class and conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsOfTypeInClassWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that are members of the given class,
		  // conform to the given test type, and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsOfTypeWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that conform to the given
		  // test type and have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_CountTestResultsWithStatus(status As UnitTestArbiterKFS.StatusCodes) As Integer
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns the number of test results currently
		  // loaded in this arbiter that have the given status.
		  
		  Dim sql As String _
		  = "SELECT count( * ) FROM ( SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" ) )"
		  
		  
		  // Get and return the result:
		  
		  Return dbsel( sql ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetElapsedTime() As DurationKFS
		  // Created 2/10/2011 by Andrew Keller
		  
		  // Returns the total elapsed time for all test results on record.
		  
		  Dim sql As String = "SELECT sum( "+kDB_TestResult_Time_Setup+" ), sum( "+kDB_TestResult_Time_Core+" ), sum( "+kDB_TestResult_Time_TearDown+" )" _
		  +" FROM "+kDB_TestResults
		  
		  
		  // Get the RecordSet:
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  // Get and return the result:
		  
		  Return DurationKFS.NewFromMicroseconds( rs.IdxField( 1 ).Int64Value + rs.IdxField( 2 ).Int64Value + rs.IdxField( 3 ).Int64Value )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetElapsedTimeForCase(case_id As Int64) As DurationKFS
		  // Created 2/10/2011 by Andrew Keller
		  
		  // Returns the total elapsed time for all test results on record for the given test case.
		  
		  Dim sql As String = "SELECT sum( "+kDB_TestResult_Time_Setup+" ), sum( "+kDB_TestResult_Time_Core+" ), sum( "+kDB_TestResult_Time_TearDown+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_CaseID+" = "+Str(case_id)
		  
		  
		  // Get the RecordSet:
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  // Get and return the result:
		  
		  Return DurationKFS.NewFromMicroseconds( rs.IdxField( 1 ).Int64Value + rs.IdxField( 2 ).Int64Value + rs.IdxField( 3 ).Int64Value )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetElapsedTimeForCaseDuringStage(case_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As DurationKFS
		  // Created 2/10/2011 by Andrew Keller
		  
		  // Returns the <stage> elapsed time for all test results on record for the given test case.
		  
		  Dim field As String
		  Select Case stage
		  Case StageCodes.Setup
		    field = kDB_TestResult_Time_Setup
		    
		  Case StageCodes.Core
		    field = kDB_TestResult_Time_Core
		    
		  Case StageCodes.TearDown
		    field = kDB_TestResult_Time_TearDown
		    
		  Else
		    Return New DurationKFS
		  End Select
		  
		  Dim sql As String = "SELECT sum( "+field+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_CaseID+" = "+Str(case_id)
		  
		  
		  // Get the RecordSet:
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  // Get and return the result:
		  
		  Return DurationKFS.NewFromMicroseconds( rs.IdxField( 1 ).Int64Value )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetElapsedTimeForClass(class_id As Int64) As DurationKFS
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the total elapsed time for all test results on record for the given test class.
		  
		  Dim sql As String = "SELECT sum( "+kDB_TestResults+"."+kDB_TestResult_Time_Setup+" ), sum( "+kDB_TestResults+"."+kDB_TestResult_Time_Core+" ), sum( "+kDB_TestResults+"."+kDB_TestResult_Time_TearDown+" )" _
		  +" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  +" WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id)
		  
		  
		  // Get the RecordSet:
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  // Get and return the result:
		  
		  Return DurationKFS.NewFromMicroseconds( rs.IdxField( 1 ).Int64Value + rs.IdxField( 2 ).Int64Value + rs.IdxField( 3 ).Int64Value )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetElapsedTimeForResult(result_id As Int64) As DurationKFS
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the total elapsed time for the given result record.
		  
		  Dim sql As String = "SELECT sum( "+kDB_TestResult_Time_Setup+" ), sum( "+kDB_TestResult_Time_Core+" ), sum( "+kDB_TestResult_Time_TearDown+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  
		  // Get the RecordSet:
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  // Get and return the result:
		  
		  Return DurationKFS.NewFromMicroseconds( rs.IdxField( 1 ).Int64Value + rs.IdxField( 2 ).Int64Value + rs.IdxField( 3 ).Int64Value )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetElapsedTimeForResultDuringStage(result_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As DurationKFS
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the <stage> elapsed time for the given test result record.
		  
		  Dim field As String
		  Select Case stage
		  Case StageCodes.Setup
		    field = kDB_TestResult_Time_Setup
		    
		  Case StageCodes.Core
		    field = kDB_TestResult_Time_Core
		    
		  Case StageCodes.TearDown
		    field = kDB_TestResult_Time_TearDown
		    
		  Else
		    Return New DurationKFS
		  End Select
		  
		  Dim sql As String = "SELECT sum( "+field+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  
		  // Get the RecordSet:
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  // Get and return the result:
		  
		  Return DurationKFS.NewFromMicroseconds( rs.IdxField( 1 ).Int64Value )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetPlaintextHeading() As String
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Returns a simple heading describing the results of the current tests.
		  
		  Return "Unit test results: " + q_GetStatusBlurb + "."
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetPlaintextReport() As String
		  // Created 2/10/2011 by Andrew Keller
		  
		  // Generates a quick summary of the test results.
		  
		  Dim caseLabels() As String
		  Dim caseExceptionSummaries() As String
		  
		  q_ListExceptionSummaries( caseLabels, caseExceptionSummaries, True )
		  
		  Return Trim( q_GetPlaintextHeading + EndOfLineKFS + EndOfLineKFS + q_GetPlaintextReportBodyForExceptionSummaries( caseLabels, caseExceptionSummaries ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetPlaintextReportBodyForExceptionSummaries(caseLabels() As String, caseExceptionSummaries() As String) As String
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Generates a single string containing all of the given exception sumaries.
		  
		  If UBound( caseLabels ) <> UBound( caseExceptionSummaries ) Then
		    
		    Dim e As New OutOfBoundsException
		    e.Message = "The "+CurrentMethodName+" function received arrays of unequal size ( "+Str(UBound(caseLabels))+" and "+Str(UBound(caseExceptionSummaries))+" )"
		    Raise e
		    
		  End If
		  
		  Dim previousLabel As String = ""
		  Dim buffer As New BinaryStream( New MemoryBlock( 0 ) )
		  
		  Dim row, last As Integer
		  last = UBound( caseLabels )
		  
		  For row = 0 To last
		    
		    If previousLabel <> caseLabels( row ) Then
		      
		      buffer.Write caseLabels( row ) + EndOfLineKFS + EndOfLineKFS
		      
		      previousLabel = caseLabels( row )
		      
		    End If
		    
		    buffer.Write caseExceptionSummaries( row )
		    
		    If row < last Then buffer.Write EndOfLineKFS + EndOfLineKFS
		    
		  Next
		  
		  buffer.Position = 0
		  
		  Return buffer.Read( buffer.Length )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurb() As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a blurb describing the status of all tests.
		  
		  Return FormatStatusBlurb( _
		  q_CountTestCases, _
		  q_CountTestCasesWithStatus( StatusCodes.Failed ), _
		  q_CountTestCasesWithStatus( StatusCodes.Category_InaccessibleDueToFailedPrerequisites ), _
		  q_CountTestCasesWithStatus( StatusCodes.Category_Incomplete ), _
		  q_GetElapsedTime )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbAndSortCueOfTestCase(case_id As Int64, ByRef sort_cue As Integer) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status blurb and the associated sort cue for the given test case.
		  
		  Dim overallStatus As StatusCodes = q_GetStatusOfTestCase( case_id )
		  
		  If overallStatus = StatusCodes.Created Then
		    
		    If q_GetWhetherTestCaseConformsToStatus( case_id, StatusCodes.Category_InaccessibleDueToFailedPrerequisites ) Then
		      
		      sort_cue = 0
		      Return "Skipped"
		      
		    Else
		      
		      sort_cue = -1
		      Return "Waiting"
		      
		    End If
		    
		  ElseIf overallStatus = StatusCodes.Delegated Then
		    
		    sort_cue = -1
		    Return "Running"
		    
		  ElseIf overallStatus = StatusCodes.Passed Then
		    
		    sort_cue = -1
		    Return "Passed"
		    
		  ElseIf overallStatus = StatusCodes.Failed Then
		    
		    sort_cue = q_CountExceptionsForCase( case_id )
		    
		    If q_GetStatusOfTestCaseDuringStage( case_id, StageCodes.Setup ) = StatusCodes.Failed Then
		      
		      Return "Setup Failed"
		      
		    ElseIf q_GetStatusOfTestCaseDuringStage( case_id, StageCodes.TearDown ) = StatusCodes.Failed Then
		      
		      Return "Tear Down Failed"
		      
		    Else
		      
		      Return "Failed"
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbAndSortCueOfTestCaseDuringStage(case_id As Int64, stage As UnitTestArbiterKFS.StageCodes, ByRef sort_cue As Integer) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status blurb and the associated sort cue for the given test case stage.
		  
		  Dim status As StatusCodes = q_GetStatusOfTestCaseDuringStage( case_id, stage )
		  
		  If status = StatusCodes.Null Then
		    
		    sort_cue = 0
		    Return "Null"
		    
		  ElseIf status = StatusCodes.Created Then
		    
		    If q_GetWhetherTestCaseConformsToStatusDuringStage( case_id, StatusCodes.Category_InaccessibleDueToFailedPrerequisites, stage ) Then
		      
		      sort_cue = 0
		      Return "Skipped"
		      
		    Else
		      
		      sort_cue = -1
		      Return "Waiting"
		      
		    End If
		    
		  ElseIf status = StatusCodes.Delegated Then
		    
		    sort_cue = -1
		    Return "Running"
		    
		  ElseIf status = StatusCodes.Passed Then
		    
		    sort_cue = -1
		    Return "Passed"
		    
		  ElseIf status = StatusCodes.Failed Then
		    
		    sort_cue = q_CountExceptionsForCaseDuringStage( case_id, stage )
		    Return "Failed"
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbAndSortCueOfTestClass(class_id As Int64, ByRef sort_cue As Integer) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status blurb and the associated sort cue for the given test class.
		  
		  Dim totalCount As Integer = q_CountTestCasesInClass( class_id )
		  Dim failedCount As Integer = q_CountTestCasesInClassWithStatus( class_id, StatusCodes.Failed )
		  Dim skippedCount As Integer = q_CountTestCasesInClassWithStatus( class_id, StatusCodes.Category_InaccessibleDueToFailedPrerequisites )
		  Dim remainingCount As Integer = q_CountTestCasesInClassWithStatus( class_id, StatusCodes.Category_Incomplete )
		  
		  sort_cue = 2 * failedCount + skippedCount
		  
		  Return FormatStatusBlurb( _
		  totalCount, _
		  failedCount, _
		  skippedCount, _
		  remainingCount )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbAndSortCueOfTestResult(result_id As Int64, ByRef sort_cue As Integer) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status blurb and the associated sort cue for the given test result.
		  
		  Dim overallStatus As StatusCodes = q_GetStatusOfTestResult( result_id )
		  
		  If overallStatus = StatusCodes.Created Then
		    
		    If q_GetWhetherTestResultConformsToStatus( result_id, StatusCodes.Category_InaccessibleDueToFailedPrerequisites ) Then
		      
		      sort_cue = 0
		      Return "Skipped"
		      
		    Else
		      
		      sort_cue = -1
		      Return "Waiting"
		      
		    End If
		    
		  ElseIf overallStatus = StatusCodes.Delegated Then
		    
		    sort_cue = -1
		    Return "Running"
		    
		  ElseIf overallStatus = StatusCodes.Passed Then
		    
		    sort_cue = -1
		    Return "Passed"
		    
		  ElseIf overallStatus = StatusCodes.Failed Then
		    
		    sort_cue = q_CountExceptionsForResult( result_id )
		    
		    If q_GetStatusOfTestResultDuringStage( result_id, StageCodes.Setup ) = StatusCodes.Failed Then
		      
		      Return "Setup Failed"
		      
		    ElseIf q_GetStatusOfTestResultDuringStage( result_id, StageCodes.TearDown ) = StatusCodes.Failed Then
		      
		      Return "Tear Down Failed"
		      
		    Else
		      
		      Return "Failed"
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbAndSortCueOfTestResultDuringStage(result_id As Int64, stage As UnitTestArbiterKFS.StageCodes, ByRef sort_cue As Integer) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status blurb and the associated sort cue for the given test result stage.
		  
		  Dim status As StatusCodes = q_GetStatusOfTestResultDuringStage( result_id, stage )
		  
		  If status = StatusCodes.Null Then
		    
		    sort_cue = 0
		    Return "Null"
		    
		  ElseIf status = StatusCodes.Created Then
		    
		    If q_GetWhetherTestResultConformsToStatusDuringStage( result_id, StatusCodes.Category_InaccessibleDueToFailedPrerequisites, stage ) Then
		      
		      sort_cue = 0
		      Return "Skipped"
		      
		    Else
		      
		      sort_cue = -1
		      Return "Waiting"
		      
		    End If
		    
		  ElseIf status = StatusCodes.Delegated Then
		    
		    sort_cue = -1
		    Return "Running"
		    
		  ElseIf status = StatusCodes.Passed Then
		    
		    sort_cue = -1
		    Return "Passed"
		    
		  ElseIf status = StatusCodes.Failed Then
		    
		    sort_cue = q_CountExceptionsForResultDuringStage( result_id, stage )
		    Return "Failed"
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbOfTestCase(case_id As Int64) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A simpler version of the q_GetStatusBlurbAndSortCueOfTestCase function.
		  
		  Dim sort_cue As Integer
		  Return q_GetStatusBlurbAndSortCueOfTestCase( case_id, sort_cue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbOfTestCaseDuringStage(case_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A simpler version of the q_GetStatusBlurbAndSortCueOfTestCaseDuringStage function.
		  
		  Dim sort_cue As Integer
		  Return q_GetStatusBlurbAndSortCueOfTestCaseDuringStage( case_id, stage, sort_cue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbOfTestClass(class_id As Int64) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A simpler version of the q_GetStatusBlurbAndSortCueOfTestClass function.
		  
		  Dim sort_cue As Integer
		  Return q_GetStatusBlurbAndSortCueOfTestClass( class_id, sort_cue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbOfTestResult(result_id As Int64) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A simpler version of the q_GetStatusBlurbAndSortCueOfTestResult function.
		  
		  Dim sort_cue As Integer
		  Return q_GetStatusBlurbAndSortCueOfTestResult( result_id, sort_cue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusBlurbOfTestResultDuringStage(result_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As String
		  // Created 2/12/2011 by Andrew Keller
		  
		  // A simpler version of the q_GetStatusBlurbAndSortCueOfTestResultDuringStage function.
		  
		  Dim sort_cue As Integer
		  Return q_GetStatusBlurbAndSortCueOfTestResultDuringStage( result_id, stage, sort_cue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusOfTestCase(case_id As Int64) As UnitTestArbiterKFS.StatusCodes
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status of the given test case.
		  
		  Dim sql As String _
		  = "SELECT max("+kDB_TestResult_Status+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_CaseID+" = "+Str(case_id)
		  
		  
		  // Get and return the result:
		  
		  Return StatusCodes( dbsel( sql ).IdxField( 1 ).IntegerValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusOfTestCaseDuringStage(case_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As UnitTestArbiterKFS.StatusCodes
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status of the given test case during the given stage.
		  
		  // Convert the stage code into a field name:
		  
		  Dim f As String
		  Select Case stage
		  Case StageCodes.Setup
		    f = kDB_TestResult_Status_Setup
		    
		  Case StageCodes.Core
		    f = kDB_TestResult_Status_Core
		    
		  Case StageCodes.Verification
		    f = kDB_TestResult_Status_Verification
		    
		  Case StageCodes.TearDown
		    f = kDB_TestResult_Status_TearDown
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "The "+CurrentMethodName+" function does not support a stage code of "+Str(Integer(stage))
		    Raise e
		  End Select
		  
		  Dim sql As String _
		  = "SELECT max( "+f+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_CaseID+" = "+Str(case_id)
		  
		  
		  // Get and return the result:
		  
		  Return StatusCodes( dbsel( sql ).IdxField( 1 ).IntegerValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusOfTestClass(class_id As Int64) As UnitTestArbiterKFS.StatusCodes
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status of the given test class.
		  
		  Dim sql As String _
		  = "SELECT max( "+kDB_TestResults+"."+kDB_TestResult_Status+" )" _
		  +" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  +" WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id)
		  
		  
		  // Get and return the result:
		  
		  Return StatusCodes( dbsel( sql ).IdxField( 1 ).IntegerValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusOfTestResult(result_id As Int64) As UnitTestArbiterKFS.StatusCodes
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status of the given test result.
		  
		  Dim sql As String _
		  = "SELECT max( "+kDB_TestResult_Status+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  
		  // Get and return the result:
		  
		  Return StatusCodes( dbsel( sql ).IdxField( 1 ).IntegerValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetStatusOfTestResultDuringStage(result_id As Int64, stage As UnitTestArbiterKFS.StageCodes) As UnitTestArbiterKFS.StatusCodes
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the status of the given test result during the given stage.
		  
		  // Convert the stage code into a field name:
		  
		  Dim f As String
		  Select Case stage
		  Case StageCodes.Setup
		    f = kDB_TestResult_Status_Setup
		    
		  Case StageCodes.Core
		    f = kDB_TestResult_Status_Core
		    
		  Case StageCodes.Verification
		    f = kDB_TestResult_Status_Verification
		    
		  Case StageCodes.TearDown
		    f = kDB_TestResult_Status_TearDown
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "The "+CurrentMethodName+" function does not support a stage code of "+Str(Integer(stage))
		    Raise e
		  End Select
		  
		  Dim sql As String _
		  = "SELECT max( "+f+" )" _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  
		  // Get and return the result:
		  
		  Return StatusCodes( dbsel( sql ).IdxField( 1 ).IntegerValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_GetTestCaseInfo(case_id As Int64, ByRef case_name As String)
		  // Created 2/6/2011 by Andrew Keller
		  
		  // Returns the various attributes of the given result through the other given parameters.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestCase_Name _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" = "+Str(case_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no test case record with ID "+Str(case_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple test case records with ID "+Str(case_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Copy the found data to the parameters.
		  
		  case_name = rs.Field( kDB_TestCase_Name ).StringValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_GetTestCaseInfo(case_id As Int64, ByRef case_name As String, ByRef class_id As Int64, ByRef class_name As String, ByRef status As StatusCodes, ByRef total_setup_t As DurationKFS, ByRef total_core_t As DurationKFS, ByRef total_teardown_t As DurationKFS)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the various attributes of the given test case through the other given parameters.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestCases+"."+kDB_TestCase_ClassID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name, sum( "+kDB_TestResults+"."+kDB_TestResult_Time_Setup+" ) AS setup_t, sum( "+kDB_TestResults+"."+kDB_TestResult_Time_Core+" ) AS core_t, sum( "+kDB_TestResults+"."+kDB_TestResult_Time_TearDown+" ) AS teardown_t" _
		  +" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID+" LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID+"" _
		  +" WHERE "+kDB_TestCases+"."+kDB_TestCase_ID+" = "+Str(case_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no test case record with ID "+Str(case_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple test case records with ID "+Str(case_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Copy the found data to the parameters.
		  
		  case_name = rs.Field( "case_name" ).StringValue
		  
		  class_id = rs.Field( "class_id" ).Int64Value
		  
		  class_name = rs.Field( "class_name" ).StringValue
		  
		  status = q_GetStatusOfTestCase( case_id )
		  
		  total_setup_t = DurationKFS.NewFromMicroseconds( rs.Field( "setup_t" ).Int64Value )
		  
		  total_core_t = DurationKFS.NewFromMicroseconds( rs.Field( "core_t" ).Int64Value )
		  
		  total_teardown_t = DurationKFS.NewFromMicroseconds( rs.Field( "teardown_t" ).Int64Value )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_GetTestCaseInfo(case_id As Int64, ByRef case_type As UnitTestArbiterKFS.TestCaseTypes)
		  // Created 2/6/2011 by Andrew Keller
		  
		  // Returns the various attributes of the given test case through the other given parameters.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestCase_TestType _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" = "+Str(case_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no test case record with ID "+Str(case_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple test case records with ID "+Str(case_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Copy the found data to the parameters.
		  
		  case_type = TestCaseTypes( rs.Field( kDB_TestCase_TestType ).IntegerValue )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_GetTestClassInfo(class_id As Int64, ByRef class_name As String)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the various attributes of the given test class through the other given parameters.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestClass_Name _
		  +" FROM "+kDB_TestClasses _
		  +" WHERE "+kDB_TestClass_ID+" = "+Str(class_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no test class record with ID "+Str(class_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple test class records with ID "+Str(class_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Copy the found data to the parameters.
		  
		  class_name = rs.Field( kDB_TestClass_Name ).StringValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_GetTestResultInfo(rslt_id As Int64, ByRef tc_id As Int64, ByRef tc_name As String, ByRef tm_id As Int64, ByRef tm_name As String, ByRef status As StatusCodes, ByRef setup_t As DurationKFS, ByRef core_t As DurationKFS, ByRef teardown_t As DurationKFS)
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns the various attributes of the given result through the other given parameters.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestResults+"."+kDB_TestResult_ID+" AS rslt_id, "+kDB_TestCases+"."+kDB_TestCase_ClassID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name, "+kDB_TestResults+"."+kDB_TestResult_CaseID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestResults+"."+kDB_TestResult_Status+" AS rslt_status, "+kDB_TestResult_Time_Setup+", "+kDB_TestResult_Time_Core+", "+kDB_TestResult_Time_TearDown _
		  +" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID+" LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID+"" _
		  +" WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" = "+Str(rslt_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no result record with ID "+Str(rslt_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple result records with ID "+Str(rslt_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Copy the found data to the parameters.
		  
		  tc_id = rs.Field( "class_id" ).Int64Value
		  
		  tc_name = rs.Field( "class_name" ).StringValue
		  
		  tm_id = rs.Field( "case_id" ).Int64Value
		  
		  tm_name = rs.Field( "case_name" ).StringValue
		  
		  status = StatusCodes( rs.Field( "rslt_status" ).IntegerValue )
		  
		  If rs.Field( kDB_TestResult_Time_Setup ).Value.IsNull Then
		    setup_t = Nil
		  Else
		    setup_t = DurationKFS.NewFromMicroseconds( rs.Field( kDB_TestResult_Time_Setup ).Int64Value )
		  End If
		  
		  If rs.Field( kDB_TestResult_Time_Core ).Value.IsNull Then
		    core_t = Nil
		  Else
		    core_t = DurationKFS.NewFromMicroseconds( rs.Field( kDB_TestResult_Time_Core ).Int64Value )
		  End If
		  
		  If rs.Field( kDB_TestResult_Time_TearDown ).Value.IsNull Then
		    teardown_t = Nil
		  Else
		    teardown_t = DurationKFS.NewFromMicroseconds( rs.Field( kDB_TestResult_Time_TearDown ).Int64Value )
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_GetTestResultInfo(result_id As Int64, ByRef case_type As UnitTestArbiterKFS.TestCaseTypes)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns the various attributes of the given result through the other given parameters.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestCases+"."+kDB_TestCase_TestType _
		  +" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  +" WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no result record with ID "+Str(result_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple result records with ID "+Str(result_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Copy the found data to the parameters.
		  
		  case_type = TestCaseTypes( rs.Field( kDB_TestCase_TestType ).IntegerValue )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetWhetherTestCaseConformsToStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Boolean
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns whether or not the given test case conforms to the given status.
		  
		  // Grab the result records for this test case.
		  
		  Dim sql As String _
		  = "SELECT max( "+kDB_TestResult_Status+" ) AS "+kDB_TestResult_Status _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  +" GROUP BY "+kDB_TestResult_CaseID
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  
		  // Check for every possible status that the user could request.
		  
		  Dim ss As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status ).IntegerValue )
		  
		  If status = StatusCodes.Category_Incomplete Then
		    
		    // For a stage to be incomplete, none of the results
		    // can have reached a status of passed or failed.
		    
		    Return ss <> StatusCodes.Passed And ss <> StatusCodes.Failed
		    
		  ElseIf status = StatusCodes.Category_Inaccessible _
		    Or status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites _
		    Or status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    // All of these cases deal with the status of the prerequisites,
		    // and not the status of this test case.
		    
		    // For a test case to be generally inaccessible, a prerequisite
		    // must not be satisfied.
		    
		    // For a test case to be inaccessible due to failed prerequisites, an
		    // immediate prerequisite must be marked as failed.
		    
		    // For a test case to be inaccessible due to missing prerequisites, an
		    // immediate prerequisite must not be marked as passed or failed.
		    
		    // For analyzing the dependencies of test cases,
		    // the individual stages are not examined.
		    
		    // Count the number of prerequisites that have the given status.
		    
		    Return dbsel( "SELECT count( "+kDB_TestCaseDependency_RequiresCaseID+" )" _
		    +" FROM "+kDB_TestCaseDependencies _
		    +" WHERE "+kDB_TestCaseDependency_CaseID+" = "+Str(case_id) _
		    +" AND "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+pq_CasesThatCauseInaccessibilityOfType( status )+" )" _
		    ).IdxField(1).IntegerValue > 0
		    
		  Else
		    
		    // All the other stages directly translate.  No interpretation.
		    
		    Return ss = status
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetWhetherTestCaseConformsToStatusDuringStage(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes, stage As UnitTestArbiterKFS.StageCodes) As Boolean
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns whether or not the given test case conforms to the given status during the given stage.
		  
		  // Grab the result records for this test case.
		  
		  Dim sql As String _
		  = "SELECT max( "+kDB_TestResult_Status+" ) AS "+kDB_TestResult_Status+", max( "+kDB_TestResult_Status_Setup+" ) AS "+kDB_TestResult_Status_Setup+", max( "+kDB_TestResult_Status_Core+" ) AS "+kDB_TestResult_Status_Core+", max( "+kDB_TestResult_Status_Verification+" ) AS "+kDB_TestResult_Status_Verification+", max( "+kDB_TestResult_Status_TearDown+" ) AS "+kDB_TestResult_Status_TearDown _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  +" GROUP BY "+kDB_TestResult_CaseID
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  
		  // Convert the given stage into a field name.
		  
		  Dim sf As String
		  Select Case stage
		    
		  Case StageCodes.Setup
		    sf = kDB_TestResult_Status_Setup
		    
		  Case StageCodes.Core
		    sf = kDB_TestResult_Status_Core
		    
		  Case StageCodes.Verification
		    sf = kDB_TestResult_Status_TearDown
		    
		  Case StageCodes.TearDown
		    sf = kDB_TestResult_Status_TearDown
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "Unsupported stage: " + Str(Integer(stage))
		    Raise e
		  End Select
		  
		  
		  // Check for every possible status that the user could request.
		  
		  Dim ss As StatusCodes = StatusCodes( rs.Field( sf ).IntegerValue )
		  
		  If status = StatusCodes.Category_Incomplete Then
		    
		    // For a stage to be incomplete, none of the results
		    // can have reached a status of passed or failed.
		    
		    Return ss <> StatusCodes.Passed And ss <> StatusCodes.Failed
		    
		  ElseIf status = StatusCodes.Category_Inaccessible Then
		    
		    // For a stage to be generally inaccessible, a prerequisite
		    // must not be satisfied.  Doesn't matter if it's missing or failed.
		    
		    Dim ss_s As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Setup ).IntegerValue )
		    Dim ss_c As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Core ).IntegerValue )
		    Dim ss_v As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Verification ).IntegerValue )
		    
		    If stage = StageCodes.Setup Then
		      
		      Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      
		    ElseIf stage = StageCodes.Core Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed
		      End If
		      
		    ElseIf stage = StageCodes.Verification Then
		      
		      If ss_c = StatusCodes.Null Then
		        If ss_s = StatusCodes.Null Then
		          Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		        Else
		          Return ss_s <> StatusCodes.Passed
		        End If
		      Else
		        Return ss_c <> StatusCodes.Passed
		      End If
		      
		    ElseIf stage = StageCodes.TearDown Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed
		      End If
		      
		    End If
		    
		  ElseIf status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    // For a stage to be inaccessible due to failed prerequisites, an
		    // immediate prerequisite must be marked as failed.  Although
		    // it may be easy to explore transitive relations for just the
		    // stages here, doing so would cause a different behavior than
		    // how test case prerequisites are calculated.
		    
		    Dim ss_s As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Setup ).IntegerValue )
		    Dim ss_c As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Core ).IntegerValue )
		    Dim ss_v As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Verification ).IntegerValue )
		    
		    If stage = StageCodes.Setup Then
		      
		      Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      
		    ElseIf stage = StageCodes.Core Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      Else
		        Return ss_s = StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.Verification Then
		      
		      If ss_c = StatusCodes.Null Then
		        If ss_s = StatusCodes.Null Then
		          Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		        Else
		          Return ss_s = StatusCodes.Failed
		        End If
		      Else
		        Return ss_c = StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.TearDown Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      Else
		        Return ss_s = StatusCodes.Failed
		      End If
		      
		    End If
		    
		  ElseIf status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites Then
		    
		    // For a stage to be inaccessible due to missing prerequisites, an
		    // immediate prerequisite must not be marked as passed or failed.
		    // Again, although it may be easy to explore transitive relations for
		    // just the stages here, doing so would cause a different behavior
		    // than how test case prerequisites are calculated.
		    
		    Dim ss_s As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Setup ).IntegerValue )
		    Dim ss_c As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Core ).IntegerValue )
		    Dim ss_v As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Verification ).IntegerValue )
		    
		    If stage = StageCodes.Setup Then
		      
		      Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      
		    ElseIf stage = StageCodes.Core Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed And ss_s <> StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.Verification Then
		      
		      If ss_c = StatusCodes.Null Then
		        If ss_s = StatusCodes.Null Then
		          Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		        Else
		          Return ss_s <> StatusCodes.Passed And ss_s <> StatusCodes.Failed
		        End If
		      Else
		        Return ss_c <> StatusCodes.Passed And ss_c <> StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.TearDown Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestCaseConformsToStatus( case_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed And ss_s <> StatusCodes.Failed
		      End If
		      
		    End If
		    
		  Else
		    
		    // All the other stages directly translate.  No interpretation.
		    
		    Return ss = status
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetWhetherTestClassConformsToStatus(class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Boolean
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns whether or not the given class conforms to the given status.
		  
		  // Check for every possible status that the user could request.
		  
		  If status = StatusCodes.Null Then
		    
		    Dim sql As String _
		    = "SELECT count(*)" _
		    + " FROM "+kDB_TestResults _
		    + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		    + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		    + " GROUP BY "+kDB_TestCases+"."+kDB_TestCase_ClassID
		    
		    Return dbsel( sql ).IdxField( 1 ).IntegerValue = 0
		    
		  ElseIf status = StatusCodes.Category_Inaccessible _
		    Or status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites _
		    Or status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    // None of these status codes apply to classes, since dependencies do not support classes yet.
		    
		    Return False
		    
		  ElseIf status = StatusCodes.Category_Incomplete Then
		    
		    // For class to be incomplete, there must be
		    // result records without passed or failed status
		    // codes, or test cases without any result records.
		    
		    Dim sql As String _
		    = "SELECT count(*)" _
		    + " FROM "+kDB_TestCases _
		    + " WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		    + " AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" )"
		    
		    Return dbsel( sql ).IdxField( 1 ).IntegerValue > 0
		    
		  Else
		    
		    Dim sql As String _
		    = "SELECT max( "+kDB_TestResults+"."+kDB_TestResult_Status+" ) AS "+kDB_TestResult_Status _
		    + " FROM "+kDB_TestResults _
		    + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		    + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		    + " GROUP BY "+kDB_TestCases+"."+kDB_TestCase_ClassID
		    
		    Return StatusCodes( dbsel( sql ).IdxField( 1 ).IntegerValue ) = status
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetWhetherTestResultConformsToStatus(result_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Boolean
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns whether or not the given test result conforms to the given status.
		  
		  // Grab the result record.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestResult_Status+", "+kDB_TestResult_CaseID _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no result record with ID "+Str(result_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple result records with ID "+Str(result_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Check for every possible status that the user could request.
		  
		  Dim ss As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status ).IntegerValue )
		  
		  If status = StatusCodes.Category_Incomplete Then
		    
		    // For a test result to be incomplete, it simply must not be
		    // marked as passed or failed.  There are no external constraints.
		    
		    Return ss <> StatusCodes.Passed And ss <> StatusCodes.Failed
		    
		  ElseIf status = StatusCodes.Category_Inaccessible _
		    Or status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites _
		    Or status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites Then
		    
		    // For a test result to be inaccessible, we follow the rules
		    // for cases, regardless of the actual status of this result.
		    
		    Return q_GetWhetherTestCaseConformsToStatus( rs.Field( kDB_TestResult_CaseID ).Int64Value, status )
		    
		  Else
		    
		    // All the other stages directly translate.  No interpretation.
		    
		    Return ss = status
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_GetWhetherTestResultConformsToStatusDuringStage(result_id As Int64, status As UnitTestArbiterKFS.StatusCodes, stage As UnitTestArbiterKFS.StageCodes) As Boolean
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns whether or not the given test result conforms to the given status during the given stage.
		  
		  // Grab the result record.
		  
		  Dim sql As String _
		  = "SELECT "+kDB_TestResult_Status+", "+kDB_TestResult_Status_Setup+", "+kDB_TestResult_Status_Core+", "+kDB_TestResult_Status_Verification+", "+kDB_TestResult_Status_TearDown _
		  +" FROM "+kDB_TestResults _
		  +" WHERE "+kDB_TestResult_ID+" = "+Str(result_id)
		  
		  Dim rs As RecordSet = dbsel( sql )
		  
		  If rs.RecordCount < 1 Then
		    Dim e As RuntimeException
		    e.Message = "There is no result record with ID "+Str(result_id)+"."
		    Raise e
		  ElseIf rs.RecordCount > 1 Then
		    Dim e As RuntimeException
		    e.Message = "There are multiple result records with ID "+Str(result_id)+".  Cannot proceed."
		  End If
		  
		  
		  // Convert the given stage into a field name.
		  
		  Dim sf As String
		  Select Case stage
		    
		  Case StageCodes.Setup
		    sf = kDB_TestResult_Status_Setup
		    
		  Case StageCodes.Core
		    sf = kDB_TestResult_Status_Core
		    
		  Case StageCodes.Verification
		    sf = kDB_TestResult_Status_TearDown
		    
		  Case StageCodes.TearDown
		    sf = kDB_TestResult_Status_TearDown
		    
		  Else
		    Dim e As New UnsupportedFormatException
		    e.Message = "Unsupported stage: " + Str(Integer(stage))
		    Raise e
		  End Select
		  
		  
		  // Check for every possible status that the user could request.
		  
		  Dim ss As StatusCodes = StatusCodes( rs.Field( sf ).IntegerValue )
		  
		  If status = StatusCodes.Category_Incomplete Then
		    
		    // For a stage to be incomplete, it simply must not be
		    // marked as passed or failed.  There are no external constraints.
		    
		    Return ss <> StatusCodes.Passed And ss <> StatusCodes.Failed
		    
		  ElseIf status = StatusCodes.Category_Inaccessible Then
		    
		    // For a stage to be generally inaccessible, a prerequisite
		    // must not be satisfied.  Doesn't matter if it's missing or failed.
		    
		    Dim ss_s As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Setup ).IntegerValue )
		    Dim ss_c As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Core ).IntegerValue )
		    Dim ss_v As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Verification ).IntegerValue )
		    
		    If stage = StageCodes.Setup Then
		      
		      Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      
		    ElseIf stage = StageCodes.Core Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed
		      End If
		      
		    ElseIf stage = StageCodes.Verification Then
		      
		      If ss_c = StatusCodes.Null Then
		        If ss_s = StatusCodes.Null Then
		          Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		        Else
		          Return ss_s <> StatusCodes.Passed
		        End If
		      Else
		        Return ss_c <> StatusCodes.Passed
		      End If
		      
		    ElseIf stage = StageCodes.TearDown Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed
		      End If
		      
		    End If
		    
		  ElseIf status = StatusCodes.Category_InaccessibleDueToFailedPrerequisites Then
		    
		    // For a stage to be inaccessible due to failed prerequisites, an
		    // immediate prerequisite must be marked as failed.  Although
		    // it may be easy to explore transitive relations for just the
		    // stages here, doing so would cause a different behavior than
		    // how test case prerequisites are calculated.
		    
		    Dim ss_s As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Setup ).IntegerValue )
		    Dim ss_c As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Core ).IntegerValue )
		    Dim ss_v As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Verification ).IntegerValue )
		    
		    If stage = StageCodes.Setup Then
		      
		      Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      
		    ElseIf stage = StageCodes.Core Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      Else
		        Return ss_s = StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.Verification Then
		      
		      If ss_c = StatusCodes.Null Then
		        If ss_s = StatusCodes.Null Then
		          Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		        Else
		          Return ss_s = StatusCodes.Failed
		        End If
		      Else
		        Return ss_c = StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.TearDown Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      Else
		        Return ss_s = StatusCodes.Failed
		      End If
		      
		    End If
		    
		  ElseIf status = StatusCodes.Category_InaccessibleDueToMissingPrerequisites Then
		    
		    // For a stage to be inaccessible due to missing prerequisites, an
		    // immediate prerequisite must not be marked as passed or failed.
		    // Again, although it may be easy to explore transitive relations for
		    // just the stages here, doing so would cause a different behavior
		    // than how test case prerequisites are calculated.
		    
		    Dim ss_s As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Setup ).IntegerValue )
		    Dim ss_c As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Core ).IntegerValue )
		    Dim ss_v As StatusCodes = StatusCodes( rs.Field( kDB_TestResult_Status_Verification ).IntegerValue )
		    
		    If stage = StageCodes.Setup Then
		      
		      Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      
		    ElseIf stage = StageCodes.Core Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed And ss_s <> StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.Verification Then
		      
		      If ss_c = StatusCodes.Null Then
		        If ss_s = StatusCodes.Null Then
		          Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		        Else
		          Return ss_s <> StatusCodes.Passed And ss_s <> StatusCodes.Failed
		        End If
		      Else
		        Return ss_c <> StatusCodes.Passed And ss_c <> StatusCodes.Failed
		      End If
		      
		    ElseIf stage = StageCodes.TearDown Then
		      
		      If ss_s = StatusCodes.Null Then
		        Return q_GetWhetherTestResultConformsToStatus( result_id, status )
		      Else
		        Return ss_s <> StatusCodes.Passed And ss_s <> StatusCodes.Failed
		      End If
		      
		    End If
		    
		  Else
		    
		    // All the other stages directly translate.  No interpretation.
		    
		    Return ss = status
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListDependenciesOfTestCase(case_id As Int64) As Int64()
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of the case IDs that depend on the given case.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCaseDependency_CaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_RequiresCaseID+" = "+Str(case_id) _
		  +" ORDER BY "+kDB_TestCaseDependency_CaseID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListDependenciesOfTestCaseWithStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of the case IDs that depend on the given case and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCaseDependency_CaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_RequiresCaseID+" = "+Str(case_id) _
		  +" AND "+kDB_TestCaseDependency_CaseID+" IN ( "+pq_CasesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestCaseDependency_CaseID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_ListExceptionSummaries(ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently logged.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_Exceptions+".*, "+kDB_TestResults+"."+kDB_TestResult_ID+" AS result_id, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name" _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  + " ORDER BY class_id ASC, case_id ASC, result_id ASC, "+kDB_Exceptions+"."+kDB_Exception_StageCode+" ASC, "+kDB_Exceptions+"."+kDB_Exception_Index+" ASC"
		  
		  
		  // Populate the arrays with the result of the query:
		  
		  GetStringArraysFromExceptionsInRecordSet dbsel( sql ), caseLabels, caseExceptionSummaries, clearArrays
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_ListExceptionSummariesForCase(case_id As Int64, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently logged for the given test case.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_Exceptions+".*, "+kDB_TestResults+"."+kDB_TestResult_ID+" AS result_id, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name" _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ID+" = "+Str(case_id) _
		  + " ORDER BY class_id ASC, case_id ASC, result_id ASC, "+kDB_Exceptions+"."+kDB_Exception_StageCode+" ASC, "+kDB_Exceptions+"."+kDB_Exception_Index+" ASC"
		  
		  
		  // Populate the arrays with the result of the query:
		  
		  GetStringArraysFromExceptionsInRecordSet dbsel( sql ), caseLabels, caseExceptionSummaries, clearArrays
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_ListExceptionSummariesForCaseDuringStage(case_id As Int64, stage As UnitTestArbiterKFS.StageCodes, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently logged for the given test case during the given stage.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_Exceptions+".*, "+kDB_TestResults+"."+kDB_TestResult_ID+" AS result_id, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name" _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ID+" = "+Str(case_id) _
		  + " AND "+kDB_Exceptions+"."+kDB_Exception_StageCode+" = "+Str(Integer(stage)) _
		  + " ORDER BY class_id ASC, case_id ASC, result_id ASC, "+kDB_Exceptions+"."+kDB_Exception_StageCode+" ASC, "+kDB_Exceptions+"."+kDB_Exception_Index+" ASC"
		  
		  
		  // Populate the arrays with the result of the query:
		  
		  GetStringArraysFromExceptionsInRecordSet dbsel( sql ), caseLabels, caseExceptionSummaries, clearArrays
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_ListExceptionSummariesForClass(class_id As Int64, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently logged for the given test class.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_Exceptions+".*, "+kDB_TestResults+"."+kDB_TestResult_ID+" AS result_id, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name" _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  + " WHERE "+kDB_TestClasses+"."+kDB_TestClass_ID+" = "+Str(class_id) _
		  + " ORDER BY class_id ASC, case_id ASC, result_id ASC, "+kDB_Exceptions+"."+kDB_Exception_StageCode+" ASC, "+kDB_Exceptions+"."+kDB_Exception_Index+" ASC"
		  
		  
		  // Populate the arrays with the result of the query:
		  
		  GetStringArraysFromExceptionsInRecordSet dbsel( sql ), caseLabels, caseExceptionSummaries, clearArrays
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_ListExceptionSummariesForResult(result_id As Int64, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently logged for the given test result.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_Exceptions+".*, "+kDB_TestResults+"."+kDB_TestResult_ID+" AS result_id, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name" _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" = "+Str(result_id) _
		  + " ORDER BY class_id ASC, case_id ASC, result_id ASC, "+kDB_Exceptions+"."+kDB_Exception_StageCode+" ASC, "+kDB_Exceptions+"."+kDB_Exception_Index+" ASC"
		  
		  
		  // Populate the arrays with the result of the query:
		  
		  GetStringArraysFromExceptionsInRecordSet dbsel( sql ), caseLabels, caseExceptionSummaries, clearArrays
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub q_ListExceptionSummariesForResultDuringStage(result_id As Int64, stage As UnitTestArbiterKFS.StageCodes, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String, clearArrays As Boolean)
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently logged for the given test result during the given stage.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_Exceptions+".*, "+kDB_TestResults+"."+kDB_TestResult_ID+" AS result_id, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name, "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name" _
		  + " FROM "+kDB_Exceptions _
		  + " LEFT JOIN "+kDB_TestResults+" ON "+kDB_Exceptions+"."+kDB_Exception_ResultID+" = "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " LEFT JOIN "+kDB_TestClasses+" ON "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+kDB_TestClasses+"."+kDB_TestClass_ID _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" = "+Str(result_id) _
		  + " AND "+kDB_Exceptions+"."+kDB_Exception_StageCode+" = "+Str(Integer(stage)) _
		  + " ORDER BY class_id ASC, case_id ASC, result_id ASC, "+kDB_Exceptions+"."+kDB_Exception_StageCode+" ASC, "+kDB_Exceptions+"."+kDB_Exception_Index+" ASC"
		  
		  
		  // Populate the arrays with the result of the query:
		  
		  GetStringArraysFromExceptionsInRecordSet dbsel( sql ), caseLabels, caseExceptionSummaries, clearArrays
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListPrerequisitesOfTestCase(case_id As Int64) As Int64()
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of the case IDs that are required for the given case to run.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_CaseID+" = "+Str(case_id) _
		  +" ORDER BY "+kDB_TestCaseDependency_RequiresCaseID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListPrerequisitesOfTestCaseWithStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns a list of the case IDs that are required for the given case to run and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCaseDependency_RequiresCaseID _
		  +" FROM "+kDB_TestCaseDependencies _
		  +" WHERE "+kDB_TestCaseDependency_CaseID+" = "+Str(case_id) _
		  +" AND "+kDB_TestCaseDependency_RequiresCaseID+" IN ( "+pq_CasesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestCaseDependency_RequiresCaseID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListStagesOfTestCase(case_id As Int64) As UnitTestArbiterKFS.StageCodes()
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns an array of the stage codes applicable to the given test case.
		  
		  // Figure out what kind of test case this is:
		  
		  Dim case_type As TestCaseTypes
		  q_GetTestCaseInfo case_id, case_type
		  
		  
		  // Build the result:
		  
		  Dim result() As StageCodes
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringSetup ) = 0 Then _
		  result.Append StageCodes.Setup
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseWithoutFixture ) = 0 Then _
		  result.Append StageCodes.Core
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringVerification ) = 0 Then _
		  result.Append StageCodes.Verification
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringTearDown ) = 0 Then _
		  result.Append StageCodes.TearDown
		  
		  
		  // Return the result:
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListStagesOfTestResult(result_id As Int64) As UnitTestArbiterKFS.StageCodes()
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns an array of the stage codes applicable to the given test result.
		  
		  // Figure out what kind of test case this is:
		  
		  Dim case_type As TestCaseTypes
		  q_GetTestResultInfo result_id, case_type
		  
		  
		  // Build the result:
		  
		  Dim result() As StageCodes
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringSetup ) = 0 Then _
		  result.Append StageCodes.Setup
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseWithoutFixture ) = 0 Then _
		  result.Append StageCodes.Core
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringVerification ) = 0 Then _
		  result.Append StageCodes.Verification
		  
		  If Integer( case_type ) Mod Integer( TestCaseTypes.TestCaseRequiringTearDown ) = 0 Then _
		  result.Append StageCodes.TearDown
		  
		  
		  // Return the result:
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCases() As Int64()
		  // Created 2/10/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded in this arbiter.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesInClass(class_id As Int64) As Int64()
		  // Created 2/10/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded
		  // in this arbiter that are members of the given class.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesInClassWithStatus(class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded in this arbiter
		  // that are members of the given class and conform to the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesOfType(type As UnitTestArbiterKFS.TestCaseTypes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded
		  // in this arbiter that conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" )" _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesOfTypeInClass(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded in this arbiter
		  // that are members of the given class and conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" )" _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesOfTypeInClassWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded in this arbiter that are
		  // members of the given class, conform to the given test type, and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" )" _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesOfTypeWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently loaded in this
		  // arbiter that conform to the given test type and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" IN ( "+pq_CasesOfType(type)+" )" _
		  +" AND "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestCasesWithStatus(status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test cases currently
		  // loaded in this arbiter that have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestCase_ID _
		  +" FROM "+kDB_TestCases _
		  +" WHERE "+kDB_TestCase_ID+" IN ( "+pq_CasesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestCase_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestClasses() As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test classes currently loaded in this arbiter.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestClass_ID _
		  +" FROM "+kDB_TestClasses _
		  +" ORDER BY "+kDB_TestClass_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestClassesWithStatus(status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test classes currently
		  // loaded in this arbiter that have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestClass_ID _
		  +" FROM "+kDB_TestClasses _
		  +" WHERE "+kDB_TestClass_ID+" IN ( "+pq_ClassesWithStatus(status)+" )" _
		  +" ORDER BY "+kDB_TestClass_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResults() As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently loaded in this arbiter.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsInCase(case_id As Int64) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently loaded
		  // in this arbiter that are members of the given test case.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsInCaseWithStatus(case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given
		  // test case and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsInClass(class_id As Int64) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given class.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsInClassWithStatus(class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given
		  // class and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsOfType(type As UnitTestArbiterKFS.TestCaseTypes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsOfTypeInCase(type As UnitTestArbiterKFS.TestCaseTypes, case_id As Int64) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given
		  // test case and conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsOfTypeInCaseWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, case_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given test case,
		  // conform to the given test type, and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+Str(case_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsOfTypeInClass(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given
		  // class and conform to the given test type.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsOfTypeInClassWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, class_id As Int64, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that are members of the given class,
		  // conform to the given test type, and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID _
		  + " WHERE "+kDB_TestCases+"."+kDB_TestCase_ClassID+" = "+Str(class_id) _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsOfTypeWithStatus(type As UnitTestArbiterKFS.TestCaseTypes, status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that conform to the given test type
		  // and have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsOfType(type)+" )" _
		  + " AND "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsWaitingForProcessing() As Int64()
		  // Created 2/24/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently waiting for processing.
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( pq_ResultsWaitingForProcessing ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function q_ListTestResultsWithStatus(status As UnitTestArbiterKFS.StatusCodes) As Int64()
		  // Created 2/13/2011 by Andrew Keller
		  
		  // Returns an array of the IDs of the test results currently
		  // loaded in this arbiter that have the given status.
		  
		  Dim sql As String _
		  = "SELECT DISTINCT "+kDB_TestResults+"."+kDB_TestResult_ID _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResults+"."+kDB_TestResult_ID+" IN ( "+pq_ResultsWithStatus(status)+" )" _
		  + " ORDER BY "+kDB_TestResults+"."+kDB_TestResult_ID+" ASC"
		  
		  
		  // Get and return the array:
		  
		  Return GetInt64ArrayFromRecordSetField( dbsel( sql ), 1 )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunDataAvailableHook()
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Raises the DataAvailable event, and if the event was
		  // not "handled", then invokes GatherEvents right here.
		  
		  If Not DataAvailable Then GatherEvents
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestsAreRunning() As Boolean
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns whether or not some tests are running.
		  
		  // Note: this routine uses the status flag in the database,
		  // so if a thread was killed in the middle of running a test,
		  // then the result here will be inaccurate.
		  
		  Return dbsel( "SELECT count( "+kDB_TestResult_ID+" ) " _
		  + " FROM "+kDB_TestResults _
		  + " WHERE "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Delegated)) _
		  + " OR "+kDB_TestResult_Status_Setup+" = "+Str(Integer(StatusCodes.Delegated)) _
		  + " OR "+kDB_TestResult_Status_Core+" = "+Str(Integer(StatusCodes.Delegated)) _
		  + " OR "+kDB_TestResult_Status_Verification+" = "+Str(Integer(StatusCodes.Delegated)) _
		  + " OR "+kDB_TestResult_Status_TearDown+" = "+Str(Integer(StatusCodes.Delegated)) _
		  ).IdxField( 1 ).IntegerValue > 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UniqueInteger() As Int64
		  // Created 1/29/2011 by Andrew Keller
		  
		  // Returns an integer that is guaranteed to be unique
		  // across all instances of this class at runtime.
		  
		  // Hopefully, this will increase the possibility of
		  // hard, fatal bugs and decrease the possibility
		  // of soft, non-fatal hard-to-track-down bugs.
		  
		  Static counter As Int64 = 0
		  
		  Dim result As Int64 = counter
		  
		  Do
		    counter = counter +1
		  Loop Until counter <> kReservedID_Null
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DataAvailable() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EventGatheringFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EventGatheringStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestCaseUpdated(testClassID As Int64, testClassName As String, testCaseID As Int64, testCaseName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestClassUpdated(testClassID As Int64, testClassName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestResultUpdated(resultRecordID As Int64, testClassID As Int64, testClassName As String, testCaseID As Int64, testCaseName As String, resultStatus As UnitTestArbiterKFS.StatusCodes, setupTime As DurationKFS, coreTime As DurationKFS, tearDownTime As DurationKFS)
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
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


	#tag Property, Flags = &h1
		Protected ge_time_cases As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ge_time_classes As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ge_time_results As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected goForAutoProcess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mydb As Database
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myObjPool As Dictionary
	#tag EndProperty


	#tag Constant, Name = kClassTestDelimiter, Type = String, Dynamic = False, Default = \".", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exceptions, Type = String, Dynamic = False, Default = \"exceptions", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_ExceptionStacks, Type = String, Dynamic = False, Default = \"stacks", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_ExceptionStack_ExceptionID, Type = String, Dynamic = False, Default = \"exception_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_ExceptionStack_Index, Type = String, Dynamic = False, Default = \"indx", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_ExceptionStack_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_ExceptionStack_Text, Type = String, Dynamic = False, Default = \"text", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_AssertionNumber, Type = String, Dynamic = False, Default = \"assnum", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ClassName, Type = String, Dynamic = False, Default = \"superclassname", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Criteria, Type = String, Dynamic = False, Default = \"crit", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ErrorCode, Type = String, Dynamic = False, Default = \"errcode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Explanation, Type = String, Dynamic = False, Default = \"expln", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Index, Type = String, Dynamic = False, Default = \"idx", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ResultID, Type = String, Dynamic = False, Default = \"result_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Scenario, Type = String, Dynamic = False, Default = \"type", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_StageCode, Type = String, Dynamic = False, Default = \"stage", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_StackTraces, Type = String, Dynamic = False, Default = \"stacks", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependencies, Type = String, Dynamic = False, Default = \"dependencies", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependency_CaseID, Type = String, Dynamic = False, Default = \"case_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependency_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependency_RequiresCaseID, Type = String, Dynamic = False, Default = \"requires_case_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCases, Type = String, Dynamic = False, Default = \"cases", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_ClassID, Type = String, Dynamic = False, Default = \"class_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_Name, Type = String, Dynamic = False, Default = \"name", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_TestType, Type = String, Dynamic = False, Default = \"testtype", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClasses, Type = String, Dynamic = False, Default = \"classes", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClass_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClass_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClass_Name, Type = String, Dynamic = False, Default = \"name", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResults, Type = String, Dynamic = False, Default = \"results", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_CaseID, Type = String, Dynamic = False, Default = \"case_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Status, Type = String, Dynamic = False, Default = \"status", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Status_Core, Type = String, Dynamic = False, Default = \"core_status", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Status_Setup, Type = String, Dynamic = False, Default = \"setup_status", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Status_TearDown, Type = String, Dynamic = False, Default = \"setup_teardown", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Status_Verification, Type = String, Dynamic = False, Default = \"setup_verify", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Time_Core, Type = String, Dynamic = False, Default = \"core_t", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Time_Setup, Type = String, Dynamic = False, Default = \"setup_t", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Time_TearDown, Type = String, Dynamic = False, Default = \"teardown_t", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Time_Verification, Type = String, Dynamic = False, Default = \"verify_t", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kReservedID_Null, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant


	#tag Enum, Name = StageCodes, Type = Integer, Flags = &h0
		Setup
		  Core
		  Verification
		TearDown
	#tag EndEnum

	#tag Enum, Name = StatusCodes, Type = Integer, Flags = &h0
		Null
		  Created
		  Category_Inaccessible
		  Category_InaccessibleDueToMissingPrerequisites
		  Category_InaccessibleDueToFailedPrerequisites
		  Delegated
		  Category_Incomplete
		  Passed
		Failed
	#tag EndEnum

	#tag Enum, Name = TestCaseTypes, Type = Integer, Flags = &h0
		TestCaseWithoutFixture = 1
		  TestCaseRequiringSetup = 2
		  TestCaseRequiringVerification = 3
		  TestCaseRequiringTearDown = 5
		  Combination_SetupAndVerification = 6
		  Combination_SetupAndTearDown = 10
		  Combination_VerificationAndTearDown = 15
		Combination_SetupAndVerificationAndTearDown = 30
	#tag EndEnum

	#tag Enum, Name = UnitTestExceptionScenarios, Type = Integer, Flags = &h0
		AssertionFailure
		  CaughtException
		UncaughtException
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Thread"
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
