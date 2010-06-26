#tag Class
Protected Class ShellKFS
Inherits Shell
	#tag Event
		Sub Completed()
		  // Created 6/9/2010 by Andrew Keller
		  
		  // Wake up the parent thread?
		  
		  If ParentThread <> Nil Then
		    
		    If ParentThread.State = Thread.Suspended Or ParentThread.State = Thread.Sleeping Then
		      
		      ParentThread.Resume
		      
		    End If
		    
		  End If
		  
		  // Allow subclasses to implement their own Completed event.
		  
		  RaiseEvent Completed
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub DataAvailable()
		  // Created 6/9/2010 by Andrew Keller
		  
		  // Wake up the parent thread?
		  
		  If ParentThread <> Nil Then
		    
		    If ParentThread.State = Thread.Suspended Or ParentThread.State = Thread.Sleeping Then
		      
		      ParentThread.Resume
		      
		    End If
		    
		  End If
		  
		  // Allow subclasses to implement their own DataAvailable event.
		  
		  RaiseEvent DataAvailable
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Completed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DataAvailable()
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
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


	#tag Property, Flags = &h0
		ParentThread As Thread
	#tag EndProperty


End Class
#tag EndClass
