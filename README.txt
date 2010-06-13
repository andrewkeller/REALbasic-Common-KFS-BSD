This is the REALbasic Common KFS BSD library.

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
  |- RB Common KFS\ BSD/

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
  |- RB Common KFS\ BSD/
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
