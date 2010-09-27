#tag Module
Protected Module BSDGlobalsKFS_UserInterface
	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Function ModificationHintCDL(Extends w As Window) As Boolean
		  // Added 11/15/2001 by Jarvis Badgley (to the Carbon Declare Library)
		  // Modified 2/3/2002 by Kevin Ballard (in the Carbon Declare Library)
		  // Added 9/27/2010 by Andrew Keller (to the REALbasic Common KFS BSD Library)
		  
		  // Returns whether or not the modification dot is currently set on the window.
		  
		  #if Target68k then
		    // No 68k code
		  #else
		    
		    #if TargetMacOS then
		      #if TargetCarbon then
		        Declare Function IsWDirty Lib "CarbonLib" Alias "IsWindowModified" (wPtr as WindowPtr) as Boolean
		      #else
		        Declare Function IsWDirty Lib "WindowsLib" Alias "IsWindowModified" (wPtr as WindowPtr) as Boolean
		      #endif // TargetCarbon
		      
		      Return IsWDirty(w)
		    #endif // TargetMacOS
		    
		  #endif // Target68k
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub ModificationHintCDL(Extends w As Window, Assigns b As Boolean)
		  // Added 11/15/2001 by Jarvis Badgley (to the Carbon Declare Library)
		  // Modified 2/3/2002 by Kevin Ballard (in the Carbon Declare Library)
		  // Added 9/27/2010 by Andrew Keller (to the REALbasic Common KFS BSD Library)
		  
		  // Sets or unsets the window to display the modification dot on OS X.
		  
		  #if Target68k then
		    // No 68k code
		  #else
		    
		    Dim osErr As Integer
		    dim v as variant
		    
		    #if TargetMacOS then
		      #if TargetCarbon then
		        Declare Function SetWindowModified Lib "Carbon" (window As WindowPtr, modified As Integer) As Integer
		      #else
		        Declare Function SetWindowModified Lib "WindowsLib" (window As WindowPtr, modified As Integer) As Integer
		      #endif // TargetCarbon
		      
		      v=b
		      osErr=SetWindowModified(w,v)
		    #endif // TargetMacOS
		    
		  #endif // Target68k
		  
		  // done.
		  
		End Sub
	#tag EndMethod


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
