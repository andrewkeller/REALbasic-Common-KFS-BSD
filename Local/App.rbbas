#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  // Execute the unit tests.
		  
		  Dim myTests As New UnitTestArbiterKFS
		  
		  myTests.ExecuteTests _
		  New TestBigStringKFS, _
		  New TestDataChainKFS, _
		  New TestHierarchalDictionaryFunctionsKFS
		  
		  // Display the results of the unit tests.
		  
		  myTests.DisplayResultsSummary
		  
		  // done.
		  
		End Sub
	#tag EndEvent


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
