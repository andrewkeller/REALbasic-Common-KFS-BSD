#tag Class
Protected Class NodeKFS
	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010 Andrew Keller.
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


	#tag Property, Flags = &h0
		Left As NodeKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParent As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/20/2010 by Andrew Keller
			  
			  // Returns a reference to the parent node.
			  
			  If myParent Is Nil Then
			    
			    Return Nil
			    
			  Else
			    
			    // If this line fails, then it's because somebody stored
			    // a non-NodeKFS object in the myParent property.
			    
			    Return NodeKFS( myParent.Value )
			    
			  End If
			  
			  // done.
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Created 8/20/2010 by Andrew Keller
			  
			  // Sets the parent node.
			  
			  If value Is Nil Then
			    
			    myParent = Nil
			    
			  Else
			    
			    myParent = New WeakRef( value )
			    
			  End If
			  
			  // done.
			  
			End Set
		#tag EndSetter
		Parent As NodeKFS
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Right As NodeKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As Variant
	#tag EndProperty


End Class
#tag EndClass
