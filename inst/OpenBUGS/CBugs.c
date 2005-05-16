/*		GNU General Public Licence
	
	This is the "classic" interface to BUGS with no Windows stuff.
	
	The brugs dynamic link library is used in the same way as in the R interface to BUGS:
	via dlopen and dlsym.
	
	The names of commands typed at the command prompt are the same as the names in the
	BUGS scipt language and of the R functions in BRugs.
	
	The mappings between the command names and the Component Pascal procedures to
	execute them are in the file Bugs/Rsrc/Script.txt
	
*/


/* 

	Save this file as a .c  file before compiling with a C compiler.

	Compile with gcc -o CBugs CBugs.c -ldl	on Linux and use the shell script LinBUGS to 
	provide the command line arguments.
	
	Compile with the Cygwin c compiler gcc -o CBugs.exe CBugs.c 	on Windows
	The Windows version needs the library cygwin1.dll. Use the short cut ClassicBUGS to provide 		the command line arguments.
	
	cd C:/Program Files/BlackBox

*/

#include <dlfcn.h>
#include <stdio.h>
#include <string.h>

int main (int argc, char **argv)
{
	void * handle;
	void (*SetRootDir) (char **string, int *len);
	void (*SetTempDir) (char **string, int *len);	
	void (*EmbedCommand) (char ** string, int *len);
	char ch;	
	char *error;
	char *root;
	char *tempDir;
	char *dll;
	char *library;
	char *buffer;
	char *logFile;
	char *cmd;
	char cmdLine[256];
	int i;	
	int len;
	int len1;
	int len2;
	int len3;
	int pos;	
	int res;
	int tabs[20];
	FILE *fp;
	FILE *log;

	if(argc != 4) {
		fprintf(stderr, "%s\n", "error must give root directory of BUGS, temp directory and library name as command line parameter");
		exit(1);
	}	
	root = argv[1],	
	len1 = strlen(root);
	tempDir = argv[2];
	len2 = strlen(tempDir);
	dll = argv[3];
	len3 = strlen(dll);
	library = (char *) malloc((len1 + len3 + 1) * sizeof(char));
	strcpy(library, root);
	strcat(library, dll);
	buffer = (char *) malloc((len2 + 12) * sizeof(char));
	strcpy(buffer, tempDir);
	strcat(buffer, "/buffer.txt");
	logFile = (char *) malloc((len2 + 13) * sizeof(char));
	strcpy(logFile, tempDir);
	strcat(logFile, "/bugslog.txt");
	
	handle = dlopen(library, RTLD_LAZY);
	if (!handle)
	{
		fputs(dlerror(), stderr);
		exit(1);
	}
	
	SetRootDir = dlsym(handle, "SetRootDir");
	error = dlerror();
	if(error != NULL)
	{
		fprintf(stderr, "%s\n", error);
		exit(1);
	}
	
	SetTempDir = dlsym(handle, "SetTempDir");
	error = dlerror();
	if(error != NULL)
	{
		fprintf(stderr, "%s\n", error);
		exit(1);
	}

	EmbedCommand = dlsym(handle, "EmbedCommand");
	error = dlerror();
	if(error != NULL)
	{
		fprintf(stderr, "%s\n", error);
		exit(1);
	}	
	
	len = strlen(root);
	SetRootDir(&root, &len);
	
	len = strlen(tempDir);
	SetTempDir(&tempDir, &len);
	
	/*	Initialize by executing Pascal procedures corresponding to INIT()	*/
	len = 6;
	cmd = (char *) malloc ((len + 1) * sizeof(char));
	strcpy(cmd, "INIT()");
	EmbedCommand(&cmd, &len);
	free(cmd);
	
	log = fopen(logFile, "w");

	tabs[0] = 1;
	tabs[1] = 20;
	i = 2;
	while (i < 20) {
		tabs[i] = 12;
		i = i + 1;
	}
	while (1){
		printf("%s", "Bugs> ");
		fprintf(log, "%s", "Bugs> ");
		gets(cmdLine);
		fprintf(log, "%s", cmdLine);
		fprintf(log, "%c", '\n');
		if (strcmp(cmdLine, "modelQuit()") == 0) exit(0);
		len = strlen(cmdLine);
		cmd = (char *) malloc((len + 1) * sizeof(char));
		strcpy(cmd, cmdLine);
		
		EmbedCommand(&cmd, &len);
		free(cmd);
		
		fp = fopen(buffer, "r");
		ch = fgetc(fp);
		pos = 0;
		i = 0;
		while (ch != EOF) {
			pos = pos + 1;
			if (ch == '\n') {
				pos = 0;
				i = 0;
			}
			if (ch == '\t') {
				pos = pos % tabs[i];
				while (pos < tabs[i]) {
					pos = pos + 1;
					printf("%c", ' ');
					fprintf(log, "%c", ' ');
				}
				i = i + 1;
				pos = 0;
			}
			if (ch != '\t') {
				printf("%c", ch);
				fprintf(log, "%c", ch);
				
			}
			ch = fgetc(fp);
		}
		fclose(fp);
		
	}
	fclose(log);
	dlclose(handle);
	return 0;
}


















