/*		GNU General Public Licence
	
	This is the "classic" interface to BUGS with no GUI stuff for use on Linux it is not needed
	for the ."classic" interface on Windows.
	
	The bugs.so file is loaded using dlopen and its initialization code implements the command 	
	line interpreter 
		
	The names of commands typed at the command prompt are the same as the names in the
	BUGS scipt language and of the R functions in BRugs.
	
	The mappings between the command names and the Component Pascal procedures to
	execute them are in the file Bugs/Rsrc/Script.txt
	
	Save this file as a .c  file before compiling with a C compiler.

	Compile with gcc -o cbugs cbugs.c -ldl on Linux and use the shell script 
	LinBUGS to provide the command line arguments.

*/

#include <dlfcn.h>
#include <stdio.h>
#include <string.h>

int main (int argc, char **argv)
{
	void * handle;
	if(argc != 2) {
		fprintf(stderr, "%s\n", "error must give library name as command line parameter");
		exit(1);
	}	
	
	handle = dlopen(argv[1], RTLD_LAZY);
	if (!handle)
	{
		fputs(dlerror(), stderr);
		exit(1);
	}
	dlclose(handle);
	return 0;
}


















