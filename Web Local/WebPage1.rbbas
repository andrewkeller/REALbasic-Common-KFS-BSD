#tag WebPage
Begin WebPage WebPage1
   Cursor          =   0
   Enabled         =   True
   Height          =   400
   HelpTag         =   ""
   HorizontalCenter=   ""
   ImplicitInstance=   True
   Index           =   ""
   IsImplicitInstance=   ""
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   ""
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   ""
   MinHeight       =   400
   MinWidth        =   600
   Style           =   "None"
   TabOrder        =   0
   Title           =   "Untitled"
   Top             =   0
   VerticalCenter  =   ""
   Visible         =   True
   Width           =   600
   ZIndex          =   1
   _HorizontalPercent=   ""
   _ImplicitInstance=   False
   _IsEmbedded     =   ""
   _Locked         =   ""
   _NeedsRendering =   True
   _OfficialControl=   False
   _VerticalPercent=   ""
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  Call InvokeInNewThreadKFS( AddressOf FireUpTestCases )
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub FireUpTestCases()
		  UnitTestPageKFS.ProcessTestClasses UnitTests_RBCKB.ListTestClasses
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This web page is licensed as BSD.  This generally means you may do
		whatever you want with this web page so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this web page does NOT require
		your work to inherit the license of this web page.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this web page.
		
		The full official license is as follows:
		
		Copyright (c) 2011 Andrew Keller.
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

