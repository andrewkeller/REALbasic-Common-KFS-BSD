#tag Window
Begin ContainerControl UnitTestViewKFS
   AcceptFocus     =   ""
   AcceptTabs      =   False
   AutoDeactivate  =   True
   Enabled         =   True
   EraseBackground =   True
   Height          =   316
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   3.2e+1
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   3.2e+1
   UseFocusRing    =   ""
   Visible         =   True
   Width           =   635
   Begin Listbox lstUnitTestResults
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   4
      ColumnsResizable=   True
      ColumnWidths    =   "2*,*,70,60"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   ""
      EnableDragReorder=   ""
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   284
      HelpTag         =   ""
      Hierarchical    =   True
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Test Name	Status	Time	% Time"
      Italic          =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   2
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   1
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   32
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   635
      _ScrollWidth    =   -1
   End
   Begin UnitTestArbiterKFS myUnitTestArbiter
      Height          =   32
      Index           =   -2147483648
      Left            =   -72
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
      Top             =   -53
      Width           =   32
   End
   Begin StaticText lblUnitTestReportHeading
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      Text            =   "No unit test results to display."
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   635
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Initialize the lock object for the listbox.
		  
		  myListboxLock = New CriticalSection
		  
		  // Set the arbiter to asynchronous mode.
		  
		  myUnitTestArbiter.Mode = UnitTestArbiterKFS.Modes.Asynchronous
		  
		  RaiseEvent Open
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function FindRowOfTestCase(lbox As Listbox, classRow As Integer, caseObject As UnitTestResultKFS, autoMake As Boolean = True) As Integer
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Finds or makes a row for the given test case results.
		  
		  If Not lbox.Expanded( classRow ) Then Return -1
		  
		  Dim row, last As Integer
		  last = lbox.ListCount -1
		  
		  For row = classRow + 1 To last
		    
		    Dim v As Variant = lbox.CellTag( row, 0 )
		    
		    If v = Nil then
		      
		      // We have ran into the end of this folder.
		      
		      Exit
		      
		    ElseIf v Is caseObject Then
		      
		      // Found it!
		      
		      Return row
		      
		    End If
		  Next
		  
		  // We ran into the end of the listbox.
		  
		  // Well, guess it's not here.
		  
		  If autoMake Then
		    
		    lbox.InsertFolder( classRow + 1, caseObject.TestMethodName, 1 )
		    Return classRow +1
		    
		  End If
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindRowOfTestClass(lbox As Listbox, className As String, autoMake As Boolean = True) As Integer
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Finds or makes a row for the given test class results.
		  
		  Dim row, last As Integer
		  last = lbox.ListCount -1
		  
		  For row = 0 To last
		    
		    If lbox.CellTag( row, 0 ) = Nil Then
		      
		      // This is an existing class folder.
		      
		      If lbox.Cell( row, 0 ) = className Then
		        
		        // Found it.
		        
		        Return row
		        
		      End If
		    End If
		  Next
		  
		  // Well, guess it's not here.
		  
		  If autoMake Then
		    
		    lbox.AddFolder className
		    Return lbox.LastIndex
		    
		  End If
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertUpdatedTestEntry(lstOut As Listbox, arbSrc As UnitTestArbiterKFS, testCaseObject As UnitTestResultKFS)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the given test case entry in the given listbox.
		  
		  myListboxLock.Enter
		  
		  // We're going to need the result object, anyways...
		  // First, find the row for the test class.
		  
		  Dim classRow As Integer = FindRowOfTestClass( lstOut, testCaseObject.TestClassName )
		  
		  // Next, update the stats for the class.
		  
		  UpdateTestClassStats( lstOut, classRow, arbSrc, testCaseObject.TestClassName )
		  
		  // Is that folder open?
		  
		  If lstOut.Expanded( classRow ) Then
		    
		    // Find the row of the test.
		    
		    Dim caseRow As Integer = FindRowOfTestCase( lstOut, classRow, testCaseObject )
		    
		    // Update the stats for the row.
		    
		    UpdateTestCaseStats( lstOut, caseRow, testCaseObject )
		    
		  End If
		  
		  lstOut.Sort
		  
		  myListboxLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateTestCaseStats(lstOut As Listbox, caseRow As Integer, caseObject As UnitTestResultKFS)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the stats for the given class.
		  
		  // Assumes a lock is already in place.
		  
		  // Store the case object, just in case:
		  
		  lstOut.CellTag( caseRow, 0 ) = caseObject
		  
		  // Set the status message:
		  
		  If caseObject.TestCasePassed Then
		    
		    lstOut.Cell( caseRow, 1 ) = "Passed"
		    lstOut.CellTag( caseRow, 1 ) = -1
		    
		  ElseIf caseObject.TestCaseSkipped Then
		    
		    lstOut.Cell( caseRow, 1 ) = "Skipped"
		    lstOut.CellTag( caseRow, 1 ) = 0
		    
		  ElseIf caseObject.TestCaseFailed Then
		    
		    lstOut.Cell( caseRow, 1 ) = "Failed"
		    lstOut.CellTag( caseRow, 1 ) = 1
		    
		  End If
		  
		  // Update the time stats:
		  UpdateTestTimeStats lstUnitTestResults, caseRow, caseObject.t_Core, myUnitTestArbiter.OverallElapsedTime
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateTestClassStats(lstOut As Listbox, classRow As Integer, arbSrc As UnitTestArbiterKFS, className As String)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the stats for the given class.
		  
		  // Did the class pass its setup routine?
		  
		  If arbSrc.TestClassSetupPassed( className ) Then
		    
		    // Okay, did any of the tests fail?
		    
		    Dim fa, sk As Integer
		    fa = arbSrc.CountFailedTestCases( className )
		    sk = arbSrc.CountSkippedTestCases( className )
		    Dim s() As String
		    If fa > 0 Then s.Append str( fa ) + " failed"
		    If sk > 0 Then s.Append str( sk ) + " skipped"
		    
		    // Store the result in the "Status" column.
		    
		    If UBound( s ) < 0 Then
		      lstUnitTestResults.Cell( classRow, 1 ) = "Passed"
		    Else
		      lstUnitTestResults.Cell( classRow, 1 ) = Join( s, ", " )
		    End If
		    
		    // And store a number in the cell tag for sorting.
		    lstUnitTestResults.CellTag( classRow, 1 ) = fa * 2 + sk
		    
		  Else
		    
		    // Well, here's an easy message.  Setup failed.
		    lstUnitTestResults.Cell( classRow, 1 ) = "Setup Failed"
		    
		    // Set the cell tag to something useful for sorting.
		    lstUnitTestResults.CellTag( classRow, 1 ) = 10 + arbSrc.CountSkippedTestCases( className )
		    
		  End If
		  
		  // Retrieve how long it took the class to run its tests:
		  Dim t As Double = arbSrc.TestClassElapsedTime( className )
		  
		  // Update the time stats:
		  UpdateTestTimeStats lstUnitTestResults, classRow, arbSrc.TestClassElapsedTime( className ), arbSrc.OverallElapsedTime
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateTestTimeStats(lstOut As Listbox, row As Integer, seconds As Double, totalSeconds As Double)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the time stats for the given row.
		  
		  // Display total time:
		  
		  lstOut.Cell( row, 2 ) = Format( seconds * 1000, "0\ \m\s" )
		  lstOut.CellTag( row, 2 ) = seconds
		  
		  // Display partial time:
		  
		  lstOut.Cell( row, 3 ) = Format( seconds / totalSeconds, "0%" )
		  lstOut.CellTag( row, 3 ) = seconds / totalSeconds
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestFinished(testCaseObject As UnitTestResultKFS)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestRunnerFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestRunnerStarting()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestStarting(testClassName As String, testCaseName As String)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/4/2010 by Andrew Keller
			  
			  // Returns a reference to the unit test arbiter.
			  
			  Return myUnitTestArbiter
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Arbiter As UnitTestArbiterKFS
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/4/2010 by Andrew Keller
			  
			  // Returns whether or not the heading label is visible.
			  
			  Return lblUnitTestReportHeading.Visible
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/4/2010 by Andrew Keller
			  
			  // Sets the visibility of the heading label.
			  
			  If lblUnitTestReportHeading.Visible Then
			    
			    lblUnitTestReportHeading.Visible = False
			    lstUnitTestResults.Top = 0
			    lstUnitTestResults.Height = Self.Height
			    
			  Else
			    
			    lblUnitTestReportHeading.Visible = True
			    lstUnitTestResults.Top = 32
			    lstUnitTestResults.Height = Self.Height - 32
			    
			  End If
			  
			  // done.
			  
			End Set
		#tag EndSetter
		HeadingVisible As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected myListboxLock As CriticalSection
	#tag EndProperty


