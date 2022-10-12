#include "lcd.h"

int main()
{
	load_al(72);
	lcd_send_control();
	lcd_send_letter();
	return 0;
}
