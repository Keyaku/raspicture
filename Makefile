SRCDIR ?= src
OBJDIR = bld
DEPS = $(OBJDIR)/*.d

DEFINES += -DHAVE_LIBBCM_HOST -DUSE_EXTERNAL_LIBBCM_HOST -DUSE_VCHIQ_ARM -DOMX_SKIP64BIT
INCLUDE += -I./include/ -I/opt/vc/include/        \
	-I/opt/vc/include/interface/vcos/pthreads/    \
	-I/opt/vc/include/interface/vmcs_host/linux/  \
	-I/opt/vc/src/hello_pi/libs/ilclient/         \

LIBRARIES += -L/opt/vc/lib -L/opt/vc/src/hello_pi/libs/ilclient

CC ?= gcc
LD = $(CC)
CFLAGS = $(INCLUDE) $(DEFINES) -c -Wall -Wno-psabi -fdiagnostics-color=auto
LDFLAGS = $(LIBRARIES) -lpthread -lopenmaxil -lbcm_host -lvcos -lvchiq_arm -lilclient

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
