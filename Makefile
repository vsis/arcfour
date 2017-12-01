CC=gcc

all: arcfour

arcfour: rc4.o main.c
	$(CC) $(CFLAGS) main.c -o arcfour rc4.o

clean:
	rm -vf *.o arcfour

.PHONY: clean