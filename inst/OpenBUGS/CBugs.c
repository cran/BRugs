/*		GNU General Public Licence
	
	This small C program loads the bugs.so ELF shared library. Save it as a .c file and then
	compile it on Linux using gcc -o bugs CBugs.c -ldl 

*/

#include <dlfcn.h>
#include <stdio.h>
#include <string.h>

int main (int argc, char **argv)
{
	void * handle;
	
	handle = dlopen("./bugs.so", RTLD_LAZY);
	if (handle)
	{
		dlclose(handle);
	}
	return 0;
}


















