#include "lcd.h"

int main()
{
	load_al(72);
	send_control();
	send_letter();
	return 0;
}
