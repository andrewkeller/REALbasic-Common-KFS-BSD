#tag Class
Protected Class TestCLIArgsArgument
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestNormal()
		  // Created 7/23/2012 by Andrew Keller
		  
		  // Makes sure that the normal scenerio works.
		  
		  Dim arg As New CLIArgsKFS.Parser.Argument( "foo", 2 )
		  
		  AssertEquals "foo", arg.Text, "The argument object did not retain its text."
		  AssertEquals 2, arg.Type, "The argument did not retain its type code."
		  
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
