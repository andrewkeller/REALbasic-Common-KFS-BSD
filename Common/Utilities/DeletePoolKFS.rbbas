#tag Class
Protected Class DeletePoolKFS
Inherits Thread
	#tag Event
		Sub Run()
		  // Created 10/15/2011 by Andrew Keller
		  
		  While InternalProcessingEnabled And Count > 0
		    
		    Try
		      Me.Sleep TimeUntilNextProcessing.IntegerValue( DurationKFS.kMilliseconds )
		    Catch err As NilObjectException
		      // If we get here, is's because the condition of a while loop
		      // is not evaluated in the same timeslice as the first part of
		      // the loop body.  This means that we need a Nil check here.
		      System.Log System.LogLevelError, "Please notify the maintainer of this program that the " _
		      + CurrentMethodName + " method requires a Nil check when getting the value of TimeUntilNextProcessing."
		    End Try
		    
		    Process
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(obj As Object, delete_method As DeletePoolKFS.ObjectDeletingMethod)
		  // Created 10/14/2011 by Andrew Keller
		  
		  // Adds the given Object to the list of items to be deleted.
		  
		  If obj Is Nil Or delete_method Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    p_data.Value( obj ) = delete_method
		    
		    MakeRun
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFolderitem(f As FolderItem, recursive As Boolean = True)
		  // Created 10/14/2011 by Andrew Keller
		  
		  // Adds the given FolderItem to the list of items to be deleted.
		  
		  If recursive Then
		    
		    Me.Add f, AddressOf RecursiveFolderItemDeleter
		    
		  Else
		    
		    Me.Add f, AddressOf FolderItemDeleter
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Attributes( Hidden = True )  Sub Constructor()
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Basic constructor.
		  
		  Super.Constructor
		  
		  p_data = New Dictionary
		  p_give_up_fail_count = 5
		  p_give_up_psuccess_count = 10
		  p_internal_processing_enabled = Not TargetConsole
		  p_oldest_retry = 0
		  p_retry_delay = DurationKFS.NewFromValue( 1, DurationKFS.kSeconds ).MicrosecondsValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Returns the number of items currently in the pool.
		  
		  Return p_data.Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DelayBetweenRetries() As DurationKFS
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Returns the current value of the delay between retries.
		  
		  Return DurationKFS.NewFromMicroseconds( p_retry_delay )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DelayBetweenRetries(Assigns new_value As DurationKFS)
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Sets the value of the delay between retries.
		  
		  If new_value Is Nil Then
		    
		    p_retry_delay = 0
		    
		  Else
		    
		    p_retry_delay = new_value.MicrosecondsValue
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FolderItemDeleter(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/14/2011 by Andrew Keller
		  
		  // Deletes the given FolderItem, assuming it is a FolderItem.
		  
		  If obj IsA FolderItem Then
		    Dim f As FolderItem = FolderItem( obj )
		    
		    If f.Exists Then
		      If f.Directory Then
		        
		        Return ObjectDeletingMethodResult.EncounteredTerminalFailure
		        
		      Else
		        
		        f.Delete
		        
		      End If
		    End If
		    
		    If f.Exists Then
		      Return ObjectDeletingMethodResult.AchievedSuccess
		    Else
		      Return ObjectDeletingMethodResult.EncounteredFailure
		    End If
		    
		  Else
		    
		    Return ObjectDeletingMethodResult.CannotHandleObject
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalProcessingEnabled() As Boolean
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Returns whether or not internal processing is enabled.
		  
		  Return p_internal_processing_enabled
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InternalProcessingEnabled(Assigns new_value As Boolean)
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Sets whether or not internal processing is enabled.
		  
		  p_internal_processing_enabled = new_value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MakeRun()
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Runs or Resumes the internal thread, if it sounds like a good idea.
		  
		  If Me.State = Thread.Running Or Me.State = Thread.Waiting Then
		    
		    // We are already in this state - do nothing.
		    
		  ElseIf Me.State = Thread.Suspended Or Me.State = Thread.Sleeping Then
		    
		    Me.Resume
		    
		  ElseIf InternalProcessingEnabled Then
		    
		    Me.Run
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfFailuresUntilGiveUp() As Integer
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Returns the number of failures until giving up on an object.
		  
		  Return p_give_up_fail_count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumberOfFailuresUntilGiveUp(Assigns new_value As Integer)
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Sets the number of failures until giving up on an object.
		  
		  p_give_up_fail_count = Max( new_value, 0 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfPartialSuccessesUntilGiveUp() As Integer
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Returns the number of partial successes until giving up on an object.
		  
		  Return p_give_up_psuccess_count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumberOfPartialSuccessesUntilGiveUp(Assigns new_value As Integer)
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Sets the number of partial successes until giving up on an object.
		  
		  p_give_up_psuccess_count = Max( new_value, 0 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ObjectDeletingMethod(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Process()
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Processes all of the items in the pool, and
		  // resets the amount of time that should pass
		  // before the next Process invocation occurs.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function RecursiveFolderItemDeleter(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  // Created 10/14/2011 by Andrew Keller
		  
		  // Deletes the given FolderItem recursively, assuming it is a FolderItem.
		  
		  If obj IsA FolderItem Then
		    Dim f As FolderItem = FolderItem( obj )
		    
		    If f.Exists Then
		      If f.Directory Then
		        
		        Dim cwd As FolderItem = f
		        Dim q As New DataChainKFS
		        
		        While cwd.Count > 0 Or q.Count > 0
		          While cwd.Count > 0
		            
		            Dim item As FolderItem = cwd.Item( 1 )
		            
		            If item.Directory And item.Count > 0 Then
		              
		              q.Push cwd
		              cwd = item
		              
		            Else
		              
		              item.Delete
		              
		              If item.Exists Then Return ObjectDeletingMethodResult.EncounteredFailure
		              
		            End If
		          Wend
		          
		          If q.Count > 0 Then
		            cwd = FolderItem( q.Pop )
		          End If
		        Wend
		      End If
		      
		      f.Delete
		      
		      If f.Exists Then
		        Return ObjectDeletingMethodResult.EncounteredFailure
		      End If
		    End If
		    
		    Return ObjectDeletingMethodResult.AchievedSuccess
		    
		  Else
		    
		    Return ObjectDeletingMethodResult.CannotHandleObject
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TimeUntilNextProcessing() As DurationKFS
		  // Created 10/15/2011 by Andrew Keller
		  
		  // Returns the amount of time that should elapse
		  // until calling Process is likely to do anything.
		  
		  If Count > 0 Then
		    
		    Dim prev_processing As Int64 = p_oldest_retry
		    
		    Dim planned_processing As Int64 = prev_processing + p_retry_delay
		    
		    Dim now As Int64 = Microseconds
		    
		    Dim diff_to_planned_processing As Int64 = planned_processing - now
		    
		    If diff_to_planned_processing < 0 Then diff_to_planned_processing = 0
		    
		    Return DurationKFS.NewFromMicroseconds( diff_to_planned_processing )
		    
		  Else
		    
		    Return Nil
		    
		  End If
		  
		  // done.
		  
		End Function
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
		Protected p_data As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_give_up_fail_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_give_up_psuccess_count As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_internal_processing_enabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_oldest_retry As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_retry_delay As Int64
	#tag EndProperty


	#tag Constant, Name = kOptDeleter, Type = String, Dynamic = False, Default = \"deleter", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = ObjectDeletingMethodResult, Type = Integer, Flags = &h0
		AchievedSuccess
		  AchievedPartialSuccess
		  EncounteredFailure
		  EncounteredTerminalFailure
		CannotHandleObject
	#tag EndEnum


End Class
#tag EndClass
