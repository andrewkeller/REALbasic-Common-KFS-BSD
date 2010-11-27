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
		  d.Value( "v4" ) = Nil
		  
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
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Children function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  Dim fndchildcore As Dictionary
		  Dim v() As PropertyListKFS
		  
		  // Make sure the Children function works for children.
		  
		  PushMessageStack "At the root level:"
		  v = root.Children
		  AssertNotIsNil v, "Children is never supposed to return a Nil result."
		  AssertEquals 2, UBound( v ), "Children did not return the correct number of items."
		  AssertSame rootcore.Value( "c1" ), v(0), "Index 0 is wrong."
		  fndchildcore = v(1)
		  AssertNotIsNil fndchildcore, "There is a problem with the outgoing Dictionary convert constructor."
		  AssertSame fndchildcore, rootcore.Value( "c2" ), "Index 1 is wrong."
		  AssertSame rootcore.Value( "c3" ), v(2), "Index 2 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c1 level:"
		  v = root.Children( "c1" )
		  AssertNotIsNil v, "Children is never supposed to return a Nil result."
		  AssertEquals -1, UBound( v ), "Children did not return the correct number of items."
		  PopMessageStack
		  
		  PushMessageStack "At the c2 level:"
		  v = root.Children( "c2" )
		  AssertNotIsNil v, "Children is never supposed to return a Nil result."
		  AssertEquals 0, UBound( v ), "Children did not return the correct number of items."
		  AssertSame Dictionary( rootcore.Value( "c2" ) ).Value( "puppy" ), v(0), "Index 0 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c2/puppy level:"
		  v = root.Children( "c2", "puppy" )
		  AssertNotIsNil v, "Children is never supposed to return a Nil result."
		  AssertEquals -1, UBound( v )
		  PopMessageStack
		  
		  PushMessageStack "At the c3 level:"
		  v = root.Children( "c3" )
		  AssertNotIsNil v, "Children is never supposed to return a Nil result."
		  AssertEquals -1, UBound( v )
		  PopMessageStack
		  
		  
		  // Make sure the Children function works with terminals.
		  
		  AssertNotIsNil root.Children( "v1" ), "Children is never supposed to return a Nil result (path was a terminal)."
		  
		  PushMessageStack "The Children function is supposed to return an empty array for terminals."
		  
		  AssertZero UBound( root.Children( "v1" ) )
		  AssertZero UBound( root.Children( "v2" ) )
		  AssertZero UBound( root.Children( "v3" ) )
		  AssertZero UBound( root.Children( "v4" ) )
		  AssertZero UBound( root.Children( "c1", "foo" ) )
		  AssertZero UBound( root.Children( "c1", "fish" ) )
		  AssertZero UBound( root.Children( "c2", "dog" ) )
		  AssertZero UBound( root.Children( "c2", "shark" ) )
		  AssertZero UBound( root.Children( "c2", "number" ) )
		  AssertZero UBound( root.Children( "c2", "puppy", "turkey" ) )
		  AssertZero UBound( root.Children( "c3", "test" ) )
		  
		  PopMessageStack
		  
		  
		  // Make sure the Children function works with nodes that don't exist.
		  
		  AssertNotIsNil root.Children( "doggie" ), "Children is never supposed to return a Nil result (path did not exist)."
		  
		  PushMessageStack "The Children function is supposed to return an empty array for paths that do not exist."
		  
		  AssertZero UBound( root.Children( "doggie" ) )
		  AssertZero UBound( root.Children( "doggie", "fishcat" ) )
		  AssertZero UBound( root.Children( "c1", "doggie" ) )
		  AssertZero UBound( root.Children( "c1", "doggie", "fishcat" ) )
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClone()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Clone operation works.
		  
		  Dim orig As PropertyListKFS = GenerateTree1
		  Dim cpy As PropertyListKFS = Nil
		  
		  // Make sure the Clone constructor works.
		  
		  PushMessageStack "In the clone constructor:"
		  
		  PushMessageStack "With non-Nil input:"
		  VerifyClone orig, New PropertyListKFS( orig ), True
		  PopMessageStack
		  
		  PushMessageStack "With Nil input:"
		  VerifyClone Nil, New PropertyListKFS( cpy ), True
		  PopMessageStack
		  
		  PopMessageStack
		  
		  
		  // Make sure the Clone method works.
		  
		  PushMessageStack "In the Clone method:"
		  VerifyClone orig, orig.Clone, True
		  PopMessageStack
		  
		  
		  // Make sure the shared Clone method works.
		  
		  PushMessageStack "In the shared Clone method:"
		  
		  PushMessageStack "With non-Nil input:"
		  VerifyClone orig, PropertyListKFS.NewPListFromClone( orig ), True
		  PopMessageStack
		  
		  PushMessageStack "With Nil input:"
		  VerifyClone Nil, PropertyListKFS.NewPListFromClone( cpy ), True
		  PopMessageStack
		  
		  PopMessageStack
		  
		  // done.
		  
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
		  // Created 11/27/2010 by Andrew Keller
		  
		  // Makes sure the Pair constructors work.
		  
		  Dim p As PropertyListKFS
		  
		  // Make sure the ParamArray version works.
		  
		  PushMessageStack "In the ParamArray version:"
		  
		  p = New PropertyListKFS( "foo" : 1, "bar" : 2, "fish" : New Dictionary( 1:2, 3:4 ), "cat" : 7 )
		  
		  AssertNotIsNil p, "Okay, something weird is happening here."
		  AssertEquals 4, p.Count
		  AssertEquals 3, p.TerminalCount
		  AssertEquals 1, p.ChildCount
		  
		  Dim d As Dictionary = p
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is supposed to return non-Nil."
		  
		  AssertTrue d.HasKey( "foo" )
		  AssertEquals 1, d.Value( "foo" )
		  
		  AssertTrue d.HasKey( "bar" )
		  AssertEquals 2, d.Value( "bar" )
		  
		  AssertTrue d.HasKey( "fish" )
		  AssertTrue d.Value( "fish" ) IsA Dictionary
		  AssertEquals 2, Dictionary( d.Value( "fish" ) ).Count
		  AssertTrue Dictionary( d.Value( "fish" ) ).HasKey( 1 )
		  AssertEquals 2, Dictionary( d.Value( "fish" ) ).Value( 1 )
		  AssertTrue Dictionary( d.Value( "fish" ) ).HasKey( 3 )
		  AssertEquals 4, Dictionary( d.Value( "fish" ) ).Value( 3 )
		  
		  AssertTrue d.HasKey( "cat" )
		  AssertEquals 7, d.Value( "cat" )
		  
		  PopMessageStack
		  
		  
		  // Make sure the Array version works.
		  
		  Dim par(-1) As Pair
		  par.Append "foo" : 1
		  par.Append "bar" : 2
		  par.Append "fish" : New Dictionary( 1:2, 3:4 )
		  par.Append "cat" : 7
		  
		  p = New PropertyListKFS( par )
		  
		  AssertNotIsNil p, "Okay, something weird is happening here."
		  AssertEquals 4, p.Count
		  AssertEquals 3, p.TerminalCount
		  AssertEquals 1, p.ChildCount
		  
		  d = p
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is supposed to return non-Nil."
		  
		  AssertTrue d.HasKey( "foo" )
		  AssertEquals 1, d.Value( "foo" )
		  
		  AssertTrue d.HasKey( "bar" )
		  AssertEquals 2, d.Value( "bar" )
		  
		  AssertTrue d.HasKey( "fish" )
		  AssertTrue d.Value( "fish" ) IsA Dictionary
		  AssertEquals 2, Dictionary( d.Value( "fish" ) ).Count
		  AssertTrue Dictionary( d.Value( "fish" ) ).HasKey( 1 )
		  AssertEquals 2, Dictionary( d.Value( "fish" ) ).Value( 1 )
		  AssertTrue Dictionary( d.Value( "fish" ) ).HasKey( 3 )
		  AssertEquals 4, Dictionary( d.Value( "fish" ) ).Value( 3 )
		  
		  AssertTrue d.HasKey( "cat" )
		  AssertEquals 7, d.Value( "cat" )
		  
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
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the TreatAsArray function works.
		  
		  Dim rootcore As New Dictionary
		  Dim root As PropertyListKFS = rootcore
		  
		  // Make sure the the getter and setter work in the root case.
		  
		  AssertFalse root.TreatAsArray, "TreatAsArray did not default to False."
		  
		  root.TreatAsArray = True
		  AssertTrue root.TreatAsArray, "TreatAsArray could not be changed to True."
		  
		  root.TreatAsArray = False
		  AssertFalse root.TreatAsArray, "TreatAsArray could not be changed back to False."
		  
		  
		  // Make sure the getter and setter work in the non-root case.
		  
		  AssertFalse root.TreatAsArray( "foo", "bar" ), "TreatAsArray does not return False for directories that do not exist."
		  
		  root.TreatAsArray( "foo", "bar" ) = False
		  AssertTrue root.HasKey( "foo" ), "Setting TreatAsArray did not create the first subfolder."
		  AssertTrue root.Value( "foo" ) IsA PropertyListKFS, "Setting TreatAsArray did not create the first subfolder correctly."
		  AssertTrue Dictionary( root.Value( "foo" ) ).HasKey( "bar" ), "Setting TreatAsArray did not create the last subfolder."
		  AssertTrue Dictionary( root.Value( "foo" ) ).Value( "bar" ) IsA PropertyListKFS, "Setting TreatAsArray did not create the last subfolder correctly."
		  
		  root.TreatAsArray( "foo", "bar" ) = True
		  AssertTrue root.TreatAsArray( "foo", "bar" ), "TreatAsArray could not be changed to True for a non-root directory."
		  
		  
		  // Make sure the getter and setter overwrite Dictionary objects correctly.
		  
		  PushMessageStack "Making sure Dictionary objects can be replaced by PropertyListKFS objects:"
		  
		  rootcore.Value( "foo" ) = New Dictionary( "bar" : New Dictionary )
		  
		  AssertFalse root.TreatAsArray( "foo" ), "TreatAsArray did not return False for a directory represented by a Dictionary object."
		  AssertFalse root.TreatAsArray( "foo", "bar" ), "TreatAsArray did not return False for a directory represented by a Dictionary object (2)."
		  
		  root.TreatAsArray( "foo", "bar" ) = False
		  
		  AssertTrue root.HasKey( "foo" ), "Setting TreatAsArray did not create the first subfolder."
		  AssertTrue root.Value( "foo" ) IsA Dictionary, "Setting TreatAsArray did not create the first subfolder correctly."
		  AssertTrue Dictionary( root.Value( "foo" ) ).HasKey( "bar" ), "Setting TreatAsArray did not create the last subfolder."
		  AssertTrue Dictionary( root.Value( "foo" ) ).Value( "bar" ) IsA PropertyListKFS, "Setting TreatAsArray did not create the last subfolder correctly."
		  
		  AssertFalse root.TreatAsArray( "foo", "bar" ), "TreatAsArray could not be set to False."
		  
		  root.TreatAsArray( "foo", "bar" ) = True
		  AssertTrue root.TreatAsArray( "foo", "bar" ), "TreatAsArray could not be set to True."
		  AssertTrue root.Value( "foo" ) IsA Dictionary, "Setting TreatAsArray to True did something to the intermediate folder."
		  
		  PopMessageStack
		  
		  // done.
		  
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
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Values function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  Dim v() As Variant
		  
		  // Make sure the Values function works for children.
		  
		  PushMessageStack "At the root level:"
		  v = root.Values
		  AssertNotIsNil v, "Values is never supposed to return a Nil result."
		  AssertEquals 3, UBound( v ), "Values did not return the correct number of items."
		  AssertEquals 12, v(0), "Index 0 is wrong."
		  AssertEquals 23, v(1), "Index 1 is wrong."
		  AssertEquals 35, v(2), "Index 2 is wrong."
		  AssertEquals 67, v(3), "Index 3 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c1 level:"
		  v = root.Values( "c1" )
		  AssertNotIsNil v, "Values is never supposed to return a Nil result."
		  AssertEquals 1, UBound( v ), "Values did not return the correct number of items."
		  AssertEquals "bar", v(0), "Index 0 is wrong."
		  AssertEquals "cat", v(1), "Index 1 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c2 level:"
		  v = root.Values( "c2" )
		  AssertNotIsNil v, "Values is never supposed to return a Nil result."
		  AssertEquals 2, UBound( v ), "Values did not return the correct number of items."
		  AssertEquals "squirrel", v(0), "Index 0 is wrong."
		  AssertEquals "monkey", v(1), "Index 1 is wrong."
		  AssertEquals "letter", v(2), "Index 2 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c2/puppy level:"
		  v = root.Values( "c2", "puppy" )
		  AssertNotIsNil v, "Values is never supposed to return a Nil result."
		  AssertEquals 0, UBound( v )
		  AssertEquals "gobble", v(0), "Index 0 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c3 level:"
		  v = root.Values( "c3" )
		  AssertNotIsNil v, "Values is never supposed to return a Nil result."
		  AssertEquals 0, UBound( v )
		  AssertEquals "case", v(0), "Index 0 is wrong."
		  PopMessageStack
		  
		  
		  // Make sure the Values function works with terminals.
		  
		  AssertNotIsNil root.Values( "v1" ), "Values is never supposed to return a Nil result (path was a terminal)."
		  
		  PushMessageStack "The Values function is supposed to return an empty array for terminals."
		  
		  AssertZero UBound( root.Values( "v1" ) )
		  AssertZero UBound( root.Values( "v2" ) )
		  AssertZero UBound( root.Values( "v3" ) )
		  AssertZero UBound( root.Values( "v4" ) )
		  AssertZero UBound( root.Values( "c1", "foo" ) )
		  AssertZero UBound( root.Values( "c1", "fish" ) )
		  AssertZero UBound( root.Values( "c2", "dog" ) )
		  AssertZero UBound( root.Values( "c2", "shark" ) )
		  AssertZero UBound( root.Values( "c2", "number" ) )
		  AssertZero UBound( root.Values( "c2", "puppy", "turkey" ) )
		  AssertZero UBound( root.Values( "c3", "test" ) )
		  
		  PopMessageStack
		  
		  
		  // Make sure the Values function works with nodes that don't exist.
		  
		  AssertNotIsNil root.Values( "doggie" ), "Values is never supposed to return a Nil result (path did not exist)."
		  
		  PushMessageStack "The Values function is supposed to return an empty array for paths that do not exist."
		  
		  AssertZero UBound( root.Values( "doggie" ) )
		  AssertZero UBound( root.Values( "doggie", "fishcat" ) )
		  AssertZero UBound( root.Values( "c1", "doggie" ) )
		  AssertZero UBound( root.Values( "c1", "doggie", "fishcat" ) )
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestWedge()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyClone(orig As PropertyListKFS, cpy As PropertyListKFS, requireNonNilResult As Boolean)
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Verifies that a clone operation worked, given the original and the clone.
		  
		  Dim origcore, cpycore As Dictionary
		  
		  // Check for the root Nil case.
		  
		  If orig Is Nil Then
		    
		    If requireNonNilResult Then
		      
		      AssertNotIsNil cpy, "This clone operation requires that the result be non-Nil (1)."
		      
		      AssertFalse cpy.TreatAsArray, "TreatAsArray should be false.", False
		      
		      cpycore = cpy
		      AssertNotIsNil cpycore, "The outgoing Dictionary convert constructor is never supposed to return Nil (1)."
		      
		      AssertZero cpycore.Count, "The clone of a Nil PropertyListKFS should be an empty PropertyListKFS object.", False
		      
		    Else
		      AssertIsNil cpy, "This clone operation requires that the result be Nil."
		    End If
		  Else
		    
		    // This is not the root Nil case.  Perform some final checks before we dive into hierarchy.
		    
		    AssertNotIsNil cpy, "This clone operation requires that the result be non-Nil (2)."
		    
		    origcore = orig
		    AssertNotIsNil origcore, "The outgoing Dictionary convert constructor is never supposed to return Nil (2)."
		    
		    cpycore = cpy
		    AssertNotIsNil cpycore, "The outgoing Dictionary convert constructor is never supposed to return Nil (3)."
		    
		    // Make sure the two data cores contain the same information,
		    // but use different Dictionary or PropertyListKFS objects.
		    
		    Dim origdirs(), cpydirs() As Variant
		    Dim checknum As Integer = 0
		    
		    origdirs.Append orig
		    cpydirs.Append cpy
		    
		    While UBound( origdirs ) >= 0
		      
		      checknum = checknum +1
		      
		      // Verify each child of the current directories.
		      
		      // Extract the directories:
		      
		      If origdirs(0) IsA Dictionary Then
		        orig = Nil
		        origcore = origdirs(0)
		      ElseIf origdirs(0) IsA PropertyListKFS Then
		        orig = origdirs(0)
		        origcore = orig
		        AssertNotIsNil origcore, "The outgoing Dictionary convert constructor is never supposed to return Nil (4)."
		      Else
		        AssertFailure "Internal error: Unknown type of directory (orig): " + ObjectDescriptionKFS( origdirs(0) )
		      End If
		      
		      If cpydirs(0) IsA Dictionary Then
		        cpy = Nil
		        cpycore = cpydirs(0)
		      ElseIf cpydirs(0) IsA PropertyListKFS Then
		        cpy = cpydirs(0)
		        cpycore = cpy
		        AssertNotIsNil cpycore, "The outgoing Dictionary convert constructor is never supposed to return Nil (5)."
		      Else
		        AssertFailure "Internal error: Unknown type of directory (cpy): " + ObjectDescriptionKFS( origdirs(0) )
		      End If
		      
		      // Make sure the directories are the same type:
		      
		      If orig Is Nil Then
		        AssertIsNil cpy, "Mismatched directories.  Orig is a Dictionary, cpy is a PropertyListKFS."
		      Else
		        AssertNotIsNil cpy, "Mismatched directories.  Orig is a PropertyListKFS, cpy is a Dictionary."
		      End If
		      
		      // Make sure the directories contain the same keys and values:
		      
		      AssertEquals origcore.Count, cpycore.Count, "Found a directory where the clone did not have the same number of keys as the original."
		      
		      For Each key As Variant In origcore.Keys
		        
		        AssertTrue cpycore.HasKey( key ), "Found a directory where the clone is missing a key (" + ObjectDescriptionKFS( key ) + ")"
		        
		        Dim lv As Variant = origcore.Value( key )
		        Dim rv As Variant = cpycore.Value( key )
		        
		        If lv IsA PropertyListKFS Or lv IsA Dictionary Then
		          origdirs.Append lv
		          cpydirs.Append rv
		        Else
		          AssertEquals lv, rv, "Encountered a terminal node where the original and copy seem to not have equivalent values."
		        End If
		        
		      Next
		      
		      // This pair of directories seem to have passed the test.  Move on.
		      
		      origdirs.Remove 0
		      cpydirs.Remove 0
		      
		    Wend
		    
		  End If
		  
		  // done.
		  
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
