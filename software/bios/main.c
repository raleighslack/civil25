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

bool checkKeyboardInput()
{
	return false;
}

void main() // does memtest and prints out 512K
{
	lcd_init();

	if (checkMemory() != EXIT_SUCCESS)
	{
		lcd_print_string("No mommy!");
	}

	char *buffer;
	char *string;
	char *something;

	utoa(ramtest(), buffer, 10);
	lcd_print_string(buffer);
	lcd_send_letter('K');

	key_disable();

	uint8_t status = key_write_command(69);
	utoa(status, string, 16);
	lcd_print_string(string);

	uint8_t ye = key_controller_test();
	utoa(ye, something, 16);
	lcd_print_string(something);

	char output = key_get_output();
	lcd_send_letter(output);

	key_enable();
	key_reset();
	key_reset();
	while (true)
	{
		char inputCharacter = key_get_output();
		lcd_send_letter(inputCharacter);
		delay(15000);
	}
}