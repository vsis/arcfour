#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "rc4.h"

// Swap two values in S array
void swap(Byte i, Byte j) {
    Byte tmp = S[i];
    S[i] = S[j];
    S[j] = tmp;
}

// Key scheduling algorithm
void ksa() {
    // Fill S with 0 to 255
    i = 0;
    do {
        S[i] = i;
        i++;
    } while (i);
    // Use Key to generate a pseudorandom S
    do {
        j = j + Key[i % key_length] + S[i];
        swap(i, j);
        i++;
    } while (i);
    // reset i and j
    i = j = 0;
}

// Pseudo-random generation algorithm
Byte prga() {
    Byte s_index;
    i++;
    j = j + S[i];
    swap(i, j);
    s_index = S[i] + S[j];
    return S[s_index];
}

// Store key from file descriptor
Byte get_key(const int input) {
    key_length = read(input, Key, 256); // key should have a lenght of 256 or less
    return (key_length != 0);
}

// RC4 Cipher
void rc4(const int input, const int output) {
    Byte buffer[BUFFER_SIZE], keep_ciphering;
    unsigned int index;
    ssize_t read_bytes, written_bytes;
    ksa();
    do {
        read_bytes = read(input, buffer, BUFFER_SIZE);
        for (index = 0; index < read_bytes; index++) {
            buffer[index] = buffer[index] ^ prga();
        }
        written_bytes = write(output, buffer, read_bytes);
        keep_ciphering = (read_bytes == BUFFER_SIZE) && (read_bytes == written_bytes);
    } while(keep_ciphering);
}
