/******************************************************************************
**              RasPicture - Remote streaming for your Pi
******************************************************************************/

#include <stdio.h>
#include <stdbool.h>

#include <bcm_host.h>

#include "raspicture.h"


int raspicture_start(FILE *stream)
{
	// Before any call to the GPU is made...
	bcm_host_init();

	// TODO: Initialize main data structures
	// TODO: Implement display startup
	// TODO: Implement streaming
	// TODO: Destroy main data structures

	return 0;
}

/* Holds and prints information on how to use this program */
void print_usage(const char *progname) {
	static const char *usage[] = {
		"Usage:\n",
		"Record to file: %s <filename>\n",
		"Output to stdout: %s\n",
	};
	size_t i, len = ARRAY_SIZE(usage);

	for (i = 0; i < len; i++) {
		fprintf(stdout, usage[i], progname);
	}

	exit(1);
}

/* Main function. */
int main(int argc, char *argv[])
{
	bool use_stdout = (argc < 2);
	FILE *stream = use_stdout ? stdout : fopen(argv[1], "wb");

	printf("RasPicture - Remote streaming for your Pi\n\n");

	// Parsing arguments
	// TODO: detect -h | --help, calls print_usage(argv[0]) then exits
	// TODO: detect -o | --output, fopen(argv[i])

	raspicture_start(stream);

	if (!use_stdout) { fclose(stream); }

	return EXIT_SUCCESS;
}
