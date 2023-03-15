#pragma once
#include <stdbool.h>
#include <stdint.h>

uint8_t key_status();

char key_read_command();
uint8_t key_write_command(uint8_t command);

uint8_t key_controller_test();

char key_get_output();

void key_disable();
void key_enable();
void key_reset();