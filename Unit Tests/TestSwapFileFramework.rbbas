#tag Class
Protected Class TestSwapFileFramework
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestAcquireRelease()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // Makes sure the AcquireSwapFile / ReleaseSwapFile loop works correctly.
		  
		  Dim f As FolderItem = AcquireSwapFile
		  
		  AssertNotNil f, "AcquireSwapFile returned a Nil FolderItem."
		  AssertTrue f.Exists, "AcquireSwapFile returned a FolderItem that doesn't exist."
		  AssertZero f.Length, "AcquireSwapFile returned a FolderItem that already has data in it."
		  
		  ReleaseSwapFile f
		  
		  AssertFalse f.Exists, "AcquireSwapFile did not delete the swap file when the ref count hit zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAcquireReleaseMultiples()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // Makes sure the AcquireSwapFile / ReleaseSwapFile loop works correctly.
		  
		  Dim f(4) As FolderItem
		  
		  For row As Integer = 0 To 4
		    
		    f(row) = AcquireSwapFile
		    
		    AssertNotNil f(row), "AcquireSwapFile returned a Nil FolderItem."
		    AssertTrue f(row).Exists, "AcquireSwapFile returned a FolderItem that doesn't exist."
		    AssertZero f(row).Length, "AcquireSwapFile returned a FolderItem that already has data in it."
		    
		  Next
		  
		  For row As Integer = 0 To 4
		    
		    ReleaseSwapFile f(row)
		    
		    AssertFalse f(row).Exists, "AcquireSwapFile did not delete the swap file when the ref count hit zero."
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAcquireRetainRelease()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // Makes sure the AcquireSwapFile / ReleaseSwapFile loop works correctly.
		  
		  Dim f As FolderItem = AcquireSwapFile
		  
		  AssertNotNil f, "AcquireSwapFile returned a Nil FolderItem."
		  AssertTrue f.Exists, "AcquireSwapFile returned a FolderItem that doesn't exist."
		  AssertZero f.Length, "AcquireSwapFile returned a FolderItem that already has data in it."
		  
		  RetainSwapFile f
		  AssertTrue f.Exists, "RetainSwapFile seems to have deleted the file."
		  AssertZero f.Length, "RetainSwapFile seems to have added data to the file."
		  
		  RetainSwapFile f
		  AssertTrue f.Exists, "RetainSwapFile seems to have deleted the file."
		  AssertZero f.Length, "RetainSwapFile seems to have added data to the file."
		  
		  ReleaseSwapFile f
		  AssertTrue f.Exists, "ReleaseSwapFile seems to have deleted the file prematurely."
		  AssertZero f.Length, "ReleaseSwapFile seems to have added data to the file."
		  
		  ReleaseSwapFile f
		  AssertTrue f.Exists, "ReleaseSwapFile seems to have deleted the file prematurely."
		  AssertZero f.Length, "ReleaseSwapFile seems to have added data to the file."
		  
		  ReleaseSwapFile f
		  AssertFalse f.Exists, "ReleaseSwapFile did not delete the swap file when the ref count hit zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
