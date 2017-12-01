CC=gcc

all: arcfour

arcfour: rc4.o main.c
	$(CC) $(CFLAGS) main.c -o arcfour rc4.o

clean:
	rm -vf *.o arcfour
	rm -vf tests/*.tmp tests/*.diff

.PHONY: clean check

check: arcfour
	bash tests/run_tests.sh
