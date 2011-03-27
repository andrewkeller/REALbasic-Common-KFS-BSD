#tag WebPage
Begin WebPage WebPage1
   Cursor          =   0
   Enabled         =   True
   Height          =   400
   HorizontalCenter=   ""
   ImplicitInstance=   True
   Index           =   ""
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   ""
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   ""
   MinHeight       =   400
   MinWidth        =   600
   Resizable       =   True
   ShowBrowserFeatures=   True
   Style           =   "None"
   TabOrder        =   0
   Title           =   "Untitled"
   Top             =   0
   VerticalCenter  =   ""
   Visible         =   True
   Width           =   600
   ZIndex          =   1
   _Connected      =   ""
   _HorizontalPercent=   ""
   _ImplicitInstance=   False
   _IsEmbedded     =   ""
   _NeedsRendering =   True
   _VerticalPercent=   ""
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  UnitTestPageKFS.ProcessTestClasses TestClassList_RBCKB.ListTestClasses
		  
		End Sub
	#tag EndEvent


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


#tag EndWindowCode
