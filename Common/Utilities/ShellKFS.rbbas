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


	#tag Property, Flags = &h0
		ParentThread As Thread
	#tag EndProperty


End Class
#tag EndClass
