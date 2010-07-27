#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  // Clean up any lose ends.
		  
		  BSDGlobalsKFS_Database.DisconnectAllDatabases
		  SwapGlobalsKFS.ReleaseAllSwapFiles
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  // Clean up any lose ends.
		  
		  BSDGlobalsKFS_Database.DisconnectAllDatabases
		  SwapGlobalsKFS.ReleaseAllSwapFiles
		  
		End Function
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
