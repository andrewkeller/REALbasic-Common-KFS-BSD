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
		  f.Value( "puppy" ) = New PropertyListKFS( "turkey":"gobble" )
		  
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
		  Dim rootcore, expchildcore, d As Dictionary
		  
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
		  d = PropertyListKFS( rootcore.Value( "foo" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertTrue d.HasKey( "bar" ), "The Child setter did not add the second level of the path."
		  AssertTrue d.Value( "bar" ) IsA PropertyListKFS, "The Child setter did not add the second level of the path correctly."
		  d = PropertyListKFS( d.Value( "bar" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertTrue d.HasKey( "fishcat" ), "The Child setter did not add the key for the new child."
		  AssertSame expchild, d.Value( "fishcat" ), "The Child setter did not assign the new child at the correct path."
		  d = PropertyListKFS( d.Value( "fishcat" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertSame expchildcore, d, "The child core does not appear to be the expected object."
		  
		  
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
		  
		  AssertEquals -1, UBound( root.Children( "v1" ) )
		  AssertEquals -1, UBound( root.Children( "v2" ) )
		  AssertEquals -1, UBound( root.Children( "v3" ) )
		  AssertEquals -1, UBound( root.Children( "v4" ) )
		  AssertEquals -1, UBound( root.Children( "c1", "foo" ) )
		  AssertEquals -1, UBound( root.Children( "c1", "fish" ) )
		  AssertEquals -1, UBound( root.Children( "c2", "dog" ) )
		  AssertEquals -1, UBound( root.Children( "c2", "shark" ) )
		  AssertEquals -1, UBound( root.Children( "c2", "number" ) )
		  AssertEquals -1, UBound( root.Children( "c2", "puppy", "turkey" ) )
		  AssertEquals -1, UBound( root.Children( "c3", "test" ) )
		  
		  PopMessageStack
		  
		  
		  // Make sure the Children function works with nodes that don't exist.
		  
		  AssertNotIsNil root.Children( "doggie" ), "Children is never supposed to return a Nil result (path did not exist)."
		  
		  PushMessageStack "The Children function is supposed to return an empty array for paths that do not exist."
		  
		  AssertEquals -1, UBound( root.Children( "doggie" ) )
		  AssertEquals -1, UBound( root.Children( "doggie", "fishcat" ) )
		  AssertEquals -1, UBound( root.Children( "c1", "doggie" ) )
		  AssertEquals -1, UBound( root.Children( "c1", "doggie", "fishcat" ) )
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClone()
		  // Created 11/27/2010 by Andrew Keller
		  
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
		Sub TestDeserialize_ApplePList_ApplePList()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure an Apple PropertyListKFS can be parsed correctly.
		  
		  Dim p As New PropertyListKFS( kSampleApplePList1 )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_ApplePList_Automatic()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_Undefined_ApplePList()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_Undefined_Automatic()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_ApplePList()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify Apple Property Lists.
		  
		  PushMessageStack "Did not recognize some data formatted as an Apple Property List."
		  
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList1 ), "(sample 1)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList2 ), "(sample 2)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList3 ), "(sample 3)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList4 ), "(sample 4)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList5 ), "(sample 5)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_Undefined()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify undefined plist formats.
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( Nil ), "Did not return Undefined for a Nil string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "" ), "Did not return Undefined for an empty string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( " " ), "Did not return Undefined for a single space."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "          " ), "Did not return Undefined for 10 spaces."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "  blah  foobar  " ), "Did not return Undefined for arbitrary text."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasChild()
		  // Created 11/27/2010 by Andrew Keller
		  
		  // Makes sure the HasChild function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  
		  // Make sure HasChild works for the existing nodes.
		  
		  PushMessageStack "HasChild failed for "
		  
		  AssertFalse root.HasChild( "v1" ), "v1."
		  AssertFalse root.HasChild( "v2" ), "v2."
		  AssertFalse root.HasChild( "v3" ), "v3."
		  AssertFalse root.HasChild( "v4" ), "v4."
		  AssertTrue root.HasChild( "c1" ), "c1."
		  AssertTrue root.HasChild( "c2" ), "c2."
		  AssertTrue root.HasChild( "c3" ), "c3."
		  AssertFalse root.HasChild( "c1", "foo" ), "c1/foo."
		  AssertFalse root.HasChild( "c1", "fish" ), "c1/fish."
		  AssertFalse root.HasChild( "c2", "dog" ), "c2/dog."
		  AssertFalse root.HasChild( "c2", "shark" ), "c2/shark."
		  AssertFalse root.HasChild( "c2", "number" ), "c2/number."
		  AssertTrue root.HasChild( "c2", "puppy" ), "c2/puppy."
		  AssertFalse root.HasChild( "c3", "test" ), "c3/test."
		  AssertFalse root.HasChild( "c2", "puppy", "turkey" ), "c2/puppy/turkey."
		  
		  // Make sure HasChild works for nodes that do not exist.
		  
		  AssertFalse root.HasChild( "foo" ), "foo."
		  AssertFalse root.HasChild( "v2bar" ), "v2bar."
		  AssertFalse root.HasChild( "c1", "boofar" ), "c1/boofar."
		  AssertFalse root.HasChild( "c1", "fishcat" ), "c1/fishcat."
		  AssertFalse root.HasChild( "c3", "test", "foo" ), "c3/test/foo."
		  AssertFalse root.HasChild( "c2", "puppy", "turkey", "donkey" ), "c2/puppy/turkey/donkey."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasKey()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the HasKey function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  
		  // Make sure HasKey works for the existing nodes.
		  
		  PushMessageStack "HasKey failed for "
		  
		  AssertTrue root.HasKey( "v1" ), "v1."
		  AssertTrue root.HasKey( "v2" ), "v2."
		  AssertTrue root.HasKey( "v3" ), "v3."
		  AssertTrue root.HasKey( "v4" ), "v4."
		  AssertTrue root.HasKey( "c1" ), "c1."
		  AssertTrue root.HasKey( "c2" ), "c2."
		  AssertTrue root.HasKey( "c3" ), "c3."
		  AssertTrue root.HasKey( "c1", "foo" ), "c1/foo."
		  AssertTrue root.HasKey( "c1", "fish" ), "c1/fish."
		  AssertTrue root.HasKey( "c2", "dog" ), "c2/dog."
		  AssertTrue root.HasKey( "c2", "shark" ), "c2/shark."
		  AssertTrue root.HasKey( "c2", "number" ), "c2/number."
		  AssertTrue root.HasKey( "c2", "puppy" ), "c2/puppy."
		  AssertTrue root.HasKey( "c3", "test" ), "c3/test."
		  AssertTrue root.HasKey( "c2", "puppy", "turkey" ), "c2/puppy/turkey."
		  
		  // Make sure HasKey works for nodes that do not exist.
		  
		  AssertFalse root.HasKey( "foo" ), "foo."
		  AssertFalse root.HasKey( "v2bar" ), "v2bar."
		  AssertFalse root.HasKey( "c1", "boofar" ), "c1/boofar."
		  AssertFalse root.HasKey( "c1", "fishcat" ), "c1/fishcat."
		  AssertFalse root.HasKey( "c3", "test", "foo" ), "c3/test/foo."
		  AssertFalse root.HasKey( "c2", "puppy", "turkey", "donkey" ), "c2/puppy/turkey/donkey."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasTerminal()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the HasTerminal function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  
		  // Make sure HasTerminal works for the existing nodes.
		  
		  PushMessageStack "HasTerminal failed for "
		  
		  AssertTrue root.HasTerminal( "v1" ), "v1."
		  AssertTrue root.HasTerminal( "v2" ), "v2."
		  AssertTrue root.HasTerminal( "v3" ), "v3."
		  AssertTrue root.HasTerminal( "v4" ), "v4."
		  AssertFalse root.HasTerminal( "c1" ), "c1."
		  AssertFalse root.HasTerminal( "c2" ), "c2."
		  AssertFalse root.HasTerminal( "c3" ), "c3."
		  AssertTrue root.HasTerminal( "c1", "foo" ), "c1/foo."
		  AssertTrue root.HasTerminal( "c1", "fish" ), "c1/fish."
		  AssertTrue root.HasTerminal( "c2", "dog" ), "c2/dog."
		  AssertTrue root.HasTerminal( "c2", "shark" ), "c2/shark."
		  AssertTrue root.HasTerminal( "c2", "number" ), "c2/number."
		  AssertFalse root.HasTerminal( "c2", "puppy" ), "c2/puppy."
		  AssertTrue root.HasTerminal( "c3", "test" ), "c3/test."
		  AssertTrue root.HasTerminal( "c2", "puppy", "turkey" ), "c2/puppy/turkey."
		  
		  // Make sure HasTerminal works for nodes that do not exist.
		  
		  AssertFalse root.HasTerminal( "foo" ), "foo."
		  AssertFalse root.HasTerminal( "v2bar" ), "v2bar."
		  AssertFalse root.HasTerminal( "c1", "boofar" ), "c1/boofar."
		  AssertFalse root.HasTerminal( "c1", "fishcat" ), "c1/fishcat."
		  AssertFalse root.HasTerminal( "c3", "test", "foo" ), "c3/test/foo."
		  AssertFalse root.HasTerminal( "c2", "puppy", "turkey", "donkey" ), "c2/puppy/turkey/donkey."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestImport()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Import function works.
		  
		  Dim p, q As PropertyListKFS
		  Dim pc, qc As Dictionary
		  
		  // Check the Nil case.
		  
		  PushMessageStack "Checking the Nil case."
		  
		  pc = New Dictionary( "foo":"bar" )
		  p = pc
		  
		  p.Import q
		  
		  AssertTrue pc.HasKey( "foo" ), "The existing entry appears to have been deleted."
		  AssertEquals "bar", pc.Value( "foo" ), "The existing entry appears to have been modified."
		  AssertEquals 1, pc.Count
		  AssertFalse p.TreatAsArray, "Import is not supposed to modify the TreatAsArray property of the local root node."
		  
		  PopMessageStack
		  
		  
		  // Check the empty case.
		  
		  PushMessageStack "Checking empty case."
		  
		  qc = New Dictionary
		  q = qc
		  
		  p.Import q
		  
		  AssertTrue pc.HasKey( "foo" ), "The existing entry appears to have been deleted."
		  AssertEquals "bar", pc.Value( "foo" ), "The existing entry appears to have been modified."
		  AssertEquals 1, pc.Count
		  AssertFalse p.TreatAsArray, "Import is not supposed to modify the TreatAsArray property of the local root node."
		  
		  PopMessageStack
		  
		  
		  // Check the simple include case.
		  
		  PushMessageStack "Checking the simple include case."
		  
		  qc.Value( "fish" ) = "cat"
		  
		  p.Import q
		  
		  AssertTrue pc.HasKey( "foo" ), "The existing entry appears to have been deleted."
		  AssertEquals "bar", pc.Value( "foo" ), "The existing entry appears to have been modified."
		  AssertTrue pc.HasKey( "fish" ), "The new key was not imported."
		  AssertEquals "cat", pc.Value( "fish" ), "The new key was not imported correctly."
		  AssertEquals 2, pc.Count
		  AssertFalse p.TreatAsArray, "Import is not supposed to modify the TreatAsArray property of the local root node."
		  
		  PopMessageStack
		  
		  
		  // Check the simple overwrite case.
		  
		  PushMessageStack "Checking the simple overwrite case."
		  
		  qc.Value( "fish" ) = "dog"
		  
		  p.Import q
		  
		  AssertTrue pc.HasKey( "foo" ), "The existing entry appears to have been deleted."
		  AssertEquals "bar", pc.Value( "foo" ), "The existing entry appears to have been modified."
		  AssertTrue pc.HasKey( "fish" ), "The new key was not imported."
		  AssertEquals "dog", pc.Value( "fish" ), "The new key was not imported correctly."
		  AssertEquals 2, pc.Count
		  AssertFalse p.TreatAsArray, "Import is not supposed to modify the TreatAsArray property of the local root node."
		  
		  PopMessageStack
		  
		  
		  // Check the complex case.
		  
		  PushMessageStack "In the complex import case:"
		  
		  q = GenerateTree1
		  qc = q
		  
		  AssertNotIsNil qc, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  p.Import q
		  
		  AssertEquals 9, pc.Count, "The result does not have the correct number of keys."
		  
		  AssertTrue pc.HasKey( "foo" ), "An existing key got deleted in the result."
		  AssertEquals "bar", pc.Value( "foo" ), "An existing key got modified in the result."
		  
		  AssertTrue pc.HasKey( "fish" ), "An existing key got deleted in the result."
		  AssertEquals "dog", pc.Value( "fish" ), "An existing key got modified in the result."
		  
		  AssertTrue pc.HasKey( "v1" ), "v1 was not imported."
		  AssertEquals 12, pc.Value( "v1" ), "A new key was not imported correctly."
		  
		  AssertTrue pc.HasKey( "v2" ), "v2 was not imported."
		  AssertEquals 23, pc.Value( "v2" ), "A new key was not imported correctly."
		  
		  AssertTrue pc.HasKey( "v3" ), "v3 was not imported."
		  AssertEquals 35, pc.Value( "v3" ), "A new key was not imported correctly."
		  
		  AssertTrue pc.HasKey( "v4" ), "v4 was not imported."
		  AssertEquals Nil, pc.Value( "v4" ), "A new key was not imported correctly."
		  
		  AssertTrue pc.HasKey( "c1" ), "c1 was not imported."
		  AssertTrue pc.Value( "c1" ) IsA PropertyListKFS, "c1 is not a PropertyListKFS object."
		  q = pc.Value( "c1" )
		  qc = q
		  AssertNotIsNil qc, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 2, qc.Count, "The c1 child does not have all the keys."
		  AssertTrue qc.HasKey( "foo" ), "c1/foo was not imported."
		  AssertEquals "bar", qc.Value( "foo" ), "c1/foo was not imported correctly."
		  AssertTrue qc.HasKey( "fish" ), "c1/foo was not imported."
		  AssertEquals "cat", qc.Value( "fish" ), "c1/foo was not imported correctly."
		  AssertFalse q.TreatAsArray, "c1 did not inherit the source's value of the TreatAsArray property."
		  
		  AssertTrue pc.HasKey( "c2" ), "c2 was not imported."
		  AssertTrue pc.Value( "c2" ) IsA Dictionary, "c2 is not a Dictionary object."
		  qc = pc.Value( "c2" )
		  AssertEquals 4, qc.Count, "The c2 child does not have all the keys."
		  AssertTrue qc.HasKey( "dog" ), "c2/dog was not imported."
		  AssertEquals "squirrel", qc.Value( "dog" ), "c2/dog was not imported correctly."
		  AssertTrue qc.HasKey( "shark" ), "c2/shark was not imported."
		  AssertEquals "monkey", qc.Value( "shark" ), "c2/shark was not imported correctly."
		  AssertTrue qc.HasKey( "number" ), "c2/number was not imported."
		  AssertEquals "letter", qc.Value( "number" ), "c2/number was not imported correctly."
		  
		  AssertTrue qc.HasKey( "puppy" ), "c2/puppy was not imported."
		  AssertTrue qc.Value( "puppy" ) IsA PropertyListKFS, "c2/puppy is not a PropertyListKFS object."
		  q = qc.Value( "puppy" )
		  qc = q
		  AssertNotIsNil qc, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, qc.Count, "The c2/puppy child does not have all the keys."
		  AssertTrue qc.HasKey( "turkey" ), "c2/puppy/turkey was not imported."
		  AssertEquals "gobble", qc.Value( "turkey" ), "c2/puppy/turkey was not imported correctly."
		  AssertFalse q.TreatAsArray, "c2/puppy did not inherit the source's value of the TreatAsArray property."
		  
		  AssertTrue pc.HasKey( "c3" ), "c3 was not imported."
		  AssertTrue pc.Value( "c3" ) IsA PropertyListKFS, "c3 was not a PropertyListKFS object."
		  q = pc.Value( "c3" )
		  qc = q
		  AssertNotIsNil qc, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, qc.Count, "The c3 child does not have all the keys."
		  AssertTrue qc.HasKey( "test" ), "c3/test was not imported."
		  AssertEquals "case", qc.Value( "test" ), "c3/test was not imported correctly."
		  AssertTrue q.TreatAsArray, "c3 did not inherit the source's value of the TreatAsArray property."
		  
		  AssertFalse p.TreatAsArray, "Import is not supposed to modify the TreatAsArray property of the local root node."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestImportLoops()
		  // Created 12/1/2010 by Andrew Keller
		  
		  // Makes sure the Import function works.
		  
		  // Check the complex loop case.
		  
		  PushMessageStack "In the complex loop case:"
		  
		  // Build a simple tree with loops:
		  
		  ' v1 --> foo
		  ' v2 --> bar
		  ' c1 [plist] {
		  '      v1 --> fish
		  '      v2 --> cat
		  '      c1 [plist] --> c2 [core]
		  '      c2 [core] --> c2/c1 [plist]
		  ' }
		  ' c2 [core] {
		  '      v1 --> bird
		  '      v2 --> dog
		  '      c1 [plist] {
		  '           c1 [plist] --> root [core]
		  '      }
		  '      c2 [plist] --> c1 [plist]
		  ' }
		  
		  Dim org As New PropertyListKFS
		  Dim org_c1 As New PropertyListKFS
		  Dim org_c1_c1 As New PropertyListKFS
		  Dim org_c1_c2 As New Dictionary
		  Dim org_c2 As New Dictionary
		  Dim org_c2_c1 As New PropertyListKFS
		  Dim org_c2_c1_c1 As New PropertyListKFS
		  Dim org_c2_c2 As New PropertyListKFS
		  
		  Dim corg As Dictionary = org
		  Dim corg_c1 As Dictionary = org_c1
		  Dim corg_c1_c1 As Dictionary = org_c1_c1
		  Dim corg_c1_c2 As Dictionary = org_c1_c2
		  Dim corg_c2 As Dictionary = org_c2
		  Dim corg_c2_c1 As Dictionary = org_c2_c1
		  Dim corg_c2_c1_c1 As Dictionary = org_c2_c1_c1
		  Dim corg_c2_c2 As Dictionary = org_c2_c2
		  
		  org_c1_c1 = PropertyListKFS.NewPListWithDataCore( corg_c2 )
		  corg_c1_c1 = org_c1_c1
		  
		  org_c2_c1_c1 = PropertyListKFS.NewPListWithDataCore( corg )
		  corg_c2_c1_c1 = org_c2_c1_c1
		  
		  corg.Value( "v1" ) = "foo"
		  corg.Value( "v2" ) = "bar"
		  corg.Value( "c1" ) = org_c1
		  corg.Value( "c2" ) = org_c2
		  corg_c1.Value( "v1" ) = "fish"
		  corg_c1.Value( "v2" ) = "cat"
		  corg_c1.Value( "c1" ) = org_c1_c1
		  corg_c1.Value( "c2" ) = corg_c2_c1
		  corg_c2.Value( "v1" ) = "bird"
		  corg_c2.Value( "v2" ) = "dog"
		  corg_c2.Value( "c1" ) = org_c2_c1
		  corg_c2.Value( "c2" ) = org_c1
		  corg_c2_c1.Value( "c1" ) = org_c2_c1_c1
		  
		  // Perform the import.
		  
		  Dim cpy As New PropertyListKFS
		  Dim ccpy As Dictionary = cpy
		  
		  cpy.Import org
		  
		  AssertTrue ccpy.HasKey( "v1" ), "v1 was not imported."
		  AssertEquals "foo", ccpy.Value( "v1" ), "v1 was not imported correctly."
		  
		  AssertTrue ccpy.HasKey( "v2" ), "v2 was not imported."
		  AssertEquals "bar", ccpy.Value( "v2" ), "v2 was not imported correctly."
		  
		  AssertTrue ccpy.HasKey( "c1" ), "c1 was not imported."
		  AssertTrue ccpy.Value( "c1" ) IsA PropertyListKFS, "c1 is supposed to be a PropertyListKFS object."
		  Dim cpy_c1 As PropertyListKFS = ccpy.Value( "c1" )
		  Dim ccpy_c1 As Dictionary = cpy_c1
		  
		  AssertTrue ccpy.HasKey( "c2" ), "c2 was not imported."
		  AssertTrue ccpy.Value( "c2" ) IsA Dictionary, "c2 is supposed to be a Dictionary object."
		  Dim cpy_c2 As Dictionary = ccpy.Value( "c2" )
		  Dim ccpy_c2 As Dictionary = cpy_c2
		  
		  AssertTrue ccpy_c1.HasKey( "v1" ), "c1/v1 was not imported."
		  AssertEquals "fish", ccpy_c1.Value( "v1" ), "c1/v1 was not imported correctly."
		  
		  AssertTrue ccpy_c1.HasKey( "v2" ), "c1/v2 was not imported."
		  AssertEquals "cat", ccpy_c1.Value( "v2" ), "c1/v2 was not imported correctly."
		  
		  AssertTrue ccpy_c1.HasKey( "c1" ), "c1/c1 was not imported."
		  AssertTrue ccpy_c1.Value( "c1" ) IsA PropertyListKFS, "c1/c1 is supposed to be a PropertyListKFS object."
		  Dim cpy_c1_c1 As PropertyListKFS = ccpy_c1.Value( "c1" )
		  Dim ccpy_c1_c1 As Dictionary = cpy_c1_c1
		  
		  AssertTrue ccpy_c1.HasKey( "c2" ), "c1/c2 was not imported."
		  AssertTrue ccpy_c1.Value( "c2" ) IsA Dictionary, "c1/c2 is supposed to be a Dictionary object."
		  Dim cpy_c1_c2 As Dictionary = ccpy_c1.Value( "c2" )
		  Dim ccpy_c1_c2 As Dictionary = cpy_c1_c2
		  
		  AssertTrue ccpy_c2.HasKey( "v1" ), "c2/v1 was not imported."
		  AssertEquals "bird", ccpy_c2.Value( "v1" ), "c2/v1 was not imported correctly."
		  
		  AssertTrue ccpy_c2.HasKey( "v2" ), "c2/v2 was not imported."
		  AssertEquals "dog", ccpy_c2.Value( "v2" ), "c2/v2 was not imported correctly."
		  
		  AssertTrue ccpy_c2.HasKey( "c1" ), "c2/c1 was not imported."
		  AssertTrue ccpy_c2.Value( "c1" ) IsA PropertyListKFS, "c2/c1 is supposed to be a PropertyListKFS object."
		  Dim cpy_c2_c1 As PropertyListKFS = ccpy_c2.Value( "c1" )
		  Dim ccpy_c2_c1 As Dictionary = cpy_c2_c1
		  
		  AssertTrue ccpy_c2.HasKey( "c2" ), "c2/c2 was not imported."
		  AssertTrue ccpy_c2.Value( "c2" ) IsA PropertyListKFS, "c2/c2 is supposed to be a PropertyListKFS object."
		  Dim cpy_c2_c2 As PropertyListKFS = cpy_c2.Value( "c2" )
		  Dim ccpy_c2_c2 As Dictionary = cpy_c2_c2
		  
		  AssertTrue ccpy_c2_c1.HasKey( "c1" ), "c2/c1/c1 was not imported."
		  AssertTrue ccpy_c2_c1.Value( "c1" ) IsA PropertyListKFS, "c2/c1/c1 is supposed to be a PropertyListKFS object."
		  Dim cpy_c2_c1_c1 As PropertyListKFS = ccpy_c2_c1.Value( "c1" )
		  Dim ccpy_c2_c1_c1 As Dictionary = cpy_c2_c1_c1
		  
		  PushMessageStack "None of the cloned directories should be the same object as the original."
		  
		  AssertNotSame org, cpy
		  AssertNotSame org_c1, cpy_c1
		  AssertNotSame org_c1_c1, cpy_c1_c1
		  AssertNotSame org_c1_c2, cpy_c1_c2
		  AssertNotSame org_c2, cpy_c2
		  AssertNotSame org_c2_c1, cpy_c2_c1
		  AssertNotSame org_c2_c2, cpy_c2_c2
		  
		  AssertNotSame corg, ccpy
		  AssertNotSame corg_c1, ccpy_c1
		  AssertNotSame corg_c1_c1, ccpy_c1_c1
		  AssertNotSame corg_c1_c2, ccpy_c1_c2
		  AssertNotSame corg_c2, ccpy_c2
		  AssertNotSame corg_c2_c1, ccpy_c2_c1
		  AssertNotSame corg_c2_c2, ccpy_c2_c2
		  
		  PopMessageStack
		  
		  // Now for making sure the homomorphism holds...
		  
		  PushMessageStack "homomorphism check failed."
		  
		  AssertNotSame cpy_c1_c1, cpy_c2
		  AssertSame ccpy_c1_c1, ccpy_c2
		  
		  AssertNotSame cpy_c1_c2, cpy_c2_c1
		  AssertSame ccpy_c1_c2, ccpy_c2_c1
		  
		  AssertSame cpy_c2_c2, cpy_c1
		  AssertSame ccpy_c2_c2, ccpy_c1
		  
		  AssertNotSame cpy_c2_c1_c1, cpy
		  AssertSame ccpy_c2_c1_c1, ccpy
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestImportSimpleLoops()
		  // Created 12/1/2010 by Andrew Keller
		  
		  // Makes sure the Import function works.
		  
		  // Check the simple loop case.
		  
		  PushMessageStack "In the simple loop case:"
		  
		  Dim p, q As PropertyListKFS
		  Dim pc, qc, p1, p2, d1, d2 As Dictionary
		  
		  qc = New Dictionary
		  q = qc
		  d1 = New Dictionary
		  d2 = New Dictionary
		  
		  qc.Value( "a" ) = d1
		  d1.Value( "b" ) = d2
		  d2.Value( "c" ) = d1
		  
		  pc = New Dictionary
		  p = pc
		  
		  p.Import q
		  
		  AssertTrue pc.HasKey( "a" ), "Import did not create the 'a' key."
		  AssertTrue pc.Value( "a" ) IsA Dictionary, "Import did not create the 'a' key as a Dictionary."
		  p1 = pc.Value( "a" )
		  
		  AssertTrue p1.HasKey( "b" ), "Import did not create the 'b' key."
		  AssertTrue p1.Value( "b" ) IsA Dictionary, "Import did not create the 'b' key as a Dictionary."
		  p2 = p1.Value( "b" )
		  
		  AssertNotSame d1, p1, "Import did not create a new Dictionary object for the 'a' key."
		  AssertNotSame d2, p2, "Import did not create a new Dictionary object for the 'b' key."
		  
		  AssertTrue p2.HasKey( "c" ), "Import did not create the 'c' key."
		  AssertSame p1, p2.Value( "c" ), "Import did not set the 'c' key to be the same Dictionary object as the 'a' key."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestKey()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Key function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  
		  // Make sure Key works for real results.
		  
		  PushMessageStack "Key failed for "
		  
		  AssertEquals "v1", root.Key( 0 ), "#0."
		  AssertEquals "v2", root.Key( 1 ), "#1."
		  AssertEquals "v3", root.Key( 2 ), "#2."
		  AssertEquals "v4", root.Key( 3 ), "#3."
		  AssertEquals "c1", root.Key( 4 ), "#4."
		  AssertEquals "c2", root.Key( 5 ), "#5."
		  AssertEquals "c3", root.Key( 6 ), "#6."
		  AssertEquals "foo", root.Key( "c1", 0 ), "c1/#0."
		  AssertEquals "fish", root.Key( "c1", 1 ), "c1/#1."
		  AssertEquals "dog", root.Key( "c2", 0 ), "c2/#0."
		  AssertEquals "shark", root.Key( "c2", 1 ), "c2/#1."
		  AssertEquals "number", root.Key( "c2", 2 ), "c2/#2."
		  AssertEquals "puppy", root.Key( "c2", 3 ), "c2/#3."
		  AssertEquals "test", root.Key( "c3", 0 ), "c3/#0."
		  AssertEquals "turkey", root.Key( "c2", "puppy", 0 ), "c2/puppy/#0."
		  
		  PopMessageStack
		  
		  
		  // Make sure Key fails correctly for out of bounds indices.
		  
		  PushMessageStack "Key is supposed to raise an OutOfBoundsException for "
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "#-1 (returned " + ObjectDescriptionKFS( root.Key( -1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "#7 (returned " + ObjectDescriptionKFS( root.Key( 7 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c1/#-1 (returned " + ObjectDescriptionKFS( root.Key( "c1", -1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c1/#2 (returned " + ObjectDescriptionKFS( root.Key( "c1", 2 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c2/#-1 (returned " + ObjectDescriptionKFS( root.Key( "c2", -1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c2/#4 (returned " + ObjectDescriptionKFS( root.Key( "c2", 4 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c3/#-1 (returned " + ObjectDescriptionKFS( root.Key( "c3", -1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c3/#1 (returned " + ObjectDescriptionKFS( root.Key( "c3", 1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c2/puppy/#-1 (returned " + ObjectDescriptionKFS( root.Key( "c2", "puppy", -1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "c2/puppy/#1 (returned " + ObjectDescriptionKFS( root.Key( "c2", "puppy", 1 ) ) + " instead)."
		  Catch err As OutOfBoundsException
		  End Try
		  
		  PopMessageStack
		  
		  
		  // Make sure Key fails correctly for directories that do not exist.
		  
		  
		  PushMessageStack "Key is supposed to raise a KeyNotFoundException when accessing a directory that does not exist."
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "( foobar/#0 returned " + ObjectDescriptionKFS( root.Key( "foobar", 0 ) ) + " instead)"
		  Catch err As KeyNotFoundException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "( v1/#0 returned " + ObjectDescriptionKFS( root.Key( "v1", 0 ) ) + " instead)"
		  Catch err As KeyNotFoundException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "( c1/birddog/#1 returned " + ObjectDescriptionKFS( root.Key( "c1", "birddog", 1 ) ) + " instead)"
		  Catch err As KeyNotFoundException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "( foobar/#0 returned " + ObjectDescriptionKFS( root.Key( "foobar", 0 ) ) + " instead)"
		  Catch err As KeyNotFoundException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "( c2/puppy/foobar/#2 returned " + ObjectDescriptionKFS( root.Key( "c2", "puppy", "foobar", 2 ) ) + " instead)"
		  Catch err As KeyNotFoundException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "( c2/puppy/turkey/#0 returned " + ObjectDescriptionKFS( root.Key( "c2", "puppy", "turkey", 0 ) ) + " instead)"
		  Catch err As KeyNotFoundException
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestKeys()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Keys function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  Dim v() As Variant
		  
		  // Make sure the Keys function works for children.
		  
		  PushMessageStack "At the root level:"
		  v = root.Keys
		  AssertNotIsNil v, "Keys is never supposed to return a Nil result."
		  AssertEquals 6, UBound( v ), "Keys did not return the correct number of items."
		  AssertEquals "v1", v(0), "Index 0 is wrong."
		  AssertEquals "v2", v(1), "Index 1 is wrong."
		  AssertEquals "v3", v(2), "Index 2 is wrong."
		  AssertEquals "v4", v(3), "Index 3 is wrong."
		  AssertEquals "c1", v(4), "Index 4 is wrong."
		  AssertEquals "c2", v(5), "Index 5 is wrong."
		  AssertEquals "c3", v(6), "Index 6 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c1 level:"
		  v = root.Keys( "c1" )
		  AssertNotIsNil v, "Keys is never supposed to return a Nil result."
		  AssertEquals 1, UBound( v ), "Keys did not return the correct number of items."
		  AssertEquals "foo", v(0), "Index 0 is wrong."
		  AssertEquals "fish", v(1), "Index 1 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c2 level:"
		  v = root.Keys( "c2" )
		  AssertNotIsNil v, "Keys is never supposed to return a Nil result."
		  AssertEquals 3, UBound( v ), "Keys did not return the correct number of items."
		  AssertEquals "dog", v(0), "Index 0 is wrong."
		  AssertEquals "shark", v(1), "Index 1 is wrong."
		  AssertEquals "number", v(2), "Index 2 is wrong."
		  AssertEquals "puppy", v(3), "Index 3 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c2/puppy level:"
		  v = root.Keys( "c2", "puppy" )
		  AssertNotIsNil v, "Keys is never supposed to return a Nil result."
		  AssertEquals 0, UBound( v )
		  AssertEquals "turkey", v(0), "Index 0 is wrong."
		  PopMessageStack
		  
		  PushMessageStack "At the c3 level:"
		  v = root.Keys( "c3" )
		  AssertNotIsNil v, "Keys is never supposed to return a Nil result."
		  AssertEquals 0, UBound( v )
		  AssertEquals "test", v(0), "Index 0 is wrong."
		  PopMessageStack
		  
		  
		  // Make sure the Keys function works with terminals.
		  
		  AssertNotIsNil root.Keys( "v1" ), "Keys is never supposed to return a Nil result (path was a terminal)."
		  
		  PushMessageStack "The Keys function is supposed to return an empty array for terminals."
		  
		  AssertEquals -1, UBound( root.Keys( "v1" ) )
		  AssertEquals -1, UBound( root.Keys( "v2" ) )
		  AssertEquals -1, UBound( root.Keys( "v3" ) )
		  AssertEquals -1, UBound( root.Keys( "v4" ) )
		  AssertEquals -1, UBound( root.Keys( "c1", "foo" ) )
		  AssertEquals -1, UBound( root.Keys( "c1", "fish" ) )
		  AssertEquals -1, UBound( root.Keys( "c2", "dog" ) )
		  AssertEquals -1, UBound( root.Keys( "c2", "shark" ) )
		  AssertEquals -1, UBound( root.Keys( "c2", "number" ) )
		  AssertEquals -1, UBound( root.Keys( "c2", "puppy", "turkey" ) )
		  AssertEquals -1, UBound( root.Keys( "c3", "test" ) )
		  
		  PopMessageStack
		  
		  
		  // Make sure the Keys function works with nodes that don't exist.
		  
		  AssertNotIsNil root.Keys( "doggie" ), "Keys is never supposed to return a Nil result (path did not exist)."
		  
		  PushMessageStack "The Keys function is supposed to return an empty array for paths that do not exist."
		  
		  AssertEquals -1, UBound( root.Keys( "doggie" ) )
		  AssertEquals -1, UBound( root.Keys( "doggie", "fishcat" ) )
		  AssertEquals -1, UBound( root.Keys( "c1", "doggie" ) )
		  AssertEquals -1, UBound( root.Keys( "c1", "doggie", "fishcat" ) )
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLookup()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Lookup function works.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim dv As String = "Hello, World!"
		  
		  // Make sure Lookup works for children.
		  
		  PushMessageStack "Lookup failed for "
		  
		  AssertEquals dv, root.Lookup( dv, "c1" ), "c1."
		  AssertEquals dv, root.Lookup( dv, "c2" ), "c2."
		  AssertEquals dv, root.Lookup( dv, "c3" ), "c3."
		  AssertEquals dv, root.Lookup( dv, "c2", "puppy" ), "c2/puppy."
		  
		  // Make sure Lookup works for terminals.
		  
		  AssertEquals 12, root.Lookup( dv, "v1" ), "v1."
		  AssertEquals 23, root.Lookup( dv, "v2" ), "v2."
		  AssertEquals 35, root.Lookup( dv, "v3" ), "v3."
		  AssertEquals Nil, root.Lookup( dv, "v4" ), "v4."
		  AssertEquals "bar", root.Lookup( dv, "c1", "foo" ), "c1/foo."
		  AssertEquals "cat", root.Lookup( dv, "c1", "fish" ), "c1/fish."
		  AssertEquals "squirrel", root.Lookup( dv, "c2", "dog" ), "c2/dog."
		  AssertEquals "monkey", root.Lookup( dv, "c2", "shark" ), "c2/shark."
		  AssertEquals "letter", root.Lookup( dv, "c2", "number" ), "c2/number."
		  AssertEquals "case", root.Lookup( dv, "c3", "test" ), "c3/test."
		  AssertEquals "gobble", root.Lookup( dv, "c2", "puppy", "turkey" ), "c2/puppy/turkey."
		  
		  // Make sure Lookup works for nodes that do not exist.
		  
		  AssertEquals dv, root.Lookup( dv, "foo" ), "foo."
		  AssertEquals dv, root.Lookup( dv, "v1", "foo" ), "v1/foo."
		  AssertEquals dv, root.Lookup( dv, "c1", "cat" ), "c1/cat."
		  AssertEquals dv, root.Lookup( dv, "c2", "puppy", "fish", "cat" ), "c2/puppy/fish/cat."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Operator_Compare method works.
		  
		  Dim one, two As PropertyListKFS
		  Dim onecore, twocore, d As Dictionary
		  
		  onecore = New Dictionary
		  twocore = New Dictionary
		  one = onecore
		  two = twocore
		  
		  // Test for various types of equality.
		  
		  PushMessageStack "A test of basic equivalence failed."
		  
		  AssertTrue one = two, "(1)"
		  
		  onecore.Value( "foo" ) = "bar"
		  twocore.Value( "foo" ) = "bar"
		  
		  AssertTrue one = two, "(2)"
		  
		  onecore.Value( "fish" ) = "cat"
		  twocore.Value( "FISH" ) = "CAT" // Dictionaries are case-insensitive.  It is simplest if this behavior is maintained.
		  
		  AssertTrue one = two, "(3)"
		  
		  onecore.Value( "ddir" ) = New Dictionary( "hello":"world" )
		  twocore.Value( "ddir" ) = New Dictionary( "hello":"world" )
		  
		  AssertTrue one = two, "(4)"
		  
		  Dictionary( onecore.Value( "ddir" ) ).Value( "foobar" ) = New Dictionary( "foo":"bar", "fish":"cat" )
		  Dictionary( twocore.Value( "ddir" ) ).Value( "foobar" ) = New Dictionary( "foo":"bar", "fish":"cat" )
		  
		  AssertTrue one = two, "(5)"
		  
		  onecore.Value( "pdir" ) = New PropertyListKFS
		  twocore.Value( "pdir" ) = New PropertyListKFS
		  
		  AssertTrue one = two, "(6)"
		  
		  d = PropertyListKFS( onecore.Value( "pdir" ) )
		  d.Value( "another" ) = "key"
		  d = PropertyListKFS( twocore.Value( "pdir" ) )
		  d.Value( "another" ) = "key"
		  
		  AssertTrue one = two, "(7)"
		  
		  PopMessageStack
		  
		  
		  // Make sure the comparison does not depend on the TreatAsArray property.
		  
		  PropertyListKFS( onecore.Value( "pdir" ) ).TreatAsArray = True
		  AssertTrue PropertyListKFS( onecore.Value( "pdir" ) ).TreatAsArray, "Could not set the TreatAsArray property (1)."
		  PropertyListKFS( twocore.Value( "pdir" ) ).TreatAsArray = True
		  AssertTrue PropertyListKFS( twocore.Value( "pdir" ) ).TreatAsArray, "Could not set the TreatAsArray property (2)."
		  
		  AssertTrue one = two, "The TreatAsArray property is not supposed to affect the result of comparisons (1)."
		  
		  one.TreatAsArray = True
		  AssertTrue one.TreatAsArray, "Could not set the TreatAsArray property (3)."
		  two.TreatAsArray = True
		  AssertTrue two.TreatAsArray, "Could not set the TreatAsArray property (4)."
		  
		  AssertTrue one = two, "The TreatAsArray property is not supposed to affect the result of comparisons (2)."
		  
		  
		  // Test for various types of inequality.
		  
		  PushMessageStack "A test of basic inequivalence failed."
		  
		  d = PropertyListKFS( onecore.Value( "pdir" ) )
		  d.Remove "another"
		  
		  AssertTrue one <> two, "(1)"
		  
		  onecore.Remove "pdir"
		  
		  AssertTrue one <> two, "(2)"
		  
		  twocore.Remove "pdir"
		  
		  AssertTrue one = two, "(3)"
		  
		  onecore.Remove "foo"
		  twocore.Remove "FISH"
		  
		  AssertTrue one <> two, "(4)"
		  
		  onecore.Remove "fish"
		  twocore.Remove "foo"
		  
		  AssertTrue one = two, "(5)"
		  
		  // done.
		  
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
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Remove method works without pruning.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  Dim d As Dictionary
		  
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  // Remove a terminal at the root level:
		  
		  PushMessageStack "The test hierarchy failed before the first remove: "
		  AssertEquals 7, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v1" ), "v1."
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v3" ), "v3."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c1" ), "c1."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  root.Remove False, "v3"
		  
		  PushMessageStack "The hierarchy test failed after the first remove: "
		  AssertEquals 6, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v1" ), "v1."
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c1" ), "c1."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  root.Remove False, "v1"
		  
		  PushMessageStack "The hierarchy test failed after the second remove: "
		  AssertEquals 5, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c1" ), "c1."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  
		  // Remove a non-root terminal:
		  
		  PushMessageStack "The hierarchy test failed before the third remove: "
		  AssertTrue rootcore.HasKey( "c1" ), "1"
		  AssertTrue rootcore.Value( "c1" ) IsA PropertyListKFS, "2"
		  d = PropertyListKFS( rootcore.Value( "c1" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 2, d.Count, "3"
		  AssertTrue d.HasKey( "foo" ), "4"
		  AssertTrue d.HasKey( "fish" ), "5"
		  AssertEquals "bar", d.Value( "foo" ), "6"
		  AssertEquals "cat", d.Value( "fish" ), "7"
		  PopMessageStack
		  
		  root.Remove False, "c1", "foo"
		  
		  PushMessageStack "The hierarchy test failed after the third remove: "
		  AssertTrue rootcore.HasKey( "c1" ), "1"
		  AssertTrue rootcore.Value( "c1" ) IsA PropertyListKFS, "2"
		  d = PropertyListKFS( rootcore.Value( "c1" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, d.Count, "3"
		  AssertTrue d.HasKey( "fish" ), "4"
		  AssertEquals "cat", d.Value( "fish" ), "5"
		  PopMessageStack
		  
		  root.Remove False, "c1", "fish"
		  
		  PushMessageStack "The hierarchy test failed after the fourth remove: "
		  AssertTrue rootcore.HasKey( "c1" ), "1"
		  AssertTrue rootcore.Value( "c1" ) IsA PropertyListKFS, "2"
		  d = PropertyListKFS( rootcore.Value( "c1" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 0, d.Count, "3"
		  PopMessageStack
		  
		  
		  // Remove an empty child:
		  
		  root.Remove False, "c1"
		  
		  PushMessageStack "The hierarchy test failed after the fifth remove: "
		  AssertEquals 4, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  
		  // Remove a non-root terminal again:
		  
		  root.Remove False, "c2", "puppy", "turkey"
		  
		  PushMessageStack "The hierarchy test failed after the sixth remove: "
		  AssertTrue rootcore.HasKey( "c2" ), "1"
		  AssertTrue rootcore.Value( "c2" ) IsA Dictionary, "2"
		  AssertTrue Dictionary( rootcore.Value( "c2" ) ).HasKey( "puppy" ), "3"
		  AssertTrue Dictionary( rootcore.Value( "c2" ) ).Value( "puppy" ) IsA PropertyListKFS, "4"
		  d = PropertyListKFS( Dictionary( rootcore.Value( "c2" ) ).Value( "puppy" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertZero d.Count, "5"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestRemovePrune()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the Remove method works without pruning.
		  
		  Dim root As PropertyListKFS = GenerateTree1
		  Dim rootcore As Dictionary = root
		  Dim d As Dictionary
		  
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  // Remove a terminal at the root level:
		  
		  PushMessageStack "The test hierarchy failed before the first remove: "
		  AssertEquals 7, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v1" ), "v1."
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v3" ), "v3."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c1" ), "c1."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  root.Remove True, "v3"
		  
		  PushMessageStack "The hierarchy test failed after the first remove: "
		  AssertEquals 6, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v1" ), "v1."
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c1" ), "c1."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  root.Remove True, "v1"
		  
		  PushMessageStack "The hierarchy test failed after the second remove: "
		  AssertEquals 5, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c1" ), "c1."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  
		  // Remove a non-root terminal:
		  
		  PushMessageStack "The hierarchy test failed before the third remove: "
		  AssertTrue rootcore.HasKey( "c1" ), "1"
		  AssertTrue rootcore.Value( "c1" ) IsA PropertyListKFS, "2"
		  d = PropertyListKFS( rootcore.Value( "c1" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 2, d.Count, "3"
		  AssertTrue d.HasKey( "foo" ), "4"
		  AssertTrue d.HasKey( "fish" ), "5"
		  AssertEquals "bar", d.Value( "foo" ), "6"
		  AssertEquals "cat", d.Value( "fish" ), "7"
		  PopMessageStack
		  
		  root.Remove True, "c1", "foo"
		  
		  PushMessageStack "The hierarchy test failed after the third remove: "
		  AssertTrue rootcore.HasKey( "c1" ), "1"
		  AssertTrue rootcore.Value( "c1" ) IsA PropertyListKFS, "2"
		  d = PropertyListKFS( rootcore.Value( "c1" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, d.Count, "3"
		  AssertTrue d.HasKey( "fish" ), "4"
		  AssertEquals "cat", d.Value( "fish" ), "5"
		  PopMessageStack
		  
		  root.Remove True, "c1", "fish"
		  
		  PushMessageStack "The hierarchy test failed after the fourth remove: "
		  AssertEquals 4, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  
		  // Remove an empty child:
		  
		  rootcore.Value( "c1" ) = New PropertyListKFS
		  root.Remove True, "c1"
		  
		  PushMessageStack "The hierarchy test failed after the fifth remove: "
		  AssertEquals 4, rootcore.Count, "count"
		  AssertTrue rootcore.HasKey( "v2" ), "v2."
		  AssertTrue rootcore.HasKey( "v4" ), "v4."
		  AssertTrue rootcore.HasKey( "c2" ), "c2."
		  AssertTrue rootcore.HasKey( "c3" ), "c3."
		  PopMessageStack
		  
		  
		  // Remove a non-root terminal again:
		  
		  root.Remove True, "c2", "puppy", "turkey"
		  
		  PushMessageStack "The hierarchy test failed after the sixth remove: "
		  AssertTrue rootcore.HasKey( "c2" ), "1"
		  AssertTrue rootcore.Value( "c2" ) IsA Dictionary, "2"
		  AssertEquals 3, Dictionary( rootcore.Value( "c2" ) ).Count, "3"
		  AssertTrue Dictionary( rootcore.Value( "c2" ) ).HasKey( "dog" ), "4"
		  AssertTrue Dictionary( rootcore.Value( "c2" ) ).HasKey( "shark" ), "5"
		  AssertTrue Dictionary( rootcore.Value( "c2" ) ).HasKey( "number" ), "6"
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSerialize_ApplePList()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSerialize_Undefined()
		  
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
		  Dim d As Dictionary
		  
		  // Make sure the the getter and setter work in the root case.
		  
		  AssertFalse root.TreatAsArray, "TreatAsArray did not default to False."
		  
		  root.TreatAsArray = True
		  AssertTrue root.TreatAsArray, "TreatAsArray could not be changed to True."
		  
		  root.TreatAsArray = False
		  AssertFalse root.TreatAsArray, "TreatAsArray could not be changed back to False."
		  
		  
		  // Make sure the getter and setter work in the non-root case.
		  
		  AssertFalse root.TreatAsArray( "foo", "bar" ), "TreatAsArray does not return False for directories that do not exist."
		  
		  root.TreatAsArray( "foo", "bar" ) = False
		  AssertTrue rootcore.HasKey( "foo" ), "Setting TreatAsArray did not create the first subfolder."
		  AssertTrue rootcore.Value( "foo" ) IsA PropertyListKFS, "Setting TreatAsArray did not create the first subfolder correctly."
		  d = PropertyListKFS( rootcore.Value( "foo" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertTrue d.HasKey( "bar" ), "Setting TreatAsArray did not create the last subfolder."
		  AssertTrue d.Value( "bar" ) IsA PropertyListKFS, "Setting TreatAsArray did not create the last subfolder correctly."
		  
		  root.TreatAsArray( "foo", "bar" ) = True
		  AssertTrue root.TreatAsArray( "foo", "bar" ), "TreatAsArray could not be changed to True for a non-root directory."
		  
		  
		  // Make sure the getter and setter overwrite Dictionary objects correctly.
		  
		  PushMessageStack "Making sure Dictionary objects can be replaced by PropertyListKFS objects:"
		  
		  rootcore.Value( "foo" ) = New Dictionary( "bar" : New Dictionary )
		  
		  AssertFalse root.TreatAsArray( "foo" ), "TreatAsArray did not return False for a directory represented by a Dictionary object."
		  AssertFalse root.TreatAsArray( "foo", "bar" ), "TreatAsArray did not return False for a directory represented by a Dictionary object (2)."
		  
		  root.TreatAsArray( "foo", "bar" ) = False
		  
		  AssertTrue rootcore.HasKey( "foo" ), "Setting TreatAsArray did not create the first subfolder."
		  AssertTrue rootcore.Value( "foo" ) IsA Dictionary, "Setting TreatAsArray did not create the first subfolder correctly."
		  AssertTrue Dictionary( rootcore.Value( "foo" ) ).HasKey( "bar" ), "Setting TreatAsArray did not create the last subfolder."
		  AssertTrue Dictionary( rootcore.Value( "foo" ) ).Value( "bar" ) IsA PropertyListKFS, "Setting TreatAsArray did not create the last subfolder correctly."
		  
		  AssertFalse root.TreatAsArray( "foo", "bar" ), "TreatAsArray could not be set to False."
		  
		  root.TreatAsArray( "foo", "bar" ) = True
		  AssertTrue root.TreatAsArray( "foo", "bar" ), "TreatAsArray could not be set to True."
		  AssertTrue rootcore.Value( "foo" ) IsA Dictionary, "Setting TreatAsArray to True did something to the intermediate folder."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Makes sure the Value functions work.
		  
		  Dim root As PropertyListKFS
		  Dim rootcore, d As Dictionary
		  Dim expvalue As New BinaryStream( "Hello, World!" )
		  
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
		  d = PropertyListKFS( rootcore.Value( "foo" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertTrue d.HasKey( "bar" ), "The Value setter did not add the second level of the path."
		  AssertTrue d.Value( "bar" ) IsA PropertyListKFS, "The Value setter did not add the second level of the path correctly."
		  d = PropertyListKFS( d.Value( "bar" ) )
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertTrue d.HasKey( "fishcat" ), "The Value setter did not add the key for the new child."
		  AssertSame expvalue, d.Value( "fishcat" ), "The Value setter did not assign the new child at the correct path."
		  
		  
		  // Make sure the getter works in the non-root case.
		  
		  AssertSame expvalue, root.Value( "foo", "bar", "fishcat" ), "The Value getter did not return a value that is known to exist.", False
		  
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
		  AssertEquals Nil, v(3), "Index 3 is wrong."
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
		  
		  AssertEquals -1, UBound( root.Values( "v1" ) )
		  AssertEquals -1, UBound( root.Values( "v2" ) )
		  AssertEquals -1, UBound( root.Values( "v3" ) )
		  AssertEquals -1, UBound( root.Values( "v4" ) )
		  AssertEquals -1, UBound( root.Values( "c1", "foo" ) )
		  AssertEquals -1, UBound( root.Values( "c1", "fish" ) )
		  AssertEquals -1, UBound( root.Values( "c2", "dog" ) )
		  AssertEquals -1, UBound( root.Values( "c2", "shark" ) )
		  AssertEquals -1, UBound( root.Values( "c2", "number" ) )
		  AssertEquals -1, UBound( root.Values( "c2", "puppy", "turkey" ) )
		  AssertEquals -1, UBound( root.Values( "c3", "test" ) )
		  
		  PopMessageStack
		  
		  
		  // Make sure the Values function works with nodes that don't exist.
		  
		  AssertNotIsNil root.Values( "doggie" ), "Values is never supposed to return a Nil result (path did not exist)."
		  
		  PushMessageStack "The Values function is supposed to return an empty array for paths that do not exist."
		  
		  AssertEquals -1, UBound( root.Values( "doggie" ) )
		  AssertEquals -1, UBound( root.Values( "doggie", "fishcat" ) )
		  AssertEquals -1, UBound( root.Values( "c1", "doggie" ) )
		  AssertEquals -1, UBound( root.Values( "c1", "doggie", "fishcat" ) )
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestWedgeAfter()
		  // Created 12/17/2010 by Andrew Keller
		  
		  // Makes sure the WedgeAfter method works.
		  
		  Dim root As  PropertyListKFS
		  Dim rootcore As Dictionary
		  Dim child As  PropertyListKFS
		  Dim childcore As Dictionary
		  
		  // Check the root case.
		  
		  PushMessageStack "Testing at the root level:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  rootcore.Value( 1 ) = "1"
		  rootcore.Value( 2 ) = "2"
		  rootcore.Value( 3 ) = "3"
		  rootcore.Value( 4 ) = "4"
		  rootcore.Value( 6 ) = "6"
		  rootcore.Value( 7 ) = "7"
		  rootcore.Value( 8 ) = "8"
		  rootcore.Value( 12 ) = "12"
		  rootcore.Value( 13 ) = "13"
		  rootcore.Value( 14 ) = "14"
		  
		  root.WedgeAfter "hello", 3
		  
		  VerifyWedgeAfter rootcore
		  
		  PopMessageStack
		  
		  
		  // Check the non-root Dictionary case.
		  
		  PushMessageStack "Testing a non-root Dictionary level:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  child = New PropertyListKFS
		  childcore = child
		  AssertNotIsNil childcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  rootcore.Value( "foo" ) = childcore
		  
		  childcore.Value( 1 ) = "1"
		  childcore.Value( 2 ) = "2"
		  childcore.Value( 3 ) = "3"
		  childcore.Value( 4 ) = "4"
		  childcore.Value( 6 ) = "6"
		  childcore.Value( 7 ) = "7"
		  childcore.Value( 8 ) = "8"
		  childcore.Value( 12 ) = "12"
		  childcore.Value( 13 ) = "13"
		  childcore.Value( 14 ) = "14"
		  
		  root.WedgeAfter "hello", "foo", 3
		  
		  VerifyWedgeAfter childcore
		  
		  PopMessageStack
		  
		  
		  // Check the non-root PropertyListKFS case.
		  
		  PushMessageStack "Testing a non-root PropertyListKFS level:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  child = New PropertyListKFS
		  childcore = child
		  AssertNotIsNil childcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  rootcore.Value( "foo" ) = child
		  
		  childcore.Value( 1 ) = "1"
		  childcore.Value( 2 ) = "2"
		  childcore.Value( 3 ) = "3"
		  childcore.Value( 4 ) = "4"
		  childcore.Value( 6 ) = "6"
		  childcore.Value( 7 ) = "7"
		  childcore.Value( 8 ) = "8"
		  childcore.Value( 12 ) = "12"
		  childcore.Value( 13 ) = "13"
		  childcore.Value( 14 ) = "14"
		  
		  root.WedgeAfter "hello", "foo", 3
		  
		  VerifyWedgeAfter childcore
		  
		  PopMessageStack
		  
		  
		  // Check the case with no collision.
		  
		  PushMessageStack "Testing the no-collision case:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  child = New PropertyListKFS
		  childcore = child
		  AssertNotIsNil childcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  rootcore.Value( "foo" ) = child
		  
		  childcore.Value( 1 ) = "1"
		  childcore.Value( 2 ) = "2"
		  childcore.Value( 3 ) = "3"
		  childcore.Value( 4 ) = "4"
		  childcore.Value( 6 ) = "6"
		  childcore.Value( 7 ) = "7"
		  childcore.Value( 8 ) = "8"
		  childcore.Value( 12 ) = "12"
		  childcore.Value( 13 ) = "13"
		  childcore.Value( 14 ) = "14"
		  
		  root.WedgeAfter "hello", "foo", -1
		  child.WedgeAfter "world", 18
		  
		  AssertTrue childcore.HasKey( 1 ), "Key 1 should be left alone."
		  AssertEquals "1", childcore.Value( 1 ), "Key 1 should be left alone."
		  
		  AssertTrue childcore.HasKey( 2 ), "Key 2 should be left alone."
		  AssertEquals "2", childcore.Value( 2 ), "Key 2 should be left alone."
		  
		  AssertTrue childcore.HasKey( 3 ), "Key 3 should be left alone."
		  AssertEquals "3", childcore.Value( 3 ), "Key 3 should be left alone."
		  
		  AssertTrue childcore.HasKey( 4 ), "Key 4 should be left alone."
		  AssertEquals "4", childcore.Value( 4 ), "Key 4 should be left alone."
		  
		  AssertTrue childcore.HasKey( 6 ), "Key 6 should be left alone."
		  AssertEquals "6", childcore.Value( 6 ), "Key 6 should be left alone."
		  
		  AssertTrue childcore.HasKey( 7 ), "Key 7 should be left alone."
		  AssertEquals "7", childcore.Value( 7 ), "Key 7 should be left alone."
		  
		  AssertTrue childcore.HasKey( 8 ), "Key 8 should be left alone."
		  AssertEquals "8", childcore.Value( 8 ), "Key 8 should be left alone."
		  
		  AssertTrue childcore.HasKey( 12 ), "Key 12 should be left alone."
		  AssertEquals "12", childcore.Value( 12 ), "Key 12 should be left alone."
		  
		  AssertTrue childcore.HasKey( 13 ), "Key 13 should be left alone."
		  AssertEquals "13", childcore.Value( 13 ), "Key 13 should be left alone."
		  
		  AssertTrue childcore.HasKey( 14 ), "Key 14 should be left alone."
		  AssertEquals "14", childcore.Value( 14 ), "Key 14 should be left alone."
		  
		  AssertTrue childcore.HasKey( -1 ), "Key -1 should be inserted."
		  AssertEquals "hello", childcore.Value( -1 ), "Key -1 should be inserted."
		  
		  AssertTrue childcore.HasKey( 18 ), "Key 18 should be inserted."
		  AssertEquals "world", childcore.Value( 18 ), "Key 18 should be inserted."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestWedgeInto()
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Makes sure the WedgeInto method works.
		  
		  Dim root As  PropertyListKFS
		  Dim rootcore As Dictionary
		  Dim child As  PropertyListKFS
		  Dim childcore As Dictionary
		  
		  // Check the root case.
		  
		  PushMessageStack "Testing at the root level:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  rootcore.Value( 1 ) = "1"
		  rootcore.Value( 2 ) = "2"
		  rootcore.Value( 3 ) = "3"
		  rootcore.Value( 4 ) = "4"
		  rootcore.Value( 6 ) = "6"
		  rootcore.Value( 7 ) = "7"
		  rootcore.Value( 8 ) = "8"
		  rootcore.Value( 12 ) = "12"
		  rootcore.Value( 13 ) = "13"
		  rootcore.Value( 14 ) = "14"
		  
		  root.WedgeInto "hello", 3
		  
		  VerifyWedgeInto rootcore
		  
		  PopMessageStack
		  
		  
		  // Check the non-root Dictionary case.
		  
		  PushMessageStack "Testing a non-root Dictionary level:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  child = New PropertyListKFS
		  childcore = child
		  AssertNotIsNil childcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  rootcore.Value( "foo" ) = childcore
		  
		  childcore.Value( 1 ) = "1"
		  childcore.Value( 2 ) = "2"
		  childcore.Value( 3 ) = "3"
		  childcore.Value( 4 ) = "4"
		  childcore.Value( 6 ) = "6"
		  childcore.Value( 7 ) = "7"
		  childcore.Value( 8 ) = "8"
		  childcore.Value( 12 ) = "12"
		  childcore.Value( 13 ) = "13"
		  childcore.Value( 14 ) = "14"
		  
		  root.WedgeInto "hello", "foo", 3
		  
		  VerifyWedgeInto childcore
		  
		  PopMessageStack
		  
		  
		  // Check the non-root PropertyListKFS case.
		  
		  PushMessageStack "Testing a non-root PropertyListKFS level:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  child = New PropertyListKFS
		  childcore = child
		  AssertNotIsNil childcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  rootcore.Value( "foo" ) = child
		  
		  childcore.Value( 1 ) = "1"
		  childcore.Value( 2 ) = "2"
		  childcore.Value( 3 ) = "3"
		  childcore.Value( 4 ) = "4"
		  childcore.Value( 6 ) = "6"
		  childcore.Value( 7 ) = "7"
		  childcore.Value( 8 ) = "8"
		  childcore.Value( 12 ) = "12"
		  childcore.Value( 13 ) = "13"
		  childcore.Value( 14 ) = "14"
		  
		  root.WedgeInto "hello", "foo", 3
		  
		  VerifyWedgeInto childcore
		  
		  PopMessageStack
		  
		  
		  // Check the case with no collision.
		  
		  PushMessageStack "Testing the no-collision case:"
		  
		  root = New PropertyListKFS
		  rootcore = root
		  AssertNotIsNil rootcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  child = New PropertyListKFS
		  childcore = child
		  AssertNotIsNil childcore, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  rootcore.Value( "foo" ) = child
		  
		  childcore.Value( 1 ) = "1"
		  childcore.Value( 2 ) = "2"
		  childcore.Value( 3 ) = "3"
		  childcore.Value( 4 ) = "4"
		  childcore.Value( 6 ) = "6"
		  childcore.Value( 7 ) = "7"
		  childcore.Value( 8 ) = "8"
		  childcore.Value( 12 ) = "12"
		  childcore.Value( 13 ) = "13"
		  childcore.Value( 14 ) = "14"
		  
		  root.WedgeInto "hello", "foo", -1
		  child.WedgeInto "world", 18
		  
		  AssertTrue childcore.HasKey( 1 ), "Key 1 should be left alone."
		  AssertEquals "1", childcore.Value( 1 ), "Key 1 should be left alone."
		  
		  AssertTrue childcore.HasKey( 2 ), "Key 2 should be left alone."
		  AssertEquals "2", childcore.Value( 2 ), "Key 2 should be left alone."
		  
		  AssertTrue childcore.HasKey( 3 ), "Key 3 should be left alone."
		  AssertEquals "3", childcore.Value( 3 ), "Key 3 should be left alone."
		  
		  AssertTrue childcore.HasKey( 4 ), "Key 4 should be left alone."
		  AssertEquals "4", childcore.Value( 4 ), "Key 4 should be left alone."
		  
		  AssertTrue childcore.HasKey( 6 ), "Key 6 should be left alone."
		  AssertEquals "6", childcore.Value( 6 ), "Key 6 should be left alone."
		  
		  AssertTrue childcore.HasKey( 7 ), "Key 7 should be left alone."
		  AssertEquals "7", childcore.Value( 7 ), "Key 7 should be left alone."
		  
		  AssertTrue childcore.HasKey( 8 ), "Key 8 should be left alone."
		  AssertEquals "8", childcore.Value( 8 ), "Key 8 should be left alone."
		  
		  AssertTrue childcore.HasKey( 12 ), "Key 12 should be left alone."
		  AssertEquals "12", childcore.Value( 12 ), "Key 12 should be left alone."
		  
		  AssertTrue childcore.HasKey( 13 ), "Key 13 should be left alone."
		  AssertEquals "13", childcore.Value( 13 ), "Key 13 should be left alone."
		  
		  AssertTrue childcore.HasKey( 14 ), "Key 14 should be left alone."
		  AssertEquals "14", childcore.Value( 14 ), "Key 14 should be left alone."
		  
		  AssertTrue childcore.HasKey( -1 ), "Key -1 should be inserted."
		  AssertEquals "hello", childcore.Value( -1 ), "Key -1 should be inserted."
		  
		  AssertTrue childcore.HasKey( 18 ), "Key 18 should be inserted."
		  AssertEquals "world", childcore.Value( 18 ), "Key 18 should be inserted."
		  
		  PopMessageStack
		  
		  // done.
		  
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

	#tag Method, Flags = &h0
		Sub VerifyWedgeAfter(dircore As Dictionary)
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Verifies the standard WedgeAfter test on the given core.
		  
		  AssertNotIsNil dircore, "VerifyWedgeInto: dircore cannot be Nil."
		  
		  For i As Integer = 1 To 4
		    AssertTrue dircore.HasKey( i ), "Key "+str(i)+" should be left alone."
		    AssertEquals str(i), dircore.Value( i ), "Key "+str(i)+" should be left alone."
		  Next
		  
		  AssertTrue dircore.HasKey( 5 ), "Key 5 should be inserted."
		  AssertEquals "hello", dircore.Value( 5 ), "Key 5 should be inserted."
		  
		  For i As Integer = 6 To 8
		    AssertTrue dircore.HasKey( i ), "Key "+str(i)+" should be left alone."
		    AssertEquals str(i), dircore.Value( i ), "Key "+str(i)+" should be left alone."
		  Next
		  
		  For i As Integer = 12 To 14
		    AssertTrue dircore.HasKey( i ), "Key "+str(i)+" should be left alone."
		    AssertEquals str(i), dircore.Value( i ), "Key "+str(i)+" should be left alone."
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyWedgeInto(dircore As Dictionary)
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Verifies the standard WedgeInto test on the given core.
		  
		  AssertNotIsNil dircore, "VerifyWedgeInto: dircore cannot be Nil."
		  
		  AssertTrue dircore.HasKey( 1 ), "Key 1 should be left alone."
		  AssertEquals "1", dircore.Value( 1 ), "Key 1 should be left alone."
		  
		  AssertTrue dircore.HasKey( 2 ), "Key 2 should be left alone."
		  AssertEquals "2", dircore.Value( 2 ), "Key 2 should be left alone."
		  
		  AssertTrue dircore.HasKey( 3 ), "Key 3 should be the new entry."
		  AssertNotEqual "3", dircore.Value( 3 ), "Key 3 should have been shifted to key 4 to allow for the new value to be inserted at key 3."
		  AssertEquals "hello", dircore.Value( 3 ), "Key 3 should be the new entry."
		  
		  AssertTrue dircore.HasKey( 4 ), "Key 4 should be shifted from key 3."
		  AssertEquals "3", dircore.Value( 4 ), "Key 4 should be shifted from key 3."
		  
		  AssertTrue dircore.HasKey( 5 ), "Key 5 should be shifted from key 4."
		  AssertEquals "4", dircore.Value( 5 ), "Key 5 should be shifted from key 4."
		  
		  AssertTrue dircore.HasKey( 6 ), "Key 6 should be left alone."
		  AssertEquals "6", dircore.Value( 6 ), "Key 6 should be left alone."
		  
		  AssertTrue dircore.HasKey( 7 ), "Key 7 should be left alone."
		  AssertEquals "7", dircore.Value( 7 ), "Key 7 should be left alone."
		  
		  AssertTrue dircore.HasKey( 8 ), "Key 8 should be left alone."
		  AssertEquals "8", dircore.Value( 8 ), "Key 8 should be left alone."
		  
		  AssertTrue dircore.HasKey( 12 ), "Key 12 should be left alone."
		  AssertEquals "12", dircore.Value( 12 ), "Key 12 should be left alone."
		  
		  AssertTrue dircore.HasKey( 13 ), "Key 13 should be left alone."
		  AssertEquals "13", dircore.Value( 13 ), "Key 13 should be left alone."
		  
		  AssertTrue dircore.HasKey( 14 ), "Key 14 should be left alone."
		  AssertEquals "14", dircore.Value( 14 ), "Key 14 should be left alone."
		  
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


	#tag Constant, Name = kSampleApplePList1, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>AB21vCardEncoding</key>\r\t<string>MACINTOSH</string>\r\t<key>AB21vCardEncoding-localized</key>\r\t<string>MACINTOSH</string>\r\t<key>ABDefaultAddressCountryCode</key>\r\t<string>us</string>\r\t<key>ABDefaultSelectedMember</key>\r\t<string>3C2C8E62-2CD7-4792-BDD2-66181478E252:ABPerson</string>\r\t<key>ABImportTipCards</key>\r\t<true/>\r\t<key>ABMainWindowViewMode</key>\r\t<integer>0</integer>\r\t<key>ABMainWindowViewMode-cardCol</key>\r\t<real>353</real>\r\t<key>ABMainWindowViewMode-contactCol</key>\r\t<real>187</real>\r\t<key>ABMainWindowViewMode-sourceCol</key>\r\t<real>159</real>\r\t<key>ABMetaDataChangeCount</key>\r\t<integer>881</integer>\r\t<key>ABMetadataLastOilChange</key>\r\t<date>2010-12-07T17:45:53Z</date>\r\t<key>ABNameDisplay</key>\r\t<integer>0</integer>\r\t<key>ABNameSorting</key>\r\t<integer>1</integer>\r\t<key>ABPhoneFormat-Edited</key>\r\t<false/>\r\t<key>ABPhoneFormat-Enabled</key>\r\t<true/>\r\t<key>ABPhoneFormat-PhoneFormatter</key>\r\t<array>\r\t\t<string>+1-###-###-####</string>\r\t\t<string>1-###-###-####</string>\r\t\t<string>###-###-####</string>\r\t\t<string>###-####</string>\r\t</array>\r\t<key>NSSplitView Subview Frames main split view</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 159.000000\x2C 519.000000\x2C NO</string>\r\t\t<string>160.000000\x2C 0.000000\x2C 187.000000\x2C 519.000000\x2C NO</string>\r\t\t<string>348.000000\x2C 0.000000\x2C 353.000000\x2C 519.000000\x2C NO</string>\r\t</array>\r\t<key>NSWindow Frame AB Main Window</key>\r\t<string>402 249 701 564 0 0 1440 878 </string>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList2, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>NSFontPanelAttributes</key>\r\t<string>1\x2C 4</string>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavPanelExpandedSizeForSaveMode</key>\r\t<string>{537\x2C 504}</string>\r\t<key>NSNavPanelExpandedStateForSaveMode</key>\r\t<true/>\r\t<key>NSWindow Frame PVInspectorPanel</key>\r\t<string>1116 499 320 375 0 0 1440 878 </string>\r\t<key>NSWindow Frame PVPreferences</key>\r\t<string>390 393 500 168 0 0 1280 778 </string>\r\t<key>PMPrintingExpandedStateForPrint</key>\r\t<true/>\r\t<key>PVAnnotationArrowStyle_1</key>\r\t<integer>2</integer>\r\t<key>PVAnnotationColor_1</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_2</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_3</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_4</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/HwcD+D3dxcP4OtrCw+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_5</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgABhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationColor_7</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/z7ez+D7u1tP4Pn5uY+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_8</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationFontName_5</key>\r\t<string>Monaco</string>\r\t<key>PVAnnotationFontSize_5</key>\r\t<real>6</real>\r\t<key>PVAnnotationInteriorColor_1</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgAAhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationInteriorColor_2</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgAAhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationInteriorColor_5</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgEBhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationLineWidth_1</key>\r\t<real>3</real>\r\t<key>PVAnnotationLineWidth_2</key>\r\t<real>3</real>\r\t<key>PVAnnotationLineWidth_5</key>\r\t<real>3</real>\r\t<key>PVGeneralSelectedPane</key>\r\t<integer>0</integer>\r\t<key>PVInspectorPanelForDoctype_NoDocument</key>\r\t<string>PVInspectorNoDocument</string>\r\t<key>PVInspectorPanelForDoctype_PDFDocument</key>\r\t<string>PVInspectorPDFAnnotations</string>\r\t<key>PVInspectorWindowOpenOnStart</key>\r\t<false/>\r\t<key>PVPDFDisplayBox</key>\r\t<integer>1</integer>\r\t<key>PVPDFDisplayMode</key>\r\t<integer>1</integer>\r\t<key>PVPDFLastSidebarWidthForOutline</key>\r\t<real>196</real>\r\t<key>PVPDFLastSidebarWidthForThumbnails</key>\r\t<real>164</real>\r\t<key>PVSidebarThumbnailColumns</key>\r\t<integer>1</integer>\r\t<key>kPVInspectorPDFMetricsUnit</key>\r\t<integer>4</integer>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList3, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>Default Window Settings</key>\r\t<string>Homebrew</string>\r\t<key>HasMigratedDefaults</key>\r\t<true/>\r\t<key>NSFontPanelAttributes</key>\r\t<string>1\x2C 4</string>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavLastRootDirectory</key>\r\t<string>~</string>\r\t<key>NSWindow Frame NSColorPanel</key>\r\t<string>867 413 201 309 0 0 1440 878 </string>\r\t<key>NSWindow Frame NSFontPanel</key>\r\t<string>296 71 445 270 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTAppPreferences</key>\r\t<string>696 272 590 399 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTFindPanel</key>\r\t<string>863 324 483 144 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow</key>\r\t<string>493 427 524 349 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Basic</key>\r\t<string>390 109 505 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Grass</key>\r\t<string>693 235 505 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Homebrew</key>\r\t<string>253 150 955 388 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Novel</key>\r\t<string>855 329 585 390 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Ocean</key>\r\t<string>833 433 585 390 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Pro</key>\r\t<string>114 449 505 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Red Sands</key>\r\t<string>805 109 585 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow emunix</key>\r\t<string>73 415 955 388 0 0 1440 878 </string>\r\t<key>ProfileCurrentVersion</key>\r\t<real>2.0099999999999998</real>\r\t<key>SecureKeyboardEntry</key>\r\t<false/>\r\t<key>Shell</key>\r\t<string></string>\r\t<key>ShowTabBar</key>\r\t<true/>\r\t<key>Startup Window Settings</key>\r\t<string>Homebrew</string>\r\t<key>TTAppPreferences Selected Tab</key>\r\t<integer>1</integer>\r\t<key>TTInspector Selected Pane</key>\r\t<string>Settings</string>\r\t<key>Window Settings</key>\r\t<dict>\r\t\t<key>Basic</key>\r\t\t<dict>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>1.004032258064516</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Basic</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Grass</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAgMC4wNzQ1MDk4MDcg\r\t\t\tMC40NjY2NjY3IDAuMjM5MjE1NwDSEBESE1okY2xhc3NuYW1lWCRj\r\t\t\tbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJj\r\t\t\taGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cYmRmiY6ZoqqttsjL\r\t\t\t0AAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADS\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAYMC41NTY4NjI3NyAw\r\t\t\tLjE1Njg2Mjc1IDAA0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nlc1dO\r\t\t\tU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RcY\r\t\t\tVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoGGkZqipa7Aw8gAAAAAAAAB\r\t\t\tAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAyg\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>CursorType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAhMC43MTM3MjU1MSAw\r\t\t\tLjI4NjI3NDUyIDAuMTQ5MDE5NjEA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAXMSAwLjY5MDE5NjEg\r\t\t\tMC4yMzEzNzI1NwDSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05T\r\t\t\tQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhU\r\t\t\tcm9vdIABCBEaIy0yNztBSE9cYmRmgIWQmaGkrb/CxwAAAAAAAAEB\r\t\t\tAAAAAAAAABkAAAAAAAAAAAAAAAAAAADJ\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAYMSAwLjk0MTE3NjUz\r\t\t\tIDAuNjQ3MDU4ODQA0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nlc1dO\r\t\t\tU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RcY\r\t\t\tVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoGGkZqipa7Aw8gAAAAAAAAB\r\t\t\tAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAyg\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Grass</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Homebrew</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANGMCAwLjgA0hAREhNa\r\t\t\tJGNsYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0\r\t\t\tXxAPTlNLZXllZEFyY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhP\r\t\t\tXGRmaG90f4iQk5yusbYAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAA\r\t\t\tAAAAAAAAuA\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>CursorBlink</key>\r\t\t\t<false/>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAhMC4yMTk2MDc4NiAw\r\t\t\tLjk5NjA3ODQ5IDAuMTUyOTQxMTgA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>CursorType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>Linewrap</key>\r\t\t\t<true/>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>ScrollbackLines</key>\r\t\t\t<real>10000</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAeMC4wMzQ1NzgzOTUg\r\t\t\tMCAwLjkxMzI2NTMxIDAuNjUA0hAREhNaJGNsYXNzbmFtZVgkY2xh\r\t\t\tc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hp\r\t\t\tdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoeMl6Coq7TGyc4A\r\t\t\tAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0A\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>ShouldLimitScrollback</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABRjAgMSAwANIQERITWiRj\r\t\t\tbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqISFFhOU09iamVjdF8Q\r\t\t\tD05TS2V5ZWRBcmNoaXZlctEXGFRyb290gAEIERojLTI3O0FIT1xi\r\t\t\tZGZtcn2GjpGarK+0AAAAAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAA\r\t\t\tAAAAALY\x3D\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAiMC4xNTY4NjI3NSAw\r\t\t\tLjk5NjA3ODQ5IDAuMDc4NDMxMzc1ANIQERITWiRjbGFzc25hbWVY\r\t\t\tJGNsYXNzZXNXTlNDb2xvcqISFFhOU09iamVjdF8QD05TS2V5ZWRB\r\t\t\tcmNoaXZlctEXGFRyb290gAEIERojLTI3O0FIT1xiZGaLkJukrK+4\r\t\t\tys3SAAAAAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAAAAAAANQ\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Homebrew</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Novel</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAaMC44NzUgMC44NTc5\r\t\t\tODM2NSAwLjc2NTYyNQDSEBESE1okY2xhc3NuYW1lWCRjbGFzc2Vz\r\t\t\tV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLR\r\t\t\tFxhUcm9vdIABCBEaIy0yNztBSE9cYmRmg4iTnKSnsMLFygAAAAAA\r\t\t\tAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADM\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAqMC4yMjc0NTEgMC4x\r\t\t\tMzcyNTQ5MSAwLjEzMzMzMzM0IDAuNjQ5OTk5OTgA0hAREhNaJGNs\r\t\t\tYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAP\r\t\t\tTlNLZXllZEFyY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJk\r\t\t\tZpOYo6y0t8DS1doAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAA\r\t\t\tAAAA3A\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAsMC40NTQwODE2NSAw\r\t\t\tLjQ1MTAwNDg5IDAuMzE1MTQzOTEgMC43NTk5OTk5OQDSEBESE1ok\r\t\t\tY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3Rf\r\t\t\tEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9c\r\t\t\tYmRmlZqlrra5wtTX3AAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAA\r\t\t\tAAAAAADe\r\t\t\t</data>\r\t\t\t<key>ShowWindowSettingsNameInTitle</key>\r\t\t\t<false/>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAbMC41IDAuMTY0MzAw\r\t\t\tNTUgMC4wOTkxNDU0NzIA0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nl\r\t\t\tc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy\r\t\t\t0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoSJlJ2lqLHDxssAAAAA\r\t\t\tAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAzQ\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAhMC4yMzMxNzMxMiAw\r\t\t\tLjEzNTQwODU3IDAuMTMyOTA2MDgA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Novel</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Ocean</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAhMC4xMzIwNTYyNCAw\r\t\t\tLjMwODQ3ODU2IDAuNzM5MTMwNDQA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>0.99596774193548387</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAXMC4xMzA3MzkzIDAu\r\t\t\tNDI4NDU4MDYgMQDSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05T\r\t\t\tQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhU\r\t\t\tcm9vdIABCBEaIy0yNztBSE9cYmRmgIWQmaGkrb/CxwAAAAAAAAEB\r\t\t\tAAAAAAAAABkAAAAAAAAAAAAAAAAAAADJ\r\t\t\t</data>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>fontAllowsDisableAntialias</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Ocean</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Pro</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANNMCAwLjg1MDAwMDAy\r\t\t\tANIQERITWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqISFFhO\r\t\t\tU09iamVjdF8QD05TS2V5ZWRBcmNoaXZlctEXGFRyb290gAEIERoj\r\t\t\tLTI3O0FIT1xkZmh2e4aPl5qjtbi9AAAAAAAAAQEAAAAAAAAAGQAA\r\t\t\tAAAAAAAAAAAAAAAAAL8\x3D\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANLMC4zMDI0MTkzNgDS\r\t\t\tEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNP\r\t\t\tYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0y\r\t\t\tNztBSE9cZGZodHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAA\r\t\t\tAAAAAAAAAAAAAAC9\r\t\t\t</data>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>0.99596774193548387</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANLMC4yNTQwMzIyNQDS\r\t\t\tEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNP\r\t\t\tYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0y\r\t\t\tNztBSE9cZGZodHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAA\r\t\t\tAAAAAAAAAAAAAAC9\r\t\t\t</data>\r\t\t\t<key>ShowWindowSettingsNameInTitle</key>\r\t\t\t<false/>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANLMC45NDc1ODA2NADS\r\t\t\tEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNP\r\t\t\tYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0y\r\t\t\tNztBSE9cZGZodHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAA\r\t\t\tAAAAAAAAAAAAAAC9\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Pro</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>shellExitAction</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Red Sands</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAsMC40NzgyNjA4NyAw\r\t\t\tLjE0NTEwNDM2IDAuMTE2ODgxMjEgMC44NTAwMDAwMgDSEBESE1ok\r\t\t\tY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3Rf\r\t\t\tEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9c\r\t\t\tYmRmlZqlrra5wtTX3AAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAA\r\t\t\tAAAAAADe\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>CursorType</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>1.004032258064516</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAjMC4yMzc5MDMyMSAw\r\t\t\tLjA5NzYwMTMzOSAwLjA4NzQzNDUyMwDSEBESE1okY2xhc3NuYW1l\r\t\t\tWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVk\r\t\t\tQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cYmRmjJGcpa2w\r\t\t\tucvO0wAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADV\r\t\t\t</data>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAcMC44NzUgMC43NDAz\r\t\t\tODg0NSAwLjEzMjEzODczANIQERITWiRjbGFzc25hbWVYJGNsYXNz\r\t\t\tZXNXTlNDb2xvcqISFFhOU09iamVjdF8QD05TS2V5ZWRBcmNoaXZl\r\t\t\tctEXGFRyb290gAEIERojLTI3O0FIT1xiZGaFipWepqmyxMfMAAAA\r\t\t\tAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAM4\x3D\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAhMC44NDMxMzczMiAw\r\t\t\tLjc4ODIzNTM3IDAuNjU0OTAxOTgA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>fontAllowsDisableAntialias</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Red Sands</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t</dict>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList4, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>IgnoreHTML</key>\r\t<true/>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavLastCurrentDirectory</key>\r\t<string>~/School/COSC 444-0</string>\r\t<key>NSNavLastRootDirectory</key>\r\t<string>~/School</string>\r\t<key>NSNavPanelExpandedSizeForOpenMode</key>\r\t<string>{537\x2C 400}</string>\r\t<key>NSNavPanelExpandedSizeForSaveMode</key>\r\t<string>{537\x2C 422}</string>\r\t<key>NSNavPanelExpandedStateForSaveMode</key>\r\t<true/>\r\t<key>NSWindow Frame NSFontPanel</key>\r\t<string>993 97 445 270 0 0 1440 878 </string>\r\t<key>NSWindow Frame NSNavGotoPanel</key>\r\t<string>956 744 432 134 0 0 1440 878 </string>\r\t<key>PMPrintingExpandedStateForPrint</key>\r\t<false/>\r\t<key>RichText</key>\r\t<integer>0</integer>\r\t<key>TextReplacement</key>\r\t<false/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList5, Type = String, Dynamic = False, Default = \"<\?xml  version\x3D\"1.0\"    encoding\x3D\"UTF-8\"\?>\r\r<!DOCTYPE   plist     PUBLIC     \"-//Apple//DTD PLIST 1.0//EN\"     \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"        >\r\r\r<plist     version\x3D\"1.0\"    >\r\r\r\r<dict>\r\t<key>ActivityViewerWindowFrame</key>\r\t<string>50 105 400 200 0 0 1440 878 </string>\r\t<key>ColorIndexedSymbols</key>\r\t<true/>\r\t<key>ColorTheme</key>\r\t<string>Xcode Default (Monaco)</string>\r\t<key>ColorThemesUpgraded</key>\r\t<true/>\r\t<key>CopySourceCodeAsRichText</key>\r\t<true/>\r\t<key>DSAPreferenceRefreshInterval</key>\r\t<real>86400</real>\r\t<key>DSAPreferenceSubscriptions</key>\r\t<dict>\r\t\t<key>http://developer.apple.com/rss/adcdocsets.atom</key>\r\t\t<string>5826CA10-BCA8-4F00-8694-F2E16CCB0E1C</string>\r\t\t<key>http://developer.apple.com/rss/com.apple.adc.documentation.AppleSnowLeopard.atom</key>\r\t\t<string>57B16CE1-8F87-4684-B5F3-8ED1850DF19A</string>\r\t\t<key>http://developer.apple.com/rss/com.apple.adc.documentation.AppleXcode3_2.atom</key>\r\t\t<string>52260324-7AE6-497E-8972-25DC39934D5B</string>\r\t</dict>\r\t<key>DSMEnabledDocSetsForSearching</key>\r\t<dict>\r\t\t<key>C</key>\r\t\t<false/>\r\t\t<key>C++</key>\r\t\t<false/>\r\t\t<key>Java</key>\r\t\t<true/>\r\t\t<key>JavaScript</key>\r\t\t<false/>\r\t\t<key>Objective-C</key>\r\t\t<false/>\r\t</dict>\r\t<key>IndentWidth</key>\r\t<integer>4</integer>\r\t<key>NSFontPanelAttributes</key>\r\t<string>1\x2C 4</string>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavLastRootDirectory</key>\r\t<string>~/Downloads/bbt</string>\r\t<key>NSNavPanelExpandedSizeForOpenMode</key>\r\t<string>{537\x2C 400}</string>\r\t<key>NSNavPanelExpandedSizeForSaveMode</key>\r\t<string>{537\x2C 400}</string>\r\t<key>NSNavPanelExpandedStateForSaveMode</key>\r\t<true/>\r\t<key>NSSplitView Sizes XCDistributedBuildsSplitView</key>\r\t<array>\r\t\t<string>{135\x2C 179}</string>\r\t\t<string>{455\x2C 179}</string>\r\t</array>\r\t<key>NSSplitView Subview Frames PBXTargetInspectorPaneSplit</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 438.000000\x2C 213.000000\x2C NO</string>\r\t\t<string>0.000000\x2C 222.000000\x2C 438.000000\x2C 284.000000\x2C NO</string>\r\t</array>\r\t<key>NSSplitView Subview Frames WebAndSearchResultsSplitView</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 0.000000\x2C 643.000000\x2C NO</string>\r\t\t<string>0.000000\x2C 0.000000\x2C 1049.000000\x2C 643.000000\x2C NO</string>\r\t</array>\r\t<key>NSSplitView Subview Frames XCBuildPropertiesInspectorSplitView</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 417.000000\x2C 363.000000\x2C NO</string>\r\t\t<string>0.000000\x2C 373.000000\x2C 417.000000\x2C 97.000000\x2C NO</string>\r\t</array>\r\t<key>NSTableView Columns XCDistributedBuildsComputersTable</key>\r\t<array>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RyaW5nQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<string>114</string>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErEENvbXB1dGVyT1NDb2x1bW6G\r\t\t</data>\r\t\t<string>103</string>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErF0NvbXB1dGVyQ29tcGlsZXJzQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<string>152</string>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RhdHVzQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<string>77</string>\r\t</array>\r\t<key>NSTableView Hidden Columns XCDistributedBuildsComputersTable</key>\r\t<array/>\r\t<key>NSTableView Sort Ordering XCDistributedBuildsComputersTable</key>\r\t<array>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RhdHVzQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<true/>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RyaW5nQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<true/>\r\t</array>\r\t<key>NSToolbar Configuration PBXModule.PBXNavigatorGroup</key>\r\t<dict>\r\t\t<key>TB Display Mode</key>\r\t\t<integer>1</integer>\r\t\t<key>TB Icon Size Mode</key>\r\t\t<integer>1</integer>\r\t\t<key>TB Is Shown</key>\r\t\t<integer>0</integer>\r\t\t<key>TB Item Identifiers</key>\r\t\t<array>\r\t\t\t<string>active-combo-popup</string>\r\t\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t\t<string>debugger-enable-breakpoints</string>\r\t\t\t<string>build-and-go</string>\r\t\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t\t<string>toggle-editor-pin</string>\r\t\t\t<string>servicesModuleproject</string>\r\t\t</array>\r\t\t<key>TB Size Mode</key>\r\t\t<integer>1</integer>\r\t\t<key>TB Visibility Priority Values</key>\r\t\t<dict>\r\t\t\t<key>active-combo-popup</key>\r\t\t\t<array>\r\t\t\t\t<integer>1400</integer>\r\t\t\t</array>\r\t\t\t<key>build-and-go</key>\r\t\t\t<array>\r\t\t\t\t<integer>1600</integer>\r\t\t\t</array>\r\t\t\t<key>com.apple.ide.PBXToolbarStopButton</key>\r\t\t\t<array>\r\t\t\t\t<integer>1600</integer>\r\t\t\t</array>\r\t\t</dict>\r\t</dict>\r\t<key>NSWindow Frame DocResultsWindow</key>\r\t<string>208 178 1049 687 0 0 1440 878 </string>\r\t<key>NSWindow Frame HUDModule</key>\r\t<string>0 479 496 345 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXAddFilesOptionsPanel</key>\r\t<string>631 228 400 396 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXSaveMultiplePanel</key>\r\t<string>500 411 440 348 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXSimpleFinder</key>\r\t<string>50 850 642 181 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXTextFieldEntryModule</key>\r\t<string>527 680 386 143 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXWizardPanel</key>\r\t<string>353 225 733 596 0 0 1440 878 </string>\r\t<key>NSWindow Frame XCBinderWindowFrameKey</key>\r\t<string>50 541 949 637 0 0 1920 1178 </string>\r\t<key>NSWindow Frame XCStringEditorModule</key>\r\t<string>485 520 476 280 0 0 1440 878 </string>\r\t<key>NSWindow Frame XCStringListEditorModule</key>\r\t<string>42 520 476 280 0 0 1440 878 </string>\r\t<key>PBXActiveKeyBindings</key>\r\t<string>Xcode Default</string>\r\t<key>PBXApplicationwideBuildSettings</key>\r\t<dict/>\r\t<key>PBXAutoIndentCharacters</key>\r\t<string>{};:#\r\r</string>\r\t<key>PBXAutoInsertsCloseBrace</key>\r\t<string>NO</string>\r\t<key>PBXBuildLogShowAllResultsDefaultKey</key>\r\t<false/>\r\t<key>PBXBuildLogShowByStepViewDefaultKey</key>\r\t<false/>\r\t<key>PBXBuildLogShowsAllBuildSteps</key>\r\t<true/>\r\t<key>PBXBuildLogShowsAnalyzerResults</key>\r\t<true/>\r\t<key>PBXBuildLogShowsErrors</key>\r\t<true/>\r\t<key>PBXBuildLogShowsWarnings</key>\r\t<true/>\r\t<key>PBXCounterpartStaysInSameEditor</key>\r\t<string>YES</string>\r\t<key>PBXDebugger.ImageSymbolsv2.sys.level</key>\r\t<integer>2</integer>\r\t<key>PBXDebugger.ImageSymbolsv2.user.level</key>\r\t<integer>2</integer>\r\t<key>PBXDebugger.LazySymbolLoading</key>\r\t<true/>\r\t<key>PBXDebuggerOldLayout</key>\r\t<false/>\r\t<key>PBXDefaultTextLineEnding</key>\r\t<string>LF</string>\r\t<key>PBXDefaultTextLineEndingForSave</key>\r\t<string>LF</string>\r\t<key>PBXFileTypesToDocumentTypes</key>\r\t<dict>\r\t\t<key>file.xib</key>\r\t\t<string>Interface/Builder</string>\r\t\t<key>wrapper.nib</key>\r\t\t<string>Interface/Builder</string>\r\t</dict>\r\t<key>PBXFindIgnoreCase</key>\r\t<true/>\r\t<key>PBXFindMatchStyle</key>\r\t<string>Contains</string>\r\t<key>PBXFindType</key>\r\t<integer>0</integer>\r\t<key>PBXGlobalFindOptionsSets</key>\r\t<array>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Project</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Project and Frameworks</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In All Open Projects</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Selected Project Items</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Frameworks</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<true/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<false/>\r\t\t\t<key>name</key>\r\t\t\t<string>In All Open Files</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t</array>\r\t<key>PBXIndentWrappedLines</key>\r\t<string>YES</string>\r\t<key>PBXInspectorPanel Configuration</key>\r\t<dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInfoInspectorPanel.Contents</key>\r\t\t<dict>\r\t\t\t<key>inspectorPanes</key>\r\t\t\t<dict>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCCommentsInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCExecutableArgumentsInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCExecutableDebugSettingsInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCExecutableInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t</dict>\r\t\t\t<key>selectedTab</key>\r\t\t\t<string>Arguments</string>\r\t\t</dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInfoInspectorPanel.Geometry</key>\r\t\t<dict>\r\t\t\t<key>Frame</key>\r\t\t\t<string>{{0\x2C -1}\x2C {390\x2C 573}}</string>\r\t\t\t<key>RubberWindowFrame</key>\r\t\t\t<string>653 195 390 593 0 0 1440 878 </string>\r\t\t</dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInspectorPanel.Contents</key>\r\t\t<dict>\r\t\t\t<key>inspectorPanes</key>\r\t\t\t<dict/>\r\t\t</dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInspectorPanel.Geometry</key>\r\t\t<dict>\r\t\t\t<key>Frame</key>\r\t\t\t<string>{{0\x2C 0}\x2C {390\x2C 571}}</string>\r\t\t\t<key>RubberWindowFrame</key>\r\t\t\t<string>50 291 390 587 0 0 1440 878 </string>\r\t\t</dict>\r\t</dict>\r\t<key>PBXNavigatorGroupDefaultFrame</key>\r\t<string>{{84\x2C 117}\x2C {715\x2C 693}}</string>\r\t<key>PBXPreferencesContentSize</key>\r\t<string>{628\x2C 342}</string>\r\t<key>PBXPreferencesSelectedIndex</key>\r\t<integer>0</integer>\r\t<key>PBXSelectToInsideMatchingBraces</key>\r\t<string>NO</string>\r\t<key>PBXSelectToMatchingBrace</key>\r\t<string>YES</string>\r\t<key>PBXSelectedGlobalFindOptionsSet</key>\r\t<string>In Project</string>\r\t<key>PBXShowColumnPositionInLineBrowser</key>\r\t<true/>\r\t<key>PBXShowLineNumbers</key>\r\t<true/>\r\t<key>PBXShowPageGuide</key>\r\t<true/>\r\t<key>PBXShowsTextColorsWhenPrinting</key>\r\t<false/>\r\t<key>PBXSimpleFindMatchStyle</key>\r\t<string>Contains</string>\r\t<key>PBXSoloBraceIndentWidth</key>\r\t<integer>0</integer>\r\t<key>PBXSyntaxColoringEnabled</key>\r\t<true/>\r\t<key>PBXSyntaxColoringUseSeparateFonts</key>\r\t<string>NO</string>\r\t<key>PBXTabKeyIndentBehavior</key>\r\t<string>InLeadingWhitespace</string>\r\t<key>PBXTextEditorWrapsLines</key>\r\t<string>NO</string>\r\t<key>PBXTurnOffWindowConfigurations</key>\r\t<false/>\r\t<key>PBXUsesSyntaxAwareIndenting</key>\r\t<string>YES</string>\r\t<key>PBXUsesTabs</key>\r\t<string>YES</string>\r\t<key>PBXWrappedLineIndentWidth</key>\r\t<integer>4</integer>\r\t<key>PBX_autoOpenProjectEditor</key>\r\t<true/>\r\t<key>PMPrintingExpandedStateForPrint</key>\r\t<false/>\r\t<key>PerspectivesToolbar.com.apple.perspectives.project.defaultV3_2.PBXModule.XCPerspectiveModule.Project</key>\r\t<array>\r\t\t<string>XCToolbarPerspectiveControl</string>\r\t\t<string>NSToolbarSeparatorItem</string>\r\t\t<string>active-combo-popup</string>\r\t\t<string>action</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>debugger-enable-breakpoints</string>\r\t\t<string>build-and-go</string>\r\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t<string>get-info</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>com.apple.pbx.toolbar.searchfield</string>\r\t</array>\r\t<key>PerspectivesToolbar.com.apple.perspectives.project.mode1v3_2.PBXModule.XCPerspectiveModule.Project</key>\r\t<array>\r\t\t<string>active-combo-popup</string>\r\t\t<string>action</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>debugger-enable-breakpoints</string>\r\t\t<string>build-and-go</string>\r\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t<string>get-info</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>com.apple.pbx.toolbar.searchfield</string>\r\t</array>\r\t<key>PerspectivesToolbar.com.apple.perspectives.project.mode2v3_2.PBXModule.XCPerspectiveModule.Project</key>\r\t<array>\r\t\t<string>active-combo-popup</string>\r\t\t<string>debugger-enable-breakpoints</string>\r\t\t<string>build-and-go</string>\r\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>get-info</string>\r\t</array>\r\t<key>ShowsFoldingSidebar</key>\r\t<true/>\r\t<key>SyntaxColoringEnabled</key>\r\t<true/>\r\t<key>TSDefaultCStringEncoding</key>\r\t<string>4</string>\r\t<key>TabWidth</key>\r\t<integer>4</integer>\r\t<key>XCActivityViewerOpenKey</key>\r\t<false/>\r\t<key>XCAlignConsecutiveSlashSlashComments</key>\r\t<true/>\r\t<key>XCAssistantSelections</key>\r\t<dict>\r\t\t<key>PBXFileWizardChooserWizard</key>\r\t\t<string>macosx.platform/C and C++/C File</string>\r\t\t<key>PBXProjectWizardChooserWizard</key>\r\t\t<string>macosx.platform/Application/Command Line Tool</string>\r\t\t<key>PBXTargetWizardChooserWizard</key>\r\t\t<string>macosx.platform/BSD/Shell Tool</string>\r\t</dict>\r\t<key>XCBinderSideBarWidthKey</key>\r\t<real>212</real>\r\t<key>XCExternalEditorList</key>\r\t<dict>\r\t\t<key>Interface/Builder</key>\r\t\t<string>com.apple.Xcode.ExternalEditor.nib!@/Developer/Applications/Interface Builder.app</string>\r\t\t<key>emacs</key>\r\t\t<string>com.apple.Xcode.ExternalEditor.\?\?\?\?@/Applications/Utilities/Terminal.app</string>\r\t</dict>\r\t<key>XCHudWindowLocationRectString</key>\r\t<string>{{0\x2C 759}\x2C {144\x2C 65}}</string>\r\t<key>XCIndentSlashSlashComments</key>\r\t<false/>\r\t<key>XCLastBuildConfigurationInspected</key>\r\t<string>Debug</string>\r\t<key>XCLastFilterSelected</key>\r\t<integer>0</integer>\r\t<key>XCMultiWizardProxymacosx.platform/Application/Command Line Tool</key>\r\t<string>Standard</string>\r\t<key>XCProjectWindowToolbarDisplayMode</key>\r\t<integer>1</integer>\r\t<key>XCProjectWindowToolbarSizeMode</key>\r\t<integer>1</integer>\r\t<key>XCReopenProjects</key>\r\t<false/>\r\t<key>XCShowSplashScreen</key>\r\t<false/>\r\t<key>XCSmartClosingBrackets</key>\r\t<true/>\r\t<key>XCUseBonjourDistributedBuildServers</key>\r\t<true/>\r\t<key>XCUserBreakpoints</key>\r\t<data>\r\tLy8gISQqVVRGOCokIQp7CglhcmNoaXZlVmVyc2lvbiA9IDE7CgljbGFzc2VzID0gewoJ\r\tfTsKCW9iamVjdHMgPSB7CgovKiBCZWdpbiBYQ0JyZWFrcG9pbnRzQnVja2V0IHNlY3Rp\r\tb24gKi8KCQk0OUQ2MTg2QTEwNkU5REQzMDBGNTIzQUEgLyogWENCcmVha3BvaW50c0J1\r\tY2tldCAqLyA9IHsKCQkJaXNhID0gWENCcmVha3BvaW50c0J1Y2tldDsKCQkJbmFtZSA9\r\tICJHbG9iYWwgQnJlYWtwb2ludHMiOwoJCQlvYmplY3RzID0gKAoJCQkpOwoJCX07Ci8q\r\tIEVuZCBYQ0JyZWFrcG9pbnRzQnVja2V0IHNlY3Rpb24gKi8KCX07Cglyb290T2JqZWN0\r\tID0gNDlENjE4NkExMDZFOUREMzAwRjUyM0FBIC8qIFhDQnJlYWtwb2ludHNCdWNrZXQg\r\tKi87Cn0K\r\t</data>\r\t<key>XC_PerspectiveExtension_ver3</key>\r\t<string>mode1v3</string>\r\t<key>XC_PerspectiveIdentifier_ver3</key>\r\t<string>com.apple.perspectives.project.mode1v3</string>\r\t<key>XcodeDefaultsVersion</key>\r\t<integer>20</integer>\r\t<key>com.apple.ide.smrt.PBXUserSmartGroupsKey.Rev10</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhA5OU011dGFibGVBcnJheQCEhAdOU0FycmF5AISE\r\tCE5TT2JqZWN0AIWEAWkCkoSEhBNOU011dGFibGVEaWN0aW9uYXJ5AISEDE5TRGljdGlv\r\tbmFyeQCVlgeShISECE5TU3RyaW5nAZWEASsZUEJYVHJhbnNpZW50TG9jYXRpb25BdFRv\r\tcIaShJqaBmJvdHRvbYaShJqaA2NseoaShJqaFVBCWEZpbGVuYW1lU21hcnRHcm91cIaS\r\thJqaC3ByZWZlcmVuY2VzhpKEl5YHkoSamgZpc0xlYWaGkoSEhAhOU051bWJlcgCEhAdO\r\tU1ZhbHVlAJWEASqElpYAhpKEmpoJcmVjdXJzaXZlhpKEop2klgGGkoSamgRyb290hpKE\r\tmpoJPFBST0pFQ1Q+hpKEmpoFaW1hZ2WGkoSamgtTbWFydEZvbGRlcoaShJqaB2NhblNh\r\tdmWGkqaShJqaBXJlZ2V4hpKEmpooXC4oY3xjcHxjcHB8Q3xDUHxDUFB8bXxtbXxqYXZh\r\tfHNofHNjcHQpJIaShJqaB2ZubWF0Y2iGkoSamgCGhpKEmpoUYWJzb2x1dGVQYXRoVG9C\r\tdW5kbGWGkq+ShJqaC2Rlc2NyaXB0aW9uhpKEmpoQPG5vIGRlc2NyaXB0aW9uPoaShJqa\r\tBG5hbWWGkoSamhRJbXBsZW1lbnRhdGlvbiBGaWxlc4aShJqaCGdsb2JhbElEhpKEmpoY\r\tMUNDMEVBNDAwNDM1MEVGOTAwNDQ0MTBChoaShJeWB5KEmpoEbmFtZYaShJqaF0ludGVy\r\tZmFjZSBCdWlsZGVyIEZpbGVzhpKEmpoZUEJYVHJhbnNpZW50TG9jYXRpb25BdFRvcIaS\r\thJqaBmJvdHRvbYaShJqaC3ByZWZlcmVuY2VzhpKEl5YHkoSamgZpc0xlYWaGkqGShJqa\r\tCXJlY3Vyc2l2ZYaSppKEmpoEcm9vdIaShJqaCTxQUk9KRUNUPoaShJqaBWltYWdlhpKE\r\tmpoLU21hcnRGb2xkZXKGkoSamgdjYW5TYXZlhpKmkoSamgVyZWdleIaSr5KEmpoHZm5t\r\tYXRjaIaShJqaCCouW254XWlihoaShJqaFGFic29sdXRlUGF0aFRvQnVuZGxlhpKEmpoA\r\thpKEmpoLZGVzY3JpcHRpb26GkoSamhA8bm8gZGVzY3JpcHRpb24+hpKEmpoIZ2xvYmFs\r\tSUSGkoSamhgxQ0MwRUE0MDA0MzUwRUY5MDA0MTExMEKGkoSamgNjbHqGkoSamhVQQlhG\r\taWxlbmFtZVNtYXJ0R3JvdXCGhoY\x3D\r\t</data>\r\t<key>kDSMBookmarkManagerAllBookmarksUserDefaultsKey</key>\r\t<array>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>Map (Java Platform SE 6)</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>ArrayList (Java Platform SE 6)</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleLegacy.CoreReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>Java 2 Platform SE v1.3.1: Class String</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>Queue (Java 2 Platform SE 5.0_19)</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>String (Java Platform SE 6)</string>\r\t\t</dict>\r\t</array>\r\t<key>kSearchResultsSubviewWidthAsString</key>\r\t<real>200</real>\r\t<key>kXCDocCheckAndInstallUpdatesAutomatically</key>\r\t<string>1</string>\r\t<key>searchMatchType</key>\r\t<integer>1</integer>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant


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
