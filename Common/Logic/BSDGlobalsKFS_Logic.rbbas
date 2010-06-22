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

	#tag Method, Flags = &h0
		Function GetUniqueIndexKFS(sCategory As String = "") As Integer
		  // returns an integer that is unique
		  // as long as this program is running
		  
		  // Created 3/15/2007 by Andrew Keller
		  
		  If dictUniqueIndex = Nil Then dictUniqueIndex = New Dictionary
		  
		  dictUniqueIndex.Value(sCategory) = dictUniqueIndex.Lookup(sCategory, -1) +1
		  
		  Return dictUniqueIndex.Value(sCategory)
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(Extends xnode As XmlNode, ParamArray names As String) As XmlNode
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Searches the given XmlElement for a node with the given name.
		  // Returns Nil if not found.
		  
		  Dim cursor As XmlNode = xnode
		  Dim probe As XmlNode
		  
		  For Each name As String In names
		    
		    // Find a child inside <cursor> with name <test>.
		    
		    probe = cursor.FirstChild
		    
		    // Linear search.  Upon success, probe <> Nil.
		    
		    While probe <> Nil
		      
		      If probe.Name = name Then Exit
		      
		      probe = probe.NextSibling
		      
		    Wend
		    
		    // Was the current name found?
		    
		    If probe = Nil Then Return Nil
		    
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

	#tag Note, Name = Miscellaneous_Usage
		This note describes the following constants:
		
		  kASCIIDownArrow
		  kASCIILeftArrow
		  kASCIIRightArrow
		  kASCIIUpArrow
		
		And delegates:
		
		  PlainMethodKFS
		
		And methods:
		
		  cvt
		  GetUniqueIndexKFS
		  Lookup
		
		
		Groups of methods are typically in their own note.  The above methods
		do not conform to any of the other existing groups, therefore are here.
		
		  - kASCII{Down,Left,Right,Up}Arrow are constants describing the ASCII
		values of the respective arrow keys.
		
		  - PlainMethodKFS is a delegate that represents any method with no
		arguments and no return value.
		
		  - cvt is a function that returns the given variant as a variant.  Useful
		for passing a value of arbitrary type through a variant only for the
		conversion functions available to the variant type.
		
		  - GetUniqueIndexKFS returns a globally unique integer.  The integer
		starts at zero and increments.  You can optionally specify a category,
		which guarantees that your function receives a continuous list.
		
		  - Lookup is a extension of the XmlNode class that allows looking up
		an XmlNode by a ParamArray of keys.  Nil is returned upon failure.
		
	#tag EndNote


	#tag Property, Flags = &h21
		#tag Note
			Used by GetUniqueIndexKFS
		#tag EndNote
		Private dictUniqueIndex As Dictionary
	#tag EndProperty


	#tag Constant, Name = kASCIIDownArrow, Type = Double, Dynamic = False, Default = \"31", Scope = Public
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
