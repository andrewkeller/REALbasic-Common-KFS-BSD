#tag Class
Protected Class BaseTestCLIArgsArgParser
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, found As CLIArgsKFS.Parser.ArgParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Asserts that the given parser should raise an exception on any of the Has/Peek/Get methods.
		  
		  PushMessageStack failureMessage
		  
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.GetNextItemValue, "GetNextItemValue"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextItem, "HasNextItem"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextItemType, "PeekNextItemType"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextItemValue, "PeekNextItemValue"
		  
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
		    
		  ElseIf caught_err IsA CLIArgsKFS.Parser.MissingFlagForAttachedParcelException Then
		    
		    AssertEquals expectedOffendingArgument, CLIArgsKFS.Parser.MissingFlagForAttachedParcelException(caught_err).OffendingArgument, failureMessage + " An exception of the correct type was raised, but it had the wrong Offending Argument.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type MissingFlagForAttachedParcelException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, method As MethodReturningField, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a MissingFlagForAttachedParcelException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As CLIArgsKFS.Parser.Fields
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CLIArgsKFS.Parser.MissingFlagForAttachedParcelException Then
		    
		    AssertEquals expectedOffendingArgument, CLIArgsKFS.Parser.MissingFlagForAttachedParcelException(caught_err).OffendingArgument, failureMessage + " An exception of the correct type was raised, but it had the wrong Offending Argument.", isTerminal
		    
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
		    
		  ElseIf caught_err IsA CLIArgsKFS.Parser.MissingFlagForAttachedParcelException Then
		    
		    AssertEquals expectedOffendingArgument, CLIArgsKFS.Parser.MissingFlagForAttachedParcelException(caught_err).OffendingArgument, failureMessage + " An exception of the correct type was raised, but it had the wrong Offending Argument.", isTerminal
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type MissingFlagForAttachedParcelException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_NoItemsLeft(method As MethodReturningField, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a ParserExahustedException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As CLIArgsKFS.Parser.Fields
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    fn_rslt = method.Invoke
		    
		  Catch err As RuntimeException
		    
		    caught_err = err
		    
		  End Try
		  
		  If caught_err Is Nil Then
		    
		    AssertFailure failureMessage, "Expected an exception but found " + ObjectDescriptionKFS( fn_rslt ) + ".", isTerminal
		    
		  ElseIf caught_err IsA CLIArgsKFS.Parser.ParserExahustedException Then
		    
		    // This is good.
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type ParserExahustedException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
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
		    
		  ElseIf caught_err IsA CLIArgsKFS.Parser.ParserExahustedException Then
		    
		    // This is good.
		    
		  Else
		    
		    AssertFailure failureMessage, "Expected an exception of type ParserExahustedException but found an exception of type " + Introspection.GetType(caught_err).Name + ".", isTerminal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNextItemValueEquals(expected_field As ParserFields, expected_value As String, found As CLIArgsKFS.Parser.ArgParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the next item in the parser has the expected characteristics.
		  
		  PushMessageStack failureMessage
		  
		  PushMessageStack "Checking the values of the fields:"
		  
		  AssertTrue found.HasNextItem, "HasNextItem"
		  AssertEquals expected_field, found.PeekNextItemType, "PeekNextItemType"
		  AssertEquals expected_value, found.PeekNextItemValue, "PeekNextItemValue"
		  AssertEquals expected_value, found.GetNextItemValue, "GetNextItemValue"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNoItemsLeft(found As CLIArgsKFS.Parser.ArgParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the given parser has no elements left.
		  
		  PushMessageStack failureMessage
		  
		  AssertFalse found.HasNextItem, "HasNextItem"
		  AssertException_NoItemsLeft AddressOf found.PeekNextItemType
		  AssertException_NoItemsLeft AddressOf found.PeekNextItemValue
		  AssertException_NoItemsLeft AddressOf found.GetNextItemValue
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningBoolean() As Boolean
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningField() As CLIArgsKFS.Parser.Fields
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
