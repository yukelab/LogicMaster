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

CFLAGS += -mcpu=cortex-m4 -mthumb -Wall -std=gnu99
CFLAGS += -Wno-unused-variable #don't waring unused variable 
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16 #use hard float uint
CFLAGS += -nostartfiles
CFLAGS += -ffunction-sections -fdata-sections -Os
#CFLAGS += -g

LFLAGS += -mcpu=cortex-m4 -mthumb 
LFLAGS += -specs=nano.specs 
LFLAGS += -u_printf_float #Use this option if you want print float
LFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
LFLAGS += -Os -Wl,--gc-sections 
#LFLAGS += -Wl,-Map=flash_sram.map

%.o:%.S
# @arm-none-eabi-gcc $(CFLAGS) -c $< -o $@
	@echo cc: $<
	@$(CC) $(CFLAGS) -c $< -o $@
%.o:%.c
# @arm-none-eabi-gcc $(CFLAGS) $(DEFS) $(INCS) -c $< -o $@
	@echo cc: $<
	@$(CC) $(CFLAGS) $(DEFS) $(INCS) -c $< -o $@

