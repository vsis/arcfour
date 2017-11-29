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
void ksa(Byte *key, unsigned int key_length) {
    // Fill S with 0 to 255
    for (int index = i = 0; index < 256 ; i = ++index) {
        S[i] =  i;
    }
    // Use key to generate a pseudorandom S
    for (int index = i = j = 0; index < 256 ; i = ++index) {
        j = j + key[i % key_length];
        swap(i, j);
    }
}

// Pseudo-random generation algorithm
Byte prga() {
    i++;
    j = j + S[i];
    swap(i, j);
    return S[S[i] + S[j]];
}

int main(int argc, char *argv[]) {
    Byte buffer[256], index;
    ssize_t b_read, b_written;
    Byte *key = (unsigned char *) argv[1];
    // the only argument needed is the key
    if (argc != 2) {
        printf("Usage: rc4 <key>\n");
        exit(1);
    }
    ksa(key, strlen(argv[1]));
    while (1) {
        // read from stdin, and write in buffer
        b_read = read(0, buffer, 255);
        // if we read something, we should cipher it
        if (b_read > 0) {
            // Cipher it!
            for (index = 0; index < b_read; index++) {
                buffer[index] = buffer[index] ^ prga();
            }
            // write it to stdout
            b_written = write(1, buffer, b_read);
        } else {
            break;
        }
    }
    exit(0);
}
