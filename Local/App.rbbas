#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Clean up any lose ends.
		  
		  BSDGlobalsKFS_Database.DisconnectAllDatabases
		  SwapGlobalsKFS.ReleaseAllSwapFiles
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Fire up the test cases:
		  
		  UnitTestWindowKFS.ProcessTestClasses GetUnitTestClassList
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  // Created 7/27/2010 by Andrew Keller
		  
		  // Clean up any lose ends.
		  
		  BSDGlobalsKFS_Database.DisconnectAllDatabases
		  SwapGlobalsKFS.ReleaseAllSwapFiles
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function GetUnitTestClassList() As UnitTestBaseClassKFS()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Returns an array of all the test classes
		  // that are processed by default.
		  
		  Dim lst() As UnitTestBaseClassKFS
		  
		  lst.Append New TestAutoreleaseStubKFS
		  lst.Append New TestBigStringKFS
		  lst.Append New TestBSDGlobalsKFS_ISO
		  lst.Append New TestBSDGlobalsKFS_String
		  lst.Append New TestDataChainKFS
		  lst.Append New TestDelegateClosureKFS
		  lst.Append New TestDurationKFS
		  lst.Append New TestNodeKFS
		  lst.Append New TestProgressDelegateKFS
		  lst.Append New TestPropertyListKFS
		  lst.Append New TestPropertyListKFS_APList
		  lst.Append New TestSwapFileFramework
		  
		  Return lst
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2009-2011 Andrew Keller.
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


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
