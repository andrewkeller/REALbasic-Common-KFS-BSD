#tag Module
Protected Module UnitTestingKFS
	#tag Method, Flags = &h21
		Private Function DefaultTests() As UnitTestingKFS.TestClass()
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns a list of the classes with test cases.
		  
		  Dim result() As UnitTestingKFS.TestClass
		  
		  result.Append New BSDGlobalsKFS_Data.TestDeepDictionaryFunctions
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExecuteTest(subject As UnitTestingKFS.TestClass, topic As Introspection.MethodInfo) As RuntimeException
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Executes tests in the given test class and returns any error that occurs.
		  
		  Try
		    
		    topic.Invoke subject
		    
		  Catch err
		    
		    Return err
		    
		  End Try
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecuteTests(subjects() As UnitTestingKFS.TestClass)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects.
		  
		  If UBound( subjects ) < 0 Then
		    
		    // No objects were provided, so inject the list
		    // of objects for the testing of this library.
		    
		    subjects = DefaultTests
		    
		  End If
		  
		  // Execute the tests
		  
		  Dim results As New Dictionary
		  
		  For Each subject As UnitTestingKFS.TestClass In subjects
		    
		    For Each item As Introspection.MethodInfo In subject.GetTestMethods
		      
		      results.Value( subject.GetClassName + "#" + item.Name ) = ExecuteTest( subject, item )
		      
		    Next
		    
		  Next
		  
		  // Save the results.
		  
		  TestResults = results
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExecuteTests(ParamArray subjects As UnitTestingKFS.TestClass)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Finds and executes test cases in the given objects.
		  
		  ExecuteTests subjects
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected TestResults As Dictionary
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
End Module
#tag EndModule
