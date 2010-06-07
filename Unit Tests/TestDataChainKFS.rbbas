#tag Class
Protected Class TestDataChainKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestAppendPop()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Makes sure the Append - Pop cycle works correctly.
		  
		  Dim c As New DataChainKFS
		  
		  c.Append 1
		  AssertEquals 1, c.Pop
		  
		  c.Append 2
		  c.Append 3
		  AssertEquals 2, c.Pop
		  AssertEquals 3, c.Pop
		  
		  c.Append 4
		  c.Append 5
		  c.Append 6
		  AssertEquals 4, c.Pop
		  AssertEquals 5, c.Pop
		  AssertEquals 6, c.Pop
		  
		  c.Append 7
		  c.Append 8
		  AssertEquals 7, c.Pop
		  c.Append 9
		  AssertEquals 8, c.Pop
		  AssertEquals 9, c.Pop
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAppendPushPop()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Makes sure the Append - Push - Pop cycle works correctly.
		  
		  Dim c As New DataChainKFS
		  
		  c.Push 1
		  c.Append 2
		  AssertEquals 1, c.Pop
		  AssertEquals 2, c.Pop
		  
		  c.Append 3
		  c.Push 4
		  c.Append 5
		  AssertEquals 4, c.Pop
		  AssertEquals 3, c.Pop
		  AssertEquals 5, c.Pop
		  
		  c.Push 6
		  c.Append 7
		  c.Push 8
		  AssertEquals 8, c.Pop
		  AssertEquals 6, c.Pop
		  AssertEquals 7, c.Pop
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCount()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Makes sure the Count function works correctly.
		  
		  Dim c As New DataChainKFS
		  
		  AssertEquals 0, c.Count
		  c.Append 1
		  AssertEquals 1, c.Count
		  
		  Call c.Pop
		  c.Push 2
		  AssertEquals 1, c.Count
		  
		  c.Push 3
		  c.Append 4
		  c.Push 5
		  c.Append 6
		  
		  AssertEquals 5, c.Count
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasValue()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Makes sure the Append - Pop cycle works correctly.
		  
		  Dim c As New DataChainKFS
		  
		  AssertFalse c.HasValue( 1 )
		  c.Append 1
		  AssertTrue c.HasValue( 1 )
		  
		  AssertFalse c.HasValue( 2 )
		  c.Push 2
		  AssertTrue c.HasValue( 2 )
		  
		  AssertFalse c.HasValue( 3 )
		  c.Append 2
		  c.Append 3
		  c.Append 3
		  c.Append 4
		  AssertTrue c.HasValue( 3 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsEmpty()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Makes sure the IsEmpty works correctly.
		  
		  Dim c As New DataChainKFS
		  
		  AssertTrue c.IsEmpty
		  
		  c.Append 1
		  AssertFalse c.IsEmpty
		  
		  c.Append 2
		  AssertFalse c.IsEmpty
		  
		  Call c.Pop
		  AssertFalse c.IsEmpty
		  
		  Call c.Pop
		  AssertTrue c.IsEmpty
		  
		  c.Append 3
		  c.Append 4
		  Call c.Pop
		  AssertFalse c.IsEmpty
		  c.Append 5
		  AssertFalse c.IsEmpty
		  Call c.Pop
		  AssertFalse c.IsEmpty
		  Call c.Pop
		  AssertTrue c.IsEmpty
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestPushPop()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Makes sure the Push - Pop cycle works correctly.
		  
		  Dim c As New DataChainKFS
		  
		  c.Push 1
		  AssertEquals 1, c.Pop
		  
		  c.Push 2
		  c.Push 3
		  AssertEquals 3, c.Pop
		  AssertEquals 2, c.Pop
		  
		  c.Push 4
		  c.Push 5
		  c.Push 6
		  AssertEquals 6, c.Pop
		  AssertEquals 5, c.Pop
		  AssertEquals 4, c.Pop
		  
		  c.Push 7
		  c.Push 8
		  AssertEquals 8, c.Pop
		  c.Push 9
		  AssertEquals 9, c.Pop
		  AssertEquals 7, c.Pop
		  
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
