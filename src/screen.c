#include <stdio.h>

#include "raspicture.h"

#define DEFAULT_SCREEN 0

int init_dispmanx(DISPMANX_STATE_T *state)
{
    int32_t success = 0;

    success = graphics_get_display_size(
		DEFAULT_SCREEN,
		&state->screen_width,
		&state->screen_height
	);
	if (success < 0) {
		PRINT_ERR("Couldn't get display size. Make sure /usr/bin/tvservice is on.\n");
		return -1;
	}

    printf("Created screen: %dx%d\n", state->screen_width, state->screen_height);

	return success;
}

int destroy_dispmanx(DISPMANX_STATE_T *state)
{
	return 0; // FIXME: implement Dispmanx unloader
}
