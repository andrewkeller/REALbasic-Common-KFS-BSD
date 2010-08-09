#tag Window
Begin Window frmMain
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1658829013
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Test Cases for the RB Common KFS BSD Library"
   Visible         =   True
   Width           =   600
   Begin TabPanel tbpMain
      AutoDeactivate  =   True
      Bold            =   ""
      Enabled         =   True
      Height          =   366
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   ""
      TabDefinition   =   "Interactive Report\rPlaintext Report\rProperty List\rLinearArgDesequencerKFS"
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   14
      Underline       =   ""
      Value           =   0
      Visible         =   True
      Width           =   560
      Begin Listbox lstPList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   ""
         Border          =   True
         ColumnCount     =   3
         ColumnsResizable=   True
         ColumnWidths    =   "*,100,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   ""
         EnableDragReorder=   ""
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   -1
         Height          =   316
         HelpTag         =   ""
         Hierarchical    =   True
         Index           =   -2147483648
         InitialParent   =   "tbpMain"
         InitialValue    =   ""
         Italic          =   ""
         Left            =   32
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   0
         ScrollbarHorizontal=   ""
         ScrollBarVertical=   True
         SelectionType   =   1
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   54
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   536
         _ScrollWidth    =   -1
      End
      Begin TextArea txtOutput
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
         Height          =   188
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "tbpMain"
         Italic          =   ""
         Left            =   32
         LimitText       =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   0
         ScrollbarHorizontal=   ""
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   182
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   536
      End
      Begin TextField txtInput
         AcceptTabs      =   True
         Alignment       =   0
         AutoDeactivate  =   True
         BackColor       =   &hFFFFFF
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
         InitialParent   =   "tbpMain"
         Italic          =   ""
         Left            =   32
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
         TabIndex        =   2
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   148
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   536
      End
      Begin StaticText StaticText1
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   82
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "tbpMain"
         Italic          =   ""
         Left            =   32
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   4
         Text            =   "Type a Unix command line instruction into the upper text field, and a summary of the parsed arguments will display in the lower text box.  Please note that arguments are first split based on spaces before they are passed to the argument parsing class, so a single argument cannot have spaces.  Normally, this is not a problem, because RB provides a pre-split array of the arguments."
         TextAlign       =   0
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   54
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   536
      End
      Begin TextArea txtUnitTestResults
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
         Height          =   316
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "tbpMain"
         Italic          =   ""
         Left            =   32
         LimitText       =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   0
         ScrollbarHorizontal=   ""
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Please wait...  Unit tests are still running..."
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   54
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   536
      End
      Begin UnitTestViewKFS myUnitTestView
         AcceptFocus     =   ""
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Enabled         =   True
         EraseBackground =   True
         HeadingVisible  =   ""
         Height          =   316
         HelpTag         =   ""
         InitialParent   =   "tbpMain"
         Left            =   32
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   54
         UseFocusRing    =   ""
         Visible         =   True
         Width           =   536
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function RenderArgResults(args As MyProgArgs) As String
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Render a human-readable summary of the
		  // given MyProgArgs instance, intended
		  // for displaying or printing on a screen.
		  
		  
		  // Initialize a mutable string for building our result:
		  
		  Dim result As New BinaryStream( New MemoryBlock(0) )
		  
		  
		  // Did an error occur while parsing the arguments?
		  
		  result.Write "Parse Error: "
		  If args.Error Then
		    result.Write "Yes (Error " + str(args.ErrorCode) + ")" + EndOfLine + args.ErrorMessage + EndOfLine
		  Else
		    result.Write "No" + EndOfLine
		  End If
		  
		  result.Write EndOfLine
		  
		  
		  // What command invoked this program?
		  
		  result.Write "App Invocation String: " + args.AppExecutionString + EndOfLine + EndOfLine
		  
		  
		  // Get a list of all methods whose names begin with "Logical" and have no arguments.
		  
		  Dim logicalMethods() As Introspection.MethodInfo
		  Dim logicalMethodNames() As String
		  
		  For Each method As Introspection.MethodInfo In Introspection.GetType(args).GetMethods
		    If method.Name.Left( 7 ) = "Logical" Then
		      
		      logicalMethods.Append method
		      logicalMethodNames.Append method.Name
		      
		    End If
		  Next
		  
		  logicalMethodNames.SortWith logicalMethods
		  
		  // Display the results of all the selected methods.
		  
		  For Each method As Introspection.MethodInfo In logicalMethods
		    
		    Try
		      
		      Dim v As Variant = method.Invoke( args )
		      result.Write method.Name + ": " + v + EndOfLine
		      
		    Catch
		    End Try
		  Next
		  
		  result.Write EndOfLine
		  
		  
		  // Output the usage string.
		  
		  result.Write args.ArgsUsageMessage + EndOfLine
		  
		  
		  // Return the result.
		  
		  result.Position = 0
		  Return result.Read( result.Length )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SampleConsoleAppOpenEvent(args() As String)
		  // Created 4/24/2010 by Andrew Keller
		  
		  // This is an example of code that you would
		  // use in a Console application's Open event.
		  // Normally, this method would actually be
		  // App.Open (The Open event in a
		  // ConsoleApplication has the same parameters
		  // as this function).
		  
		  // Pretending that this is App.Open......
		  
		  
		  // Pipe the given arguments through the example subclass
		  // of LinearArgDesequencerKFS, and display what comes out.
		  
		  // Note: LinearArgDesequencerKFS parses the arguments
		  // that were passed to its constructor.  This can be
		  // done by the conventional "New" operator, or by the
		  // convert constructor, as is used here:
		  
		  txtOutput.Text = RenderArgResults( args )
		  
		  // done.
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events lstPList
	#tag Event
		Sub Open()
		  // Created 1/8/2010 by Andrew Keller
		  
		  // A simple test case for the PropertyListKFS class.
		  
		  // Open something interesting.
		  
		  Dim plist As PropertyListKFS
		  Dim f As FolderItem
		  
		  Try
		    
		    f = SpecialFolder.Preferences.Child( "com.apple.Xcode.plist" )
		    
		    plist = f.OpenAsPropertyListKFS
		    
		    Me.AddFolder "Root"
		    Me.Cell( Me.LastIndex, 1 ) = plist.Type_Localized
		    Me.Cell( Me.LastIndex, 2 ) = "(" + str( plist.Count ) + " items)"
		    Me.RowTag( Me.LastIndex ) = plist
		    
		    Return
		    
		    // This code tests saving the resulting plist file.
		    
		    Dim result As PropertyListKFS = New PropertyListKFS_XML1
		    PropertyListKFS_XML1(result).File = SpecialFolder.Desktop.Child( "output.plist" )
		    
		    result.Revert plist
		    
		    result.Save
		    
		  Catch err As NilObjectException
		    
		    If f = Nil Then
		      
		      MsgBox "The file could not be found."
		      
		    Else
		      
		      MsgBox "Something really bad happened somewhere inside the PropertyListKFS class."
		      
		    End If
		    
		  Catch err As UnsupportedFormatException
		    
		    MsgBox "None of the PropertyListKFS subclasses were able to parse the file."
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub ExpandRow(row As Integer)
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Standard ExpandRow event.
		  
		  // Get the current plist node.
		  
		  Dim plist As PropertyListKFS = Me.RowTag( row )
		  
		  If plist <> Nil Then
		    
		    If plist.Type = PropertyListKFS.kNodeTypeDictionary Then
		      
		      For Each key As Variant In plist.Keys
		        
		        Dim child As PropertyListKFS = plist.Child( key )
		        
		        If child.Type <= PropertyListKFS.kNodeTypeArray Then
		          
		          Me.AddFolder key.StringValue
		          Me.Cell( Me.LastIndex, 2 ) = "(" + str(child.Count ) + " items)"
		          
		        Else
		          
		          Me.AddRow key.StringValue
		          Me.Cell( Me.LastIndex, 2 ) = child.Value
		          
		        End If
		        
		        Me.Cell( Me.LastIndex, 1 ) = child.Type_Localized
		        Me.RowTag( Me.LastIndex ) = child
		        
		      Next
		      
		    ElseIf plist.Type = PropertyListKFS.kNodeTypeArray Then
		      
		      For index As Integer = 0 To plist.Count -1
		        
		        Dim child As PropertyListKFS = plist.Child( index )
		        
		        If child.Type <= PropertyListKFS.kNodeTypeArray Then
		          
		          Me.AddFolder "Item " + str( index )
		          Me.Cell( Me.LastIndex, 2 ) = "(" + str( child.Count ) + " items)"
		          
		        Else
		          
		          Me.AddRow "Item " + str( index )
		          Me.Cell( Me.LastIndex, 2 ) = child.Value
		          
		        End If
		        
		        Me.Cell( Me.LastIndex, 1 ) = child.Type_Localized
		        Me.RowTag( Me.LastIndex ) = child
		        
		      Next
		      
		    Else
		      
		      MsgBox "You just tried to expand a terminal node."
		      
		    End If
		  Else
		    
		    MsgBox "Could not find the PropertyListKFS reference."
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub CollapseRow(row As Integer)
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Standard CollapseRow event.
		  
		  // Figure out how many items are in this directory.
		  
		  Dim plist As PropertyListKFS = Me.RowTag( row )
		  
		  If plist <> Nil Then
		    
		    For count As Integer = plist.Count DownTo 1
		      
		      Me.RemoveRow row + 1
		      
		    Next
		    
		  Else
		    
		    MsgBox "Could not find the PropertyListKFS reference."
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Detect left and right arrows.
		  
		  Select Case Asc( Key )
		    
		  Case kASCIILeftArrow
		    Me.Expanded( Me.ListIndex ) = False
		    
		  Case kASCIIRightArrow
		    Me.Expanded( Me.ListIndex ) = True
		    
		  End Select
		  
		  // done.
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events txtInput
	#tag Event
		Sub TextChange()
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Take the text in this text box, pipe it
		  // through an instance of MyProgArgs, and
		  // display what comes out.
		  
		  Dim args() As String = Me.Text.Split( " " )
		  
		  SampleConsoleAppOpenEvent args
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Trigger the TextChange event so that txtOutput updates.
		  
		  Me.Text = "./myprog -b foo -a bar -cvv fish cat dog bird"
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events myUnitTestView
	#tag Event
		Sub TestFinished(testCaseObject As UnitTestResultKFS)
		  // Refresh the plaintext report:
		  
		  txtUnitTestResults.Text = Me.Arbiter.PlaintextReport
		  
		  // done.
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  // Instruct the unit test arbiter to start running the unit tests:
		  
		  Me.HeadingVisible = True
		  Me.DetailsBoxVisible = False
		  Me.DetailsBoxPosition = UnitTestViewKFS.DetailsBoxPositions.Bottom
		  Me.DetailsBoxAutoVisibility = UnitTestViewKFS.DetailsBoxAutoVisibilityOptions.FullAutomatic
		  Me.AutoSelectErrors = True
		  Me.Arbiter.Mode = UnitTestArbiterKFS.Modes.Asynchronous
		  
		  Me.Arbiter.ExecuteTests _
		  New TestBigStringKFS, _
		  New TestDataChainKFS, _
		  New TestDurationKFS, _
		  New TestHierarchalDictionaryFunctionsKFS, _
		  New TestSwapFileFramework
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
