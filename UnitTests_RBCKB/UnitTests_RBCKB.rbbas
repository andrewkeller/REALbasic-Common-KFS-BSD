#tag Module
Protected Module UnitTests_RBCKB
	#tag Method, Flags = &h1
		Protected Function ListTestClasses() As UnitTestBaseClassKFS()
		  // Created 3/17/2011 by Andrew Keller
		  
		  // Returns an array of all the test classes in this library.
		  
		  Dim lst() As UnitTestBaseClassKFS
		  
		  lst.Append New TestAggregatingResourceManagerKFS
		  lst.Append New TestAutoDeletingFolderItemKFS
		  lst.Append New TestAutoreleaseStubKFS
		  lst.Append New TestBigStringKFS
		  lst.Append New TestBSDGlobalsKFS_Database
		  lst.Append New TestBSDGlobalsKFS_FileIO
		  lst.Append New TestBSDGlobalsKFS_ISO
		  lst.Append New TestBSDGlobalsKFS_Logic
		  lst.Append New TestBSDGlobalsKFS_String
		  lst.Append New TestBSDGlobalsKFS_UserInterface
		  lst.Append New TestCachableCriteriaKFS_AlwaysCache
		  lst.Append New TestCachableCriteriaKFS_CacheUntilSystemUptime
		  lst.Append New TestCachableCriteriaKFS_Latch
		  lst.Append New TestCachableCriteriaKFS_NeverCache
		  lst.Append New TestClosuresKFS
		  lst.Append New TestDataChainKFS
		  lst.Append New TestDeletePoolKFS
		  lst.Append New TestDosCommandLineArgumentParser
		  lst.Append New TestDurationKFS
		  lst.Append New TestLinearArgDesequencerKFS
		  lst.Append New TestLinearCLArgumentKFS
		  lst.Append New TestMainThreadInvokerKFS
		  lst.Append New TestNodeKFS
		  lst.Append New TestPosixCommandLineArgumentParser
		  lst.Append New TestProgressDelegateKFS
		  lst.Append New TestPropertyListKFS
		  lst.Append New TestPropertyListKFS_APList
		  lst.Append New TestSimpleResourceManagerKFS
		  
		  Return lst
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This module is licensed as BSD.  This generally means you may do
		whatever you want with this module so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this module does NOT require
		your work to inherit the license of this module.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this module.
		
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
