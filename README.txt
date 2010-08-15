This is the REALbasic Common KFS BSD library.

LIBRARY CONTENTS

The purpose of this repository is to provide additional classes and functionality to the REALbasic language.  The library itself is contained within the Common folder.  The project file, GUI Project.rbres, exists to run the unit tests, located in the Unit Tests folder.  All classes internal to the app that run unit tests are located inside the Local folder.

This library currently provides the following items:

  - BigStringKFS - A String class that automatically swaps to disk with large strings, and seamlessly works with Strings, BinaryStreams, MemoryBlocks, and Folderitems.

  - DataChainKFS - A simple class that adds stack and queue functionality.

  - DelegateTimerKFS - A subclass of the Timer class that allows configuring the behavior of the Action event at runtime.

  - DurationKFS - A class that represents a measure of time accurate to microseconds and with a ceiling of a few hundred centuries.

  - HierarchalDictionaryFunctionsKFS - Extends the Dictionary class to allow for accessing nested Dictionaries.

  - LinearArgDesequencerKFS - A class that assists in parsing command-line arguments.

  - NodeKFS - Not much more than a data structure that aids in creating other data structures.

  - OrderedDictionaryKFS - A subclass of the Dictionary class that allows keys to have reproducible indices.

  - PropertyListKFS - A class for reading and writing property lists.  Scheduled for depreciation as soon as HierarchalDictionaryFunctionsKFS can read and write files.

  - ShellKFS - A subclass of the Shell class that is designed to work better with threads.

  - StatusLoggerKFS, StatusLogEntryKFS, StatusLogQueryKFS - A logging framework.

  - SwapGlobalsKFS - A set of functions for allocating swap files in a standardized way.

  - UnitTestArbiterKFS, UnitTestBaseClassKFs, UnitTestExceptionKFS, UnitTestResultKFS - A unit testing framework for REALbasic.

  - XgridBatchFileKFS, XgridJobKFS, XgridTaskKFS - Classes for reading and writing Xgrid batch files.  Will be finished as soon as HierarchalDictionaryFunctionsKFS can read and write files.


REPOSITORY USAGE

It is intended that this repository be used as a submodule, although it is completely self-sustaining with regard to internal test cases.

The intended usage of this repository is as follows:

  My Great Project Foo
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

In other words, it is expected that your main project be saved using REAL Studio's Version Control format, and this repository be a submodule located along with any other libraries you might have.

Once this repository is added, simply drag and drop the folder containing the library into the main project's Project Editor such that the folders in the Project Editor correspond with those on the file system, and delete everything except the Common folder of this repository.  When that is complete, the main project's Project Editor should look something like this:

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

At this point, you should have full access to the whole library from your main project.


INITIALIZATION

Currently, all of the code in this repository can compile without checking out any submodules.

The following command should successfully add this repository as a submodule in your repository:

  git submodule add git://github.com/andrewkeller/REALbasic-Common-KFS-BSD.git "RB Common KFS BSD"
