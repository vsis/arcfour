CC=gcc

all: arcfour

arcfour: rc4.o main.c
	$(CC) $(CFLAGS) main.c -o arcfour rc4.o

saber1: rc4.o saber1.h saber1.c
	$(CC) $(CFLAGS) saber1.c -o saber1 rc4.o

clean:
	rm -vf *.o arcfour saber1
	rm -vf tests/*.tmp tests/*.diff

.PHONY: clean check

check: arcfour saber1
	./tests/run_tests.sh | column -s "|" -t
	@test ! -f tests/error.tmp # If a tests fails, an error.tmp file will be touched
