typedef unsigned char Byte;

Byte S[256];
Byte i = 0;
Byte j = 0;


// Swap two values in S array
void swap(Byte i, Byte j);

// Key scheduling algorithm
void ksa(Byte *key, unsigned int key_length);

// Pseudo-random generation algorithm
Byte prga();
