#pragma once
#include <stdbool.h>

void lcd_print_string(const char *string);

void lcd_return_home();

void lcd_send_letter(char c);

void lcd_send_control(char c);

void lcd_function_set(bool data_len, bool disp_lines, bool font);

void lcd_display_control(bool onoff, bool onoffcursor, bool onoffblink);

void lcd_entry_mode(bool cursor_move_dir, bool disp_shift);

void lcd_clear_display();
