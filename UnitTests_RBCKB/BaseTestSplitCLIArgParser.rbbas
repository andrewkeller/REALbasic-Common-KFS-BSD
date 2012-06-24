#tag Class
Protected Class BaseTestSplitCLIArgParser
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, found As CommandLineArgumentsKFS.CommandLineArgumentParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Asserts that the given parser should raise an exception on any of the Has/Peek/Get methods.
		  
		  PushMessageStack failureMessage
		  
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextAppInvocationString, "HasNextAppInvocationString"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextFlag, "HasNextFlag"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextAttachedParcel, "HasNextAttachedParcel"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextParcel, "HasNextParcel"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextSomething, "HasNextSomething"
		  
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextFlag, "PeekNextFlag"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextParcel, "PeekNextParcel"
		  
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.GetNextFlag, "GetNextFlag"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.GetNextAttachedParcel, "GetNextAttachedParcel"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.GetNextParcel, "GetNextParcel"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, method As MethodReturningBoolean, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a MissingFlagForAttachedParcelException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As Boolean
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.MissingFlagForAttachedParcelException Then
		    
		    AssertEquals expectedOffendingArgument, CommandLineArgumentsKFS.MissingFlagForAttachedParcelException(caught_err).OffendingArgument, failureMessage + " An exception of the correct type was raised, but it had the wrong Offending Argument.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type MissingFlagForAttachedParcelException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, method As MethodReturningString, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a MissingFlagForAttachedParcelException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As String
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.MissingFlagForAttachedParcelException Then
		    
		    AssertEquals expectedOffendingArgument, CommandLineArgumentsKFS.MissingFlagForAttachedParcelException(caught_err).OffendingArgument, failureMessage + " An exception of the correct type was raised, but it had the wrong Offending Argument.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type MissingFlagForAttachedParcelException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_NoItemsLeft(method As MethodReturningString, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a ParserExahustedException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As String
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.ParserExahustedException Then
		    
		    // This is good.
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type ParserExahustedException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_NoSuchNextItem(expectedErrorCode As Integer, method As MethodReturningBoolean, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a NoSuchNextItemException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As Boolean
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.NoSuchNextItemException Then
		    
		    AssertEquals expectedErrorCode, caught_err.ErrorNumber, failureMessage + " An exception of the correct type was raised, but it had the wrong error code.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type NoSuchNextItemException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_NoSuchNextItem(expectedErrorCode As Integer, method As MethodReturningString, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a NoSuchNextItemException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As String
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CommandLineArgumentsKFS.NoSuchNextItemException Then
		    
		    AssertEquals expectedErrorCode, caught_err.ErrorNumber, failureMessage + " An exception of the correct type was raised, but it had the wrong error code.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type NoSuchNextItemException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
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
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotTheAppInvocationString, AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotTheAppInvocationString, AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  End If
		  
		  If ParserFields.Flag = expected_field Then
		    AssertEquals expected_value, found.PeekNextFlag, "PeekNextFlag"
		  Else
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotAFlag, AddressOf found.PeekNextFlag, "PeekNextFlag"
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotAFlag, AddressOf found.GetNextFlag, "GetNextFlag"
		  End If
		  
		  If ParserFields.AttachedParcel = expected_field Then
		    AssertEquals expected_value, found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		  Else
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotAnAttachedParcel, AddressOf found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotAnAttachedParcel, AddressOf found.GetNextAttachedParcel, "GetNextAttachedParcel"
		  End If
		  
		  If ParserFields.Parcel = expected_field Then
		    AssertEquals expected_value, found.PeekNextParcel, "PeekNextParcel"
		  Else
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotAParcel, AddressOf found.PeekNextParcel, "PeekNextParcel"
		    AssertException_NoSuchNextItem CommandLineArgumentsKFS.NoSuchNextItemException.kErrorCodeNextItemIsNotAParcel, AddressOf found.GetNextParcel, "GetNextParcel"
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
		  
		  AssertException_NoItemsLeft AddressOf found.PeekNextAppInvocationString, "PeekNextAppInvocationString"
		  AssertException_NoItemsLeft AddressOf found.PeekNextFlag, "PeekNextFlag"
		  AssertException_NoItemsLeft AddressOf found.PeekNextAttachedParcel, "PeekNextAttachedParcel"
		  AssertException_NoItemsLeft AddressOf found.PeekNextParcel, "PeekNextParcel"
		  
		  AssertException_NoItemsLeft AddressOf found.GetNextAppInvocationString, "GetNextAppInvocationString"
		  AssertException_NoItemsLeft AddressOf found.GetNextFlag, "GetNextFlag"
		  AssertException_NoItemsLeft AddressOf found.GetNextAttachedParcel, "GetNextAttachedParcel"
		  AssertException_NoItemsLeft AddressOf found.GetNextParcel, "GetNextParcel"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningBoolean() As Boolean
	#tag EndDelegateDeclaration

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
