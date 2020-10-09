OBJS := ./main.o
INCS := -I./
DEFS := -DUSE_STDPERIPH_DRIVER

GCC_PATH = /opt/gcc-arm-none-eabi-6_2-2016q4/bin
PREFIX = arm-none-eabi-
ifdef GCC_PATH
	CC = $(GCC_PATH)/$(PREFIX)gcc
	AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
	CP = $(GCC_PATH)/$(PREFIX)objcopy
	SZ = $(GCC_PATH)/$(PREFIX)size
else
	CC = $(PREFIX)gcc
	AS = $(PREFIX)gcc -x assembler-with-cpp
	CP = $(PREFIX)objcopy
	SZ = $(PREFIX)size
endif


default: all
name := LogicMaster

include platform/platform.mk
include stlib/stlib.mk
include lua/lua.mk
include llibs/llibs.mk
include common.mk

all:$(name).bin

burn:$(name).bin
	@st-flash write $< 0x08000000
	
clean:
	@rm -f $(name).bin $(name).elf $(OBJS)
	
$(name).bin:$(name).elf
# @arm-none-eabi-objcopy -O binary -S $< $@
	@$(CP) -O binary -S $< $@
$(name).elf:$(OBJS)
# @arm-none-eabi-gcc $(LFLAGS) $^ -Tstlib/flash.ld -o $@
# @arm-none-eabi-size $@
	@$(CC) $(LFLAGS) $^ -Tstlib/flash.ld -o $@
	@$(SZ) $@
	
.PHONY: all burn clean


