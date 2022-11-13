const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 31, 33, 35, 37};
// const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53};
#define CLOCK 2
#define READ_WRITE 3

void setup()
{
    for (int n = 0; n < 20; n += 1)
    {
        pinMode(ADDR[n], INPUT);
    }
    pinMode(CLOCK, INPUT);
    pinMode(READ_WRITE, INPUT);

    attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);

    Serial.begin(57600);
}

void onClock()
{
    char output[19];

    unsigned int address = 0;
    for (int n = 0; n < 20; n += 1)
    {
        int bit = digitalRead(ADDR[n]) ? 1 : 0;
        Serial.print(bit);
        address = (address << 1) + bit;
    }

    Serial.print("   ");

    sprintf(output, "   %05x %c", address, digitalRead(READ_WRITE) ? 'r' : 'W');
    Serial.println(output);
}

void loop() {}