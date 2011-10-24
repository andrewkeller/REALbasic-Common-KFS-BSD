#tag Class
Protected Class TestAutoDeletingFolderItemKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub AfterTestCase(testMethodName As String)
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Empty the autodelete pool.
		  
		  For Each k As Variant In p_autodelete_pool.Keys
		    
		    If k IsA FolderItem Then
		      Dim f As FolderItem = FolderItem( k )
		      
		      Try
		        
		        f.DeleteKFS True
		        
		      Catch err As CannotDeleteFilesystemEntryExceptionKFS
		        
		        StashException err
		        
		      End Try
		    Else
		      AssertFailure "I don't know how to clean up a " + Introspection.GetType( k ).Name + " object.", False
		    End If
		    
		    p_autodelete_pool.Remove k
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Initialize properties of this class.
		  
		  p_autodelete_pool = New Dictionary
		  
		  // Add each variant of TestCloneConstructor:
		  
		  For Each a As Boolean In Array( False, True )
		    
		    Call DefineVirtualTestCase( "TestCloneConstructor( "+Str(a)+" )", _
		    ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestCloneConstructor, New Dictionary( "use_exists" : a ) ) )
		    
		  Next
		  
		  // Add each variant of TestLocalDeletePool:
		  
		  For Each use_recursive As Boolean In Array( True, False )
		    For Each use_backgrounddelete As Boolean In Array( True, False )
		      
		      Dim name As String = "TestLocalDeletePool"
		      If use_recursive Then name = name + "_Recursive"
		      If use_backgrounddelete Then name = name + "_BackgroundDelete"
		      
		      Call DefineVirtualTestCase( name, ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestLocalDeletePool, New Dictionary( _
		      "use_recursive" : use_recursive, _
		      "use_backgrounddelete" : use_backgrounddelete )))
		      
		    Next
		  Next
		  
		  // Add each variant of TestNewTempFileOrFolder:
		  
		  For Each type As String In Array( "file", "folder" )
		    For Each parent As String In Array( "SpecialFolder.Temporary", "a provided folder", "a provided file", "Nil" )
		      For Each add_children As Boolean In Array( True, False )
		        For Each disable_autodelete As Boolean In Array( True, False )
		          For Each disable_recursivedelete As Boolean In Array( True, False )
		            If Not ( type = "file" And add_children = True ) Then
		              
		              Dim name As String = "TestNew" + Titlecase(type) + ": within " + parent
		              If add_children Then name = name + ", with children"
		              If disable_autodelete Then name = name + ", without AutoDelete"
		              If disable_recursivedelete Then name = name + ", without RecursiveDelete"
		              
		              Call DefineVirtualTestCase( name, ClosuresKFS.NewClosure_From_Dictionary( AddressOf TestNewTempFileOrFolder, New Dictionary( _
		              "type" : type, _
		              "parent" : parent, _
		              "add_children" : add_children, _
		              "disable_autodelete" : disable_autodelete, _
		              "disable_recursivedelete" : disable_recursivedelete )))
		              
		            End If
		          Next
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub CleanUpFolderItemAfterTestCase(f As FolderItem)
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Adds the given FolderItem to the autodelete pool.
		  
		  If Not ( f Is Nil ) Then
		    
		    p_autodelete_pool.Value( New FolderItem( f ) ) = True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NewRandomName(prefix As String = "kfs-foobar") As String
		  // Created 9/10/2011 by Andrew Keller
		  
		  // Returns a name that is unlikely to be used anywhere in the filesystem.
		  
		  Dim ms As Int64 = Microseconds
		  
		  Return prefix + "-" + Str(ms)
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCloneConstructor(options As Dictionary)
		  // Created 9/5/2011 by Andrew Keller
		  
		  // Makes sure the clone constructor behaves as expected.
		  
		  AssertNotIsNil options, "An options Dictionary was not provided."
		  Dim use_exists As Boolean = options.Value( "use_exists" )
		  
		  
		  Dim parent_folder As FolderItem = SpecialFolder.Temporary
		  
		  AssertNotIsNil parent_folder, "SpecialFolder.Temporary is returning Nil.  This will cause some big problems."
		  
		  Dim f As FolderItem = parent_folder.Child( NewRandomName )
		  
		  AssertNotIsNil f, "Okay, that was weird...  I wasn't expecting the Child function to return Nil."
		  AssertFalse f.Exists, "Okay, now that is even weirder.  Our supposedly random file name already exists."
		  
		  If use_exists Then
		    
		    Dim bs As BinaryStream = BinaryStream.Create( f )
		    bs.Close
		    
		    AssertTrue f.Exists, "Oh, great.  I tried to create a file, but nothing happened."
		    
		    CleanUpFolderItemAfterTestCase f
		    
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
		  
		  Dim expected As New FolderItem
		  
		  AssertNotIsNil expected, "The expected FolderItem is Nil.  Huh?"
		  
		  Dim found As New AutoDeletingFolderItemKFS
		  
		  AssertNotIsNil found, "The New AutoDeletingFolderItemKFS object is Nil  Huh?"
		  
		  AssertFalse found.AutoDeleteEnabled, "AutoDeleteEnabled should be False when using the default constructor.", False
		  AssertTrue found.AutoDeleteIsRecursive, "AutoDeleteIsRecursive should be True by default.", False
		  
		  AssertEquals expected.ShellPath, found.ShellPath, "The new AutoDeletingFolderItemKFS object should have the same shell path as the new FolderItem object."
		  AssertEquals expected.Directory, found.Directory, "The new AutoDeletingFolderItemKFS object should be the same type as the new FolderItem object (is or is not a directory).", False
		  AssertEquals expected.Exists, found.Exists, "The new AutoDeletingFolderItemKFS object should exist just the same as the new FolderItem object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestEnableAutoDelete()
		  // Created 9/10/2011 by Andrew Keller
		  
		  // Makes enabling AutoDelete retroactively works as expected.
		  
		  Dim parent_folder As FolderItem = SpecialFolder.Temporary
		  
		  AssertNotIsNil parent_folder, "SpecialFolder.Temporary is returning Nil.  This will cause some big problems."
		  
		  Dim f As FolderItem = parent_folder.Child( NewRandomName )
		  
		  AssertNotIsNil f, "Okay, that was weird...  I wasn't expecting the Child function to return Nil."
		  AssertFalse f.Exists, "Okay, now that is even weirder.  Our supposedly random file name already exists."
		  
		  Dim bs As BinaryStream = BinaryStream.Create( f )
		  bs.Close
		  
		  AssertTrue f.Exists, "Oh, great.  I tried to create a file, but nothing happened."
		  
		  CleanUpFolderItemAfterTestCase f
		  
		  // Now, create a new AutoDeletingFolderItemKFS object at
		  // this location such that AutoDelete is false by default.
		  
		  Dim temp_file As New AutoDeletingFolderItemKFS( f )
		  
		  AssertFalse temp_file.AutoDeleteEnabled, "AutoDeleteEnabled should be False by default when cloning a FolderItem object."
		  
		  // Now, set AutoDelete to True:
		  
		  temp_file.AutoDeleteEnabled = True
		  
		  AssertTrue temp_file.AutoDeleteEnabled, "AutoDeleteEnabled did not change to true."
		  
		  // Now, make sure the file gets deleted.
		  
		  temp_file = Nil
		  
		  AssertFalse f.Exists, "The file did not get deleted."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLocalDeletePool(options As Dictionary)
		  // Created 10/22/2011 by Andrew Keller
		  
		  // Makes sure that a DeletePoolKFS object can be set,
		  // and that the FolderItem gets deleted using that object.
		  
		  AssertNotIsNil options, "An options Dictionary was not provided."
		  Dim use_recursive As Boolean = options.Value( "use_recursive" )
		  Dim use_backgrounddelete As Boolean = options.Value( "use_backgrounddelete" )
		  
		  // Setup:
		  
		  Dim f As AutoDeletingFolderItemKFS
		  Dim f_bkup As FolderItem
		  
		  If use_recursive Then
		    
		    f = AutoDeletingFolderItemKFS.NewTemporaryFolder
		    AssertNotIsNil f, "This test requires that the NewTemporaryFolder method returns a non-Nil result."
		    AssertTrue f.Exists, "This test requires that the NewTemporaryFolder method returns a folder that exists."
		    CleanUpFolderItemAfterTestCase f
		    AssertTrue f.Directory, "This test requires that the NewTemporaryFolder method returns a folder."
		    
		    f_bkup = New FolderItem( f )
		    Dim g As FolderItem = f_bkup.Child( "new file" )
		    Call BinaryStream.Create( g )
		    AssertTrue g.Exists, "Unable to create a new file inside the new temporary folder."
		    
		  Else
		    
		    f = AutoDeletingFolderItemKFS.NewTemporaryFile
		    AssertNotIsNil f, "This test requires that the NewTemporaryFile method returns a non-Nil result."
		    AssertTrue f.Exists, "This test requires that the NewTemporaryFile method returns a file that exists."
		    CleanUpFolderItemAfterTestCase f
		    AssertFalse f.Directory, "This test requires that the NewTemporaryFile method returns a file."
		    
		    f_bkup = New FolderItem( f )
		    
		  End If
		  
		  f.AutoDeleteOperatesInBackgroundThread = use_backgrounddelete
		  AssertEquals use_backgrounddelete, f.AutoDeleteOperatesInBackgroundThread, "The AutoDeleteOperatesInBackgroundThread property did not retain its value."
		  
		  // Test:
		  
		  AssertIsNil f.DeletePool, "The default value of the DeletePool property should be Nil."
		  
		  Dim p As New DeletePoolKFS
		  p.DelayBetweenRetries = Nil
		  p.InternalProcessingEnabled = False
		  p.NumberOfFailuresUntilGiveUp = 5
		  p.NumberOfPartialSuccessesUntilGiveUp = 8
		  
		  f.DeletePool = p
		  AssertSame p, f.DeletePool, "Either the getter or the setter for the DeletePool property does not work."
		  
		  AssertEquals 0, p.Count, "The number of items in the DeletePoolKFS object should be zero before the AutoDeletingFolderItemKFS object has deallocated."
		  
		  f = Nil
		  
		  If use_backgrounddelete Then
		    
		    AssertTrue f_bkup.Exists, "The item pointed to by the AutoDeletingFolderItemKFS should still exist, even though the AutoDeletingFolderItemKFS has deallocated."
		    AssertEquals 1, p.Count, "The DeletePoolKFS object should contain one item now that the AutoDeletingFolderItemKFS object has deallocated."
		    
		    p.Process
		    
		    AssertFalse f_bkup.Exists, "The item pointed to by the AutoDeletingFolderItemKFS should still now not exist, since the Process method has been called."
		    AssertEquals 0, p.Count, "The DeletePoolKFS object should now contain no items."
		    
		  Else
		    
		    AssertFalse f_bkup.Exists, "The item pointed to by the AutoDeletingFolderItemKFS should no longer exist, since object has deallocated and AutoDeleteOperatesInBackgroundThread was False."
		    AssertEquals 0, p.Count, "The DeletePoolKFS object should contain no items (the FolderItem to delete should have came and went faster than we could test for it)."
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewTempFileOrFolder(options As Dictionary)
		  // Created 9/10/2011 by Andrew Keller
		  
		  // Makes sure creating a new temp file or folder works.
		  
		  AssertNotIsNil options, "An options Dictionary was not provided."
		  
		  Dim use_file As Boolean = options.Value( "type" ) = "file"
		  Dim use_parent_systemp As Boolean = options.Value( "parent" ) = "SpecialFolder.Temporary"
		  Dim use_parent_folder As Boolean = options.Value( "parent" ) = "a provided folder"
		  Dim use_parent_file As Boolean = options.Value( "parent" ) = "a provided file"
		  Dim use_parent_Nil As Boolean = options.Value( "parent" ) = "Nil"
		  Dim use_addchildren As Boolean = options.Value( "add_children" ) = True
		  Dim use_autodelete As Boolean = options.Value( "disable_autodelete" ) = False
		  Dim use_recursivedelete As Boolean = options.Value( "disable_recursivedelete" ) = False
		  
		  AssertTrue use_parent_systemp Or use_parent_folder Or use_parent_file Or use_parent_Nil, _
		  "In the provided options, none of the parent types were set."
		  
		  // Now that we have our options, let's make sure things happen correctly.
		  // Basically, all we are going to do is create a new AutoDeletingFolderItemKFS, and let it die.
		  
		  // First, let's create a parent FolderItem that we can use later if needed.
		  
		  Dim sample_parent_folderitem As FolderItem = SpecialFolder.Temporary.Child( NewRandomName( "valid parent" ) )
		  AssertNotIsNil sample_parent_folderitem, "The sample parent FolderItem is Nil."
		  AssertFalse sample_parent_folderitem.Exists, "Apparently, our randomly generated folder name already exists."
		  sample_parent_folderitem.CreateAsFolder
		  AssertTrue sample_parent_folderitem.Exists, "Failed to create the sample parent FolderItem."
		  AssertTrue sample_parent_folderitem.Directory, "Another process mananged to grab our randomly generated folder name before we could make it as a folder."
		  CleanUpFolderItemAfterTestCase sample_parent_folderitem
		  
		  Dim sample_invalid_parent_folderitem As FolderItem = SpecialFolder.Temporary.Child( NewRandomName( "invalid parent" ) )
		  AssertNotIsNil sample_invalid_parent_folderitem, "The sample invalid parent FolderItem is Nil."
		  AssertFalse sample_invalid_parent_folderitem.Exists, "Apparently, our randomly generated file name already exists."
		  Dim bs As BinaryStream = BinaryStream.Create( sample_invalid_parent_folderitem, True )
		  bs.Close
		  AssertTrue sample_invalid_parent_folderitem.Exists, "Failed to create the sample invalid parent FolderItem."
		  AssertFalse sample_invalid_parent_folderitem.Directory, "Another process mananged to grab our randomly generated folder name before we could make it as a file."
		  CleanUpFolderItemAfterTestCase sample_invalid_parent_folderitem
		  
		  // Now, let's create the AutoDeletingFolderItemKFS object.
		  
		  Dim adf As AutoDeletingFolderItemKFS
		  
		  If use_file Then
		    If use_parent_systemp Then
		      
		      adf = AutoDeletingFolderItemKFS.NewTemporaryFile
		      
		    ElseIf use_parent_folder Then
		      
		      adf = AutoDeletingFolderItemKFS.NewTemporaryFile( sample_parent_folderitem )
		      
		    ElseIf use_parent_file Then
		      
		      Try
		        #pragma BreakOnExceptions Off
		        adf = AutoDeletingFolderItemKFS.NewTemporaryFile( sample_invalid_parent_folderitem )
		      Catch err As CannotAccessFilesystemEntryExceptionKFS
		        // The error was properly detected.
		        Return
		      Catch err As RuntimeException
		        ReRaiseRBFrameworkExceptionsKFS err
		        // The error was not properly detected.
		        StashException err
		      End Try
		      AssertFailure "While creating a new temporary file, providing a file as the parent should cause a CannotAccessFilesystemEntryExceptionKFS exception to be raised."
		      
		    ElseIf use_parent_Nil Then
		      
		      Try
		        #pragma BreakOnExceptions Off
		        adf = AutoDeletingFolderItemKFS.NewTemporaryFile( Nil )
		      Catch err As NilObjectException
		        // The error was properly detected.
		        Return
		      Catch err As RuntimeException
		        ReRaiseRBFrameworkExceptionsKFS err
		        // The error was not properly detected.
		        StashException err
		      End Try
		      AssertFailure "While creating a new temporary file, providing Nil as the parent should cause a NilObjectException exception to be raised."
		      
		    End If
		  Else
		    If use_parent_systemp Then
		      
		      adf = AutoDeletingFolderItemKFS.NewTemporaryFolder
		      
		    ElseIf use_parent_folder Then
		      
		      adf = AutoDeletingFolderItemKFS.NewTemporaryFolder( sample_parent_folderitem )
		      
		    ElseIf use_parent_file Then
		      
		      Try
		        #pragma BreakOnExceptions Off
		        adf = AutoDeletingFolderItemKFS.NewTemporaryFolder( sample_invalid_parent_folderitem )
		      Catch err As CannotAccessFilesystemEntryExceptionKFS
		        // The error was properly detected.
		        Return
		      Catch err As RuntimeException
		        ReRaiseRBFrameworkExceptionsKFS err
		        // The error was not properly detected.
		        StashException err
		      End Try
		      AssertFailure "While creating a new temporary folder, providing a file as the parent should cause a CannotAccessFilesystemEntryExceptionKFS exception to be raised."
		      
		    ElseIf use_parent_Nil Then
		      
		      Try
		        #pragma BreakOnExceptions Off
		        adf = AutoDeletingFolderItemKFS.NewTemporaryFolder( Nil )
		      Catch err As NilObjectException
		        // The error was properly detected.
		        Return
		      Catch err As RuntimeException
		        ReRaiseRBFrameworkExceptionsKFS err
		        // The error was not properly detected.
		        StashException err
		      End Try
		      AssertFailure "While creating a new temporary folder, providing Nil as the parent should cause a NilObjectException exception to be raised."
		      
		    End If
		  End If
		  
		  CleanUpFolderItemAfterTestCase adf
		  
		  // Our AutoDeletingFolderItemKFS object has been created.
		  
		  Dim adf_clone As FolderItem = New FolderItem( adf )
		  Dim parent As FolderItem = adf_clone.Parent
		  
		  // Do we need to add children?
		  
		  If use_addchildren And Not use_file Then
		    
		    For Each name As String In Array( "1", "3", "5", "7" )
		      adf_clone.Child( name ).CreateAsFolder
		      For Each name2 As String In Array( "foo", "bar", "fish", "cat" )
		        bs = BinaryStream.Create( adf_clone.Child( name ).Child( name2 ), True )
		        bs.Close
		      Next
		    Next
		    
		    For Each name As String In Array( "2", "4", "6", "8" )
		      bs = BinaryStream.Create( adf_clone.Child( name ), True )
		      bs.Close
		    Next
		    
		  End If
		  
		  // Do we need to disable autodelete?
		  
		  If Not use_autodelete Then adf.AutoDeleteEnabled = False
		  
		  // Do we need to disable recursive delete?
		  
		  If Not use_recursivedelete Then adf.AutoDeleteIsRecursive = False
		  
		  // It is now time to deallocate the AutoDeletingFolderItemKFS object, and see what happens.
		  
		  Try
		    #pragma BreakOnExceptions Off
		    adf = Nil
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    // The error was not properly detected.
		    AssertFailure err, "No exception should have been raised when deallocating the AutoDeletingFolderItemKFS object."
		  End Try
		  
		  If Not use_file And use_addchildren And use_autodelete And Not use_recursivedelete Then
		    AssertTrue adf_clone.Exists, "The AutoDeletingFolderItemKFS object was not supposed to be able to delete the FolderItem (the folder had contents, and a recursive delete was not requested)."
		  ElseIf use_autodelete Then
		    AssertFalse adf_clone.Exists, "The AutoDeletingFolderItemKFS object did not delete itself."
		  Else
		    AssertTrue adf_clone.Exists, "The AutoDeletingFolderItemKFS object was not supposed to delete itself."
		  End If
		  
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
		Protected p_autodelete_pool As Dictionary
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
