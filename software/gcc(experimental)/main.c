#include <lcd.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

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
	const char *string = "Hello, World!";
	lcd_print_string(string);
}