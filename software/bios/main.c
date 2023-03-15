#include <lcd.h>
#include <utils.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <key8242.h>
#define _OPEN_SYS_ITOA_EXT

void lcd_init()
{
	lcd_function_set(true, true, false);   // Set 8 bit mode, 2-line display, 5x8 font
	lcd_display_control(true, true, true); // Display on, cursor on, blink on
	lcd_entry_mode(true, false);		   // Increment and shift cursor; don't shift display
	lcd_return_home();
}

bool checkMemory()
{
	uint16_t ramSize = ramtest();

	if (!ramSize || ramSize != 512)
		return EXIT_FAILURE;

	return EXIT_SUCCESS;
}

void main() // does memtest and prints out 512K
{
	lcd_init();

	if (checkMemory() != EXIT_SUCCESS)
	{
		lcd_print_string("No memory!");
	}

	lcd_print_string("Hello, World!");
}