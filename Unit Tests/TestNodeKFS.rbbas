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
		  
		  AssertTrue n1.Left Is Nil, "NodeKFS did not start out with a Nil Left property."
		  
		  n1.Left = n2
		  
		  AssertTrue n1.Left Is n2, "Either the getter or the setter for the Left property does not work."
		  
		  n1.Left = Nil
		  
		  AssertTrue n1.Left Is Nil, "Either the getter or the setter for the Left property does not work (cannot set back to Nil)."
		  
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
		  
		  AssertTrue n1.Parent Is Nil, "NodeKFS did not start out with a Nil Parent property."
		  
		  n1.Parent = n2
		  
		  AssertTrue n1.Parent Is n2, "Either the getter or the setter for the Parent property does not work."
		  
		  n1.Parent = Nil
		  
		  AssertTrue n1.Parent Is Nil, "Either the getter or the setter for the Parent property does not work (cannot set back to Nil)."
		  
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
		  
		  AssertTrue n1.Right Is Nil, "NodeKFS did not start out with a Nil Right property."
		  
		  n1.Right = n2
		  
		  AssertTrue n1.Right Is n2, "Either the getter or the setter for the Right property does not work."
		  
		  n1.Right = Nil
		  
		  AssertTrue n1.Right Is Nil, "Either the getter or the setter for the Right property does not work (cannot set back to Nil)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure the Value property works correctly.
		  
		  Dim n As New NodeKFS
		  
		  AssertTrue n.Value Is Nil, "NodeKFS did not start out with a Nil Value property."
		  
		  n.Value = 15
		  
		  AssertEquals 15, n.Value, "Either the getter or the setter for the Value property does not work."
		  
		  n.Value = "hello"
		  
		  AssertEquals "hello", n.Value, "Either the getter or the setter for the Value property does not work (cannot set again)."
		  
		  n.Value = Nil
		  
		  AssertTrue n.Value Is Nil, "Either the getter or the setter for the Value property does not work (cannot set back to Nil)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


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
