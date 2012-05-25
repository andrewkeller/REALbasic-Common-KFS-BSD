#tag Class
Protected Class TestAggregatingResourceManagerKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Sets up all of the test cases.
		  
		  Dim neverCache As CachableCriteriaKFS = New CachableCriteriaKFS_NeverCache
		  Dim alwaysCache As CachableCriteriaKFS = New CachableCriteriaKFS_AlwaysCache
		  Dim emptyStringArray(-1) As String
		  
		  // No aggregates:
		  
		  AddFetchTest New AggregatingResourceManagerKFS, "foo", False, Nil, Nil, "the aggregator had no aggregates"
		  AddGetTest New AggregatingResourceManagerKFS, "foo", False, Nil, "the aggregator had no aggregates"
		  AddHasKeyTest New AggregatingResourceManagerKFS, "foo", False, "the aggregator had no aggregates"
		  AddListKeysAsStringTest New AggregatingResourceManagerKFS, emptyStringArray, "the aggregator had no aggregates"
		  AddLookupTest New AggregatingResourceManagerKFS, "foo", "bar", False, "bar", "the aggregator had no aggregates"
		  
		  // 1 aggregate with no keys:
		  
		  AddFetchTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS ), _
		  "foo", False, Nil, alwaysCache, "the aggregator had 1 aggregate with no keys"
		  AddGetTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS ), _
		  "foo", False, Nil, "the aggregator had 1 aggregate with no keys"
		  AddHasKeyTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS ), _
		  "foo", False, "the aggregator had 1 aggregate with no keys"
		  AddListKeysAsStringTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS ), _
		  emptyStringArray, "the aggregator had 1 aggregate with no keys"
		  AddLookupTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS ), _
		  "foo", "bar", False, "bar", "the aggregator had 1 aggregate with no keys"
		  
		  // 1 aggregate, key found:
		  
		  AddFetchTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 42 ))), _
		  "foo", True, 42, alwaysCache, "the aggregator had 1 aggregate, and it had had the requested key"
		  AddGetTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 42 ))), _
		  "foo", True, 42, "the aggregator had 1 aggregate, and it had had the requested key"
		  AddHasKeyTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 42 ))), _
		  "foo", True, "the aggregator had 1 aggregate, and it had had the requested key"
		  AddListKeysAsStringTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 42 ))), _
		  Array("foo"), "the aggregator had 1 aggregate with a single key, 'foo'."
		  AddLookupTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 42 ))), _
		  "foo", 3, True, 42, "the aggregator had 1 aggregate, and it had had the requested key"
		  
		  // 1 aggregate, key not found:
		  
		  AddFetchTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "fish" : 17 ))), _
		  "foo", False, 17, alwaysCache, "the aggregator had 1 aggregate, and it did not have the requested key"
		  AddGetTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "fish" : 17 ))), _
		  "foo", False, 17, "the aggregator had 1 aggregate, and it did not have the requested key"
		  AddHasKeyTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "fish" : 17 ))), _
		  "foo", False, "the aggregator had 1 aggregate, and it did not have the requested key"
		  AddListKeysAsStringTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "fish" : 17 ))), _
		  Array("fish"), "the aggregator had 1 aggregate with a single key, 'fish'."
		  AddLookupTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "fish" : 17 ))), _
		  "foo", 3, False, 3, "the aggregator had 1 aggregate, and it did not have the requested key"
		  
		  // 2 aggregates, key found in first:
		  
		  AddFetchTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "foo", True, 17, alwaysCache, "the aggregator had 2 aggregates, both of which had the requested key"
		  AddGetTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "foo", True, 17, "the aggregator had 2 aggregates, both of which had the requested key"
		  AddHasKeyTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "foo", True, "the aggregator had 2 aggregates, both of which had the requested key"
		  AddListKeysAsStringTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  Array("foo", "bar", "fish" ), "the aggregator had 2 aggregates, each with 2 keys, one of which was common ('foo')"
		  AddLookupTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "foo", 3, True, 17, "the aggregator had 2 aggregates, both of which had the requested key"
		  
		  // 2 aggregates, key found in second:
		  
		  AddFetchTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "fish", True, 12, alwaysCache, "the aggregator had 2 aggregates, the second of which had the requested key"
		  AddGetTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "fish", True, 12, "the aggregator had 2 aggregates, the second of which had the requested key"
		  AddHasKeyTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "fish", True, "the aggregator had 2 aggregates, the second of which had the requested key"
		  AddListKeysAsStringTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  Array("foo", "bar", "fish" ), "the aggregator had 2 aggregates, each with 2 keys, one of which was common ('foo')"
		  AddLookupTest New AggregatingResourceManagerKFS( New SimpleResourceManagerKFS( New Dictionary( "foo" : 17, "bar" : 25 )), New SimpleResourceManagerKFS( New Dictionary( "foo" : 42, "fish" : 12 ))), _
		  "fish", 3, True, 12, "the aggregator had 2 aggregates, the second of which had the requested key"
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub AddFetchTest(obj As ResourceManagerKFS, key As String, expectHasKey As Boolean, expectedValue As Variant, expectedCachingCriteria As CachableCriteriaKFS, scenarioDesc As String)
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Defines a new test case with the given characteristics.
		  
		  Static testCaseNumber As Integer = 0
		  testCaseNumber = testCaseNumber + 1
		  Dim testCaseName As String = "TestFetch_" + Format( testCaseNumber, "0" )
		  
		  Call DefineVirtualTestCase testCaseName, ClosuresKFS.NewClosure_From_Dictionary( AddressOf GenericFetchTest, New Dictionary( _
		  "obj" : obj, _
		  "key" : key, _
		  "expectHasKey" : expectHasKey, _
		  "expectedValue" : expectedValue, _
		  "expectedCachingCriteria" : expectedCachingCriteria, _
		  "scenarioDesc" : scenarioDesc ))
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddGetTest(obj As ResourceManagerKFS, key As String, expectHasKey As Boolean, expectedValue As Variant, scenarioDesc As String)
		  // Created 5/23/2012 by Andrew Keller
		  
		  // Defines a new test case with the given characteristics.
		  
		  Static testCaseNumber As Integer = 0
		  testCaseNumber = testCaseNumber + 1
		  Dim testCaseName As String = "TestGet_" + Format( testCaseNumber, "0" )
		  
		  Call DefineVirtualTestCase testCaseName, ClosuresKFS.NewClosure_From_Dictionary( AddressOf GenericGetTest, New Dictionary( _
		  "obj" : obj, _
		  "key" : key, _
		  "expectHasKey" : expectHasKey, _
		  "expectedValue" : expectedValue, _
		  "scenarioDesc" : scenarioDesc ))
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddHasKeyTest(obj As ResourceManagerKFS, key As String, expectHasKey As Boolean, scenarioDesc As String)
		  // Created 5/23/2012 by Andrew Keller
		  
		  // Defines a new test case with the given characteristics.
		  
		  Static testCaseNumber As Integer = 0
		  testCaseNumber = testCaseNumber + 1
		  Dim testCaseName As String = "TestHasKey_" + Format( testCaseNumber, "0" )
		  
		  Call DefineVirtualTestCase testCaseName, ClosuresKFS.NewClosure_From_Dictionary( AddressOf GenericHasKeyTest, New Dictionary( _
		  "obj" : obj, _
		  "key" : key, _
		  "expectHasKey" : expectHasKey, _
		  "scenarioDesc" : scenarioDesc ))
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddListKeysAsStringTest(obj As ResourceManagerKFS, expectedValue() As String, scenarioDesc As String)
		  // Created 5/23/2012 by Andrew Keller
		  
		  // Defines a new test case with the given characteristics.
		  
		  Static testCaseNumber As Integer = 0
		  testCaseNumber = testCaseNumber + 1
		  Dim testCaseName As String = "TestListKeysAsString_" + Format( testCaseNumber, "0" )
		  
		  Call DefineVirtualTestCase testCaseName, ClosuresKFS.NewClosure_From_Dictionary( AddressOf GenericListKeysAsStringTest, New Dictionary( _
		  "obj" : obj, _
		  "expectedValue" : expectedValue, _
		  "scenarioDesc" : scenarioDesc ))
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddLookupTest(obj As ResourceManagerKFS, key As String, defaultValue As Variant, expectHasKey As Boolean, expectedValue As Variant, scenarioDesc As String)
		  // Created 5/23/2012 by Andrew Keller
		  
		  // Defines a new test case with the given characteristics.
		  
		  Static testCaseNumber As Integer = 0
		  testCaseNumber = testCaseNumber + 1
		  Dim testCaseName As String = "TestLookup_" + Format( testCaseNumber, "0" )
		  
		  Call DefineVirtualTestCase testCaseName, ClosuresKFS.NewClosure_From_Dictionary( AddressOf GenericLookupTest, New Dictionary( _
		  "obj" : obj, _
		  "key" : key, _
		  "defaultValue" : defaultValue, _
		  "expectHasKey" : expectHasKey, _
		  "expectedValue" : expectedValue, _
		  "scenarioDesc" : scenarioDesc ))
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ArrayDescription(s() As String) As String
		  // Created 5/23/2012 by Andrew Keller
		  
		  // Returns a textual version of the given array.
		  
		  If s Is Nil Then
		    
		    Return "Nil"
		    
		  ElseIf UBound( s ) < 0 Then
		    
		    Return "[ ]"
		    
		  Else
		    
		    Return "[ """ + Join( s, """, """ ) + """ ]"
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertEquals(expected() As String, found() As String, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/23/2012 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Equal( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Equal(expected() As String, found() As String, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 5/23/2012 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given two string arrays are equal.
		  
		  Dim expected_str As String = ArrayDescription( expected )
		  Dim found_str As String = ArrayDescription( found )
		  
		  If expected_str = found_str Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, expected_str, found_str, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenericFetchTest(params As Dictionary)
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Performs a generic Fetch test based on the given parameters.
		  
		  Dim obj As ResourceManagerKFS = params.Value( "obj" )
		  Dim key As String = params.Value( "key" )
		  Dim expectHasKey As Boolean = params.Value( "expectHasKey" )
		  Dim expectedValue As Variant = params.Value( "expectedValue" )
		  Dim expectedCachingCriteria As CachableCriteriaKFS = params.Value( "expectedCachingCriteria" )
		  Dim scenarioDesc As String = params.Value( "scenarioDesc" )
		  
		  Dim v As Variant = 42
		  Dim pc As CachableCriteriaKFS = New CachableCriteriaKFS_AlwaysCache
		  Dim pc_bkup As CachableCriteriaKFS = pc
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Boolean
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = obj.Fetch( key, v, pc )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  AssertNotSame 42, v, "The Fetch method was supposed to change the value parameter from what it was.", False
		  AssertNotSame pc_bkup, pc, "The Fetch method was supposed to change the cachableCriteria parameter from what it was.", False
		  
		  If PresumeIsNil( caught_err, "The Fetch method should never raise an exception when " + scenarioDesc + "." ) Then
		    If expectHasKey Then
		      AssertEquals expectHasKey, fn_rslt, "The Fetch method was supposed to return " + Str(expectHasKey) + " when " + scenarioDesc + ".", False
		      AssertEquals expectedValue, v, "The Fetch method was supposed to set the value parameter to " + ObjectDescriptionKFS(expectedValue) + " when " + scenarioDesc + "."
		      If PresumeNotIsNil( pc, "The Fetch method was supposed to set the cachableCriteria parameter to an object reporting " + Str(expectedCachingCriteria.IsCachable) + " when " + scenarioDesc + "." ) Then
		        AssertEquals expectedCachingCriteria.IsCachable, pc.IsCachable, "The Fetch method was supposed to set the cachableCriteria parameter to an object reporting " + ObjectDescriptionKFS(expectedCachingCriteria.IsCachable) + " when " + scenarioDesc + "."
		      End If
		    Else
		      AssertFalse fn_rslt, "The Fetch method was supposed to return False.", False
		      AssertIsNil v, "The Fetch method was supposed to set the value parameter to Nil.", False
		      AssertIsNil pc, "The Fetch method was supposed to set the cachableCriteria parameter to Nil.", False
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenericGetTest(params As Dictionary)
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Performs a generic Get test based on the given parameters.
		  
		  Dim obj As ResourceManagerKFS = params.Value( "obj" )
		  Dim key As String = params.Value( "key" )
		  Dim expectHasKey As Boolean = params.Value( "expectHasKey" )
		  Dim expectedValue As Variant = params.Value( "expectedValue" )
		  Dim scenarioDesc As String = params.Value( "scenarioDesc" )
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = obj.Get( key )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If expectHasKey Then
		    
		    If PresumeIsNil( caught_err, "The Get method should not raise an exception when " + scenarioDesc + "." ) Then
		      AssertEquals expectedValue, fn_rslt, "The Get method was supposed to return " + Str(expectHasKey) + " when " + scenarioDesc + ".", False
		    End If
		    
		  Else
		    
		    If PresumeNotIsNil( caught_err, "The Get method was supposed to raise an exception when " + scenarioDesc + "." ) Then
		      If PresumeTrue( caught_err IsA ResourceNotFoundInManagerException, "The Get method was supposed to raise a ResourceNotFoundInManagerException when " + scenarioDesc + "." ) Then
		        AssertEquals key, ResourceNotFoundInManagerException( caught_err ).OffendingKey, "The Get method was supposed to set the OffendingKey property of the exception to """ + key + """.", False
		      End If
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenericHasKeyTest(params As Dictionary)
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Performs a generic HasKey test based on the given parameters.
		  
		  Dim obj As ResourceManagerKFS = params.Value( "obj" )
		  Dim key As String = params.Value( "key" )
		  Dim expectHasKey As Boolean = params.Value( "expectHasKey" )
		  Dim scenarioDesc As String = params.Value( "scenarioDesc" )
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Boolean
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = obj.HasKey( key )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The HasKey method should never raise an exception when " + scenarioDesc + "." ) Then
		    AssertEquals expectHasKey, fn_rslt, "The HasKey method was supposed to return " + Str(expectHasKey) + " when " + scenarioDesc + ".", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenericListKeysAsStringTest(params As Dictionary)
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Performs a generic ListKeysAsArray test based on the given parameters.
		  
		  Dim obj As ResourceManagerKFS = params.Value( "obj" )
		  Dim expectedValue() As String = params.Value( "expectedValue" )
		  Dim scenarioDesc As String = params.Value( "scenarioDesc" )
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt() As String
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = obj.ListKeysAsArray
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The ListKeysAsArray method should never raise an exception when " + scenarioDesc + "." ) Then
		    
		    AssertEquals expectedValue, fn_rslt, "The ListKeysAsArray method was supposed to return " + ArrayDescription(expectedValue) + " when " + scenarioDesc + ".", False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GenericLookupTest(params As Dictionary)
		  // Created 5/22/2012 by Andrew Keller
		  
		  // Performs a generic Lookup test based on the given parameters.
		  
		  Dim obj As ResourceManagerKFS = params.Value( "obj" )
		  Dim key As String = params.Value( "key" )
		  Dim defaultValue As String = params.Value( "defaultValue" )
		  Dim expectHasKey As Boolean = params.Value( "expectHasKey" )
		  Dim expectedValue As Variant = params.Value( "expectedValue" )
		  Dim scenarioDesc As String = params.Value( "scenarioDesc" )
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = obj.Lookup( key, defaultValue )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Lookup method should never raise an exception when " + scenarioDesc + "." ) Then
		    If expectHasKey Then
		      
		      AssertEquals expectedValue, fn_rslt, "The Lookup method was supposed to return " + Str(expectHasKey) + " (the retrieved value) when " + scenarioDesc + ".", False
		      
		    Else
		      
		      AssertEquals defaultValue, fn_rslt, "The Lookup method was supposed to return " + Str(expectHasKey) + " (the default value) when " + scenarioDesc + ".", False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeEquals(expected() As String, found() As String, failureMessage As String = "") As Boolean
		  // Created 5/23/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given values are not equal.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Equal( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
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
		
		Copyright (c) 2012 Andrew Keller.
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
