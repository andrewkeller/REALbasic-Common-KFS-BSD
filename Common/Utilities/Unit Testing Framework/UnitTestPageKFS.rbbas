#tag WebPage
Begin WebPage UnitTestPageKFS
   Cursor          =   0
   Enabled         =   True
   Height          =   202
   HorizontalCenter=   0
   ImplicitInstance=   True
   Index           =   ""
   Left            =   362
   LockBottom      =   False
   LockHorizontal  =   ""
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   ""
   MinHeight       =   100
   MinWidth        =   100
   Resizable       =   True
   ShowBrowserFeatures=   False
   Style           =   "None"
   TabOrder        =   0
   Title           =   "Unit Test Results"
   Top             =   269
   VerticalCenter  =   0
   Visible         =   True
   Width           =   306
   ZIndex          =   1
   _Connected      =   ""
   _HorizontalPercent=   ""
   _ImplicitInstance=   False
   _IsEmbedded     =   ""
   _NeedsRendering =   True
   _VerticalPercent=   ""
   Begin WebLabel lblStatus
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   16
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   2
      Style           =   "None"
      TabOrder        =   0
      Text            =   "No unit test results to display."
      Top             =   14
      VerticalCenter  =   0
      Visible         =   True
      Width           =   456
      ZIndex          =   1
      _HorizontalPercent=   ""
      _IsEmbedded     =   ""
      _NeedsRendering =   True
      _VerticalPercent=   ""
   End
   Begin WebProgressWheel pgwProgress
      Cursor          =   0
      Enabled         =   True
      Height          =   16
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   270
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Scope           =   2
      Style           =   "None"
      TabOrder        =   -1
      Top             =   14
      Type            =   1
      VerticalCenter  =   0
      Visible         =   False
      Width           =   16
      ZIndex          =   1
      _HorizontalPercent=   ""
      _IsEmbedded     =   ""
      _NeedsRendering =   True
      _VerticalPercent=   ""
   End
   Begin WebTextArea txtResult
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   140
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      ReadOnly        =   True
      Scope           =   2
      Style           =   "None"
      TabOrder        =   1
      Text            =   ""
      Top             =   42
      VerticalCenter  =   0
      Visible         =   True
      Width           =   266
      ZIndex          =   1
      _HorizontalPercent=   ""
      _IsEmbedded     =   ""
      _NeedsRendering =   True
      _VerticalPercent=   ""
   End
   Begin UnitTestArbiterKFS myUnitTestArbiter
      Height          =   32
      Index           =   -2147483648
      Left            =   80
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      Style           =   "None"
      Top             =   80
      Width           =   32
   End
   Begin Timer refreshTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   100
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   2
      Style           =   "None"
      Top             =   100
      Width           =   32
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ProcessTestClasses(lst() As UnitTestBaseClassKFS)
		  // Created 3/26/2011 by Andrew Keller
		  
		  // Makes sure that this window is visible, and instructs the arbiter to process the given test classes.
		  
		  Self.Show
		  
		  Arbiter.CreateJobsForTestClasses lst
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessTestClasses(ParamArray lst As UnitTestBaseClassKFS)
		  // Created 3/26/2011 by Andrew Keller
		  
		  // An overloaded version of ProcessTestClasses.
		  
		  ProcessTestClasses lst
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshResults()
		  // Created 3/26/2011 by Andrew Keller
		  
		  // Refresh the display.
		  
		  lblStatus.Text = myUnitTestArbiter.q_GetPlaintextHeading
		  
		  pgwProgress.Visible = myUnitTestArbiter.TestsAreRunning
		  
		  txtResult.Text = myUnitTestArbiter.q_GetPlaintextReportBody
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
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
			  // Created 3/26/2010 by Andrew Keller
			  
			  // Returns a reference to the UnitTestArbiterKFS object on this page.
			  
			  Return myUnitTestArbiter
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Arbiter As UnitTestArbiterKFS
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events myUnitTestArbiter
	#tag Event
		Function DataAvailable() As Boolean
		  // Created 3/26/2011 by Andrew Keller
		  
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
		  // Created 3/26/2011 by Andrew Keller
		  
		  // Refresh the display.
		  
		  RefreshResults
		  
		  // done.
		  
		End Sub
	#tag EndEvent
#tag EndEvents
