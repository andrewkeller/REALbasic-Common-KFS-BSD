This is the REALbasic Common KFS BSD library.

LIBRARY CONTENTS

The purpose of this repository is to provide additional classes and functionality to the REALbasic language.  This library is setup as a GUI application, where the library code is in the Common folder.  The purpose of the library application is to run the library's unit tests.

In addition to some individual useful functions, this library also contains the following classes and frameworks:

  - AutoreleaseStubKFS - A simple class that executes a given delegate when it get deallocated.  Can greatly simplify cleanup code in some cases.

  - BigStringKFS - A String class that automatically swaps to disk with large strings, and seamlessly works with Strings, BinaryStreams, MemoryBlocks, and Folderitems.

  - ClosuresKFS - A class that generates closures around delegates.

  - DataChainKFS - A simple class that adds stack and queue functionality.

  - DurationKFS - A class that represents a measure of time accurate to microseconds and with a ceiling of a few hundred centuries.

  - LinearArgDesequencerKFS - A class that assists in parsing command-line arguments.

  - NodeKFS - Not much more than a data structure that aids in creating other data structures.

  - ProgressDelegateKFS - A class that allows for easy calculation of overall progress in hierarchal or parallel algorithms.

  - PropertyListKFS - A class similar to the Dictionary except that it is designed for trees of data.

  - StatusLoggerKFS, StatusLogEntryKFS, StatusLogQueryKFS - A logging framework.

  - SwapGlobalsKFS - A set of functions for allocating swap files in a standardized way.

  - UnitTestArbiterKFS, UnitTestBaseClassKFs, UnitTestExceptionKFS, UnitTestWindowKFS - A unit testing framework for REALbasic.


REVISION USAGE

In this library, the revision tags are used to specify how much of a change occurred between any two revisions.  Revisions can have up to 3 segments.  If the third segment changes, then something very basic changed, and you will likely be able to update to the newer revision without modification of your own code.  If the second segment changes, then the usage or behavior of something changed.  Depending on the situation, you might or might not need to update code in the parent project.  If the first segment changes, then a file was added or deleted in the library, and you will need to re-add the library to your project.


REPOSITORY USAGE

If you would simply like a copy of the library, and do not want version control, then simply open up the library application, and copy-and-paste the entire "Common" folder from the library's project tab into your project.  It might then be useful to rename it to something memorable, like RB Common KFS BSD.

If you would like to use this library in conjunction with version control, then you should know that this library is designed to be used with a host project that is saved in REAL Studio's Version Control format.  The following command should successfully add this repository as a submodule in your repository, assuming you are using Git:

  git submodule add git://github.com/andrewkeller/REALbasic-Common-KFS-BSD.git "Libraries/RB Common KFS BSD"

Once this library has been successfully cloned, simply drag the entire Libraries folder into your project (or just the RB Common KFS BSD folder, if you already have another library).  Then, in the project editor, inside the RB Common KFS BSD folder, delete everything except the Common folder.  Your project editor should now look something like this:

  Project Editor
  |
  |- Foo.rbres
  |- Foo.rbvcp
  |- Local/
  |  |- App.rbbas
  |  |- Build Automation.rbbas
  |  |- MenuBar1.rbmnu
  |  |- Window1.rbfrm
  |
  |- RB Common KFS BSD/
     |- Common/
        |- Lots
        |- And
        |- Lots
        |- Of
        |- Classes

At this point, you should have full access to the whole library from your main project.  See http://kellerfarm.com/life/rbvcp/ for a more detailed article on this approach to using libraries with REAL Studio.
