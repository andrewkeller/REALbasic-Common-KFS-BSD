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
		
		Copyright (c) 2001, 2002, 2010 Jarvis Badgley, Kevin Ballard, Andrew Keller.
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
