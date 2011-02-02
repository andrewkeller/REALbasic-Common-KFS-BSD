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
		    
		    // Get the execption type:
		    
		    Dim e_type As UnitTestExceptionScenarios
		    If e_list(e_indx).IsAFailedAssertion Then
		      e_type = UnitTestExceptionScenarios.AssertionFailure
		    ElseIf e_list(e_indx).ExceptionWasCaught Then
		      e_type = UnitTestExceptionScenarios.CaughtException
		    Else
		      e_type = UnitTestExceptionScenarios.UncaughtException
		    End If
		    
		    // Insert the new data:
		    
		    rec = New DatabaseRecord
		    
		    rec.Int64Column( kDB_Exception_ID ) = e_id
		    rec.Int64Column( kDB_Exception_ModDate ) = CurrentTimeCode
		    rec.Int64Column( kDB_Exception_ResultID ) = rslt_id
		    rec.IntegerColumn( kDB_Exception_StageCode ) = Integer( stage )
		    rec.IntegerColumn( kDB_Exception_Index ) = e_indx
		    rec.IntegerColumn( kDB_Exception_Scenario ) = Integer( e_type )
		    rec.Column( kDB_Exception_ClassName ) = e_list(e_indx).ExceptionClassType
		    rec.IntegerColumn( kDB_Exception_ErrorCode ) = e_list(e_indx).ErrorNumber
		    rec.Column( kDB_Exception_Message ) = e_list(e_indx).FailureMessage
		    rec.Column( kDB_Exception_Situation ) = e_list(e_indx).SituationalMessage
		    rec.IntegerColumn( kDB_Exception_AssertionNumber ) = e_list(e_indx).AssertionNumber
		    
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
		  
		  goForAutoProcess = True
		  timeCodeCache = 0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountFailedTestCases() As Integer
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns the number of test cases that have failed results.
		  
		  // Note that if a test case has two result records, one of
		  // which passed and the other of which failed, that that
		  // test case is considered to be both passed and failed.
		  
		  Return dbsel( "SELECT count( "+kDB_TestResult_ID+" ) FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Failed)) ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountInaccessibleTestCases() As Integer
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns the number of test cases that are currently inaccessible due to unsatisfied prerequisites.
		  
		  // Get the list of results that have passed:
		  
		  Dim rslts_passed As String = "SELECT "+kDB_TestResult_CaseID+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Passed))
		  
		  // Find all results where any dependency has not been satisfied at least once
		  // ("satisfied" means the test passed):
		  
		  Dim count_missing_dep As String = "SELECT count( "+kDB_TestResult_ID+" ) FROM "+kDB_TestResults+", "+kDB_TestCaseDependencies+" WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCaseDependencies+"."+kDB_TestCaseDependency_CaseID+" AND depends_case_id NOT IN ( "+rslts_passed+" )"
		  
		  Return dbsel( count_missing_dep ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountTestCases() As Integer
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns the number of test cases currently loaded in this arbiter.
		  
		  // Note that this is the number of test case specifications, NOT the number of test case result records.
		  
		  Return dbsel( "SELECT count( "+kDB_TestCase_ID+" ) FROM "+kDB_TestCases ).IdxField( 1 ).IntegerValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateJobsForTestClass(class_id As UInt64)
		  // Created 1/30/2011 by Andrew Keller
		  
		  // Creates new jobs for each test case in the given loaded test class.
		  
		  // This routine runs the DataAvailable hook.
		  
		  // First, acquire a list of all test cases for the given job.
		  
		  Dim rs As RecordSet = dbsel( "select distinct "+kDB_TestCase_ID+" from "+kDB_TestCases+" where "+kDB_TestCase_ClassID+" = "+Str(class_id)+" order by "+kDB_TestCase_Name )
		  
		  // Next, loop through each test case, and create a new job for each.
		  
		  While Not rs.EOF
		    
		    Dim tc_id As Int64 = rs.Field( kDB_TestCase_ID ).Int64Value
		    
		    // Get an ID for this result record:
		    
		    Dim rslt_id As Int64 = UniqueInteger
		    
		    // Add a locking helper to the object pool:
		    
		    myObjPool.Value( rslt_id ) = True
		    
		    // Add the result record in the database:
		    
		    dbexec "insert into "+kDB_TestResults+" ( "+kDB_TestResult_ID+", "+kDB_TestResult_ModDate+", "+kDB_TestResult_CaseID+", "+kDB_TestResult_Status+", "+kDB_TestResult_SetupTime+", "+kDB_TestResult_CoreTime+", "+kDB_TestResult_TearDownTime+" ) " _
		    + "values ( "+Str(rslt_id)+", "+Str(CurrentTimeCode)+", "+Str(tc_id)+", "+Str(Integer(StatusCodes.Created))+", null, null, null )"
		    
		    rs.MoveNext
		    
		  Wend
		  
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
		  + kDB_TestClass_Name + " varchar, " _
		  + "primary key ( " + kDB_TestClass_ID + " ) )"
		  
		  table_defs.Append "create table "+kDB_TestCases+" ( " _
		  + kDB_TestCase_ID + " integer, " _
		  + kDB_TestCase_TestType + " integer, " _
		  + kDB_TestCase_ClassID + " integer, " _
		  + kDB_TestCase_Name + " varchar, " _
		  + "primary key ( " + kDB_TestCase_ID + " ) )"
		  
		  table_defs.Append "create table "+kDB_TestCaseDependencies+" ( " _
		  + kDB_TestCaseDependency_CaseID + " integer, " _
		  + kDB_TestCaseDependency_DependsOnCaseID + " integer )"
		  
		  table_defs.Append "create table "+kDB_TestResults+" ( " _
		  + kDB_TestResult_ID + " integer, " _
		  + kDB_TestResult_ModDate + " integer, " _
		  + kDB_TestResult_CaseID + " integer, " _
		  + kDB_TestResult_Status + " integer, " _
		  + kDB_TestResult_SetupTime + " integer, " _
		  + kDB_TestResult_CoreTime + " integer, " _
		  + kDB_TestResult_TearDownTime + " integer, " _
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
		  + kDB_Exception_Message + " varchar, " _
		  + kDB_Exception_Situation + " varchar, " _
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
		Function ElapsedTime() As DurationKFS
		  // Created 2/2/2011 by Andrew Keller
		  
		  // Returns the total elapsed time for all test results on record.
		  
		  Dim sql As String = "SELECT sum( st ) AS st " _
		  +"FROM ( SELECT sum( "+kDB_TestResult_CoreTime+" ) AS st FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_CoreTime+" <> NULL " _
		  +"UNION SELECT sum( "+kDB_TestResult_SetupTime+" ) FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_SetupTime+" <> NULL " _
		  +"UNION SELECT sum( "+kDB_TestResult_TearDownTime+" ) FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_TearDownTime+" <> NULL )"
		  
		  Return DurationKFS.NewFromMicroseconds( dbsel( sql ).IdxField( 1 ).Int64Value )
		  
		  // done.
		  
		End Function
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

	#tag Method, Flags = &h0
		Sub GatherEvents()
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Fires the TestCaseUpdated event for every test case that has been updated since timeCodeCache.
		  
		  Dim nothingChanged As Boolean
		  
		  Do
		    
		    Dim sql As String
		    Dim ntcc As Int64 = CurrentTimeCode
		    Dim tcc As Int64 = timeCodeCache
		    
		    // Get all the exception stack records that have changed:
		    
		    sql = "SELECT "+kDB_ExceptionStack_ExceptionID+" FROM "+kDB_ExceptionStacks+" WHERE "+kDB_ExceptionStack_ModDate+" > "+Str(timeCodeCache)
		    
		    // Get all the exceptions records that have changed:
		    
		    sql = "SELECT "+kDB_Exception_ResultID+" FROM "+kDB_Exceptions+" WHERE "+kDB_Exception_ModDate+" > "+Str(timeCodeCache)+" OR "+kDB_Exception_ID+" IN (" + chr(10)+sql+chr(10) + ")"
		    
		    // Get all the result records that have changed:
		    
		    sql = "SELECT "+kDB_TestResult_CaseID+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_ModDate+" > "+Str(timeCodeCache)+" OR "+kDB_TestResult_ID+" IN (" + chr(10)+sql+chr(10) + ")"
		    
		    // Get all the overall class id / case id records that have changed:
		    
		    sql = "WHERE case_id IN (" + chr(10)+sql+chr(10) + ")"
		    sql = "FROM "+kDB_TestClasses+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestClasses+"."+kDB_TestClass_ID+" = "+kDB_TestCases+"."+kDB_TestCase_ClassID +chr(10)+sql
		    sql = "SELECT "+kDB_TestClasses+"."+kDB_TestClass_ID+" AS class_id, "+kDB_TestClasses+"."+kDB_TestClass_Name+" AS class_name, "+kDB_TestCases+"."+kDB_TestCase_ID+" AS case_id, "+kDB_TestCases+"."+kDB_TestCase_Name+" AS case_name" +chr(10)+sql
		    
		    // Execute the query:
		    
		    Dim rs As RecordSet = dbsel( sql )
		    nothingChanged = rs.RecordCount = 0
		    
		    // Fire the TestCaseUpdated event for each of the found records:
		    
		    While Not rs.EOF
		      
		      RaiseEvent TestCaseUpdated rs.Field( "class_id" ).Int64Value, rs.Field( "class_name" ).StringValue, rs.Field( "case_id" ).Int64Value, rs.Field( "case_name" ).StringValue
		      
		      rs.MoveNext
		      
		    Wend
		    
		    // Update the time code cache:
		    
		    timeCodeCache = ntcc
		    
		  Loop Until nothingChanged
		  
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
		Protected Function GetAndLockNextTestCase(rslt_id As Int64) As Boolean
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Searches for a doable, undelegated job, and tries to get a lock on it.
		  // Upon a successful lock, the ID of the test case is returned through the
		  // tc_id parameter.  Returns whether or not a lock was successfully obtained.
		  
		  // This routine runs the DataAvailable hook.
		  
		  // Since this query is a bit more comlicated than the others,
		  // here is a more visual copy of the query being executed here:
		  
		  ' SELECT rslt_id, case_id, class_id, del_cnt
		  ' FROM (
		  '     SELECT results.id AS rslt_id, case_id, class_id
		  '     FROM results LEFT JOIN cases ON results.case_id = cases.id
		  '     WHERE status = 1 AND results.id NOT IN (
		  '         SELECT id
		  '         FROM results, dependencies
		  '         WHERE results.case_id = dependencies.case_id AND depends_case_id NOT IN (
		  '             SELECT case_id
		  '             FROM results
		  '             WHERE status = 5
		  '         )
		  '     )
		  ' )
		  ' LEFT JOIN (
		  '     SELECT cnt_class_id, sum( del_cnt ) AS del_cnt
		  '     FROM (
		  '         SELECT cases.class_id AS cnt_class_id, count( status ) AS del_cnt
		  '         FROM ( results LEFT JOIN cases ON results.case_id = cases.id )
		  '         WHERE status = 2
		  '         GROUP BY class_id
		  '     UNION
		  '         SELECT id, 0
		  '         FROM classes
		  '     )
		  '     GROUP BY cnt_class_id
		  ' )
		  ' ON class_id = cnt_class_id
		  ' ORDER BY del_cnt ASC;
		  
		  // Build the above SQL query (using constants for field names
		  // instead of a huge block of text improves maintainability of code).
		  
		  // Get the list of results that have passed:
		  
		  Dim rslts_passed As String = "SELECT "+kDB_TestResult_CaseID+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Passed))
		  
		  // Find all results where any dependency has not been satisfied at least once
		  // ("satisfied" means the test passed):
		  
		  Dim missing_dep As String = "SELECT "+kDB_TestResult_ID+" FROM "+kDB_TestResults+", "+kDB_TestCaseDependencies+" WHERE "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCaseDependencies+"."+kDB_TestCaseDependency_CaseID+" AND depends_case_id NOT IN ( "+rslts_passed+" )"
		  
		  // Get the list of result records that are not yet delegated, and have all dependencies satisfied:
		  
		  Dim undel_jobs As String  = "SELECT "+kDB_TestResults+"."+kDB_TestResult_ID+" AS rslt_id, "+kDB_TestResult_CaseID+", "+kDB_TestCase_ClassID+" FROM "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID+" WHERE "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Created))+" AND "+kDB_TestResults+"."+kDB_TestResult_ID+" NOT IN ( "+missing_dep+" )"
		  
		  // Find out how many test cases are currently delegated for each task where test cases are delegated:
		  
		  Dim del_jobs_nonzero As String = "SELECT "+kDB_TestCases+"."+kDB_TestCase_ClassID+" AS cnt_class_id, count( "+kDB_TestResult_Status+" ) AS del_cnt FROM ( "+kDB_TestResults+" LEFT JOIN "+kDB_TestCases+" ON "+kDB_TestResults+"."+kDB_TestResult_CaseID+" = "+kDB_TestCases+"."+kDB_TestCase_ID+" ) WHERE "+kDB_TestResult_Status+" = 2 GROUP BY "+kDB_TestCase_ClassID
		  
		  // Create a blank list of zeros for each test class:
		  
		  Dim zero_for_each_class As String = "SELECT "+kDB_TestClass_ID+", 0 FROM "+kDB_TestClasses
		  
		  // Find out how many test cases are currently delegated for each task:
		  
		  Dim del_jobs As String = "SELECT cnt_class_id, sum( del_cnt ) AS del_cnt FROM ( "+del_jobs_nonzero+" UNION "+zero_for_each_class+" ) GROUP BY cnt_class_id"
		  
		  // Get a list of records that are not yet delegated, have all dependencies satisfied,
		  // and sort by the number of currently delegated test cases for the class, ascending:
		  
		  Dim jobs_todo As String = "SELECT rslt_id, "+kDB_TestResult_CaseID+", "+kDB_TestCase_ClassID+", del_cnt FROM ( "+undel_jobs+" ) LEFT JOIN ( "+del_jobs+" ) ON class_id = cnt_class_id ORDER BY del_cnt ASC"
		  
		  // We now have a query that gets a list of prospective jobs to do.
		  // Keep trying to obtain a lock on the class until we either get one,
		  // or until there are no jobs left to process.
		  
		  Dim rs As RecordSet
		  
		  Do
		    
		    rs = dbsel( jobs_todo )
		    
		    While Not rs.EOF
		      
		      rslt_id = rs.Field( "rslt_id" ).Int64Value
		      
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
		        
		        rs = dbsel( "SELECT "+kDB_TestResult_Status+", "+kDB_TestResult_ModDate+" FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_ID+" = "+Str(rslt_id) )
		        
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
		      
		      rs.MoveNext
		      
		    Wend
		    
		  Loop Until rs.RecordCount = 0
		  
		  Return False
		  
		  // done.
		  
		End Function
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
		  
		  Dim testCases() As Introspection.MethodInfo = c.GetTestMethods
		  Dim classConstructor As Introspection.MethodInfo = testCases(0)
		  testCases.Remove 0
		  
		  // Get an ID for the class:
		  
		  Dim class_id As Int64 = UniqueInteger
		  
		  // Store the class into the object bucket:
		  
		  myObjPool.Value( class_id ) = c
		  
		  // Add the class to the database:
		  
		  dbexec "insert into "+kDB_TestClasses+" ( "+kDB_TestClass_ID+", "+kDB_TestClass_Name+" ) values ( "+Str(class_id)+", '"+c.ClassName+"' )"
		  
		  // Get an ID for the class constructor:
		  
		  Dim cnstr_id As Int64 = UniqueInteger
		  
		  // Store the class constructor into the object bucket:
		  
		  myObjPool.Value( cnstr_id ) = classConstructor
		  
		  // Add the class constructor to the database:
		  
		  dbexec "insert into "+kDB_TestCases+" ( "+kDB_TestCase_ID+", "+kDB_TestCase_TestType+", "+kDB_TestCase_ClassID+", "+kDB_TestCase_Name+" ) values ( "+Str(cnstr_id)+", "+Str(Integer(TestCaseTypes.Constructor))+", "+Str(class_id)+", 'Constructor' )"
		  
		  // Add the rest of the test cases to the database:
		  
		  For Each tc As Introspection.MethodInfo In testCases
		    
		    // Get an ID for the test case:
		    
		    Dim tc_id As Int64 = UniqueInteger
		    
		    // Store the test case into the object bucket:
		    
		    myObjPool.Value( tc_id ) = tc
		    
		    // Add a dependency on the constructor to the database:
		    
		    dbexec "insert into "+kDB_TestCaseDependencies+" ( "+kDB_TestCaseDependency_CaseID+", "+kDB_TestCaseDependency_DependsOnCaseID+" ) values ( "+Str(tc_id)+", "+Str(cnstr_id)+" )"
		    
		    // Add the test case to the database:
		    
		    dbexec "insert into "+kDB_TestCases+" ( "+kDB_TestCase_ID+", "+kDB_TestCase_TestType+", "+kDB_TestCase_ClassID+", "+kDB_TestCase_Name+" ) values ( "+Str(tc_id)+", "+Str(Integer(TestCaseTypes.Standard))+", "+Str(class_id)+", '"+tc.Name+"' )"
		    
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

	#tag Method, Flags = &h0
		Function PlaintextHeading() As String
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Returns a simple heading describing the results of the current tests.
		  
		  Dim result As String
		  Dim i As Integer
		  Dim d As Double
		  
		  If TestsAreRunning Then
		    result = "Unit test results so far: "
		  Else
		    result = "Unit test results: "
		  End If
		  
		  i = CountTestCases
		  result = result + str( i ) + " test"
		  If i <> 1 Then result = result + "s"
		  
		  If i > 0 Then
		    
		    i = CountFailedTestCases
		    result = result + ", " + str( i ) + " failure"
		    If i <> 1 Then result = result + "s"
		    
		    i = CountInaccessibleTestCases
		    If i <> 0 Then
		      result = result + ", " + str( i ) + " inaccessible due to unsatisfied prerequisites"
		    End If
		    
		    d = ElapsedTime.Value
		    result = result + ", " + str( d ) + " second"
		    If d <> 1 Then result = result + "s"
		    
		  End If
		  result = result + "."
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProcessNextTestCase() As Boolean
		  // Created 1/31/2011 by Andrew Keller
		  
		  // Acquires, locks, and processes the next test case.
		  
		  Dim rslt_id As Int64
		  
		  If GetAndLockNextTestCase( rslt_id ) Then
		    
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
		  Dim tm As Introspection.MethodInfo = Introspection.MethodInfo( myObjPool.Value( class_id ) )
		  
		  
		  // Next, clear out any existing results.
		  
		  dbexec "DELETE FROM "+kDB_ExceptionStacks+" WHERE "+kDB_ExceptionStack_ExceptionID+" IN ( SELECT "+kDB_Exception_ID+" FROM "+kDB_Exceptions+" WHERE "+kDB_Exception_ResultID+" = "+Str(rslt_id)+" )"
		  dbexec "DELETE FROM "+kDB_Exceptions+" WHERE "+kDB_Exception_ResultID+" = "+Str(rslt_id)
		  rs = dbsel( rslt_master_sql )
		  rs.Edit
		  rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		  rs.Field( kDB_TestResult_Status ).IntegerValue = Integer( StatusCodes.Delegated )
		  rs.Field( kDB_TestResult_SetupTime ).Value = Nil
		  rs.Field( kDB_TestResult_CoreTime ).Value = Nil
		  rs.Field( kDB_TestResult_TearDownTime ).Value = Nil
		  rs.Update
		  mydb.Commit
		  
		  
		  // And finally, run the test.
		  
		  Dim t_setup, t_core, t_teardown As DurationKFS
		  Dim e_setup(), e_core(), e_teardown() As UnitTestExceptionKFS
		  Dim e_term As RuntimeException
		  
		  // Lock the test class itself:
		  tc.Lock.Enter
		  
		  // Clear the status data structures in the test class:
		  Call GatherExceptionsFromTestClass( tc )
		  
		  // Execute the test case setup method:
		  
		  If case_type = TestCaseTypes.Standard Then
		    tc.PushMessageStack "While running the test case setup routine: "
		    t_setup = DurationKFS.NewStopwatchStartingNow
		    Try
		      tc.InvokeTestCaseSetup case_name
		    Catch err As RuntimeException
		      e_term = err
		    End Try
		    t_setup.Stop
		    e_setup = GatherExceptionsFromTestClass( tc, e_term )
		    CommitExceptions e_setup, StageCodes.Setup, rslt_id
		    rs.Edit
		    rs.Field( kDB_TestResult_SetupTime ).Int64Value = t_setup.MicrosecondsValue
		    rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		    rs.Update
		    mydb.Commit
		  End If
		  
		  If UBound( e_setup ) < 0 Then
		    
		    // Execute the test case core method:
		    
		    t_core = DurationKFS.NewStopwatchStartingNow
		    Try
		      tm.Invoke tc
		    Catch err As RuntimeException
		      e_term = err
		    End Try
		    t_core.Stop
		    e_core = GatherExceptionsFromTestClass( tc, e_term )
		    CommitExceptions e_core, StageCodes.Core, rslt_id
		    rs.Edit
		    rs.Field( kDB_TestResult_CoreTime ).Int64Value = t_core.MicrosecondsValue
		    rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		    rs.Update
		    mydb.Commit
		    
		    // Execute the test case tear down method:
		    
		    If case_type = TestCaseTypes.Standard Then
		      tc.PushMessageStack "While running the test case tear down routine: "
		      t_teardown = DurationKFS.NewStopwatchStartingNow
		      Try
		        tc.InvokeTestCaseTearDown case_name
		      Catch err As RuntimeException
		        e_term = err
		      End Try
		      t_teardown.Stop
		      e_teardown = GatherExceptionsFromTestClass( tc, e_term )
		      CommitExceptions e_teardown, StageCodes.TearDown, rslt_id
		      rs.Edit
		      rs.Field( kDB_TestResult_TearDownTime ).Int64Value = t_teardown.MicrosecondsValue
		      rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		      rs.Update
		      mydb.Commit
		    End If
		    
		  End If
		  
		  // Release the lock on the test class:
		  tc.Lock.Leave
		  
		  
		  // Update the staus field of the result record:
		  
		  rs.Edit
		  If UBound( e_setup ) > -1 Or UBound( e_core ) > -1 Or UBound( e_teardown ) > -1 Then
		    rs.Field( kDB_TestResult_Status ).IntegerValue = Integer( StatusCodes.Failed )
		  Else
		    rs.Field( kDB_TestResult_Status ).IntegerValue = Integer( StatusCodes.Passed )
		  End If
		  rs.Field( kDB_TestResult_ModDate ).Int64Value = CurrentTimeCode
		  rs.Update
		  mydb.Commit
		  
		  
		  // Run the DataAvailable hook.
		  
		  RunDataAvailableHook
		  
		  // done.
		  
		End Sub
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
		  
		  Return dbsel( "SELECT count( "+kDB_TestResult_ID+" ) FROM "+kDB_TestResults+" WHERE "+kDB_TestResult_Status+" = "+Str(Integer(StatusCodes.Delegated)) ).IdxField( 1 ).IntegerValue > 0
		  
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
		  
		  counter = counter +1
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DataAvailable() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestCaseUpdated(testClassID As Int64, testClassName As String, testCaseID As Int64, testCaseName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestRunnerFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestRunnerStarting()
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
		Protected goForAutoProcess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mydb As Database
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myObjPool As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected timeCodeCache As Int64
	#tag EndProperty


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

	#tag Constant, Name = kDB_Exception_ErrorCode, Type = String, Dynamic = False, Default = \"errcode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Index, Type = String, Dynamic = False, Default = \"idx", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Message, Type = String, Dynamic = False, Default = \"msg", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_ResultID, Type = String, Dynamic = False, Default = \"result_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Scenario, Type = String, Dynamic = False, Default = \"type", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_Situation, Type = String, Dynamic = False, Default = \"stn", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_Exception_StageCode, Type = String, Dynamic = False, Default = \"stage", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_StackTraces, Type = String, Dynamic = False, Default = \"stacks", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependencies, Type = String, Dynamic = False, Default = \"dependencies", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependency_CaseID, Type = String, Dynamic = False, Default = \"case_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCaseDependency_DependsOnCaseID, Type = String, Dynamic = False, Default = \"depends_case_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCases, Type = String, Dynamic = False, Default = \"cases", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_ClassID, Type = String, Dynamic = False, Default = \"class_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_Name, Type = String, Dynamic = False, Default = \"name", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestCase_TestType, Type = String, Dynamic = False, Default = \"testtype", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClasses, Type = String, Dynamic = False, Default = \"classes", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClass_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestClass_Name, Type = String, Dynamic = False, Default = \"name", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResults, Type = String, Dynamic = False, Default = \"results", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_CaseID, Type = String, Dynamic = False, Default = \"case_id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_CoreTime, Type = String, Dynamic = False, Default = \"core_t", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_ID, Type = String, Dynamic = False, Default = \"id", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_ModDate, Type = String, Dynamic = False, Default = \"md", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_SetupTime, Type = String, Dynamic = False, Default = \"setup_t", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_Status, Type = String, Dynamic = False, Default = \"status", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kDB_TestResult_TearDownTime, Type = String, Dynamic = False, Default = \"teardown_t", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = StageCodes, Type = Integer, Flags = &h1
		Setup
		  Core
		TearDown
	#tag EndEnum

	#tag Enum, Name = StatusCodes, Type = Integer, Flags = &h1
		Null
		  Created
		  Delegated
		  Failed
		Passed
	#tag EndEnum

	#tag Enum, Name = TestCaseTypes, Type = Integer, Flags = &h1
		Standard
		Constructor
	#tag EndEnum

	#tag Enum, Name = UnitTestExceptionScenarios, Type = Integer, Flags = &h1
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
