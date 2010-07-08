#tag Class
Protected Class TestBigStringKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestConvertFromBinaryStream()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a BinaryStream object.
		  
		  Dim testString As String = "Hello, my great wonderful world in 2010!"
		  Dim testData As New BinaryStream( testString )
		  
		  Dim s1 As New BigStringKFS( testData )
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to initialize from a BinaryStream object."
		  
		  Dim s2 As BigStringKFS = testData
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to convert from a BinaryStream object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromFile()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a FolderItem.
		  
		  Dim testString As String = "Hello, my great wonderful world in 2010!"
		  Dim testFile As FolderItem = AcquireSwapFile
		  
		  // Save our test string to the test file.
		  
		  Try
		    Dim bs As BinaryStream = BinaryStream.Create( testFile )
		    bs.Write testString
		    bs.Close
		  Catch
		    AssertFailure "Could not prepare a file that will be used for testing how the BigStringKFS class handles files."
		  End Try
		  
		  // Execute the tests.
		  
		  Dim s1 As New BigStringKFS( testFile )
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to initialize from a FolderItem."
		  
		  Dim s2 As BigStringKFS = testFile
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to convert from a FolderItem."
		  
		  // Release the test file.
		  
		  ReleaseSwapFile testFile
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromMemoryBlock()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a MemoryBlock object.
		  
		  Dim testString As String = "Hello, my great wonderful world in 2010!"
		  Dim testData As MemoryBlock = testString
		  
		  Dim s1 As New BigStringKFS( testData )
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to initialize from a MemoryBlock object."
		  
		  Dim s2 As BigStringKFS = testData
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to convert from a MemoryBlock object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromString()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a String object.
		  
		  Dim testString As String = "Hello, my great wonderful world in 2010!"
		  
		  Dim s1 As New BigStringKFS( testString )
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to initialize from a String object."
		  
		  Dim s2 As BigStringKFS = testString
		  AssertEquals testString, s1.StringValue, "BigStringKFS was not able to convert from a String object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
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
