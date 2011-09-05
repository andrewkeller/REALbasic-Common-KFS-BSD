#tag Class
Protected Class TestAutoDeletingFolderItemKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub AfterTestCase(testMethodName As String)
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Delete all items in the delete_me array.
		  
		  While UBound( delete_me ) > -1
		    
		    If Not ( delete_me(0) Is Nil ) Then
		      
		      Try
		        
		        #pragma BreakOnExceptions Off
		        
		        delete_me(0).DeleteKFS True
		        
		      Catch err As CannotDeleteFilesystemEntryExceptionKFS
		        
		        StashException err, "An error occurred while trying to clean up one of the test files."
		        
		      End Try
		      
		    End If
		    
		    delete_me.Remove 0
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Add each variant of TestCloneConstructor.
		  
		  For Each a As Boolean In Array( False, True )
		    
		    Call DefineVirtualTestCase( "TestCloneConstructor( "+Str(a)+" )", _
		    ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestCloneConstructor, New Dictionary( "use_exists" : a ) ) )
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub MakeSureFolderItemGetsDeleted(f As FolderItem)
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Adds the given FolderItem to the list of items scheduled for deletion.
		  
		  delete_me.Append f
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCloneConstructor(options As Dictionary)
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Makes sure the clone constructor behaves as expected.
		  
		  Dim use_exists As Boolean = options.Value( "use_exists" )
		  
		  
		  Dim parent_folder As FolderItem = SpecialFolder.Temporary
		  
		  AssertNotIsNil parent_folder, "SpecialFolder.Temporary is returning Nil.  This will cause some big problems."
		  
		  Dim f As FolderItem = parent_folder.Child( "kfs-foobar-"+Str(Microseconds) )
		  
		  AssertNotIsNil f, "Okay, that was weird...  I wasn't expecting the Child function to return Nil."
		  AssertFalse f.Exists, "Okay, now that is even weirder.  Our supposedly random file name already exists."
		  
		  If use_exists Then
		    
		    Dim bs As BinaryStream = BinaryStream.Create( f )
		    bs.Close
		    
		    MakeSureFolderItemGetsDeleted f
		    
		  End If
		  
		  // And go for the first clone.
		  
		  PushMessageStack "First clone: "
		  
		  Dim temp_file As New AutoDeletingFolderItemKFS( f )
		  
		  AssertNotIsNil temp_file, "The temporary file is Nil.  Huh?"
		  
		  AssertFalse temp_file.AutoDeleteEnabled, "AutoDeleteEnabled should be False when using the default constructor.", False
		  AssertTrue temp_file.AutoDeleteIsRecursive, "AutoDeleteIsRecursive should be True by default.", False
		  
		  If use_exists Then
		    AssertTrue temp_file.Exists, "The file should not have gone away."
		  Else
		    AssertFalse temp_file.Exists, "Cloning a FolderItem that doesn't exist should not create the FolderItem."
		  End If
		  AssertEquals parent_folder.ShellPath, temp_file.Parent.ShellPath, "The clone's parent should have the same path as the known parent."
		  
		  PopMessageStack
		  
		  // And go for the second clone.
		  
		  PushMessageStack "Second clone: "
		  
		  temp_file = New AutoDeletingFolderItemKFS( f )
		  
		  AssertNotIsNil temp_file, "The temporary file is Nil.  Huh?"
		  
		  AssertFalse temp_file.AutoDeleteEnabled, "AutoDeleteEnabled should be False when using the default constructor.", False
		  AssertTrue temp_file.AutoDeleteIsRecursive, "AutoDeleteIsRecursive should be True by default.", False
		  
		  If use_exists Then
		    AssertTrue temp_file.Exists, "The file should not have gone away."
		  Else
		    AssertFalse temp_file.Exists, "Cloning a FolderItem that doesn't exist should not create the FolderItem."
		  End If
		  AssertEquals parent_folder.ShellPath, temp_file.Parent.ShellPath, "The clone's parent should have the same path as the known parent."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDefaultConstructor()
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Makes sure the default constructor behaves as expected.
		  
		  Dim parent_folder As FolderItem = SpecialFolder.Temporary
		  
		  AssertNotIsNil parent_folder, "SpecialFolder.Temporary is returning Nil.  This will cause some big problems."
		  
		  Dim temp_file As New AutoDeletingFolderItemKFS
		  
		  AssertNotIsNil temp_file, "The temporary file is Nil.  Huh?"
		  
		  MakeSureFolderItemGetsDeleted temp_file
		  
		  AssertFalse temp_file.AutoDeleteEnabled, "AutoDeleteEnabled should be False when using the default constructor.", False
		  AssertTrue temp_file.AutoDeleteIsRecursive, "AutoDeleteIsRecursive should be True by default.", False
		  
		  AssertTrue temp_file.Exists, "The file was not reserved automatically."
		  AssertFalse temp_file.Directory, "The file was allocated as ...  a... folder?  What?"
		  AssertEquals parent_folder.ShellPath, temp_file.Parent.ShellPath, "A default temporary file is supposed to be a child of the SpecialFolder.Temporary folder.", False
		  
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


	#tag Property, Flags = &h1
		Protected delete_me() As FolderItem
	#tag EndProperty


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
