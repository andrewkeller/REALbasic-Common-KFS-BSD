#tag Class
Protected Class AutoreleaseStubKFS
	#tag Method, Flags = &h0
		Sub Add(fn As DictionaryMethodKFS, param As Dictionary)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given DictionaryMethod.
		  
		  p_dict.Append fn
		  p_dict.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(fn As PlainMethodKFS)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given PlainMethod.
		  
		  p_plain.Append fn
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(fn As VariantMethodKFS, param As Variant)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given VariantMethod.
		  
		  p_var.Append fn
		  p_var.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  p_dict = New DataChainKFS
		  p_plain = New DataChainKFS
		  p_var = New DataChainKFS
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As DictionaryMethodKFS, param As Dictionary)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  p_dict.Append fn
		  p_dict.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As PlainMethodKFS)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  p_plain.Append fn
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As VariantMethodKFS, param As Variant)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  p_var.Append fn
		  p_var.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Invoke all the methods we've collected.
		  
		  While Not p_dict.IsEmpty
		    
		    Try
		      DictionaryMethodKFS( p_dict.Pop ).Invoke( Dictionary( p_dict.Pop ) )
		    Catch
		    End Try
		    
		  Wend
		  
		  While Not p_plain.IsEmpty
		    
		    Try
		      PlainMethodKFS( p_plain.Pop ).Invoke
		    Catch
		    End Try
		    
		  Wend
		  
		  While Not p_var.IsEmpty
		    
		    Try
		      VariantMethodKFS( p_var.Pop ).Invoke( p_var.Pop )
		    Catch
		    End Try
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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
		Protected p_dict As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_plain As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_var As DataChainKFS
	#tag EndProperty


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
End Class
#tag EndClass
