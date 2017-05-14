SRCDIR ?= src
OBJDIR = bld
DEPS = $(OBJDIR)/*.d

# Including headers
INC_DMX = -I/opt/vc/include/                    \
	-I/opt/vc/include/interface/vmcs_host/      \
	-I/opt/vc/include/interface/vcos/pthreads   \
	-I/opt/vc/include/interface/vmcs_host/linux
INC_OMX = -I/opt/vc/include/IL
INC_OMX_ILCLIENT = -I/opt/vc/src/hello_pi/libs/ilclient/

INCLUDE += -I./include/ $(INC_DMX) $(INC_OMX) $(INC_OMX_ILCLIENT)

# Libraries to use
LIBS_DMX = -L/opt/vc/lib/ -lbcm_host -lvcos -lvchiq_arm -lpthread
LIBS_OMX = -lopenmaxil
LIBS_OMX_ILCLIENT = -L/opt/vc/src/hello_pi/libs/ilclient -lilclient

# Definitions
DEFINES += -DOMX_SKIP64BIT

# Compiler and Linker flags
CFLAGS = $(INCLUDE) $(DEFINES)
CFLAGS += -c -Wall -Wno-psabi -fdiagnostics-color=auto
LDFLAGS = $(LIBS_DMX) $(LIBS_OMX) $(LIBS_OMX_ILCLIENT)

# Compilers, Linkers, and executable filename
CC ?= gcc
LD = $(CC)

EXECFILE ?= raspicture

################################################################################
#############       DO NOT CHANGE ANYTHING BELOW THIS PART        ##############
################################################################################
EXEC = $(OBJDIR)/$(EXECFILE)

# Filtering files for rule management
SRC := $(shell find $(SRCDIR) -name *.c)
OBJ := $(subst $(SRCDIR),$(OBJDIR),$(SRC:%.c=%.o))

# Objects and dependencies compilation
$(OBJDIR)/%.o: $(addprefix $(SRCDIR)/,%.c)
	$(shell mkdir -p $(dir $@))
	$(CC) -MMD -o $@ $< $(CFLAGS)

# General rules
all: $(EXEC)

# Linking
$(EXEC): $(OBJ)
	$(LD) -o $@ $^ $(LDFLAGS)

# Including dependencies
-include $(DEPS)

################################################################################
#############       DO NOT CHANGE ANYTHING ABOVE THIS PART        ##############
################################################################################

clean:
	rm -rf $(ZIPFILE) $(OBJDIR)/*.o $(DEPS) $(EXEC) *.DS_Store

.PHONY: all clean zip
