#ifndef RASPICTURE_H
#define RASPICTURE_H

#include <bcm_host.h>

/****** Common structures ******/
typedef struct {
    uint32_t screen_width;
    uint32_t screen_height;
    DISPMANX_DISPLAY_HANDLE_T dispman_display;
} DISPMANX_STATE_T;

/****** Useful definitions ******/
#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))

#define PRINT_ERR(msg) fprintf(stderr, "%s:%d\n\t%s: %s", __FILE__, __LINE__, __FUNCTION__, msg)

/****** Prototypes ******/
/* RasPicture controller */
int init_dispmanx(DISPMANX_STATE_T*);
int destroy_dispmanx(DISPMANX_STATE_T*);

#endif // RASPICTURE_H
