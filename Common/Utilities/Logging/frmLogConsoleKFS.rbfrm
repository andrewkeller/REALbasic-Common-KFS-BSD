#tag Window
Begin Window frmLogConsoleKFS
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   300
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   110
   MinimizeButton  =   True
   MinWidth        =   270
   Placement       =   0
   Resizeable      =   True
   Title           =   "Log Console"
   Visible         =   False
   Width           =   800
   Begin StatusLogQueryKFS myDB
      Enabled         =   True
      Height          =   32
      Index           =   -2147483648
      Left            =   841
      LockedInPosition=   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   -43
      Visible         =   True
      Width           =   32
   End
   Begin Listbox lstDisplay
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   5
      ColumnsResizable=   True
      ColumnWidths    =   "170, 300, 100, 80"
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
      Height          =   232
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "timestamp	calling_method	debug_level	is_error	message"
      Italic          =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   1
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   48
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   760
      _ScrollWidth    =   -1
   End
   Begin TextField txtQuery
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   16777215
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   234
      LimitText       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   546
   End
   Begin Label lblSQLStart
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   20
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "select * from primary_log where"
      TextAlign       =   2
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   210
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  // Created 4/15/2009 by Andrew Keller
		  
		  // close our instance of frmLogDetailsKFS
		  
		  If Not ( myDetailsWindow Is Nil ) Then
		    If Not ( myDetailsWindow.Value Is Nil ) Then
		      If myDetailsWindow.Value IsA frmLogDetailsKFS Then
		        
		        frmLogDetailsKFS( myDetailsWindow.Value ).Close
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  // Created 4/6/2009 by Andrew Keller
		  // Modified 4/15/2009 --;
		  
		  // set the default query
		  
		  txtQuery.Text = StatusLoggerKFS.kLogDB_PL_FieldTimestamp + " >= '" + myDB.LogStartupTime.SQLDateTime + "'"
		  SetQueryArgs txtQuery.Text
		  
		  // initialize properties
		  
		  myDetailsWindow = Nil
		  
		  // done
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			// Created 4/6/2009 by Andrew Keller
			
			// standard close menuitem
			
			Self.Close
			
			Return True
			
			// done.
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub SetQueryArgs(sQuery As String)
		  // Created 4/6/2009 by Andrew Keller
		  
		  // set the arguments of the query (will cause a full refresh of the recordset)
		  
		  lstDisplay.DeleteAllRows
		  
		  myDB.QueryArgs = sQuery
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateDetails(doubleClick As Boolean = False)
		  // Created 4/15/2009 by Andrew Keller
		  // Modified 4/20/2009 --; now more liberal with doubleClick = True
		  
		  // show the selected log entry in an instance of frmLogDetailsKFS
		  
		  Static currentlyDisplayed As StatusLogEntryKFS = Nil
		  
		  // determine if there is a window open
		  
		  Dim w As frmLogDetailsKFS
		  
		  If Not ( myDetailsWindow Is Nil ) Then
		    If Not ( myDetailsWindow.Value Is Nil ) Then
		      If myDetailsWindow.Value IsA frmLogDetailsKFS Then
		        
		        w = frmLogDetailsKFS( myDetailsWindow.Value )
		        
		      End If
		    End If
		  End If
		  
		  If w Is Nil And doubleClick = False Then Return
		  
		  // at this point, some details might have to be updated
		  
		  // get the currently displayed log entry
		  
		  Dim shouldDisplay As StatusLogEntryKFS = Nil
		  
		  If lstDisplay.ListIndex > -1 Then
		    shouldDisplay = StatusLogEntryKFS( lstDisplay.CellTag( lstDisplay.ListIndex, 0 ) )
		  End If
		  
		  // is there a change?
		  
		  If currentlyDisplayed <> shouldDisplay Or doubleClick Then
		    
		    // yes
		    
		    // initialize the window if necessary
		    
		    If w Is Nil Then
		      w = New frmLogDetailsKFS
		      myDetailsWindow = New WeakRef( w )
		      w.Show
		    End If
		    
		    // show the data
		    
		    w.DisplayEntryDetails( shouldDisplay )
		    
		    currentlyDisplayed = shouldDisplay
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This window is licensed as BSD.
		
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


	#tag Property, Flags = &h0
		myDetailsWindow As WeakRef
	#tag EndProperty


#tag EndWindowCode

#tag Events myDB
	#tag Event
		Sub QueryError(iCode As Integer, sMsg As String)
		  // Created 4/6/2009 by Andrew Keller
		  
		  // just tell the user
		  
		  MsgBox "A query error of type " + str( iCode ) + " has occurred:" + EndOfLine + EndOfLine + sMsg
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub QueryComplete()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // perform post-update functions
		  
		  Try
		    
		    lstDisplay.Sort
		    
		  Catch e As NilObjectException
		    
		    // do nothing
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewLogEntry(entry As StatusLogEntryKFS)
		  // Created 4/6/2009 by Andrew Keller
		  // Modified 4/1/2009 --; now uses the new StatusLogEntryKFS class
		  
		  // add this entry to the listbox
		  
		  Try
		    
		    lstDisplay.AddRow entry.Timestamp.SQLDateTime
		    lstDisplay.CellTag( lstDisplay.LastIndex, 0 ) = entry
		    lstDisplay.Cell( lstDisplay.LastIndex, 1 ) = entry.CallingMethod
		    lstDisplay.Cell( lstDisplay.LastIndex, 2 ) = str( entry.DebugLevel )
		    lstDisplay.Cell( lstDisplay.LastIndex, 3 ) = cvt( entry.IsError ).StringValue
		    lstDisplay.Cell( lstDisplay.LastIndex, 4 ) = entry.MessagePreview
		    
		  Catch e As NilObjectException
		    
		    // do nothing
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lstDisplay
	#tag Event
		Sub Open()
		  // Created 4/6/2009 by Andrew Keller
		  
		  // initialize things
		  
		  Me.ColumnSortDirection( 0 ) = Listbox.SortDescending
		  Me.SortedColumn = 0
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  // Created 4/6/2009 by Andrew Keller
		  // Modified 4/1/2009 --; now uses the new StatusLogEntryKFS class
		  
		  Select Case column
		  Case 0
		    
		    // sort the timestamp column by the Microseconds value
		    
		    Dim d1, d2 As UInt64
		    
		    d1 = StatusLogEntryKFS( Me.CellTag( row1, 0 ) ).Microseconds
		    d2 = StatusLogEntryKFS( Me.CellTag( row2, 0 ) ).Microseconds
		    
		    If d1 < d2 Then
		      result = -1
		    ElseIf d1 > d2 Then
		      result = 1
		    Else
		      result = 0
		    End If
		    
		    Return True
		    
		  End Select
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  // Created 4/15/2009 by Andrew Keller
		  
		  // show the selected log entry in an instance of frmLogDetailsKFS
		  
		  UpdateDetails True
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  // Created 4/15/2009 by Andrew Keller
		  
		  // show the selected log entry in an instance of frmLogDetailsKFS
		  
		  UpdateDetails
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // show the log window ?
		  
		  Dim iKey As Integer = Asc( Key )
		  
		  If iKey = 13 Or iKey = 10 Or iKey = 3 Then
		    
		    UpdateDetails True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events txtQuery
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  // Created 4/6/2009 by Andrew Keller
		  
		  // if the user pressed return, then update the query
		  
		  Dim k As Integer = Asc( Key )
		  
		  If k = 13 Or k = 10 Then
		    
		    SetQueryArgs Me.Text
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndEvent
#tag EndEvents
