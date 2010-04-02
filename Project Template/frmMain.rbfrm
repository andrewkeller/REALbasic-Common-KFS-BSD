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
   MaximizeButton  =   False
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
      TabDefinition   =   "Property List"
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
         TabPanelIndex   =   1
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
   End
End
#tag EndWindow

#tag WindowCode
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
		    
		  Catch err As NilObjectException
		    
		    If f = Nil Then
		      
		      MsgBox "The file could not be found."
		      
		    Else
		      
		      MsgBox "Something really bad happened somewhere inside the PropertyListKFS class."
		      
		    End If
		    
		  Catch err As UnsupportedFormatException
		    
		    MsgBox "None of the PropertyListKFS subclasses were able to parse the file."
		    
		  End Try
		  
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
