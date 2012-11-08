* What: SRQM Session 1
* Who:  F. Briatte and I. Petev
* When: 2012-01-26


* Hi! Welcome to your first SRQM do-file.

* You are probably viewing this file from the Stata do-file editor, after 
* opening it with the 'doedit replication/week1' command. If so, you are
* doing it right: congratulations! Let us guide you through your first
* do-file.


* Comments
* --------

* This line is a comment due to the '*' symbol at its beginning. It takes a
* green colour in the Stata do-file editor. This do-file is fully commented
* to guide you through the basics. In your own code, you should also use 
* comments to document and section your operations.


* Practice
* --------

* Your mission for next week is to replicate this do-file. That means running 
* it in full, reading the comments along as you execute its commands. Use the 
* course slides to learn about running do-files and read from the Stata Guide 
* to understand the commands used.

* There is no substitute to practice to learn statistical software. Code is
* like music, you will recognize the tune and notation if you listen to it.
* When you learn to code, you learn to play, either for yourself or for the
* audience of your programming language. For Stata, the audience is a pretty
* wide range of people and institutions.


* Interface
* ---------

* Quickly review the Stata windows. The Command window is where you will enter
* all commands, the results of which will show in the Results window. Your
* past commands will also show in the Review window. Finally, the Variables
* window should be empty at that stage, because no dataset is currently loaded
* in Stata. More windows will be opened as we go on.

* Note that we will use windows but not, as you are used to, menus. The menu
* interface in Stata offers point-and-click accessibility but is not suited
* for programming purposes. Instead, everything we do will be command-based.


* ====================
* = WARM-UP EXERCISE =
* ====================


* Type or copy and paste the following line to the Command window:
pwd

* The previous command returns the path to your working directory. It prints
* its output to the Results window, and the command is stored in history as
* shown in the Review window.

* Now, load a sample Stata dataset that is included with the software:
sysuse lifeexp, clear

* The previous command loads data in the background. You can access the data
* with the following command. Close the window after taking a look.
browse

* Back to the main window, the Variables window shows the list of variables.
* We are going to use two of them to build a plot. Type the following:
scatter lexp safewater

* This command creates your first Stata graph. Close the Graph window when
* you are done inspecting the graph. Finally, type the following command after
* uncommenting it (remove the asterisk and trailing space):
* doedit example

* The previous command creates an empty do-file called 'example.do'. The file
* is located in your working directory, which should be the SRQM folder.
* Stata has also opened the file in the Do-file Editor so that you can edit it
* from its programming interface. Copy and paste the four following lines into
* that empty do-file window:

// Example do-file.
sysuse lifeexp, clear
sc lexp safewater
clear

* Notice that the syntax used for the 'scatter' command is different because
* it has been abbreviated to 'sc'. The first line is a comment that uses an
* alternative way to tell Stata that the line is a comment. Save and close
* the do-file window when you have copied the full code to it.

* The do-file can now be run with the following command (uncomment to run):
* do example

* The do-file can now be erased with the following command (uncomment to run):
* rm example.do

* These commands quickly show you how we are going to use the software: by
* running (executing) code from Stata do-files, so that you can write your
* own do-file for your research projects. 


* Commands
* --------


* Tip (1): Get to learn some syntax

* Most Stata commands share an identical syntax that calls one or several
* variables as the main argument:

*   command variable

* Most Stata commands will also allow one or more options after a comma.
* Optional arguments are shown in brackets in the Stata help pages:

*   command variable [, options]


* Tip (2): Run all lines in sequential order

* - Applies to all do-files.
* - Requires you execute do-files in full.
* - Requires you know where you are in your code.

clear
set obs 100
gen test=1
ren test x // This line will not run if you do not run the previous ones.


* Tip (3): Run multiple lines together

* - Applies every time you see '///' at the end of a line.
* - Requires you select more than one line. Use Ctrl-L (Win) or Cmmd-L (Mac).
* - Requires you run them with Ctrl-D (Win) or Cmmd-Shift-D (Mac).

di "This is a test. Execute me by selecting this line, " ///
	"and this line too, " _newline ///
	"and this line too. Well done :)"

* You will have to do the same for code loops, such as 'foreach {}' loops.
* You will usually be warned before in the comments. Finally, note that these
* multiple-line commands do *not* work if you copy-paste from the do-file to
* the Command window.


* Tip (4): Keyboard shortcuts for Mac (Win)

