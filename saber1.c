#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include "rc4.h"
#include "saber1.h"

// Get the IV from file
Byte get_iv(const int input, Byte * buffer) {
    ssize_t read_bytes;
    read_bytes = read(input, buffer, 10); // Saber 1 read only 10 bytes for IV
    return read_bytes;
}

void print_usage() {
    printf("Usage:\n");
    printf("    saber1 (cipher|decipher) <key_file>\n");
}

void print_cant_open() {
    printf("Can't open the key file\n");
}

// Get the saber mode from user given string
Byte get_saber_mode(const char * mode) {
    if (strcmp("cipher", mode) == 0) {
        return CIPHER;
    } else if (strcmp("decipher", mode) == 0) {
        return DECIPHER;
    } else {
        return UNKNOWN;
    }
}

int main (int argc, char *argv[]) {
    Byte iv[10], iv_length, written_iv;
    int key_file, iv_file;
    Byte got_key, saber_mode;
    // The accepted arguments are (cipher|decipher) and <key_file>
    if (argc != 3) {
        print_usage();
        exit(1);
    }
    // The first argument must be cipher or decipher
    saber_mode = get_saber_mode(argv[1]);
    if (saber_mode == UNKNOWN) {
        print_usage();
        exit(4);
    }
    // Get the key
    key_file = open(argv[2], O_RDONLY);
    if (key_file < 3) {
        print_cant_open();
        exit(2);
    }
    // Store the key
    got_key = get_key(key_file);
    if (! got_key) {
        print_cant_open();
        exit(3);
    }
    // if saber mode is "cipher", we read IV from /dev/urandom
    // but, if saber mode is "decipher", we read IV from stdin
    if (saber_mode == CIPHER){
        iv_file = open("/dev/urandom", O_RDONLY);
    } else {
        iv_file = 0;
    }
    iv_length = get_iv(iv_file, &Key[key_length]);
    key_length += iv_length;
    if (key_length > 256){
        printf("Your key is too long\n");
        exit(5);
    }
    // If we are in cipher mode, we need to write IV to the stdout
    if (saber_mode == CIPHER) {
        written_iv = write(1, &Key[key_length - iv_length], iv_length);
        if (written_iv != iv_length) {
            exit(6);
        }
    }
    // Now we are ready to cipher or decipher from the stdin
    rc4(0, 1);
    close(0);
    close(1);
    close(key_file);
    exit(0);
}
