#tag Class
Protected Class TestSimpleResourceManagerKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestFetch_Empty()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Fetch method works when the resource manager is empty.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS
		  
		  Dim v As Variant = 42
		  Dim pc As PersistenceCriteriaKFS = New PersistenceCriteriaKFS_Latch
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Boolean
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Fetch( "foo", v, pc )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Fetch method should never raise an exception." ) Then
		    AssertFalse fn_rslt, "The Fetch method was supposed to return False.", False
		    AssertIsNil v, "The Fetch method was supposed to set the value parameter to Nil.", False
		    AssertIsNil pc, "The Fetch method was supposed to set the persistenceCriteria parameter to Nil.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFetch_Found()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Fetch method works when the resource manager has the key we're looking for.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS(New Dictionary( "foo" : 15 ))
		  
		  Dim v As Variant = 42
		  Dim pc As PersistenceCriteriaKFS = New PersistenceCriteriaKFS_Latch
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Boolean
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Fetch( "foo", v, pc )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Fetch method should never raise an exception." ) Then
		    AssertTrue fn_rslt, "The Fetch method was supposed to return True.", False
		    AssertEquals 15, v, "The Fetch method was supposed to set the value parameter to 15.", False
		    If Not (pc IsA PersistenceCriteriaKFS_AlwaysPersist) Then
		      AssertFailure "The Fetch method was supposed to set the persistenceCriteria parameter to a new object.", _
		      "Expected a PersistenceCriteriaKFS_AlwaysPersist object but found " + ObjectDescriptionKFS( pc ) + ".", False
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFetch_NotFound()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Fetch method works when the resource manager doesn't have the key we're looking for.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS(New Dictionary( "bar" : 15 ))
		  
		  Dim v As Variant = 42
		  Dim pc As PersistenceCriteriaKFS = New PersistenceCriteriaKFS_Latch
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Boolean
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Fetch( "foo", v, pc )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Fetch method should never raise an exception." ) Then
		    AssertFalse fn_rslt, "The Fetch method was supposed to return False.", False
		    AssertIsNil v, "The Fetch method was supposed to set the value parameter to Nil.", False
		    AssertIsNil pc, "The Fetch method was supposed to set the persistenceCriteria parameter to Nil.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGet_Empty()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Get method works when the resource manager is empty.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Get( "foo" )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If caught_err IsA ResourceNotFoundInManagerException Then
		    AssertEquals "foo", ResourceNotFoundInManagerException(caught_err).OffendingKey, _
		    "The exception was raised correctly, but did not have the OffendingKey property set correctly.", False
		  Else
		    AssertFailure "The Get method was supposed to raise a ResourceNotFoundInManagerException.", _
		    "Expected a ResourceNotFoundInManagerException but found " + ObjectDescriptionKFS(caught_err) + ".", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGet_Found()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Get method works when the resource manager has the key we're looking for.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS(New Dictionary( "foo" : 15 ))
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Get( "foo" )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Get method was not supposed to raise an exception for a key that exists." ) Then
		    AssertEquals 15, fn_rslt, "The Get method was supposed to return the key's value.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGet_NotFound()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Get method works when the resource manager doesn't have the key we're looking for.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS(New Dictionary( "bar" : 15 ))
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Get( "foo" )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If caught_err IsA ResourceNotFoundInManagerException Then
		    AssertEquals "foo", ResourceNotFoundInManagerException(caught_err).OffendingKey, _
		    "The exception was raised correctly, but did not have the OffendingKey property set correctly.", False
		  Else
		    AssertFailure "The Get method was supposed to raise a ResourceNotFoundInManagerException.", _
		    "Expected a ResourceNotFoundInManagerException but found " + ObjectDescriptionKFS(caught_err) + ".", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLookup_Empty()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Lookup method works when the resource manager is empty.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Lookup( "foo", "fish" )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Lookup method should never raise an exception." ) Then
		    AssertEquals "fish", fn_rslt, "The Lookup method was supposed to return 'fish'.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLookup_Found()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Lookup method works when the resource manager has the key we're looking for.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS(New Dictionary( "foo" : 15 ))
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Lookup( "foo", "fish" )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Lookup method should never raise an exception." ) Then
		    AssertEquals 15, fn_rslt, "The Lookup method was supposed to return 15.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLookup_NotFound()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Makes sure the Lookup method works when the resource manager doesn't have the key we're looking for.
		  
		  Dim rsrc As ResourceManagerKFS = New SimpleResourceManagerKFS(New Dictionary( "bar" : 15 ))
		  
		  Dim caught_err As RuntimeException = Nil
		  Dim fn_rslt As Variant
		  
		  Try
		    #pragma BreakOnExceptions Off
		    fn_rslt = rsrc.Lookup( "foo", "fish" )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caught_err = err
		  End Try
		  
		  If PresumeIsNil( caught_err, "The Lookup method should never raise an exception." ) Then
		    AssertEquals "fish", fn_rslt, "The Lookup method was supposed to return 'fish'.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2012 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
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