#tag EndWindowCode

#tag Events lstUnitTestResults
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Compares the given rows.
		  
		  If column = 1 Or column = 2 Or column = 3 Then
		    
		    If Me.CellTag( row1, column ) < Me.CellTag( row2, column ) Then
		      
		      result = -1
		      
		    ElseIf Me.CellTag( row1, column ) > Me.CellTag( row2, column ) Then
		      
		      result = 1
		      
		    Else
		      
		      result = 0
		      
		    End If
		    
		    Return True
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Set the default sorted column:
		  
		  Me.SortedColumn = 1
		  Me.ColumnSortDirection( 1 ) = Listbox.SortDescending
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Make the text the right color:
		  
		  If column = 1 Then
		    
		    Dim s As String = Me.Cell( row, column )
		    
		    If InStr( s, "failed" ) > 0 Then
		      
		      g.ForeColor = &cEE0000
		      
		    ElseIf InStr( s, "skipped" ) > 0 Then
		      
		      g.ForeColor = &cEEDD00
		      
		    ElseIf InStr( s, "passed" ) > 0 Then
		      
		      g.ForeColor = &c00DD00
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub CollapseRow(row As Integer)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Removes the items involved with the given folder.
		  
		  myListboxLock.Enter
		  
		  If Me.CellTag( row, 0 ) = Nil Then
		    
		    While row < Me.ListCount - 1 And Me.CellTag( row + 1, 0 ) = Nil
		      
		      Me.RemoveRow row + 1
		      
		    Wend
		    
		  Else
		    
		    For row = row + 1 To Min( row + 3, Me.ListCount -1 )
		      
		      Me.RemoveRow row
		      
		    Next
		    
		  End If
		  
		  myListboxLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub ExpandRow(row As Integer)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Adds rows for each test case and refreshes them.
		  
		  myListboxLock.Enter
		  
		  Dim v As Variant = Me.CellTag( row, 0 )
		  
		  If v = Nil Then
		    
		    For Each caseName As String In myUnitTestArbiter.TestCaseNames( Me.Cell( row, 0 ) )
		      
		      Dim r As UnitTestResultKFS = myUnitTestArbiter.TestCaseResultContainer( Me.Cell( row, 0 ), caseName )
		      
		      Me.AddFolder caseName
		      UpdateTestCaseStats Me, Me.LastIndex, r
		      
		    Next
		    
		  ElseIf v IsA UnitTestResultKFS Then
		    
		    Dim r As UnitTestResultKFS = v
		    
		    Me.AddRow "Setup"
		    Me.AddRow "Core"
		    Me.AddRow "Tear Down"
		    UpdateTestCaseStats Me, row, r
		    
		  End If
		  
		  Me.Sort
		  
		  myListboxLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Make the text the right color:
		  
		  If row >= 0 And row < Me.ListCount Then
		    If Me.CellTag( row, 0 ) = Nil Then
		      
		      g.ForeColor = &cEEEEFF
		      
		      If column = 0 Then
		        
		        g.FillRoundRect 17, 0, 16, g.Height, 8, 8
		        g.FillRect 25, 0, g.Width, g.Height
		        
		      Else
		        
		        g.FillRect 0, 0, g.Width, g.Height
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Function
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Do things when keys are pressed.
		  
		  Select Case Asc( key )
		  Case kASCIIRightArrow
		    
		    For row As Integer = Me.ListCount -1 DownTo 0
		      If Me.Selected( row ) Then
		        Me.Expanded( row ) = True
		      End If
		    Next
		    
		    Return True
		    
		  Case kASCIILeftArrow
		    
		    For row As Integer = 0 To Me.ListCount -1
		      If Me.Selected( row ) Then
		        Me.Expanded( row ) = False
		      End If
		    Next
		    
		    Return True
		    
		  End Select
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events myUnitTestArbiter
	#tag Event
		Sub TestFinished(testCaseObject As UnitTestResultKFS)
		  // Refresh the interactive report:
		  
		  lblUnitTestReportHeading.Caption = Me.PlaintextHeading
		  InsertUpdatedTestEntry lstUnitTestResults, myUnitTestArbiter, testCaseObject
		  
		  // Fire the container's TestFinished event:
		  
		  RaiseEvent TestFinished testCaseObject
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub TestRunnerFinished()
		  // Refresh the interactive report:
		  
		  lblUnitTestReportHeading.Caption = Me.PlaintextHeading
		  
		  // Fire the container's TestRunnerFinished event:
		  
		  RaiseEvent TestRunnerFinished
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub TestStarting(testClassName As String, testCaseName As String)
		  // Fire the container's TestStarting event:
		  
		  RaiseEvent TestStarting testClassName, testCaseName
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub TestRunnerStarting()
		  // Fire the container's TestRunnerStarting event:
		  
		  RaiseEvent TestRunnerStarting
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
