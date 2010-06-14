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


	#tag Note, Name = Advanced_Usage
		The method of using this class allows for easily implementing some sort of a progress meter when executing commands.
		
		The following is the same Run event of a Thread as there is in the Basic Usage note, except that a Progress event is now implemented.
		
		
		Event Progress( message As String )
		
		Sub Run()
		  
		  // First, we need a ShellKFS object:
		  Dim sh As New ShellKFS
		  
		  // Next, since this is technically an asynchronous operation, we need to set the shell to asynchronous mode:
		  sh.Mode = 1
		  
		  // Next, we need to tell the shell object which thread to wake up upon an event:
		  sh.ParentThread = Me
		  
		  // And that's it!  Now, we execute commands just like normal:
		  sh.Execute "sleep 5 ; pwd"
		  
		  // Now, we must go to sleep, and the shell object will wake up this thread when something happens:
		  Dim startTime As Double = Microseconds * .000001
		  While sh.IsRunning
		    RaiseEvent Progress "Yes, it's still running (" + str(Microseconds*.000001 - startTime) + " seconds elapsed)"
		    Me.Sleep 1000
		  Wend
		  
		  // At this point, the shell has completed or timed out.  Display the result:
		  MsgBox "Result of pwd: " + sh.Result
		  
		  // All done!
		  
		End Sub
		
		
		Notice how the loop for waiting until the shell finishes is not suspending the thread
		like the Basic Usage example, but is instead sleeping for a finite amount of time.
		Since the sleep command will run While sh.IsRunning = True, the net effect is that
		the thread will sit there waiting for the shell to finish, reporting progress every second.
		
		Now, granted, elapsed time is not a good example of progress.  But you get the point - You don't
		have to use Suspend in that loop.  ShellKFS will wake up a thread that is either suspended or sleeping.
		
	#tag EndNote

	#tag Note, Name = Basic_Usage
		This class currently only has one logical modification from the built-in Shell class:
		It has the ability to wake up a thread when any of its events fire.
		
		And it does so in a very straight-forward way.  Observe the following code in a Thread's Run event:
		
		
		Sub Run()
		  
		  // First, we need a ShellKFS object:
		  Dim sh As New ShellKFS
		  
		  // Next, since this is technically an asynchronous operation, we need to set the shell to asynchronous mode:
		  sh.Mode = 1
		  
		  // Next, we need to tell the shell object which thread to wake up upon an event:
		  sh.ParentThread = Me
		  
		  // And that's it!  Now, we execute commands just like normal:
		  sh.Execute "sleep 5 ; pwd"
		  
		  // Now, we must go to sleep, and the shell object will wake up this thread when something happens:
		  While sh.IsRunning
		    Me.Suspend
		  Wend
		  
		  // At this point, the shell has completed.  Display the result:
		  MsgBox "Result of pwd: " + sh.Result
		  
		  // All done!
		  
		End Sub
		
		
		For simplicity, this class implements this behavior for all shell modes.  There's no big reason to avoid
		this behavior in any of the modes in a general case.  To "turn off" this behavior, and thus, behave as
		a normal shell, simply do not set the ParentThread property, or if you already have, set it to Nil.
		
	#tag EndNote

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
