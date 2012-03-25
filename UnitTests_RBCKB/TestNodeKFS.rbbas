#tag Class
Protected Class TestNodeKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestLeft()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure the Left property works correctly.
		  
		  Dim n1, n2 As NodeKFS
		  
		  n1 = New NodeKFS
		  n2 = New NodeKFS
		  
		  AssertIsNil n1.Left, "NodeKFS did not start out with a Nil Left property."
		  
		  n1.Left = n2
		  
		  AssertSame n2, n1.Left, "Either the getter or the setter for the Left property does not work."
		  
		  n1.Left = Nil
		  
		  AssertIsNil n1.Left, "Either the getter or the setter for the Left property does not work (cannot set back to Nil)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestParent()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure the Parent property works correctly.
		  
		  Dim n1, n2 As NodeKFS
		  
		  n1 = New NodeKFS
		  n2 = New NodeKFS
		  
		  AssertIsNil n1.Parent, "NodeKFS did not start out with a Nil Parent property."
		  
		  n1.Parent = n2
		  
		  AssertSame n2, n1.Parent, "Either the getter or the setter for the Parent property does not work."
		  
		  n1.Parent = Nil
		  
		  AssertIsNil n1.Parent, "Either the getter or the setter for the Parent property does not work (cannot set back to Nil)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestRight()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure the Right property works correctly.
		  
		  Dim n1, n2 As NodeKFS
		  
		  n1 = New NodeKFS
		  n2 = New NodeKFS
		  
		  AssertIsNil n1.Right, "NodeKFS did not start out with a Nil Right property."
		  
		  n1.Right = n2
		  
		  AssertSame n2, n1.Right, "Either the getter or the setter for the Right property does not work."
		  
		  n1.Right = Nil
		  
		  AssertIsNil n1.Right, "Either the getter or the setter for the Right property does not work (cannot set back to Nil)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure the Value property works correctly.
		  
		  Dim n As New NodeKFS
		  
		  AssertIsNil n.Value, "NodeKFS did not start out with a Nil Value property."
		  
		  n.Value = 15
		  
		  AssertEquals 15, n.Value, "Either the getter or the setter for the Value property does not work."
		  
		  n.Value = "hello"
		  
		  AssertEquals "hello", n.Value, "Either the getter or the setter for the Value property does not work (cannot set again)."
		  
		  n.Value = Nil
		  
		  AssertIsNil n.Value, "Either the getter or the setter for the Value property does not work (cannot set back to Nil)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2010, 2011 Andrew Keller.
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
