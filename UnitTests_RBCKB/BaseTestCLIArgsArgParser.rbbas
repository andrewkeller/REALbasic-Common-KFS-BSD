#tag Class
Protected Class BaseTestCLIArgsArgParser
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, found As CLIArgsKFS.Parser.ArgParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/21/2012 by Andrew Keller
		  
		  // Asserts that the given parser should raise an exception on any of the Has/Peek/Get methods.
		  
		  PushMessageStack failureMessage
		  
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.HasNextArgument, "HasNextArgument"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.GetNextArgument, "GetNextArgument"
		  AssertException_MissingFlagForAttachedParcel expectedOffendingArgument, AddressOf found.PeekNextArgument, "PeekNextArgument"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertException_MissingFlagForAttachedParcel(expectedOffendingArgument As String, method As MethodReturningArgument, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a MissingFlagForAttachedParcelException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As CLIArgsKFS.Parser.Argument
		  
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
		Protected Sub AssertException_NoItemsLeft(method As MethodReturningArgument, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Invokes the given method, and makes sure that it raises a ParserExahustedException exception.
		  
		  Dim caught_err As RuntimeException
		  Dim fn_rslt As CLIArgsKFS.Parser.Argument
		  
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
		Protected Sub AssertNextItemEquals(expected_type As Integer, expected_value As String, found As CLIArgsKFS.Parser.ArgParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the next item in the parser has the expected characteristics.
		  
		  PushMessageStack failureMessage
		  
		  PushMessageStack "Checking the values of the fields:"
		  
		  AssertTrue found.HasNextArgument, "HasNextArgument"
		  
		  Dim arg1 As CLIArgsKFS.Parser.Argument = found.PeekNextArgument
		  AssertNotIsNil arg1, "The PeekNextArgument function should never return Nil."
		  
		  Dim arg2 As CLIArgsKFS.Parser.Argument = found.GetNextArgument
		  AssertNotIsNil arg2, "The GetNextArgument function should never return Nil."
		  
		  AssertSame arg1, arg2, "The PeekNextArgument and GetNextArgument functions should return the same object."
		  
		  AssertEquals expected_type, arg1.Type, "Unexpected argument type code."
		  AssertEquals expected_value, arg1.Text, "Unexpected argument data (the Text property)."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNoItemsLeft(found As CLIArgsKFS.Parser.ArgParser, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 6/18/2012 by Andrew Keller
		  
		  // Asserts that the given parser has no elements left.
		  
		  PushMessageStack failureMessage
		  
		  AssertFalse found.HasNextArgument, "HasNextArgument"
		  AssertException_NoItemsLeft AddressOf found.GetNextArgument
		  AssertException_NoItemsLeft AddressOf found.PeekNextArgument
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningArgument() As CLIArgsKFS.Parser.Argument
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function MethodReturningBoolean() As Boolean
	#tag EndDelegateDeclaration


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