* - Cmmd-L (Ctrl-L) selects a whole line
* - Shift + Up/Down arrows selects or deselects neighbouring lines
* - Cmmd-Shift-D (Ctrl-D) executes the selection
* - Cmmd-` (Alt-Tab) switches between application windows

* If you get lost while replicating a do-file, the safest option is to run it
* again from the top. To do that, keyboard shortcuts make your life easy: from
* the line where you want to start again, just press Cmmd-L (Ctrl-L), then 
* Cmmd-Shift-Up (Ctrl-Shift-Up), and finally press Cmmd-Shift-D (Ctrl-D) to 
* rerun the code down to your initial line.

* Additionally, you can navigate your past commands from the Command window,
* using the PageUp/PageDown keys. One last tip at that stage: practice a lot!


* =========
* = SETUP =
* =========


* The following steps teach you about setting up Stata on any computer. Start
* by making sure that you just launched Stata and have nothing stored in memory.
* The next command will ensure that this is the case:
clear 


* (1) Memory
* ----------

* Skip this section if you are running Stata 12+.

* Your first step with Stata consists in allocating enough memory to it. The
* default amount of memory that Stata loads at startup is too small to open
* large datasets: if you forget to set memory, Stata will reply with an error
* message. The basic command to allocate 500MB memory follows:
set mem 500m

* Note: the 'cap' (capture) prefix is not part of the command, it is an extra
* safety to allow this do-file to run through the line even if it returns an
* error, as it should if you are using Stata 12+.

* You need to repeat that command every time you run Stata. The command works
* only if Stata has no data in storage: if you already have a dataset opened,
* then Stata will reply with an error message. Fortunately, if you are running
* Stata from your own computer, you can set memory permanently:
set mem 500m, perm 

* There is more to learn about memory size and default settings in Stata, but
* for the purpose of this course, this will largely suffice. Furthermore, if
* you are running Stata 12, you are spared from setting memory yourself: Stata
* will do it automatically.


* (2) Screen breaks
* -----------------

* By default, Stata uses screen breaks. If you forget to disable those, the
* 'Results' window will nag you with useless prompts. Save yourself the hassle
* of screen breaks by disabling them:
set more off

* In fact, let's try to disable them permanently on your computer:
set more off, perm


* (3) Additional commands
* -----------------------

* Stata can be extended by installing packages, just like you would install a
* plugin or an extension for another software. The packages add new commands or
* graph schemes to Stata.

* Make sure that you are connected to the Internet before continuing, so that
* Stata can connect to the SSC archive and to other online sources. If you are
* using a Sciences Po workstation, you will also need to uncomment and run the
* following command to avoid an issue with admin privileges:

* sysdir set PLUS "c:\temp"

* This course makes heavy use of the 'fre' package to view frequencies.
* Install the package by uncommenting and running this command while online:

* ssc install fre

* Read the package description:
ado de fre


* (4) Working directory
* ---------------------

* The working directory is where Stata will look to open and save stuff like 
* datasets or logs. Use the 'pwd' command to see where Stata is looking now.
pwd

* Use 'ls' command to list the files where Stata is looking. The 'w' option will
* cause the command to print only the filenames without system information.
ls, w

* For this course, you need to set the working directory to the SRQM folder.
* Use the 'File > Change Working Directory...' menu item in the Stata graphical
* user interface to select the SRQM folder. The path to that foldr will show in
* the Results window. It might look like this:

* cd "/Users/fr/Documents/Teaching/SRQM/"

* I use Mac OS X, which is why my file path takes that form. Ivaylo uses a PC,
* and his own working directory might be set like this:

* cd "C:\Users\Ivo\Desktop\SRQM"

* You will need to identify that file path on your own computer. Choose a simple
* location for the SRQM folder and then keep it there without renaming it or any
* of the folders that lead to it. Be careful with that, or you will get errors
* when trying to study for the course.

* The 'cd' command shown above navigates through your folders. The next example
* assumes that you are now in the SRQM folder. It will select the folder that
* contains the course do-files. The quotes can be omitted when the path contains
* no spaces, but we will use them systematically for consistency:

* cd "Replication"

* Now go back one level to return to the SRQM folder:

* cd ..

* Finally, list the files without moving to a directory

* The settings covered in this section of the do-file should now be permanently
* stored on your computer. You will not need to come back to them. Furthermore,
* the course uses a setup utility program that silently checks on them for you.


* (5) Log
* -------

* You can save the commands and results from this do-file to a log file, which
* will serve as a backup of your work. To log this session, type:
log using "Replication/week1.log", replace

* The log command will now create a history of your work on this do-file. You
* should keep it for replication purposes. It will log all your commands and
* their results, including commands that returned an error. Refer to the Stata
* Guide for further guidance on log files, and do not forget to produce logs in
* the .log plain text format rather than in the less handy SMCL default format.
* Also make sure that you specify the 'replace' option to overwite any previous
* log file that might have been created by running this do-file in the past.
* The 'name' option can be omitted.

* Now run these example commands (do not worry about the comments, you can leave
* them where they are and 'execute' them too, Stata will just ignore them):

d year sex weight raceb  // describe a few variables
keep if year==2009       // keep observations for year 2009

* Calculate the frequencies for each racial-ethnic group.
fre raceb

* Obtain summary statistics for the weight variable.
su weight

* List gender groups from the sex variable.
tab sex

* Crosstabulate sex and race.
tab raceb

* Plot average weight by sex and race.
gr dot weight, over(raceb) over(sex) name(weight_race_sex, replace)

* To close the log file previously opened, type the following command:
cap log close

* You will not be able to run the above command if no log is opened. The 'cap'
* prefix allows you to run the command and continue even if it returns an error.
* To close any other opened log, uncomment and run the following command:

* log close _all

* If you now go to your 'Replication' folder and open the week1.log file with 
* any plain text editor, you will find a copy of everything that was entered 
* between the 'log using' and 'log close' commands, including comments, the 
* example above and its output for each command. You can view the file in Stata:
view "Replication/week1.log"

* The dot graph will need to be saved separately: this can be done in several
* ways that are documented in the course slides and in the Stata Guide. The
* Stata help pages also cover each graph command. Have a look at them:
help graph

* Identically, there is more about logs in the Stata Guide and in several of
* the tutorials included in the course material, but we also recommend that you
* use the Stata help pages, as explained below.


* ============
* = DATASETS =
* ============


* Show all datasets for this course. The asterisk in the command is an escape 
* character that causes the command to return all matches (within .dta files).
* The 'w' option is to make the output less verbose.
ls "Datasets/*.dta", w

* All datasets are in the SRQM Teaching Pack, and will load only if your working
* directory is correctly set. The README file of the Datasets folder holds links
* to essential documents for you to read if you want to use the data for your
* research project. You can start looking for variables of interest by using the
* lookfor command after loading one of the course datasets.

use "Datasets/ess2008.dta", clear
lookfor health immig

use "Datasets/qog2011.dta", clear
lookfor devel orig

use "Datasets/wvs2000.dta", clear
lookfor army homo

// etc. (this line is also a comment)

* Tip: an additional package can help you search for variables across datasets.
lookfor_all health, dir(Datasets)

* The command above, like all commands that calls datasets or do-files,
* requires that the SRQM folder has been set as the working directory.

* We will now load data from the U.S. National Health Interview Survey (2009).
use "Datasets/nhis2009.dta", clear

* The 'clear' option gets rid of any data previously loaded into memory, since
* Stata can only open one dataset at once.


* ========
* = HELP =
* ========


* It is essential to the methods covered by this course that you learn to use
* help extensively. The course material includes a lot of help with Stata, but
* you should also learn to use the internal Stata help pages.

* This command will serve as an example:
su weight if raceb==1, d

* To understand what 'su' means and does, type 'help' followed by 'su':
help su

* The underline tells you that 'su' is shorthand for 'summarize', which returns
* a few summary statistics for the variable 'weight' in this example. The 'if'
* component of the command is also documented in Stata:
help if

* The 'd' option is documented on the help page for 'summarize'. It specifies
* that you want more detailed statistics: 'd' is shorthand for 'detail' here.

* The 'help' command itself can be abbreviated to simply 'h'. Try this example
* to realise how quick accessing Stata help pages can be:
h su


* =======
* = END =
* =======


* The course will teach you to write commands like the ones featured in this
* do-file. If you combine practice, documentation and a bit of intuition, you
* can learn most of the Stata syntax in a few weeks through trial-and-error.
* Get ready by practicing as soon as possible! Programming works that way.

* Last words: when you leave Stata, DO NOT SAVE YOUR DATASET. Keep it intact as
* originally downloaded. Instead, save the do-file that contains the commands
* you used to perform your analysis. Stata will automatically save the log file
* for you when you shut it down, so this requires no action on your side. For
* additional help, please turn again to the Stata Guide.

* Close log (if still opened, which it should not).
cap log close

* We are done. Just quit the application, have a nice week, and see you soon :)
* exit, clear