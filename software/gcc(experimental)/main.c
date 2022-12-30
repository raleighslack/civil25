#include <lcd.h>

void main()
{
	lcd_send_control(0x38); // Set 8 bit mode, 2-line display, 5x8 font
	lcd_send_control(0x0f); // Display on, cursor on, blink on
	lcd_send_control(0x06); // Increment and shift cursor; don't shift display
	lcd_return_home();
	lcd_send_letter('a');

	const char *buffer = "wewe";
	lcd_print_string(buffer);
}