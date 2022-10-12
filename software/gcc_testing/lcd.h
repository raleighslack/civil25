#pragma once

#include <stdint.h>
#include <stdbool.h>

void lcd_print_string(const char* string);

void lcd_home();

void load_al(uint8_t x);
void lcd_send_letter();
void lcd_send_control();
