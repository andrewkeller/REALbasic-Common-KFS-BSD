#tag Window
Begin Window UnitTestWindowKFS
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   316
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Unit Test Results"
   Visible         =   True
   Width           =   635
   Begin Listbox lstUnitTestResults
      AutoDeactivate  =   True
      AutoHideScrollbars=   False
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
      Height          =   250
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   46
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   635
      _ScrollWidth    =   -1
   End
   Begin Label lblUnitTestReportHeading
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
      Left            =   20
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   2
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      Text            =   "No unit test results to display."
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   567
   End
   Begin TextArea txtDetails
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   16777215
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
      Scope           =   2
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   336
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   False
      Width           =   100
   End
   Begin UnitTestArbiterKFS myUnitTestArbiter
      Height          =   32
      Index           =   -2147483648
      Left            =   712
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      TabPanelIndex   =   0
      Top             =   212
      Width           =   32
   End
   Begin Timer refreshTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   712
      LockedInPosition=   False
      Mode            =   0
      Period          =   100
      Scope           =   2
      TabPanelIndex   =   0
      Top             =   158
      Width           =   32
   End
   Begin ProgressWheel pgwTestsRunning
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   599
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   15
      Visible         =   False
      Width           =   16
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Initialize this class.
		  
		  lb_StatusUpdatePool = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Rearrange the pieces of this container control based on the dimensions.
		  
		  If Self.Width > 800 Then
		    
		    DetailsBoxPosition = DetailsBoxPositions.Right
		    DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.HideUntilExceptions
		    
		  Else
		    
		    DetailsBoxPosition = DetailsBoxPositions.Bottom
		    DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.FullAutomatic
		    
		  End If
		  
		  // Update the positions of the controls.
		  
		  UpdateControlLocations
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Rearrange the pieces of this container control based on the dimensions.
		  
		  If Self.Width > 800 Then
		    
		    DetailsBoxPosition = DetailsBoxPositions.Right
		    DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.HideUntilExceptions
		    
		  Else
		    
		    DetailsBoxPosition = DetailsBoxPositions.Bottom
		    DetailsBoxAutoVisibility = DetailsBoxAutoVisibilityOptions.FullAutomatic
		    
		  End If
		  
		  // Update the positions of the controls.
		  
		  UpdateControlLocations
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function FindRowOfTestCase(lbox As Listbox, classRow As Integer, testCaseID As Int64, testCaseName As String = "") As Integer
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Finds or makes a row for the given test case results.
		  
		  If Not lbox.Expanded( classRow ) Then Return -1
		  
		  Dim row, last As Integer
		  last = lbox.ListCount -1
		  
		  For row = classRow + 1 To last
		    
		    Dim rowObjID As Int64 = lbox.CellTag( row, 0 )
		    
		    If rowObjID = testCaseID Then
		      
		      // Found it!
		      
		      Return row
		      
		    ElseIf Floor( lbox.RowTag( row ).DoubleValue ) < Floor( kCaseRow ) Then
		      
		      // We have encountered another class row, which means
		      // we are no longer inside the folder for the class.
		      
		      Exit
		      
		    End If
		  Next
		  
		  // We ran into the end of the listbox or folder.
		  
		  // Well, guess it's not here.
		  
		  If testCaseName <> "" Then
		    
		    lbox.InsertFolder( classRow +1, testCaseName, 1 )
		    lbox.RowTag( classRow +1 ) = kCaseRow
		    lbox.CellTag( classRow +1, 0 ) = testCaseID
		    Return classRow +1
		    
		  End If
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindRowOfTestClass(lbox As Listbox, testClassID As Int64, testClassName As String = "") As Integer
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Finds or makes a row for the given test class results.
		  
		  Dim row, last As Integer
		  last = lbox.ListCount -1
		  
		  For row = 0 To last
		    
		    If lbox.CellTag( row, 0 ) = testClassID Then
		      
		      // Found it.
		      
		      Return row
		      
		    End If
		  Next
		  
		  // Well, guess it's not here.
		  
		  If testClassName <> "" Then
		    
		    lbox.AddFolder testClassName
		    lbox.RowTag( lbox.LastIndex ) = kClassRow
		    lbox.CellTag( lbox.LastIndex, 0 )  = testClassID
		    Return lbox.LastIndex
		    
		  End If
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub GetSelectedExceptionsFromListbox(lbox As Listbox, arbSrc As UnitTestArbiterKFS, ByRef caseLabels() As String, ByRef caseExceptionSummaries() As String)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Returns a list of all the exceptions currently selected in the given listbox.
		  
		  ReDim caseLabels( -1 )
		  ReDim caseExceptionSummaries( -1 )
		  
		  Dim togo As Integer = lbox.ListCount
		  If togo > 0 Then
		    For row As Integer = lbox.ListIndex To lbox.ListCount -1
		      
		      If lbox.Selected( row ) Then
		        
		        Dim rowType As Double = lbox.RowTag( row )
		        Dim rowObjID As Int64 = lbox.CellTag( row, 0 )
		        
		        Select Case rowType
		        Case kClassRow
		          
		          arbSrc.q_ListExceptionSummariesForClass( rowObjID, caseLabels, caseExceptionSummaries, False )
		          
		          // Fast-forward to the next class.
		          
		          While row + 1 < lbox.ListCount And Floor( lbox.RowTag( row + 1 ) ) > Floor( kClassRow )
		            row = row + 1
		          Wend
		          
		        Case kCaseRow
		          
		          arbSrc.q_ListExceptionSummariesForCase( rowObjID, caseLabels, caseExceptionSummaries, False )
		          
		          // Fast-forward to the next case or class.
		          
		          While row + 1 < lbox.ListCount And Floor( lbox.RowTag( row + 1 ) ) > Floor( kCaseRow )
		            row = row + 1
		          Wend
		          
		        Case kCaseSetupRow
		          
		          arbSrc.q_ListExceptionSummariesForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Setup, caseLabels, caseExceptionSummaries, False )
		          
		        Case kCaseCoreRow
		          
		          arbSrc.q_ListExceptionSummariesForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Core, caseLabels, caseExceptionSummaries, False )
		          
		        Case kCaseVerificationRow
		          
		          arbSrc.q_ListExceptionSummariesForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Verification, caseLabels, caseExceptionSummaries, False )
		          
		        Case kCaseTearDownRow
		          
		          arbSrc.q_ListExceptionSummariesForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.TearDown, caseLabels, caseExceptionSummaries, False )
		          
		        End Select
		      End If
		      
		      // Decrement togo, in case we can bail out early.
		      
		      togo = togo - 1
		      If togo = 0 Then Exit
		      
		    Next
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertUpdatedTestEntry(lstOut As Listbox, arbSrc As UnitTestArbiterKFS, testClassID As Int64, testClassName As String, testCaseID As Int64, testCaseName As String)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the given test case entry in the given listbox.
		  
		  // First, find the row for the test class.
		  
		  lb_UpdateInProgress = lb_UpdateInProgress +1
		  
		  Dim classRow As Integer = FindRowOfTestClass( lstOut, testClassID, testClassName )
		  
		  // Next, tag this row for getting its status and time
		  // fields updated in the EventGatheringFinished event:
		  
		  lb_StatusUpdatePool.Value( testClassID ) = True
		  
		  // Is that folder open?
		  
		  If lstOut.Expanded( classRow ) Then
		    
		    // Find the row of the test.
		    
		    Dim caseRow As Integer = FindRowOfTestCase( lstOut, classRow, testCaseID, testCaseName )
		    
		    // Update the stats for the row.
		    
		    UpdateListboxRowData( lstOut, caseRow, arbSrc )
		    
		    // Is the test case folder open?
		    
		    If lstOut.Expanded( caseRow ) Then
		      
		      // Update each of the stages:
		      
		      For stageRow As Integer = caseRow +1 To lstOut.ListCount -1
		        
		        If Floor( lstOut.RowTag( stageRow ).DoubleValue ) < Floor( kCaseSetupRow ) Then Exit
		        
		        UpdateListboxRowData( lstOut, stageRow, arbSrc )
		        
		      Next
		    End If
		  End If
		  
		  // The timer will update the status messages time percentages when it gets around to it.
		  
		  lb_UpdateInProgress = lb_UpdateInProgress -1
		  
		  // Listbox sorting is intended to be done in the EventGaterhingFinished event.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessTestClasses(lst() As UnitTestBaseClassKFS)
		  // Created 3/18/2011 by Andrew Keller
		  
		  // Makes sure that this window is visible, and instructs the arbiter to process the given test classes.
		  
		  Self.Show
		  
		  Arbiter.CreateJobsForTestClasses lst
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessTestClasses(ParamArray lst As UnitTestBaseClassKFS)
		  // Created 3/18/2011 by Andrew Keller
		  
		  // An overloaded version of ProcessTestClasses.
		  
		  ProcessTestClasses lst
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshDetailsBox()
		  // Created 8/5/2010 by Andrew Keller
		  
		  // Refreshes the text in the details box.
		  
		  lb_prevSelCount = lstUnitTestResults.SelCount
		  lb_prevListIndex = lstUnitTestResults.ListIndex
		  
		  Dim caseLabels() As String
		  Dim caseExceptionSummaries() As String
		  
		  GetSelectedExceptionsFromListbox( lstUnitTestResults, myUnitTestArbiter, caseLabels, caseExceptionSummaries )
		  
		  Dim newText As String = myUnitTestArbiter.q_GetPlaintextReportBodyForExceptionSummaries( caseLabels, caseExceptionSummaries )
		  
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
		      lstUnitTestResults.Height = ( Self.Height - lstUnitTestResults.Top - 12 - 20 ) * OldListboxHeightFraction
		      
		      txtDetails.Top = lstUnitTestResults.Top + lstUnitTestResults.Height + 12
		      txtDetails.Left = 0
		      txtDetails.Width = Self.Width
		      txtDetails.Height = Self.Height - txtDetails.Top - 20
		      
		    Case DetailsBoxPositions.Right
		      
		      lstUnitTestResults.Width = ( Self.Width - 12 ) * OldListboxWidthFraction
		      lstUnitTestResults.Height = Self.Height - lstUnitTestResults.Top - 20
		      
		      txtDetails.Top = lstUnitTestResults.Top
		      txtDetails.Left = lstUnitTestResults.Left + lstUnitTestResults.Width + 12
		      txtDetails.Width = Self.Width - txtDetails.Left
		      txtDetails.Height = Self.Height - txtDetails.Top - 20
		      
		    End Select
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateListboxRowData(lbox As Listbox, idsToUpdate As Dictionary, arbSrc As UnitTestArbiterKFS, totalSeconds As DurationKFS = Nil, selectIfError As Boolean = False)
		  // Created 2/16/2010 by Andrew Keller
		  
		  // Updates the data in the rows specified in the given Dictionary.
		  
		  For row As Integer = 0 To lbox.ListCount -1
		    
		    If idsToUpdate.HasKey( lbox.CellTag( row, 0 ) ) Then
		      
		      UpdateListboxRowData lbox, row, arbSrc, totalSeconds, selectIfError
		      
		    End If
		    
		  Next
		  
		  idsToUpdate.Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateListboxRowData(lbox As Listbox, row As Integer, arbSrc As UnitTestArbiterKFS, totalSeconds As DurationKFS = Nil, selectIfError As Boolean = False)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the data in the given row.
		  
		  Dim rowType As Double = lbox.RowTag( row )
		  Dim rowObjID As Int64 = lbox.CellTag( row, 0 )
		  
		  Dim rowStatus As String
		  Dim sortCue As Integer
		  
		  Dim rowTime As DurationKFS
		  
		  Select Case rowType
		  Case kClassRow
		    
		    rowStatus = arbSrc.q_GetStatusBlurbAndSortCueOfTestClass( rowObjID, sortCue )
		    rowTime = arbSrc.q_GetElapsedTimeForClass( rowObjID )
		    
		  Case kCaseRow
		    
		    rowStatus = arbSrc.q_GetStatusBlurbAndSortCueOfTestCase( rowObjID, sortCue )
		    rowTime = arbSrc.q_GetElapsedTimeForCase( rowObjID )
		    
		  Case kCaseSetupRow
		    
		    rowStatus = arbSrc.q_GetStatusBlurbAndSortCueOfTestCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Setup, sortCue )
		    rowTime = arbSrc.q_GetElapsedTimeForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Setup )
		    
		  Case kCaseCoreRow
		    
		    rowStatus = arbSrc.q_GetStatusBlurbAndSortCueOfTestCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Core, sortCue )
		    rowTime = arbSrc.q_GetElapsedTimeForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Core )
		    
		  Case kCaseVerificationRow
		    
		    rowStatus = arbSrc.q_GetStatusBlurbAndSortCueOfTestCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Verification, sortCue )
		    rowTime = arbSrc.q_GetElapsedTimeForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.Verification )
		    
		  Case kCaseTearDownRow
		    
		    rowStatus = arbSrc.q_GetStatusBlurbAndSortCueOfTestCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.TearDown, sortCue )
		    rowTime = arbSrc.q_GetElapsedTimeForCaseDuringStage( rowObjID, UnitTestArbiterKFS.StageCodes.TearDown )
		    
		  Else
		    
		    MsgBox "Unsupported row type: " + Str( rowType )
		    
		  End Select
		  
		  lbox.Cell( row, 1 ) = rowStatus
		  lbox.CellTag( row, 1 ) = sortCue
		  
		  UpdateTestTimeValue lbox, row, rowTime, totalSeconds
		  
		  // Automatically select the row?
		  
		  If selectIfError And sortCue > 0 Then lbox.Selected( row ) = True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateTestTimePercentage(lstOut As Listbox, row As Integer, seconds As DurationKFS, totalSeconds As DurationKFS)
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Updates the time percentage for the given row.
		  
		  If seconds Is Nil Then seconds = New DurationKFS
		  If totalSeconds Is Nil Then totalSeconds = New DurationKFS
		  
		  // Display partial time:
		  
		  Dim d As Double = seconds / totalSeconds
		  
		  lstOut.Cell( row, 3 ) = Format( d, "0%" )
		  lstOut.CellTag( row, 3 ) = d
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateTestTimePercentages(lbox As Listbox, arbSrc As UnitTestArbiterKFS)
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Updates the time percentages of all rows in the given listbox.
		  
		  Dim totalSeconds As DurationKFS = arbSrc.q_GetElapsedTime
		  
		  For row As Integer = 0 To lbox.ListCount -1
		    
		    UpdateTestTimePercentage lbox, row, lbox.CellTag( row, 2 ), totalSeconds
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub UpdateTestTimeValue(lstOut As Listbox, row As Integer, seconds As DurationKFS, totalSeconds As DurationKFS = Nil)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Updates the time value for the given row, and optionally, also the time percentage.
		  
		  If seconds Is Nil Then seconds = New DurationKFS
		  
		  // Display total time:
		  
		  lstOut.Cell( row, 2 ) = seconds.ShortHumanReadableStringValue( DurationKFS.kMilliseconds )
		  lstOut.CellTag( row, 2 ) = seconds
		  
		  // Display partial time:
		  
		  If Not ( totalSeconds Is Nil ) Then UpdateTestTimePercentage lstOut, row, seconds, totalSeconds
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, 2011 Andrew Keller.
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
			  
			  If _dbpos <> value Then
			    
			    _dbpos = value
			    
			    DetailsBoxVisible = DetailsBoxVisible
			    
			  End If
			  
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
			      lstUnitTestResults.Height = ( Self.Height - lstUnitTestResults.Top - 12 - 20 ) * OldListboxHeightFraction
			      lstUnitTestResults.LockTop = True
			      lstUnitTestResults.LockBottom = False
			      lstUnitTestResults.LockLeft = True
			      lstUnitTestResults.LockRight = True
			      
			      txtDetails.Top = lstUnitTestResults.Top + lstUnitTestResults.Height + 12
			      txtDetails.Left = 0
			      txtDetails.Width = Self.Width
			      txtDetails.Height = Self.Height - txtDetails.Top - 20
			      txtDetails.LockTop = False
			      txtDetails.LockBottom = False
			      txtDetails.LockLeft = True
			      txtDetails.LockRight = True
			      
			    Case DetailsBoxPositions.Right
			      
			      lstUnitTestResults.Width = ( Self.Width - 12 ) * OldListboxWidthFraction
			      lstUnitTestResults.Height = Self.Height - lstUnitTestResults.Top - 20
			      lstUnitTestResults.LockTop = True
			      lstUnitTestResults.LockBottom = True
			      lstUnitTestResults.LockLeft = True
			      lstUnitTestResults.LockRight = False
			      
			      txtDetails.Top = lstUnitTestResults.Top
			      txtDetails.Left = lstUnitTestResults.Left + lstUnitTestResults.Width + 12
			      txtDetails.Width = Self.Width - txtDetails.Left
			      txtDetails.Height = Self.Height - txtDetails.Top - 20
			      txtDetails.LockTop = True
			      txtDetails.LockBottom = True
			      txtDetails.LockLeft = False
			      txtDetails.LockRight = False
			      
			    End Select
			    
			  Else
			    
			    lstUnitTestResults.Width = Self.Width
			    lstUnitTestResults.Height = Self.Height - lstUnitTestResults.Top - 20
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

	#tag Property, Flags = &h21
		Private lb_prevListIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lb_prevSelCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lb_StatusUpdatePool As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lb_UpdateInProgress As Integer
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


	#tag Constant, Name = kCaseCoreRow, Type = Double, Dynamic = False, Default = \"3.25", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseRow, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseSetupRow, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseTearDownRow, Type = Double, Dynamic = False, Default = \"3.75", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaseVerificationRow, Type = Double, Dynamic = False, Default = \"3.5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kClassRow, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kGreen, Type = Color, Dynamic = False, Default = \"&c00DD00", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kRed, Type = Color, Dynamic = False, Default = \"&cEE0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kYellow, Type = Color, Dynamic = False, Default = \"&cE4D300", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = DetailsBoxAutoVisibilityOptions, Flags = &h0
		FullManual
		  FullAutomatic
		HideUntilExceptions
	#tag EndEnum

	#tag Enum, Name = DetailsBoxPositions, Flags = &h0
		Right
		Bottom
	#tag EndEnum


