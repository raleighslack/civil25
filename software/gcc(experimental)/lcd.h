#pragma once

void lcd_print_string(const char *string);

void lcd_return_home();

void lcd_send_letter(char c);

void lcd_send_control(char c);

void lcd_clear_display();