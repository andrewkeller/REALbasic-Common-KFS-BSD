#tag Module
Protected Module BSDGlobalsKFS_Logic
	#tag Method, Flags = &h0
		Function cvt(v As Variant) As Variant
		  // simple variant loop-back
		  // used for easy converting
		  
		  // Created 10/1/2005 by Andrew Keller
		  
		  Return v
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub DictionaryMethodKFS(d As Dictionary)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function GetUniqueIndexKFS(sCategory As String = "") As Integer
		  // returns an integer that is unique
		  // as long as this program is running
		  
		  // Created 3/15/2007 by Andrew Keller
		  
		  If dictUniqueIndex Is Nil Then dictUniqueIndex = New Dictionary
		  
		  dictUniqueIndex.Value(sCategory) = dictUniqueIndex.Lookup(sCategory, -1) +1
		  
		  Return dictUniqueIndex.Value(sCategory)
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InvokeInMainThreadKFS(Extends d As PlainMethodKFS, delay As Integer = 1) As MainThreadInvokerKFS
		  // Created 7/28/2011 by Andrew Keller
		  
		  // Runs the given method in the main thread.
		  
		  Return InvokeInMainThreadKFS( d, delay )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InvokeInMainThreadKFS(d As PlainMethodKFS, delay As Integer = 1) As MainThreadInvokerKFS
		  // Created 7/28/2011 by Andrew Keller
		  
		  // Runs the given method in the main thread.
		  
		  If d Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return New MainThreadInvokerKFS( d, delay )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InvokeInNewThreadKFS(Extends d As PlainMethodKFS) As Thread
		  // Created 7/12/2011 by Andrew Keller
		  
		  // Runs the given method in a new thread.
		  
		  Return InvokeInNewThreadKFS( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InvokeInNewThreadKFS(Extends d As ThreadMethodKFS) As Thread
		  // Created 7/12/2011 by Andrew Keller
		  
		  // Runs the given method in a new thread.
		  
		  Return InvokeInNewThreadKFS( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InvokeInNewThreadKFS(d As PlainMethodKFS) As Thread
		  // Created 10/1/2010 by Andrew Keller
		  
		  // Runs the given method in a new thread.
		  
		  If d Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Dim t As New Thread
		    
		    AddHandler t.Run, ClosuresKFS.NewClosure_Thread_From_void( d )
		    
		    t.Run
		    
		    Return t
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InvokeInNewThreadKFS(d As ThreadMethodKFS) As Thread
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Runs the given method in a new thread.
		  
		  If d Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Dim t As New Thread
		    
		    AddHandler t.Run, d
		    
		    t.Run
		    
		    Return t
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LookupKFS(Extends xnode As XmlNode, ParamArray names As String) As XmlNode
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Searches the given XmlElement for a node with the given name.
		  // Returns Nil if not found.
		  
		  Dim cursor As XmlNode = xnode
		  Dim probe As XmlNode
		  
		  For Each name As String In names
		    
		    // Find a child inside <cursor> with name <test>.
		    
		    probe = cursor.FirstChild
		    
		    // Linear search.  Upon success, probe <> Nil.
		    
		    While Not ( probe Is Nil )
		      
		      If probe.Name = name Then Exit
		      
		      probe = probe.NextSibling
		      
		    Wend
		    
		    // Was the current name found?
		    
		    If probe Is Nil Then Return Nil
		    
		    // It was!
		    
		    // Update the cursor for the next itteration.
		    
		    cursor = probe
		    
		  Next
		  
		  // Loop complete.
		  
		  Return cursor
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub PlainMethodKFS()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub ReRaiseRBFrameworkExceptionsKFS(e As RuntimeException)
		  // Created 8/7/2011 by Andrew Keller
		  
		  // Raises the given exception, if it is one of RB's
		  // internal exceptions that you are not supposed to catch.
		  
		  // Intended for use in a Catch-all block.
		  
		  If e IsA EndException _
		    Or e IsA ThreadEndException Then
		    
		    Raise e
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ThreadMethodKFS(t As Thread)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub VariantMethodKFS(v As Variant)
	#tag EndDelegateDeclaration


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
		
		Copyright (c) 2005-2011 Andrew Keller.
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


	#tag Property, Flags = &h21
		#tag Note
			Used by GetUniqueIndexKFS
		#tag EndNote
		Private dictUniqueIndex As Dictionary
	#tag EndProperty


	#tag Constant, Name = kASCIIDownArrow, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIIEscape, Type = Double, Dynamic = False, Default = \"27", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIILeftArrow, Type = Double, Dynamic = False, Default = \"28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIIRightArrow, Type = Double, Dynamic = False, Default = \"29", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIIUpArrow, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant


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
