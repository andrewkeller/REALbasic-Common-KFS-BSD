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
      TabDefinition   =   "LinearArgDesequencerKFS"
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
      Begin TextArea txtOutput
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
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
         TabPanelIndex   =   1
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
         AutomaticallyCheckSpelling=   False
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
         TabPanelIndex   =   1
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
      Begin Label StaticText1
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
         TabPanelIndex   =   1
         TabStop         =   True
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
		      
		    Catch err As RuntimeException
		      ReRaiseRBFrameworkExceptionsKFS err
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


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This window is licensed as BSD.  This generally means you may do
		whatever you want with this window so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this window does NOT require
		your work to inherit the license of this window.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this window.
		
		The full official license is as follows:
		
		Copyright (c) 2009-2011 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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


#tag EndWindowCode

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