#tag EndWindowCode

#tag Events lstUnitTestResults
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  // Created 8/3/2010 by Andrew Keller
		  
		  // Compares the given rows.
		  
		  If column = 0 Then
		    
		    // Compare based on row type.
		    
		    Dim t1 As Double = Me.RowTag( row1 )
		    Dim t2 As Double = Me.RowTag( row2 )
		    
		    If Floor( t1 ) = Floor( t2 ) And t1 <> t2 Then
		      
		      If t1 < t2 Then
		        result = -1
		      ElseIf t1 > t2 Then
		        result = 1
		      Else
		        
		        // Okay, so they're the same type.
		        // Compare based on text.
		        
		        Dim s1 As String = Me.Cell( row1, 0 )
		        Dim s2 As String = Me.Cell( row2, 0 )
		        
		        If s1 < s2 Then
		          result = -1
		        ElseIf s1 > s2 Then
		          result = 1
		        Else
		          result = 0
		        End If
		      End If
		      
		      Return True
		      
		    End If
		    
		  ElseIf column = 1 Then
		    
		    // Compare based on frequency of errors.
		    
		    Dim t1 As Double = Me.CellTag( row1, 1 )
		    Dim t2 As Double = Me.CellTag( row2, 1 )
		    
		    If t1 < t2 Then
		      result = -1
		    ElseIf t1 > t2 Then
		      result = 1
		    Else
		      
		      // Okay, so they have the same number of errors.
		      // Compare based on row type.
		      
		      t1 = Me.RowTag( row1 )
		      t2 = Me.RowTag( row2 )
		      
		      If t1 = t2 Then
		        
		        // Okay, so they're the same type.
		        // Compare based on the text in the left column.
		        
		        Dim s1 As String = Me.Cell( row1, 0 )
		        Dim s2 As String = Me.Cell( row2, 0 )
		        
		        If s1 < s2 Then
		          result = 1 * Me.ColumnSortDirection(0)
		        ElseIf s1 > s2 Then
		          result = -1 * Me.ColumnSortDirection(0)
		        Else
		          result = 0
		        End If
		        
		      Else
		        
		        // They are different row types, and they might or might not be at the same level.
		        
		        If t1 < t2 Then
		          result = 1 * Me.ColumnSortDirection(0)
		        ElseIf t1 > t2 Then
		          result = -1 * Me.ColumnSortDirection(0)
		        End If
		        
		      End If
		    End If
		    
		    Return True
		    
		  ElseIf column = 2 Or column = 3 Then
		    
		    // Compare based on the DurationKFS object in the time column.
		    
		    Try
		      result = DurationKFS( Me.CellTag( row1, 2 ) ).Operator_Compare( DurationKFS( Me.CellTag( row2, 2 ) ) )
		      Return True
		    Catch err As RuntimeException
		      MsgBox "An exception was raised when trying to access one of the duration cell tags: " + err.Message
		    End Try
		    
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
		  
		  Dim rowType As Integer = Me.RowTag( row )
		  
		  // We are assuming that this row is guaranteed to be
		  // an expanded folder, because this event was fired.
		  
		  lb_UpdateInProgress = lb_UpdateInProgress +1
		  
		  While row + 1 < Me.ListCount And Floor( Me.RowTag( row + 1 ) ) > rowType
		    
		    Me.RemoveRow row + 1
		    
		  Wend
		  
		  lb_UpdateInProgress = lb_UpdateInProgress -1
		  
		  If lb_UpdateInProgress = 0 Then RefreshDetailsBox
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub ExpandRow(row As Integer)
		  // Created 8/4/2010 by Andrew Keller
		  
		  // Adds rows for each test case and refreshes them.
		  
		  lb_UpdateInProgress = lb_UpdateInProgress +1
		  
		  Dim totalSeconds As DurationKFS = myUnitTestArbiter.q_GetElapsedTime
		  
		  Dim rowType As Double = Me.RowTag( row )
		  Select Case rowType
		  Case kClassRow
		    
		    For Each case_id As Int64 In myUnitTestArbiter.q_ListTestCasesInClass( Me.CellTag( row, 0 ) )
		      
		      Dim case_name As String
		      myUnitTestArbiter.q_GetTestCaseInfo case_id, case_name
		      
		      Me.AddFolder case_name
		      Me.RowTag( Me.LastIndex ) = kCaseRow
		      Me.CellTag( Me.LastIndex, 0 ) = case_id
		      UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, totalSeconds
		      
		    Next
		    
		  Case kCaseRow
		    
		    Dim case_id As Int64 = Me.CellTag( row, 0 )
		    
		    For Each stage As UnitTestArbiterKFS.StageCodes In myUnitTestArbiter.q_ListStagesOfTestCase( case_id )
		      Select Case stage
		      Case UnitTestArbiterKFS.StageCodes.Setup
		        
		        Me.AddRow "Setup"
		        Me.RowTag( Me.LastIndex ) = kCaseSetupRow
		        Me.CellTag( Me.LastIndex, 0 ) = case_id
		        UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, totalSeconds
		        
		      Case UnitTestArbiterKFS.StageCodes.Core
		        
		        Me.AddRow "Core"
		        Me.RowTag( Me.LastIndex ) = kCaseCoreRow
		        Me.CellTag( Me.LastIndex, 0 ) = case_id
		        UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, totalSeconds
		        
		      Case UnitTestArbiterKFS.StageCodes.Verification
		        
		        Me.AddRow "Verification"
		        Me.RowTag( Me.LastIndex ) = kCaseVerificationRow
		        Me.CellTag( Me.LastIndex, 0 ) = case_id
		        UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, totalSeconds
		        
		      Case UnitTestArbiterKFS.StageCodes.TearDown
		        
		        Me.AddRow "Tear Down"
		        Me.RowTag( Me.LastIndex ) = kCaseTearDownRow
		        Me.CellTag( Me.LastIndex, 0 ) = case_id
		        UpdateListboxRowData Me, Me.LastIndex, myUnitTestArbiter, totalSeconds
		        
		      Else
		        
		        // Um...  The arbiter was updated without this class...
		        MsgBox "Unsupported test case stage code: "+Str(stage)
		        
		      End Select
		    Next
		    
		  Case kCaseSetupRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Case Setup Rows were not intended to be folders."
		    
		  Case kCaseCoreRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Class Core Rows were not intended to be folders."
		    
		  Case kCaseVerificationRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Class Verification Rows were not intended to be folders."
		    
		  Case kCaseTearDownRow
		    
		    // Um...  This should never happen...
		    MsgBox "Test Class Tear Down Rows were not intended to be folders."
		    
		  End Select
		  
		  Me.Sort
		  
		  lb_UpdateInProgress = lb_UpdateInProgress -1
		  
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
		      
		    ElseIf rowType = kCaseSetupRow _
		      Or rowType = kCaseCoreRow _
		      Or rowType = kCaseVerificationRow _
		      Or rowType = kCaseTearDownRow Then
		      
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
		  Case 29 // ASCII Right Arrow
		    
		    lb_UpdateInProgress = lb_UpdateInProgress +1
		    For row As Integer = Me.ListCount -1 DownTo 0
		      If Me.Selected( row ) Then
		        Me.Expanded( row ) = True
		      End If
		    Next
		    lb_UpdateInProgress = lb_UpdateInProgress -1
		    
		    If lb_UpdateInProgress = 0 Then RefreshDetailsBox
		    
		    Return True
		    
		  Case 28 // ASCII Left Arrow
		    
		    lb_UpdateInProgress = lb_UpdateInProgress +1
		    For row As Integer = 0 To Me.ListCount -1
		      If Me.Selected( row ) Then
		        Me.Expanded( row ) = False
		      End If
		    Next
		    lb_UpdateInProgress = lb_UpdateInProgress -1
		    
		    If lb_UpdateInProgress = 0 Then RefreshDetailsBox
		    
		    Return True
		    
		  Case 27 // ASCII Escape
		    
		    lstUnitTestResults.ListIndex = -1
		    
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
		  
		  If lb_UpdateInProgress = 0 Then
		    If Me.SelCount <> lb_prevSelCount Or Me.ListIndex <> lb_prevListIndex Then
		      
		      RefreshDetailsBox
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events myUnitTestArbiter
	#tag Event
		Sub TestResultUpdated(resultRecordID As Int64, testClassID As Int64, testClassName As String, testCaseID As Int64, testCaseName As String, resultStatus As UnitTestArbiterKFS.StatusCodes, setupTime As DurationKFS, coreTime As DurationKFS, tearDownTime As DurationKFS)
		  // Refresh the interactive report:
		  
		  InsertUpdatedTestEntry lstUnitTestResults, myUnitTestArbiter, testClassID, testClassName, testCaseID, testCaseName
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub EventGatheringStarted()
		  // Disable events in the listbox, so that our messing
		  // with it won't hog too much time with refreshes:
		  
		  // Disable listbox events:
		  
		  lb_UpdateInProgress = lb_UpdateInProgress +1
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub EventGatheringFinished()
		  // Invoke the post-update refresh routines (including the
		  // ones we supressed in the EventGatheringStarted event)
		  
		  // Update the class rows that were modified:
		  
		  UpdateListboxRowData lstUnitTestResults, lb_StatusUpdatePool, myUnitTestArbiter, Nil, AutoSelectErrors
		  
		  // Update the time percentage column:
		  
		  UpdateTestTimePercentages lstUnitTestResults, myUnitTestArbiter
		  
		  // Resort the listbox:
		  
		  lstUnitTestResults.Sort
		  
		  // Enable listbox events:
		  
		  lb_UpdateInProgress = lb_UpdateInProgress -1
		  
		  // Refresh the details box:
		  
		  If lb_UpdateInProgress = 0 Then RefreshDetailsBox
		  
		  // Refresh the heading:
		  
		  lblUnitTestReportHeading.Caption = myUnitTestArbiter.q_GetPlaintextHeading
		  
		  // Refresh the visibility of the progress spinner:
		  
		  pgwTestsRunning.Visible = myUnitTestArbiter.TestsAreRunning
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function DataAvailable() As Boolean
		  // Signal the user interface to refresh at the next available opportunity.
		  
		  If refreshTimer.Mode = Timer.ModeOff Then refreshTimer.Mode = Timer.ModeSingle
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events refreshTimer
	#tag Event
		Sub Action()
		  // Created 2/3/2011 by Andrew Keller
		  
		  // Some time has passed since new events were known to exist in the arbiter.
		  
		  myUnitTestArbiter.GatherEvents
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
