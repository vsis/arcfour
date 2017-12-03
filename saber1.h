#define CIPHER 1
#define DECIPHER 2
#define UNKNOWN 3

// Get the IV from file
Byte get_iv(const int input, Byte * buffer);

// Get the saber mode from user given string
Byte get_saber_mode(const char * mode);

void print_usage();

void print_cant_open();
