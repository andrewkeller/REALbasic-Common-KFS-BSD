#tag Class
Protected Class TestBSDGlobalsKFS_RegEx
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestMatches_EmptySrc()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the Matches method works with an empty source.
		  
		  Dim src As String = ""
		  
		  AssertTrue src.Matches( "" ), "An empty string should conform to an empty regular expression.", False
		  
		  AssertTrue src.Matches( "^$", True ), "An empty string should conform to '^$'.", False
		  
		  AssertFalse src.Matches( "." ), "An empty string should not conform to '.'.", False
		  
		  AssertTrue src.Matches( ".*" ), "An empty string should conform to '.*'.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMatches_Multiline()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the Matches method works with a source that has unusual characters.
		  
		  Dim src As String = "Hello" + chr(10) + "World!"
		  
		  AssertFalse src.Matches( "hello world" ), "That really should not have worked.", False
		  
		  AssertTrue src.Matches( "hello.world" ), "There's something wrong with newlines.", False
		  
		  AssertTrue src.Matches( "hello\sworld" ), "There's something wrong with the whitespace character set.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMatches_NormalUse()
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Makes sure the Matches method works with normal use.
		  
		  Dim src As String = "Hello, World!"
		  
		  AssertTrue src.Matches( "" ), "A string should conform to an empty regular expression.", False
		  
		  AssertFalse src.Matches( "^$", True ), """Hello, World!"" should not conform to '^$'.", False
		  
		  If PresumeTrue( src.Matches( "^h", False ), "Uh oh... Something bad is happening here." ) Then
		    
		    AssertTrue src.Matches( "^h" ), "Case-sensitivity should default to False.", False
		  End If
		  
		  AssertFalse src.Matches( "^h", True ), "Okay, I'm still not sure what's happening here.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2012 Andrew Keller.
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
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
		#tag EndViewProperty
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
End Class
#tag EndClass
