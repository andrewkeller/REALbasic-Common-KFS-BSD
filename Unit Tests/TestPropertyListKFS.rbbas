#tag Class
Protected Class TestPropertyListKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Function GenerateTree1() As PropertyListKFS
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Returns a sample tree with various properties.
		  
		  Dim d, e, f, g As Dictionary
		  
		  d = New Dictionary
		  
		  d.Value( "v1" ) = 12
		  d.Value( "v2" ) = 23
		  d.Value( "v3" ) = 35
		  d.Value( "v4" ) = 67
		  
		  d.Value( "c1" ) = New PropertyListKFS
		  e = PropertyListKFS( d.Value( "c1" ) )
		  
		  d.Value( "c2" ) = New Dictionary
		  f = Dictionary( d.Value( "c2" ) )
		  
		  d.Value( "c3" ) = New PropertyListKFS
		  g = PropertyListKFS( d.Value( "c3" ) )
		  PropertyListKFS( d.Value( "c3" ) ).TreatAsArray = True
		  
		  e.Value( "foo" ) = "bar"
		  e.Value( "fish" ) = "cat"
		  
		  f.Value( "dog" ) = "squirrel"
		  f.Value( "shark" ) = "monkey"
		  f.Value( "number" ) = "letter"
		  f.Value( "puppy" ) = New PropertyListKFS( New Dictionary( "turkey":"gobble" ) )
		  
		  g.Value( "test" ) = "case"
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChild()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Child functions work.
		  
		  Dim root, expchild As PropertyListKFS
		  Dim rootcore, expchildcore As Dictionary
		  
		  // Make sure the setter works in the root case.
		  
		  rootcore = New Dictionary
		  root = rootcore
		  expchildcore = New Dictionary( "foo":"bar" )
		  expchild = expchildcore
		  
		  root.Child( "foobar" ) = expchild
		  
		  AssertTrue rootcore.HasKey( "foobar" ), "The Child setter did not add the key for the child."
		  AssertSame expchild, rootcore.Value( "foobar" ), "The Child setter did not set the child correctly."
		  
		  
		  // Make sure the getter works in the root case.
		  
		  AssertSame expchild, root.Child( "foobar" ), "The Child getter did not return a child that is known to exist.", False
		  
		  
		  // Make sure the setter works in the non-root case.
		  
		  expchildcore = New Dictionary( "fish":"cat" )
		  expchild = expchildcore
		  
		  root.Child( "foo", "bar", "fishcat" ) = expchild
		  
		  AssertTrue rootcore.HasKey( "foo" ), "The Child setter did not add the first level of the path."
		  AssertTrue rootcore.Value( "foo" ) IsA PropertyListKFS, "The Child setter did not add the first level of the path correctly."
		  AssertTrue Dictionary( rootcore.Value( "foo" ) ).HasKey( "bar" ), "The Child setter did not add the second level of the path."
		  AssertTrue Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) IsA PropertyListKFS, "The Child setter did not add the second level of the path correctly."
		  AssertTrue Dictionary( Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) ).HasKey( "fishcat" ), "The Child setter did not add the key for the new child."
		  AssertSame expchild, Dictionary( Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) ).Value( "fishcat" ), "The Child setter did not assign the new child at the correct path."
		  
		  
		  // Make sure the getter works in the non-root case.
		  
		  AssertSame expchild, root.Child( "foo", "bar", "fishcat" ), "The Child getter did not return a child that is known to exist.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChildCount()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the ChildCount function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  
		  // Make sure ChildCount works for the children.
		  
		  PushMessageStack "ChildCount failed for the "
		  AssertEquals 3, root.ChildCount, "root directory."
		  AssertEquals 0, root.ChildCount( "c1" ), "c1 directory."
		  AssertEquals 1, root.ChildCount( "c2" ), "c2 directory."
		  AssertEquals 0, root.ChildCount( "c2", "puppy" ), "c2/puppy directory."
		  AssertEquals 0, root.ChildCount( "c3" ), "c3 directory."
		  PopMessageStack
		  
		  // Make sure ChildCount works for the terminals.
		  
		  PushMessageStack "ChildCount should return zero for terminal nodes."
		  AssertZero root.ChildCount( "v1" )
		  AssertZero root.ChildCount( "v2" )
		  AssertZero root.ChildCount( "v3" )
		  AssertZero root.ChildCount( "v4" )
		  AssertZero root.ChildCount( "c1", "foo" )
		  AssertZero root.ChildCount( "c1", "fish" )
		  AssertZero root.ChildCount( "c2", "dog" )
		  AssertZero root.ChildCount( "c2", "shark" )
		  AssertZero root.ChildCount( "c2", "number" )
		  AssertZero root.ChildCount( "c3", "test" )
		  PopMessageStack
		  
		  // Make sure ChildCount works for keys that don't exist.
		  
		  PushMessageStack "ChildCount should return zero for nodes that do not exist."
		  AssertZero root.ChildCount( "foo" )
		  AssertZero root.ChildCount( "foo", "bar" )
		  AssertZero root.ChildCount( "v1", "foo" )
		  AssertZero root.ChildCount( "c1", "foo", "bar" )
		  AssertZero root.ChildCount( "c2", "foo" )
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestChildren()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClone()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructorDataCore()
		  // Created 11/24/2010 by Andrew Keller
		  
		  // Makes sure the data core constructors work.
		  
		  Dim c, d As Dictionary
		  Dim p As PropertyListKFS
		  
		  // Test the NewPListWithDataCore function with real input.
		  
		  d = New Dictionary( "foo":"bar" )
		  p = PropertyListKFS.NewPListWithDataCore( d )
		  
		  AssertNotIsNil p, "NewPListWithDataCore should never return a Nil result."
		  AssertFalse p.TreatAsArray, "The TreatAsArray property must default to False.", False
		  
		  d.Value( "fish" ) = "cat"
		  c = p
		  
		  AssertSame d, c, "NewPListWithDataCore should not clone the given Dictionary object; it should simply use it."
		  AssertEquals d.Count, c.Count, "Something weird is happening here."
		  
		  
		  // Test the NewPListWithDataCore function with Nil input.
		  
		  p = PropertyListKFS.NewPListWithDataCore( Nil )
		  
		  AssertNotIsNil p, "NewPListWithDataCore should never return a Nil result."
		  AssertFalse p.TreatAsArray, "The TreatAsArray property must default to False.", False
		  
		  c = p
		  
		  AssertNotIsNil c, "NewPListWithDataCore should not use a given Nil Dictionary object; it should make a new one."
		  AssertZero c.Count, "A new data core should be empty."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructorDefault()
		  // Created 11/24/2010 by Andrew Keller
		  
		  // Makes sure the default constructor works.
		  
		  Dim p As New PropertyListKFS
		  
		  AssertNotIsNil p, "WTF???"
		  AssertFalse p.TreatAsArray, "The TreatAsArray property must default to False.", False
		  
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The data core of a new PropertyListKFS object should never be Nil."
		  AssertZero d.Count, "The data core of a new PropertyListKFS object should be empty."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructorPair()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCount()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Count function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  
		  // Make sure Count works for the children.
		  
		  PushMessageStack "Count failed for the "
		  AssertEquals 7, root.Count, "root directory."
		  AssertEquals 2, root.Count( "c1" ), "c1 directory."
		  AssertEquals 4, root.Count( "c2" ), "c2 directory."
		  AssertEquals 1, root.Count( "c2", "puppy" ), "c2/puppy directory."
		  AssertEquals 1, root.Count( "c3" ), "c3 directory."
		  PopMessageStack
		  
		  // Make sure Count works for the terminals.
		  
		  PushMessageStack "Count should return zero for terminal nodes."
		  AssertZero root.Count( "v1" )
		  AssertZero root.Count( "v2" )
		  AssertZero root.Count( "v3" )
		  AssertZero root.Count( "v4" )
		  AssertZero root.Count( "c1", "foo" )
		  AssertZero root.Count( "c1", "fish" )
		  AssertZero root.Count( "c2", "dog" )
		  AssertZero root.Count( "c2", "shark" )
		  AssertZero root.Count( "c2", "number" )
		  AssertZero root.Count( "c3", "test" )
		  PopMessageStack
		  
		  // Make sure Count works for keys that don't exist.
		  
		  PushMessageStack "Count should return zero for nodes that do not exist."
		  AssertZero root.Count( "foo" )
		  AssertZero root.Count( "foo", "bar" )
		  AssertZero root.Count( "v1", "foo" )
		  AssertZero root.Count( "c1", "foo", "bar" )
		  AssertZero root.Count( "c2", "foo" )
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasChild()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasKey()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasTerminal()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestImport()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestKey()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestKeys()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLookup()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Convert()
		  // Created 11/24/2010 by Andrew Keller
		  
		  // Makes sure the convert constructor works.
		  
		  Dim c, d As Dictionary
		  Dim p As PropertyListKFS
		  
		  // Test the convert constructor with real input.
		  
		  d = New Dictionary( "foo":"bar" )
		  p = d
		  
		  AssertNotIsNil p, "I thought convert constructors could never generate a Nil result."
		  AssertFalse p.TreatAsArray, "The TreatAsArray property must default to False.", False
		  
		  d.Value( "fish" ) = "cat"
		  c = p
		  
		  AssertSame d, c, "The data core convert constructor should not clone the given Dictionary object; it should simply use it."
		  AssertEquals d.Count, c.Count, "Something weird is happening here."
		  
		  
		  // Test the convert constructor with Nil input.
		  
		  d = Nil
		  p = d
		  
		  AssertNotIsNil p, "I thought convert constructors could never generate a Nil result."
		  AssertFalse p.TreatAsArray, "The TreatAsArray property must default to False.", False
		  
		  c = p
		  
		  AssertNotIsNil c, "The data core convert constructor should not use a given Nil Dictionary object; it should make a new one."
		  AssertZero c.Count, "A new data core should be empty."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestRemove()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTerminalCount()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the TerminalCount function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  
		  // Make sure TerminalCount works for the children.
		  
		  PushMessageStack "TerminalCount failed for the "
		  AssertEquals 4, root.TerminalCount, "root directory."
		  AssertEquals 2, root.TerminalCount( "c1" ), "c1 directory."
		  AssertEquals 3, root.TerminalCount( "c2" ), "c2 directory."
		  AssertEquals 1, root.TerminalCount( "c2", "puppy" ), "c2/puppy directory."
		  AssertEquals 1, root.TerminalCount( "c3" ), "c3 directory."
		  PopMessageStack
		  
		  // Make sure TerminalCount works for the terminals.
		  
		  PushMessageStack "TerminalCount should return zero for terminal nodes."
		  AssertZero root.TerminalCount( "v1" )
		  AssertZero root.TerminalCount( "v2" )
		  AssertZero root.TerminalCount( "v3" )
		  AssertZero root.TerminalCount( "v4" )
		  AssertZero root.TerminalCount( "c1", "foo" )
		  AssertZero root.TerminalCount( "c1", "fish" )
		  AssertZero root.TerminalCount( "c2", "dog" )
		  AssertZero root.TerminalCount( "c2", "shark" )
		  AssertZero root.TerminalCount( "c2", "number" )
		  AssertZero root.TerminalCount( "c3", "test" )
		  PopMessageStack
		  
		  // Make sure TerminalCount works for keys that don't exist.
		  
		  PushMessageStack "TerminalCount should return zero for nodes that do not exist."
		  AssertZero root.TerminalCount( "foo" )
		  AssertZero root.TerminalCount( "foo", "bar" )
		  AssertZero root.TerminalCount( "v1", "foo" )
		  AssertZero root.TerminalCount( "c1", "foo", "bar" )
		  AssertZero root.TerminalCount( "c2", "foo" )
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTreatAsArray()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Value functions work.
		  
		  Dim root As PropertyListKFS
		  Dim rootcore As Dictionary
		  Dim expvalue As String = "Hello, World!"
		  
		  // Make sure the setter works in the root case.
		  
		  rootcore = New Dictionary
		  root = rootcore
		  
		  root.Value( "foo" ) = expvalue
		  
		  AssertTrue rootcore.HasKey( "foo" ), "The Value setter did not add the key for the child."
		  AssertSame expvalue, rootcore.Value( "foo" ), "The Value setter did not assign the value to the key."
		  
		  
		  // Make sure the getter works in the root case.
		  
		  AssertSame expvalue, root.Value( "foo" ), "The Value getter did not return a value that is known to exist.", False
		  
		  
		  // Make sure the setter works in the non-root case.
		  
		  root.Value( "foo", "bar", "fishcat" ) = expvalue
		  
		  AssertTrue rootcore.HasKey( "foo" ), "The Value setter did not add the first level of the path."
		  AssertTrue rootcore.Value( "foo" ) IsA PropertyListKFS, "The Value setter did not add the first level of the path correctly."
		  AssertTrue Dictionary( rootcore.Value( "foo" ) ).HasKey( "bar" ), "The Value setter did not add the second level of the path."
		  AssertTrue Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) IsA PropertyListKFS, "The Value setter did not add the second level of the path correctly."
		  AssertTrue Dictionary( Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) ).HasKey( "fishcat" ), "The Value setter did not add the key for the new child."
		  AssertSame expvalue, Dictionary( Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) ).Value( "fishcat" ), "The Value setter did not assign the new child at the correct path."
		  
		  
		  // Make sure the getter works in the non-root case.
		  
		  AssertSame expvalue, root.Child( "foo", "bar", "fishcat" ), "The Value getter did not return a value that is known to exist.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValues()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestWedge()
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
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
