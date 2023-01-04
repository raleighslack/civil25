#include <lcd.h>
#include <utils.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#define _OPEN_SYS_ITOA_EXT

void lcd_init()
{
	lcd_function_set(true, true, false);   // Set 8 bit mode, 2-line display, 5x8 font
	lcd_display_control(true, true, true); // Display on, cursor on, blink on
	lcd_entry_mode(true, false);		   // Increment and shift cursor; don't shift display
	lcd_return_home();
}

void main()
{
	lcd_init();
	uint16_t ramSize = ramtest();
	char buffer[sizeof(uint16_t) * 8 + 1];
	utoa(ramSize, buffer, 1);
	lcd_print_string(buffer);
}