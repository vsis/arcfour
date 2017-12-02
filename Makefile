CC=gcc

all: arcfour

arcfour: rc4.o main.c
	$(CC) $(CFLAGS) main.c -o arcfour rc4.o

clean:
	rm -vf *.o arcfour
	rm -vf tests/*.tmp tests/*.diff

.PHONY: clean check

check: arcfour
	./tests/run_tests.sh | column -s "|" -t
	@test ! -f tests/error.tmp # If a tests fails, an error.tmp file will be touched
