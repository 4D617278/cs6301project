Picinae: Platform In Coq for INstruction Analysis of Executables
Dr. Kevin Hamlen
CS6301-005: Language-based Security
The University of Texas at Dallas
Fall 2022


(1) Software Installation Requirements

In order to compile and execute this demo code, the user must first install
the Coq program-proof co-development system from INRIA:

https://coq.inria.fr/

This demo code was most recently tested using the Microsoft Windows version
of Coq v8.15.1, so we recommend using that version.


(2) Initial Build

Extract all provided files into a single common folder on the test system.
Some versions of Coq struggle with path names containing spaces, so we
recommend a whitespace-free path (e.g., "C:\Picinae").

To build the software on Windows, first edit the first line of the provided
"windows_build.bat" script to point to the full path of the coqc.exe
executable if you installed it at a non-standard location when installing
Coq.  The default is:

@SET coqc="C:\Coq\bin\coqc.exe"

Next, run the script from within the folder where all the Picinae .v files
are located.  Successful builds will conclude with a success message.
Otherwise the failure message reported by Coq will be printed.

Installation on Linux systems requires first renaming the _CoqProject.bak
file to _CoqProject (no file extension), and then running make on the
provided Makefile.

Important: When testing on Windows, be sure there is no file named _CoqProject
in the folder.  It causes the Windows version of Coq to misidentify the
namespace of the project, resulting in a build failure.


(3) Running the demo

Once the Coq is installed and the Picinae system is fully built (see the
above steps), you can run the demo by loading the provided "strcmp_i386.v"
and "strcmp_proofs.v" files into CoqIDE (Coq's GUI).

Important:  On Windows, do not launch CoqIDE from the Start Menu and then
load .v files into it.  Doing so causes CoqIDE to open in the wrong working
directory, with the result that it will not be able to find the Picinae
library files.  If launching CoqIDE directly, one must use a command prompt
to first set the correct working directory.  This is why it is easier to
double-click the .v file directly.

The "strcmp_i386.v" file contains a pre-lifted IL for gnu strcpy.  Using
the CoqIDE menus, execute "Compile -> Compile buffer".  Next, load the
"strcmp_proofs.v" file, which proves correctness of the lifted IL code.
It can be tested by using CoqIDE's arrow buttons in the usual way to
compile the proofs (all lines should turn green).
