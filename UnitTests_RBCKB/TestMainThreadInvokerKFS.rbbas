#tag Class
Protected Class TestMainThreadInvokerKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub BeforeTestCase(testMethodName As String)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Sets up this class for a test case.
		  
		  ReDim obj_delay( -1 )
		  ReDim obj_elapsed( -1 )
		  ReDim obj_pool( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub VerifyTestCase(testMethodName As String)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Make sure all the objects get deallocated.
		  
		  While UBound( obj_pool ) >= 0
		    
		    // First, verify the state of the object tracking data structure.
		    
		    Dim all_good As Boolean
		    
		    AssertNotIsNil obj_pool(0), "No cell in obj_pool should be Nil.", False
		    AssertNotIsNil obj_delay(0), "No cell in obj_delay should be Nil.", False
		    AssertNotIsNil obj_elapsed(0), "No cell in obj_elapsed should be Nil.", False
		    
		    all_good = Not ( obj_pool(0) Is Nil Or obj_delay(0) Is Nil Or obj_elapsed(0) Is Nil )
		    
		    // Next, make sure the WeakRef points to either
		    // nothing or a MainThreadInvokerKFS object.
		    
		    If obj_pool(0).Value Is Nil Then
		      
		      // This is valid.  Do nothing.
		      
		    ElseIf obj_pool(0).Value IsA MainThreadInvokerKFS Then
		      
		      // This is also valid.  Do nothing.
		      
		    Else
		      
		      // The object in this WeakRef is not valid.
		      
		      AssertIsNil obj_pool(0).Value, "An invalid object was found in the obj_pool node."
		      all_good = False
		      
		    End If
		    
		    // Continue with tests?
		    
		    If Not all_good Then _
		    AssertFailure "Bailing out because the state of the object tracking data structure has been compromised."
		    
		    
		    // Okay, it looks like the state of the object tracking data structure
		    // is just fine.  Check for items that should be gone by now.
		    
		    If obj_elapsed(0) > obj_delay(0) Then
		      
		      If obj_pool(0).Value Is Nil Then
		        
		        // This is good.  Do nothing.
		        
		      Else
		        
		        AssertFailure "A MainThreadInvokerKFS object did not deallocate after its delay expired.", False
		        
		      End If
		      
		      // Regardless of what happened, remove the item.
		      
		      obj_pool.Remove 0
		      obj_delay.Remove 0
		      obj_elapsed.Remove 0
		      
		    Else
		      
		      // The time for this object to deallocate has not yet come.
		      
		      App.YieldToNextThread
		      
		    End If
		    
		    // And repeat until everything is accounted for.
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function MakeObject(d As PlainMethod) As MainThreadInvokerKFS
		  // Created 729/2011 by Andrew Keller
		  
		  // Creates, Tracks, and Returns a new MainThreadInvokerKFS
		  // object created using the given parameter.
		  
		  Dim m As New MainThreadInvokerKFS( d )
		  
		  TrackObject m, kDefaultDelay
		  
		  Return m
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeObject(d As PlainMethod, delay As Integer) As MainThreadInvokerKFS
		  // Created 729/2011 by Andrew Keller
		  
		  // Creates, Tracks, and Returns a new MainThreadInvokerKFS
		  // object created using the given parameters.
		  
		  Dim m As New MainThreadInvokerKFS( d, delay )
		  
		  TrackObject m, delay
		  
		  Return m
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub PlainMethod()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Sub TrackObject(obj As MainThreadInvokerKFS, delay As Integer)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Remembers the given object so that we can make sure it deallocates.
		  
		  If Not ( obj Is Nil ) Then
		    
		    obj_pool.Append New WeakRef( obj )
		    obj_delay.Append New DurationKFS( Max( delay, 0 ), DurationKFS.kMilliseconds )
		    obj_elapsed.Append DurationKFS.NewStopwatchStartingNow
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
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


	#tag Property, Flags = &h1
		Protected obj_delay() As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected obj_elapsed() As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected obj_pool() As WeakRef
	#tag EndProperty


	#tag Constant, Name = kDefaultDelay, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant


End Class
#tag EndClass
