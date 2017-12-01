#define BUFFER_SIZE 256

typedef unsigned char Byte;

unsigned short int key_length;
Byte Key[256];
Byte S[256];
Byte i;
Byte j;


// Swap two values in S array
void swap(Byte i, Byte j);

// Key scheduling algorithm
void ksa();

// Pseudo-random generation algorithm
Byte prga();

// Store key from file descriptor
Byte get_key(const int input);

// RC4 Cipher
void rc4(const int input, const int output);
