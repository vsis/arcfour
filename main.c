#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include "rc4.h"

void print_usage() {
    printf("Usage:\n");
    printf("    arcfour <key file>\n");
}

void print_cant_open() {
    printf("Can't open the key file\n");
}
int main(int argc, char *argv[]) {
    int key_file;
    Byte got_key;
    // The only argument is a file with the key
    if (argc != 2) {
        print_usage();
        exit(1);
    }
    // Get the key
    key_file = open(argv[1], O_RDONLY);
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
    // Use the cipher
    // Input is stdin, and output is stdout
    rc4(0, 1);
    exit(0);
}
