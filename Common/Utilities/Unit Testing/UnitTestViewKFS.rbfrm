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
   Left            =   32
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
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
      Priority        =   5
      Scope           =   2
      StackSize       =   0
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
   Begin TextArea txtDetails
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   100
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   678
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   336
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   False
      Width           =   100
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

	#tag Event
		Sub Resized()
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Update the positions of the controls.
		  
		  UpdateControlLocations
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Update the positions of the controls.
		  
		  UpdateControlLocations
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function FindRowOfTestCase(lbox As Listbox, classRow As Integer, caseObject As UnitTestResultKFS, autoMake As Boolean = True) As Integer
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Finds or makes a row for the given test case results.
		  
		  If Not lbox.Expanded( classRow ) Then Return -1
		  
		  Dim row, last As Integer
		  last = lbox.ListCount -1
		  
		  For row = classRow + 1 To last
		    
		    Dim rowType As Double = lbox.RowTag( row )
		    
		    If rowType = kCaseRow Then
		      If lbox.CellTag( classRow, 0 ) Is caseObject Then
		        
		        // Found it!
		        
		        Return row
		        
		      End If
		    ElseIf Floor( rowType ) < Floor( kClassRow ) Then
		      
		      // We went off the end of the previous folder.
		      
		      Exit
		      
		    End If
		  Next
		  
		  // We ran into the end of the listbox.
		  
		  // Well, guess it's not here.
		  
		  If autoMake Then
		    
		    lbox.InsertFolder( classRow +1, caseObject.TestMethodName, 1 )
		    lbox.RowTag( classRow +1 ) = kCaseRow
		    lbox.CellTag( classRow +1, 0 ) = caseObject
		    Return classRow +1
		    
		  End If
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindRowOfTestClass(lbox As Listbox, className As String, autoMake As Boolean = True) As Integer
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Finds or makes a row for the given test class results.
		  
		  Dim row, last As Integer
		  last = lbox.ListCount -1
		  
		  For row = 0 To last
		    
		    If lbox.RowTag( row ) = kClassRow Then
		      
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
		    lbox.RowTag( lbox.LastIndex ) = kClassRow
		    lbox.CellTag( lbox.LastIndex, 0 )  = className
		    Return lbox.LastIndex
		    
		  End If
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetSelectedExceptionsFromListbox(lbox As Listbox) As Pair()
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently selected in the given listbox.
		  
		  Dim result() As Pair
		  Dim currentClass As String
		  Dim currentCase As UnitTestResultKFS
		  
		  For row As Integer = 0 To lbox.ListCount -1
		    
		    If lbox.RowTag(row) = kClassRow Then
		      currentClass = lbox.CellTag(row,0)
		      currentCase = Nil
		    ElseIf lbox.CellTag(row,0) IsA UnitTestResultKFS Then
		      currentCase = lbox.CellTag(row,0)
		    End If
		    
		    If lbox.Selected( row ) Then
		      Select Case lbox.RowTag(row)
		      Case kClassRow
		        
		        // Add all exceptions for the whole class.
		        
		        For Each e As UnitTestExceptionKFS In myUnitTestArbiter.Exceptions( currentClass, True, False )
		          result.Append currentClass + ".Constructor:" : e
		        Next
		        For Each r As UnitTestResultKFS In myUnitTestArbiter.TestCaseResultContainers( currentClass )
		          For Each e As UnitTestExceptionKFS In r.e_Setup
		            result.Append r.TestClassName + "." + r.TestMethodName + " (Setup):" : e
		          Next
		          For Each e As UnitTestExceptionKFS In r.e_Core
		            result.Append r.TestClassName + "." + r.TestMethodName + ":" : e
		          Next
		          For Each e As UnitTestExceptionKFS In r.e_TearDown
		            result.Append r.TestClassName + "." + r.TestMethodName + " (Tear Down):" : e
		          Next
		        Next
		        
		        // Fast-forward to the next class.
		        
		        While row + 1 < lbox.ListCount And Floor( lbox.RowTag( row + 1 ) ) > Floor( kClassRow )
		          row = row + 1
		        Wend
		        
		      Case kClassSetupRow
		        
		        // Add all exceptions for class setup.
		        
		        For Each e As UnitTestExceptionKFS In myUnitTestArbiter.Exceptions( currentClass, True, False )
		          result.Append currentClass + ".Constructor:" : e
		        Next
		        
		      Case kCaseRow
		        
		        // Add all exceptions for this test case.
		        
		        For Each e As UnitTestExceptionKFS In currentCase.e_Setup
		          result.Append currentCase.TestClassName + "." + currentCase.TestMethodName + " (Setup):" : e
		        Next
		        For Each e As UnitTestExceptionKFS In currentCase.e_Core
		          result.Append currentCase.TestClassName + "." + currentCase.TestMethodName + ":" : e
		        Next
		        For Each e As UnitTestExceptionKFS In currentCase.e_TearDown
		          result.Append currentCase.TestClassName + "." + currentCase.TestMethodName + " (Tear Down):" : e
		        Next
		        
		        // Fast-forward to the next case or class.
		        
		        While row + 1 < lbox.ListCount And Floor( lbox.RowTag( row + 1 ) ) > Floor( kCaseRow )
		          row = row + 1
		        Wend
		        
		      Case kCaseSetupRow
		        
		        // Add the setup exceptions for this test case.
		        
		        For Each e As UnitTestExceptionKFS In currentCase.e_Setup
		          result.Append currentCase.TestClassName + "." + currentCase.TestMethodName + " (Setup):" : e
		        Next
		        
		      Case kCaseCoreRow
		        
		        // Add the core exceptions for this test case.
		        
		        For Each e As UnitTestExceptionKFS In currentCase.e_Core
		          result.Append currentCase.TestClassName + "." + currentCase.TestMethodName + ":" : e
		        Next
		        
		      Case kCaseTearDownRow
		        
		        // Add the tear down exceptions for this test case.
		        
		        For Each e As UnitTestExceptionKFS In currentCase.e_TearDown
		          result.Append currentCase.TestClassName + "." + currentCase.TestMethodName + " (Tear Down):" : e
		        Next
		        
		      End Select
		    End If
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertUpdatedTestEntry(lstOut As Listbox, arbSrc As UnitTestArbiterKFS, testCaseObject As UnitTestResultKFS)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the given test case entry in the given listbox.
		  
		  myListboxLock.Enter
		  
		  // We're going to need the result object, anyways...
		  // First, find the row for the test class.
		  
		  Dim classRow As Integer = FindRowOfTestClass( lstOut, testCaseObject.TestClassName )
		  
		  // Next, update the stats for the class.
		  
		  UpdateListboxRowData( lstOut, classRow, arbSrc, testCaseObject )
		  
		  // Is that folder open?
		  
		  If lstOut.Expanded( classRow ) Then
		    
		    // Find the row of the test.
		    
		    Dim caseRow As Integer = FindRowOfTestCase( lstOut, classRow, testCaseObject )
		    
		    // Update the stats for the row.
		    
		    UpdateListboxRowData( lstOut, caseRow, arbSrc, testCaseObject )
		    
		  End If
		  
		  // Now, refresh all the time percentages, since theoretically, time has elapsed.
		  
		  Dim row, last As Integer
		  last = lstOut.ListCount -1
		  Dim et As DurationKFS = arbSrc.ElapsedTime
		  Dim n As Double
		  For row = 0 To last
		    
		    UpdateTestTimeStats lstOut, row, lstOut.CellTag( row, 2 ), et
		    
		  Next
		  
		  // Automatically select the row?
		  
		  If AutoSelectErrors Then
		    If testCaseObject.TestCaseFailed Then
		      lstOut.Selected( classRow ) = True
		    End If
		  End If
		  
		  lstOut.Sort
		  
		  myListboxLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshDetailsBox()
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Refreshes the text in the details box.
		  
		  Dim newText As String = RenderDetails( GetSelectedExceptionsFromListbox( lstUnitTestResults ) )
		  
		  If Not DetailsBoxVisible Then
		    
		    If ( DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.FullAutomatic _
		      Or DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.HideUntilExceptions ) _
		      And newText <> "" Then
		      
		      DetailsBoxVisible = True
		      
		    End If
		  Else
		    If DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.FullAutomatic _
		      And newText = "" Then
		      
		      DetailsBoxVisible = False
		      
		    End If
		  End If
		  
		  txtDetails.Text = newText
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RenderDetails(listOfExceptions() As Pair) As String
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Converts the given pair array into plain text.
		  
		  Dim result(), prev As String
		  
		  For Each p As Pair In listOfExceptions
		    
		    If p.Left = prev Then
		      
		      result.Append p.Right
		      
		    Else
		      
		      result.Append p.Left + EndOfLineKFS + UnitTestExceptionKFS( p.Right ).Message
		      
		    End If
		  Next
		  
		  Return Join( result, EndOfLineKFS + EndOfLineKFS )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateControlLocations()
		  // Created 8/5/2010 by Andrew Keller
		  
		  Dim minSepPos As Integer
		  
		  If DetailsBoxVisible Then
		    
		    // Note: this code is equal to DetailsBoxVisible.Set, except that unneeded code is removed.
		    
		    Select Case DetailsBoxPosition
		    Case DetailsBoxPositions.Bottom
		      
		      lstUnitTestResults.Width = Self.Width
		      lstUnitTestResults.Height = ( Self.Height - lstUnitTestResults.Top - 12 ) * OldListboxHeightFraction
		      
		      txtDetails.Top = lstUnitTestResults.Top + lstUnitTestResults.Height + 12
		      txtDetails.Left = 0
		      txtDetails.Width = Self.Width
		      txtDetails.Height = Self.Height - txtDetails.Top
		      
		    Case DetailsBoxPositions.Right
		      
		      lstUnitTestResults.Width = ( Self.Width - 12 ) * OldListboxWidthFraction
		      lstUnitTestResults.Height = Self.Height - lstUnitTestResults.Top
		      
		      txtDetails.Top = lstUnitTestResults.Top
		      txtDetails.Left = lstUnitTestResults.Left + lstUnitTestResults.Width + 12
		      txtDetails.Width = Self.Width - txtDetails.Left
		      txtDetails.Height = Self.Height - txtDetails.Top
		      
		    End Select
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateListboxRowData(lbox As Listbox, row As Integer, arbSrc As UnitTestArbiterKFS, rsltObject As UnitTestResultKFS = Nil)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the data in the given row.
		  
		  // Assumes a lock has already been acquired.
		  
		  Dim rowType As Double = lbox.RowTag( row )
		  
		  If rowType = kClassRow Then
		    
		    Dim className As String = lbox.CellTag( row, 0 )
		    
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
		        lbox.Cell( row, 1 ) = "Passed"
		      Else
		        lbox.Cell( row, 1 ) = Join( s, ", " )
		      End If
		      
		      // And store a number in the cell tag for sorting.
		      lbox.CellTag( row, 1 ) = fa * 2 + sk
		      
		    Else
		      
		      // Well, here's an easy message.  Setup failed.
		      lbox.Cell( row, 1 ) = "Setup Failed"
		      
		      // Set the cell tag to something useful for sorting.
		      lbox.CellTag( row, 1 ) = 10 + arbSrc.CountSkippedTestCases( className )
		      
		    End If
		    
		    // Update the time stats:
		    UpdateTestTimeStats lbox, row, arbSrc.ElapsedTime( className ), arbSrc.ElapsedTime
		    
		  ElseIf rowType = kClassSetupRow Then
		    
		    Dim className As String = lbox.CellTag( row, 0 )
		    
		    // Did the class pass its setup routine?
		    
		    If arbSrc.TestClassSetupPassed( className ) Then
		      
		      lbox.Cell( row, 1 ) = "Passed"
		      lbox.CellTag( row, 1 ) = 0
		    Else
		      lbox.Cell( row, 1 ) = "Failed"
		      lbox.CellTag( row, 1 ) = 1
		      
		    End If
		    
		    // Update the time stats:
		    UpdateTestTimeStats lbox, row, arbSrc.ElapsedTime( className, True, False, False, False ), arbSrc.ElapsedTime
		    
		  ElseIf rowType = kCaseRow Then
		    
		    If rsltObject = Nil Then rsltObject = lbox.CellTag( row, 0 )
		    
		    // Did the case pass?
		    
		    If rsltObject.TestCasePassed Then
		      
		      lbox.Cell( row, 1 ) = "Passed"
		      lbox.CellTag( row, 1 ) = -1
		      
		    ElseIf rsltObject.TestCaseSkipped Or rsltObject.e_ClassSetup.Ubound > -1 Then
		      
		      lbox.Cell( row, 1 ) = "Skipped"
		      lbox.CellTag( row, 1 ) = 0
		      
		    ElseIf rsltObject.TestCaseFailed Then
		      
		      lbox.Cell( row, 1 ) = "Failed"
		      lbox.CellTag( row, 1 ) = 1
		      
		    End If
		    
		    // Update the time stats:
		    UpdateTestTimeStats lbox, row, rsltObject.t_Setup + rsltObject.t_Core + rsltObject.t_TearDown, arbSrc.ElapsedTime
		    
		  ElseIf rowType = kCaseSetupRow Then
		    
		    If rsltObject = Nil Then rsltObject = lbox.CellTag( row, 0 )
		    
		    // Did the case pass?
		    
		    If rsltObject.TestCaseSkipped Or rsltObject.e_ClassSetup.Ubound > -1 Then
		      
		      lbox.Cell( row, 1 ) = "Skipped"
		      lbox.CellTag( row, 1 ) = 0
		      
		    ElseIf rsltObject.e_Setup.Ubound < 0 Then
		      
		      lbox.Cell( row, 1 ) = "Passed"
		      lbox.CellTag( row, 1 ) = -1
		    Else
		      lbox.Cell( row, 1 ) = "Failed"
		      lbox.CellTag( row, 1 ) = 1
		      
		    End If
		    
		    // Update the time stats:
		    UpdateTestTimeStats lbox, row, rsltObject.t_Setup, arbSrc.ElapsedTime
		    
		  ElseIf rowType = kCaseCoreRow Then
		    
		    If rsltObject = Nil Then rsltObject = lbox.CellTag( row, 0 )
		    
		    // Did the case pass?
		    
		    If rsltObject.TestCaseSkipped Or rsltObject.e_ClassSetup.Ubound > -1 Or rsltObject.e_Setup.Ubound > -1 Then
		      
		      lbox.Cell( row, 1 ) = "Skipped"
		      lbox.CellTag( row, 1 ) = 0
		      
		    ElseIf rsltObject.e_Core.Ubound < 0 Then
		      
		      lbox.Cell( row, 1 ) = "Passed"
		      lbox.CellTag( row, 1 ) = -1
		      
		    Else
		      
		      lbox.Cell( row, 1 ) = "Failed"
		      lbox.CellTag( row, 1 ) = 1
		      
		    End If
		    
		    // Update the time stats:
		    UpdateTestTimeStats lbox, row, rsltObject.t_Core, arbSrc.ElapsedTime
		    
		  ElseIf rowType = kCaseTearDownRow Then
		    
		    If rsltObject = Nil Then rsltObject = lbox.CellTag( row, 0 )
		    
		    // Did the case pass?
		    
		    If rsltObject.TestCaseSkipped Or rsltObject.e_ClassSetup.Ubound > -1 Or rsltObject.e_Setup.Ubound > -1 Then
		      
		      lbox.Cell( row, 1 ) = "Skipped"
		      lbox.CellTag( row, 1 ) = 0
		      
		    ElseIf rsltObject.e_TearDown.Ubound < 0 Then
		      
		      lbox.Cell( row, 1 ) = "Passed"
		      lbox.CellTag( row, 1 ) = -1
		    Else
		      lbox.Cell( row, 1 ) = "Failed"
		      lbox.CellTag( row, 1 ) = 1
		      
		    End If
		    
		    // Update the time stats:
		    UpdateTestTimeStats lbox, row, rsltObject.t_TearDown, arbSrc.ElapsedTime
		    
		  ElseIf lbox.CellTag( row, 0 ) IsA UnitTestExceptionKFS Then
		    
		    Dim e As UnitTestExceptionKFS = lbox.CellTag( row, 0 )
		    
		    lbox.Cell( row, 0 ) = e.Message
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateTestTimeStats(lstOut As Listbox, row As Integer, seconds As DurationKFS, totalSeconds As DurationKFS)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the time stats for the given row.
		  
		  // Display total time:
		  
		  lstOut.Cell( row, 2 ) = Format( seconds.Value( DurationKFS.kMilliseconds ), "0\ \m\s" )
		  lstOut.CellTag( row, 2 ) = seconds
		  
		  // Display partial time:
		  
		  Dim d As Double = seconds / totalSeconds
		  
		  lstOut.Cell( row, 3 ) = Format( d, "0%" )
		  lstOut.CellTag( row, 3 ) = d
		  
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

	#tag Property, Flags = &h0
		AutoSelectErrors As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Returns the current value of the automatic hide/show ability of the details box.
			  
			  Return _dbvis
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Sets the value of the automatic hide/show ability of the details box.
			  
			  _dbvis = value
			  
			  // done.
			  
			End Set
		#tag EndSetter
		DetailsBoxAutoVisibility As DetailsBoxAutoVisibilityOptions
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Returns the relative position of the details box.
			  
			  Return _dbpos
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Sets the relative position of the details box.
			  
			  _dbpos = value
			  
			  DetailsBoxVisible = DetailsBoxVisible
			  
			  // done.
			  
			End Set
		#tag EndSetter
		DetailsBoxPosition As DetailsBoxPositions
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Returns whether or not the details box is visible.
			  
			  Return txtDetails.Visible
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Sets the visibility of the details box.
			  
			  txtDetails.Visible = value
			  
			  If value Then
			    Select Case DetailsBoxPosition
			    Case DetailsBoxPositions.Bottom
			      
			      lstUnitTestResults.Width = Self.Width
			      lstUnitTestResults.Height = ( Self.Height - lstUnitTestResults.Top - 12 ) * OldListboxHeightFraction
			      lstUnitTestResults.LockTop = True
			      lstUnitTestResults.LockBottom = False
			      lstUnitTestResults.LockLeft = True
			      lstUnitTestResults.LockRight = True
			      
			      txtDetails.Top = lstUnitTestResults.Top + lstUnitTestResults.Height + 12
			      txtDetails.Left = 0
			      txtDetails.Width = Self.Width
			      txtDetails.Height = Self.Height - txtDetails.Top
			      txtDetails.LockTop = False
			      txtDetails.LockBottom = False
			      txtDetails.LockLeft = True
			      txtDetails.LockRight = True
			      
			    Case DetailsBoxPositions.Right
			      
			      lstUnitTestResults.Width = ( Self.Width - 12 ) * OldListboxWidthFraction
			      lstUnitTestResults.Height = Self.Height - lstUnitTestResults.Top
			      lstUnitTestResults.LockTop = True
			      lstUnitTestResults.LockBottom = True
			      lstUnitTestResults.LockLeft = True
			      lstUnitTestResults.LockRight = False
			      
			      txtDetails.Top = lstUnitTestResults.Top
			      txtDetails.Left = lstUnitTestResults.Left + lstUnitTestResults.Width + 12
			      txtDetails.Width = Self.Width - txtDetails.Left
			      txtDetails.Height = Self.Height - txtDetails.Top
			      txtDetails.LockTop = True
			      txtDetails.LockBottom = True
			      txtDetails.LockLeft = False
			      txtDetails.LockRight = False
			      
			    End Select
			    
			  Else
			    
			    lstUnitTestResults.Width = Self.Width
			    lstUnitTestResults.Height = Self.Height - lstUnitTestResults.Top
			    lstUnitTestResults.LockTop = True
			    lstUnitTestResults.LockBottom = True
			    lstUnitTestResults.LockLeft = True
			    lstUnitTestResults.LockRight = True
			    
			  End If
			  
			  // Note: The following line is needed to work around a display bug in RB.
			  // If you're using a newer version than 2009r3, then try removing this line
			  // and see if the focus ring around lstUnitTestResults is correctly redrawn.
			  
			  Self.Refresh
			  
			  // done.
			  
			End Set
		#tag EndSetter
		DetailsBoxVisible As Boolean
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
			  
			  DetailsBoxVisible = DetailsBoxVisible
			  
			  // done.
			  
			End Set
		#tag EndSetter
		HeadingVisible As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected myListboxLock As CriticalSection
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Returns what the height fraction of the details box the last time it was set.
			  
			  Return _dbheightf
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Protected OldListboxHeightFraction As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  // Created 8/5/2010 by Andrew Keller
			  
			  // Returns what the width fraction of the details box the last time it was set.
			  
			  Return _dbwidthf
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Protected OldListboxWidthFraction As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected _dbheightf As Double = .5
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected _dbpos As DetailsBoxPositions
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected _dbvis As DetailsBoxAutoVisibilityOptions
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected _dbwidthf As Double = .5
	#tag EndProperty


	#tag Constant, Name = kCaseCoreRow, Type = Double, Dynamic = False, Default = \"3.5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseRow, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseSetupRow, Type = Double, Dynamic = False, Default = \"3.25", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseTearDownRow, Type = Double, Dynamic = False, Default = \"3.75", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kClassRow, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kClassSetupRow, Type = Double, Dynamic = False, Default = \"3.125", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kGreen, Type = Color, Dynamic = False, Default = \"&c00DD00", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kRed, Type = Color, Dynamic = False, Default = \"&cEE0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kYellow, Type = Color, Dynamic = False, Default = \"&cE4D300", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = DetailsBoxAutoVisibilityOptions, Type = Integer, Flags = &h0
		FullManual
		  FullAutomatic
		HideUntilExceptions
	#tag EndEnum

	#tag Enum, Name = DetailsBoxPositions, Type = Integer, Flags = &h0
		Right
		Bottom
	#tag EndEnum


