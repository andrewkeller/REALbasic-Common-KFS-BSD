#tag Class
Protected Class TestDeletePoolKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub AfterTestCase(testMethodName As String)
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Clear the expectations:
		  
		  ReDim Expectations( -1 )
		  
		  // Empty the autodelete pool.
		  
		  For Each k As Variant In p_autodelete_pool.Keys
		    
		    If k IsA FolderItem Then
		      Dim f As FolderItem = FolderItem( k )
		      
		      Try
		        
		        f.DeleteKFS True
		        p_autodelete_pool.Remove f
		        
		      Catch err As CannotDeleteFilesystemEntryExceptionKFS
		        
		        StashException err
		        
		      End Try
		    Else
		      AssertFailure "I don't know how to clean up a " + Introspection.GetType( k ).Name + " object.", False
		      p_autodelete_pool.Remove k
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Initialize properties of this class.
		  
		  p_autodelete_pool = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Destructor()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Last chance to empty the autodelete pool.
		  
		  For Each k As Variant In p_autodelete_pool.Keys
		    Dim f As FolderItem = FolderItem( k )
		    
		    Try
		      
		      f.DeleteKFS True
		      p_autodelete_pool.Remove f
		      
		    Catch err As CannotDeleteFilesystemEntryExceptionKFS
		      
		      System.Log System.LogLevelError, "Error: Cannot delete temporary file " + f.AbsolutePath + ": " + err.Message
		      
		    End Try
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub AssertAllExpectationsSatisfied()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Asserts that there are no upcoming Expectations.
		  
		  Dim s() As String
		  
		  For Each item As Variant In Expectations
		    s.Append ObjectDescriptionKFS( item )
		  Next
		  
		  AssertEmptyString Join( s, ", " ), "Not all expectations were satisfied."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub BaseFolderItemDeleteMethodsTest(deleter As DeletePoolKFS.ObjectDeletingMethod, delete_me As FolderItem, expected_outcome As DeletePoolKFS.ObjectDeletingMethodResult)
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the given delete method operates as expected on the given FolderItem.
		  
		  Dim result As DeletePoolKFS.ObjectDeletingMethodResult
		  
		  Try
		    
		    result = deleter.Invoke( delete_me )
		    
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    
		    AssertFailure err, "A delete method is never supposed to raise an exception."
		  End Try
		  
		  If expected_outcome = DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess Then
		    
		    If Not ( delete_me Is Nil ) Then AssertFalse delete_me.Exists, "The delete method did not completely delete the target."
		    AssertEquals expected_outcome, result, "The delete method is supposed to return DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess when it successfully deletes its target."
		    
		  Else
		    
		    AssertTrue delete_me.Exists, "The delete method was not supposed to be able to delete the target."
		    AssertEquals expected_outcome, result, "The delete method did not return the expected status code."
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

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
		Protected Function GetTemporaryFile() As FolderItem
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Returns a new empty temporary file that is registered with the autodelete pool.
		  
		  Dim f As FolderItem = SpecialFolder.Temporary
		  
		  AssertNotIsNil f, "Unable to create a new temporary file, because SpecialFolder.Temporary returned Nil."
		  AssertTrue f.Exists, "Unable to create a new temporary file, because SpecialFolder.Temporary apparently doesn't exist."
		  
		  Do
		    
		    f = f.Child( NewRandomName )
		    
		  Loop Until Not f.Exists
		  
		  Call BinaryStream.Create( f )
		  
		  AssertTrue f.Exists, "Unable to create a new temporary file, because a BinaryStream could not be opened to the target (error code " + Str( f.LastErrorCode ) + ")."
		  AssertFalse f.Directory, "Unable to create a new temporary file, because something made a folder in the place where I wanted to make a file."
		  
		  CleanUpFolderItemAfterTestCase f
		  
		  Return f
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTemporaryFolder() As FolderItem
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Returns a new empty temporary folder that is registered with the autodelete pool.
		  
		  Dim f As FolderItem = SpecialFolder.Temporary
		  
		  AssertNotIsNil f, "Unable to create a new temporary folder, because SpecialFolder.Temporary returned Nil."
		  AssertTrue f.Exists, "Unable to create a new temporary folder, because SpecialFolder.Temporary apparently doesn't exist."
		  
		  Do
		    
		    f = f.Child( NewRandomName )
		    
		  Loop Until Not f.Exists
		  
		  f.CreateAsFolder
		  
		  AssertTrue f.Exists, "Unable to create a new temporary folder because of an error of type " + Str( f.LastErrorCode ) + "."
		  AssertTrue f.Directory, "Unable to create a new temporary folder because something made a file in the place where I wanted to make a folder."
		  
		  CleanUpFolderItemAfterTestCase f
		  
		  Return f
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTemporaryNonExistantFolderItem() As FolderItem
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Returns a new FolderItem that is not Nil and doesn't exist.
		  
		  Return GetTemporaryFolder.Child( "thisfiledoesnotexist" )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTemporaryPopulatedFolder() As FolderItem
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Returns a new populated temporary folder that is registered with the autodelete pool.
		  
		  Dim f As FolderItem = GetTemporaryFolder
		  
		  Call BinaryStream.Create( f.Child( "foo.txt" ) )
		  Call BinaryStream.Create( f.Child( "bar.txt" ) )
		  Call BinaryStream.Create( f.Child( "fish.txt" ) )
		  Call BinaryStream.Create( f.Child( "cat.txt" ) )
		  
		  Dim g As FolderItem = f.Child( "subdir1" )
		  g.CreateAsFolder
		  
		  Call BinaryStream.Create( g.Child( "elephant.txt" ) )
		  Call BinaryStream.Create( g.Child( "mouse.txt" ) )
		  Call BinaryStream.Create( g.Child( "ant.txt" ) )
		  
		  g = f.Child( "subdir2" )
		  g.CreateAsFolder
		  
		  Call BinaryStream.Create( g.Child( "bird.txt" ) )
		  Call BinaryStream.Create( g.Child( "dog.txt" ) )
		  
		  Return f
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub MockCore(id As Variant)
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the given ID is next in line in the Expectations.
		  
		  If UBound( Expectations ) > -1 And Expectations(0) = id Then
		    
		    // This is good.
		    
		    Expectations.Remove 0
		    
		  Else
		    
		    // This id was not expected.
		    
		    If UBound( Expectations ) > -1 Then
		      
		      AssertFailure "Unexpected expectation.", "Expected " + ObjectDescriptionKFS( Expectations(0) ) + " but found " + ObjectDescriptionKFS( id ) + "."
		      
		    Else
		      
		      AssertFailure "Unexpected expectation.", "Expected nothing but found " + ObjectDescriptionKFS( id ) + "."
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MockDeleteMethod_AchievedPartialSuccess(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/19/2011 by Andrew Keller
		  
		  // A delete method that always returns a status of AchievedPartialSuccess.
		  
		  MockCore DeletePoolKFS.ObjectDeletingMethodResult.AchievedPartialSuccess
		  Return DeletePoolKFS.ObjectDeletingMethodResult.AchievedPartialSuccess
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MockDeleteMethod_AchievedSuccess(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/19/2011 by Andrew Keller
		  
		  // A delete method that always returns a status of AchievedSuccess.
		  
		  MockCore DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  Return DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MockDeleteMethod_CannotHandleObject(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/19/2011 by Andrew Keller
		  
		  // A delete method that always returns a status of CannotHandleObject.
		  
		  MockCore DeletePoolKFS.ObjectDeletingMethodResult.CannotHandleObject
		  Return DeletePoolKFS.ObjectDeletingMethodResult.CannotHandleObject
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MockDeleteMethod_EncounteredFailure(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/19/2011 by Andrew Keller
		  
		  // A delete method that always returns a status of EncounteredFailure.
		  
		  MockCore DeletePoolKFS.ObjectDeletingMethodResult.EncounteredFailure
		  Return DeletePoolKFS.ObjectDeletingMethodResult.EncounteredFailure
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MockDeleteMethod_EncounteredTerminalFailure(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/19/2011 by Andrew Keller
		  
		  // A delete method that always returns a status of EncounteredTerminalFailure.
		  
		  MockCore DeletePoolKFS.ObjectDeletingMethodResult.EncounteredTerminalFailure
		  Return DeletePoolKFS.ObjectDeletingMethodResult.EncounteredTerminalFailure
		  
		  // done.
		  
		End Function
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
		Sub TestHandler_FolderItemDelete_File()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.FolderItemDeleter can delete a single file.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.FolderItemDeleter, _
		  GetTemporaryFile, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_FolderItemDelete_FilledFolder()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.FolderItemDeleter can delete a filled folder.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.FolderItemDeleter, _
		  GetTemporaryPopulatedFolder, _
		  DeletePoolKFS.ObjectDeletingMethodResult.EncounteredTerminalFailure
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_FolderItemDelete_Folder()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.FolderItemDeleter can delete an empty folder.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.FolderItemDeleter, _
		  GetTemporaryFolder, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_FolderItemDelete_Nil()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.FolderItemDeleter can delete Nil.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.FolderItemDeleter, _
		  Nil, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_FolderItemDelete_NonExistant()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.FolderItemDeleter can delete a FolderItem that doesn't exist.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.FolderItemDeleter, _
		  GetTemporaryNonExistantFolderItem, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_RecursiveFolderItemDelete_File()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.RecursiveFolderItemDeleter can delete a single file.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.RecursiveFolderItemDeleter, _
		  GetTemporaryFile, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_RecursiveFolderItemDelete_FilledFolder()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.RecursiveFolderItemDeleter can delete a filled folder.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.RecursiveFolderItemDeleter, _
		  GetTemporaryPopulatedFolder, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_RecursiveFolderItemDelete_Folder()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.RecursiveFolderItemDeleter can delete an empty folder.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.RecursiveFolderItemDeleter, _
		  GetTemporaryFolder, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_RecursiveFolderItemDelete_Nil()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.RecursiveFolderItemDeleter can delete Nil.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.RecursiveFolderItemDeleter, _
		  Nil, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_RecursiveFolderItemDelete_NonExistant()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that DeletePoolKFS.RecursiveFolderItemDeleter can delete a FolderItem that doesn't exist.
		  
		  BaseFolderItemDeleteMethodsTest _
		  AddressOf DeletePoolKFS.RecursiveFolderItemDeleter, _
		  GetTemporaryNonExistantFolderItem, _
		  DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_AchievedPartialSuccess()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_AchievedPartialSuccess_Immediate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_AchievedSuccess()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the default workflow operates properly.
		  
		  Dim p As New DeletePoolKFS
		  p.DelayBetweenRetries = Nil
		  p.InternalProcessingEnabled = False
		  p.NumberOfFailuresUntilGiveUp = 5
		  p.NumberOfPartialSuccessesUntilGiveUp = 8
		  
		  AssertEquals 0, p.Count, "The Count property should be zero by default."
		  AssertIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should be Nil by default."
		  
		  p.Add New Dictionary, "mock object", AddressOf MockDeleteMethod_AchievedSuccess, False
		  
		  AssertAllExpectationsSatisfied
		  AssertEquals 1, p.Count, "The DeletePoolKFS object should now have a count of 1."
		  AssertNotIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should not be Nil as long as there are items left to process."
		  
		  p.Add New Dictionary, "mock object", AddressOf MockDeleteMethod_AchievedSuccess, False
		  
		  AssertAllExpectationsSatisfied
		  AssertEquals 2, p.Count, "The DeletePoolKFS object should now have a count of 2."
		  AssertNotIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should not be Nil as long as there are items left to process."
		  
		  Expectations.Append DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  Expectations.Append DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  p.Process
		  
		  AssertAllExpectationsSatisfied
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should now have a count of zero."
		  AssertIsNil p.TimeUntilNextProcessing, "When there are no items left to process, the TimeUntilNextProcessing property should be Nil."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_AchievedSuccess_Immediate()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the default workflow operates properly.
		  
		  Dim p As New DeletePoolKFS
		  p.DelayBetweenRetries = Nil
		  p.InternalProcessingEnabled = False
		  p.NumberOfFailuresUntilGiveUp = 5
		  p.NumberOfPartialSuccessesUntilGiveUp = 8
		  
		  AssertEquals 0, p.Count, "The Count property should be zero by default."
		  AssertIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should be Nil by default."
		  
		  Expectations.Append DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  p.Add New Dictionary, "mock object", AddressOf MockDeleteMethod_AchievedSuccess, True
		  
		  AssertAllExpectationsSatisfied
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should have a count of zero. (1)"
		  AssertIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should still be Nil because there are no items to process. (1)"
		  
		  Expectations.Append DeletePoolKFS.ObjectDeletingMethodResult.AchievedSuccess
		  p.Add New Dictionary, "mock object", AddressOf MockDeleteMethod_AchievedSuccess, True
		  
		  AssertAllExpectationsSatisfied
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should have a count of zero. (2)"
		  AssertIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should still be Nil because there are no items to process. (2)"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_CannotHandleObject()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_CannotHandleObject_Immediate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_EncounteredFailure()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_EncounteredFailure_Immediate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_EncounteredTerminalFailure()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProcess_EncounteredTerminalFailure_Immediate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_Count()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the Count property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertZero p.Count, "The Count property should return zero by default."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_DelayBetweenRetries()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the DelayBetweenRetries property works.
		  
		  Dim p As New DeletePoolKFS
		  Dim d As DurationKFS = p.DelayBetweenRetries
		  
		  If PresumeNotIsNil( d, "The DelayBetweenRetries property is never supposed to return Nil (1)." ) Then
		    AssertEquals DurationKFS.NewFromValue( 1, DurationKFS.kSeconds ).MicrosecondsValue, d.MicrosecondsValue, "The default value for the DelayBetweenRetries property should be 1 second.", False
		  End If
		  
		  p.DelayBetweenRetries = DurationKFS.NewFromValue( 4, DurationKFS.kSeconds )
		  d = p.DelayBetweenRetries
		  
		  If PresumeNotIsNil ( d, "The DelayBetweenRetries property is never supposed to return Nil (2)." ) Then
		    AssertEquals DurationKFS.NewFromValue( 4, DurationKFS.kSeconds ).MicrosecondsValue, d.MicrosecondsValue, "Setting the DelayBetweenRetries property to a new value should cause the new value to be reported by the getter.", False
		  End If
		  
		  p.DelayBetweenRetries = Nil
		  d = p.DelayBetweenRetries
		  
		  If PresumeNotIsNil( d, "The DelayBetweenRetries property is never supposed to return Nil (3)." ) Then
		    AssertEquals DurationKFS.NewFromValue( 0 ).MicrosecondsValue, d.MicrosecondsValue, "Setting the DelayBetweenRetries property to Nil should cause the property to become zero.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_InternalProcessingEnabled()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the InternalProcessingEnabled property works.
		  
		  Dim p As New DeletePoolKFS
		  Dim expected As Boolean = Not TargetConsole
		  
		  AssertEquals expected, p.InternalProcessingEnabled, "The default value for the InternalProcessingEnabled should be " + Str( expected ) + " for the current application type."
		  
		  expected = Not expected
		  p.InternalProcessingEnabled = expected
		  
		  AssertEquals expected, p.InternalProcessingEnabled, "Setting the InternalProcessingEnabled property to " + Str( expected ) + " did not cause the getter to return " + Str( expected ) + "."
		  
		  expected = Not expected
		  p.InternalProcessingEnabled = expected
		  
		  AssertEquals expected, p.InternalProcessingEnabled, "Setting the InternalProcessingEnabled property back to " + Str( expected ) + " did not cause the getter to return " + Str( expected ) + "."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_NumberOfFailuresUntilGiveUp()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the NumberOfFailuresUntilGiveUp property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertEquals 5, p.NumberOfFailuresUntilGiveUp, "The default value for the NumberOfFailuresUntilGiveUp property should be 5.", False
		  
		  p.NumberOfFailuresUntilGiveUp = 8
		  
		  AssertEquals 8, p.NumberOfFailuresUntilGiveUp, "Setting the NumberOfFailuresUntilGiveUp property to 8 did not cause the getter to return 8.", False
		  
		  p.NumberOfFailuresUntilGiveUp = -12
		  
		  AssertEquals 0, p.NumberOfFailuresUntilGiveUp, "The NumberOfFailuresUntilGiveUp property is supposed to sanitize negative values to zero.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_NumberOfPartialSuccessesUntilGiveUp()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the NumberOfPartialSuccessesUntilGiveUp property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertEquals 10, p.NumberOfPartialSuccessesUntilGiveUp, "The default value for the NumberOfPartialSuccessesUntilGiveUp property should be 10.", False
		  
		  p.NumberOfPartialSuccessesUntilGiveUp = 13
		  
		  AssertEquals 13, p.NumberOfPartialSuccessesUntilGiveUp, "Setting the NumberOfPartialSuccessesUntilGiveUp property to 13 did not cause the getter to return 13.", False
		  
		  p.NumberOfPartialSuccessesUntilGiveUp = -7
		  
		  AssertEquals 0, p.NumberOfPartialSuccessesUntilGiveUp, "The NumberOfPartialSuccessesUntilGiveUp property is supposed to sanitize negative values to zero.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_TimeUntilNextProcessing()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the TimeUntilNextProcessing property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should return Nil by default."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortcut_AddFolderItem()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the default workflow operates properly.
		  
		  Dim f As FolderItem = GetTemporaryFile
		  Dim g As FolderItem = GetTemporaryPopulatedFolder
		  
		  Dim p As New DeletePoolKFS
		  p.InternalProcessingEnabled = False
		  
		  p.AddFolderitem f, True, False
		  
		  AssertTrue f.Exists, "The DeletePoolKFS object was not supposed to delete the first item immediately."
		  AssertEquals 1, p.Count, "The DeletePoolKFS object should now have a count of 1."
		  
		  p.AddFolderitem g, True, False
		  
		  AssertTrue g.Exists, "The DeletePoolKFS object was not supposed to delete the second item immediately."
		  AssertEquals 2, p.Count, "The DeletePoolKFS object should now have a count of 2."
		  
		  p.Process
		  
		  AssertFalse f.Exists, "The DeletePoolKFS object was supposed to delete the first object."
		  AssertFalse g.Exists, "The DeletePoolKFS object was supposed to delete the second object."
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should now have a count of zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortcut_AddFolderItem_Immediate()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the default workflow operates properly.
		  
		  Dim f As FolderItem = GetTemporaryFile
		  Dim g As FolderItem = GetTemporaryPopulatedFolder
		  
		  Dim p As New DeletePoolKFS
		  p.InternalProcessingEnabled = False
		  
		  p.AddFolderitem f, True, True
		  
		  AssertFalse f.Exists, "The DeletePoolKFS object was supposed to delete the first object immediately."
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should have a count of zero. (1)"
		  
		  p.AddFolderitem g, True, True
		  
		  AssertFalse g.Exists, "The DeletePoolKFS object was supposed to delete the second object immediately."
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should have a count of zero. (2)"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortcut_AddFolderItem_NilTarget()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the default workflow operates properly.
		  
		  Dim f As FolderItem = Nil
		  Dim g As FolderItem = Nil
		  
		  Dim p As New DeletePoolKFS
		  p.InternalProcessingEnabled = False
		  
		  p.AddFolderitem f, False, False
		  
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should still have a count of 0."
		  
		  p.AddFolderitem g, False, False
		  
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should still have a count of 0."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortcut_AddFolderItem_NonRecursive()
		  // Created 10/19/2011 by Andrew Keller
		  
		  // Makes sure that the default workflow operates properly.
		  
		  Dim f As FolderItem = GetTemporaryFile
		  Dim g As FolderItem = GetTemporaryPopulatedFolder
		  
		  Dim p As New DeletePoolKFS
		  p.InternalProcessingEnabled = False
		  
		  p.AddFolderitem f, False, False
		  
		  AssertTrue f.Exists, "The DeletePoolKFS object was not supposed to delete the first item immediately."
		  AssertEquals 1, p.Count, "The DeletePoolKFS object should now have a count of 1."
		  
		  p.AddFolderitem g, False, False
		  
		  AssertTrue g.Exists, "The DeletePoolKFS object was not supposed to delete the second item immediately."
		  AssertEquals 2, p.Count, "The DeletePoolKFS object should now have a count of 2."
		  
		  p.Process
		  
		  AssertFalse f.Exists, "The DeletePoolKFS object was supposed to delete the first object."
		  AssertTrue g.Exists, "The DeletePoolKFS object was supposed to delete the second object."
		  AssertEquals 0, p.Count, "The DeletePoolKFS object should now have a count of zero."
		  
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
		Protected Expectations() As Variant
	#tag EndProperty

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
