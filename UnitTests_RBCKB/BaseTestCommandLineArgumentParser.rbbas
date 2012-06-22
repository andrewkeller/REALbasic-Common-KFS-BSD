#tag Class
Protected Class BaseTestCommandLineArgumentParser
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertBlowsUp(expectedErrorCode As Integer, method As MethodReturningString, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises an exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As String
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found """ + fn_rslt + """.", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.CommandLineArgumentParserException Then
		    
		    AssertEquals expectedErrorCode, caught_err.ErrorNumber, failureMessage + " An exception of the correct type was raised, but it had the wrong error code.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type CommandLineArgumentParserException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNextItemValueEquals(expected_field As ParserFields, expected_value As String, found As CommandLineArgumentsKFS.CommandLineArgumentParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the next item in the parser has the expected characteristics.
		  
		  PushMessageStack failureMessage
		  
		  PushMessageStack "Testing the initial state of the fields:"
		  AssertEquals ParserFields.AppInvocationString = expected_field, found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertEquals ParserFields.Flag = expected_field, found.HasNextFlag, "HasNextFlag"
		  AssertEquals ParserFields.AttachedParcel = expected_field, found.HasNextAttachedParcel, "HasNextAttachedParcel"
		  AssertEquals ParserFields.Parcel = expected_field, found.HasNextParcel, "HasNextParcel"
		  AssertTrue found.HasNextSomething, "HasNextSomething"
		  PopMessageStack
		  
		  PushMessageStack "Peeking/Getting the values of the fields:"
		  
		  If ParserFields.AppInvocationString = expected_field Then
		    AssertEquals expected_value, found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		  Else
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotTheAppInvocationString, AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotTheAppInvocationString, AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  End If
		  
		  If ParserFields.Flag = expected_field Then
		    AssertEquals expected_value, found.PeekNextFlag, "PeekNextFlag"
		  Else
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotAFlag, AddressOf found.PeekNextFlag, "PeekNextFlag"
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotAFlag, AddressOf found.GetNextFlag, "GetNextFlag"
		  End If
		  
		  If ParserFields.AttachedParcel = expected_field Then
		    AssertEquals expected_value, found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		  Else
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotAnAttachedParcel, AddressOf found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotAnAttachedParcel, AddressOf found.GetNextAttachedParcel, "GetNextAttachedParcel"
		  End If
		  
		  If ParserFields.Parcel = expected_field Then
		    AssertEquals expected_value, found.PeekNextParcel, "PeekNextParcel"
		  Else
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotAParcel, AddressOf found.PeekNextParcel, "PeekNextParcel"
		    AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNextItemIsNotAParcel, AddressOf found.GetNextParcel, "GetNextParcel"
		  End If
		  
		  PushMessageStack "Testing afterward:"
		  AssertEquals ParserFields.AppInvocationString = expected_field, found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertEquals ParserFields.Flag = expected_field, found.HasNextFlag, "HasNextFlag"
		  AssertEquals ParserFields.AttachedParcel = expected_field, found.HasNextAttachedParcel, "HasNextAttachedParcel"
		  AssertEquals ParserFields.Parcel = expected_field, found.HasNextParcel, "HasNextParcel"
		  AssertTrue found.HasNextSomething, "HasNextSomething"
		  PopMessageStack
		  PopMessageStack
		  
		  PushMessageStack "Getting the value of the requested field:"
		  
		  If ParserFields.AppInvocationString = expected_field Then
		    AssertEquals expected_value, found.GetNextAppInvocationString
		  ElseIf ParserFields.Flag = expected_field Then
		    AssertEquals expected_value, found.GetNextFlag
		  ElseIf ParserFields.AttachedParcel = expected_field Then
		    AssertEquals expected_value, found.GetNextAttachedParcel
		  ElseIf ParserFields.Parcel = expected_field Then
		    AssertEquals expected_value, found.GetNextParcel
		  End If
		  
		  PopMessageStack
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNoItemsLeft(found As CommandLineArgumentsKFS.CommandLineArgumentParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the given parser has no elements left.
		  
		  PushMessageStack failureMessage
		  
		  AssertFalse found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertFalse found.HasNextFlag, "HasNextFlag"
		  AssertFalse found.HasNextAttachedParcel, "HasNextAttachedParcel"
		  AssertFalse found.HasNextParcel, "HasNextParcel"
		  AssertFalse found.HasNextSomething, "HasNextSomething"
		  
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.PeekNextFlag, "PeekNextFlag"
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.PeekNextParcel, "PeekNextParcel"
		  
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.GetNextFlag, "GetNextFlag"
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.GetNextAttachedParcel, "GetNextAttachedParcel"
		  AssertBlowsUp CommandLineArgumentsKFS.CommandLineArgumentParserException.kErrorCodeNoNextItem, AddressOf found.GetNextParcel, "GetNextParcel"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningString() As String
	#tag EndDelegateDeclaration


	#tag Enum, Name = ParserFields, Flags = &h0
		AppInvocationString
		  Flag
		  AttachedParcel
		Parcel
	#tag EndEnum


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
