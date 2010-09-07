#tag Class
Protected Class AutoreleaseStubKFS
	#tag Method, Flags = &h0
		Sub Add(fn As DictionaryMethodKFS, param As Dictionary)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given DictionaryMethod.
		  
		  p_dict.Append fn
		  p_dict.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(fn As PlainMethodKFS)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given PlainMethod.
		  
		  p_plain.Append fn
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(fn As VariantMethodKFS, param As Variant)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given VariantMethod.
		  
		  p_var.Append fn
		  p_var.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  p_dict = New DataChainKFS
		  p_plain = New DataChainKFS
		  p_var = New DataChainKFS
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As DictionaryMethodKFS, param As Dictionary)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  p_dict.Append fn
		  p_dict.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As PlainMethodKFS)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  p_plain.Append fn
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As VariantMethodKFS, param As Variant)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  p_var.Append fn
		  p_var.Append param
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Invoke all the methods we've collected.
		  
		  While Not p_dict.IsEmpty
		    
		    Try
		      DictionaryMethodKFS( p_dict.Pop ).Invoke( Dictionary( p_dict.Pop ) )
		    Catch
		    End Try
		    
		  Wend
		  
		  While Not p_plain.IsEmpty
		    
		    Try
		      PlainMethodKFS( p_plain.Pop ).Invoke
		    Catch
		    End Try
		    
		  Wend
		  
		  While Not p_var.IsEmpty
		    
		    Try
		      VariantMethodKFS( p_var.Pop ).Invoke( p_var.Pop )
		    Catch
		    End Try
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected p_dict As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_plain As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_var As DataChainKFS
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
End Class
#tag EndClass