#tag EndWindowCode

#tag Events lstUnitTestResults
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Compares the given rows.
		  
		  If column = 1 Or column = 3 Then
		    
		    Dim t1 As Double = Me.CellTag( row1, column )
		    Dim t2 As Double = Me.CellTag( row2, column )
		    
		    If t1 < t2 Then
		      
		      result = -1
		      
		    ElseIf t1 > t2 Then
		      
		      result = 1
		      
		    Else
		      
		      result = 0
		      
		    End If
		    
		    Return True
		    
		  ElseIf column = 2 Then
		    
		    Try
		      result = DurationKFS( Me.CellTag( row1, column ) ).Operator_Compare( DurationKFS( Me.CellTag( row2, column ) ) )
		      Return True
		    Catch err As RuntimeException
		      NewStatusReportKFS "UnitTestViewKFS.lstUnitTestResults.CompareRows", 0, True, "An exception was raised when trying to access one of the duration cell tags.", err.Message
		    End Try
		    
		  ElseIf column = 0 Then
		    
		    Dim t1 As Double = Me.RowTag( row1 )
		    Dim t2 As Double= Me.RowTag( row2 )
		    
		    If Floor( t1 ) = floor( t2 ) And t1 <> t2 Then
		      
		      // These items are at the same "level"
		      
		      // Compare using our fancy order.
		      
		      If t1 < t2 Then
		        result = -1
		      ElseIf t1 > t2 Then
		        result = 1
		      Else
		        result = 0
		      End If
		      
		      Return True
		      
		    End If
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
		  Me.ColumnSortDirection( 0 ) = Listbox.SortAscending
		  Me.ColumnSortDirection( 1 ) = Listbox.SortDescending
		  Me.ColumnSortDirection( 2 ) = Listbox.SortDescending
		  Me.ColumnSortDirection( 3 ) = Listbox.SortDescending
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Make the text the right color and style:
		  
		  If column = 1 Then
		    
		    Dim s As String = Me.Cell( row, column )
		    
		    If InStr( s, "failed" ) > 0 Then
		      
		      g.ForeColor = kRed
		      
		    ElseIf InStr( s, "skipped" ) > 0 Then
		      
		      g.ForeColor = kYellow
		      
		    ElseIf InStr( s, "passed" ) > 0 Then
		      
		      g.ForeColor = kGreen
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub CollapseRow(row As Integer)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Removes the items involved with the given folder.
		  
		  // The row ID constants are in numerical order of hierarchies...
		  // This means that removing rows becomes easier...
		  // Just delete the succeeding rows with higher row IDs.
		  
		  myListboxLock.Enter
		  
		  Dim rowType As Integer = Me.RowTag( row )
		  
		  // We are assuming that this row is guaranteed to be
		  // an expanded folder, because this event was fired.
		  
		  While row + 1 < Me.ListCount And Floor( Me.RowTag( row + 1 ) ) > rowType
		    
		    Me.RemoveRow row + 1
		    
		  Wend
		  
		  myListboxLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub ExpandRow(row As Integer)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Adds rows for each test case and refreshes them.
		  
		  myListboxLock.Enter
		  
		  Dim rowType As Double = Me.RowTag( row )
		  Select Case rowType
		  Case kClassRow
		    
		    Me.AddRow "Constructor"
		    Me.RowTag( Me.LastIndex ) = kClassSetupRow
		    Me.CellTag( Me.LastIndex, 0 ) = Me.Cell( row, 0 )
		    UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter
		    
		    For Each r As UnitTestResultKFS In myUnitTestArbiter.TestCaseResultContainers( Me.CellTag( row, 0 ) )
		      
		      Me.AddFolder r.TestMethodName
		      Me.RowTag( Me.LastIndex ) = kCaseRow
		      Me.CellTag( Me.LastIndex, 0 ) = r
		      UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, r
		      
		    Next
		    
		  Case kClassSetupRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Class Setup Rows were not intended to be folders."
		    
		  Case kCaseRow
		    
		    Dim r As UnitTestResultKFS = Me.CellTag( row, 0 )
		    
		    Me.AddRow "Setup"
		    Me.RowTag( Me.LastIndex ) = kCaseSetupRow
		    Me.CellTag( Me.LastIndex, 0 ) = r
		    UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, r
		    
		    Me.AddRow "Core"
		    Me.RowTag( Me.LastIndex ) = kCaseCoreRow
		    Me.CellTag( Me.LastIndex, 0 ) = r
		    UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, r
		    
		    Me.AddRow "Tear Down"
		    Me.RowTag( Me.LastIndex ) = kCaseTearDownRow
		    Me.CellTag( Me.LastIndex, 0 ) = r
		    UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, r
		    
		  Case kCaseSetupRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Case Setup Rows were not intended to be folders."
		    
		  Case kCaseCoreRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Class Core Rows were not intended to be folders."
		    
		  Case kCaseTearDownRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Class Tear Down Rows were not intended to be folders."
		    
		  End Select
		  
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
		    
		    Dim rowType As Double = Me.RowTag( row )
		    Dim c As Color
		    
		    If rowType = kClassRow Then
		      
		      g.ForeColor = &cEEEEFF
		      
		      If column = 0 Then
		        
		        g.FillRoundRect 17, 0, 16, g.Height, 8, 8
		        g.FillRect 25, 0, g.Width, g.Height
		        
		      Else
		        
		        g.FillRect 0, 0, g.Width, g.Height
		        
		      End If
		      
		    ElseIf rowType = kCaseSetupRow Or rowType = kCaseCoreRow Or rowType = kCaseTearDownRow Then
		      
		      g.ForeColor = &cF0F0F0
		      
		      If column = 0 Then
		        
		        g.FillRoundRect 41, 0, 16, g.Height, 8, 8
		        g.FillRect 49, 0, g.Width, g.Height
		        
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
	#tag Event
		Sub Change()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Refresh the details box.
		  
		  Static prevSelCount As Integer = 0
		  Static prevListIndex As Integer = -1
		  
		  If Me.SelCount <> prevSelCount Or Me.ListIndex <> prevListIndex Then
		    
		    prevSelCount = Me.SelCount
		    prevListIndex = Me.ListIndex
		    RefreshDetailsBox
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events myUnitTestArbiter
	#tag Event
		Sub TestFinished(testCaseObject As UnitTestResultKFS)
		  // Refresh the interactive report:
		  
		  lblUnitTestReportHeading.Caption = Me.PlaintextHeading
		  InsertUpdatedTestEntry lstUnitTestResults, myUnitTestArbiter, testCaseObject
		  RefreshDetailsBox
		  
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
