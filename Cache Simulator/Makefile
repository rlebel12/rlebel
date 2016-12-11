default: clean make clang run


make: cacheSim.c
	gcc -g -O0 cacheSim.c

clean:
	rm -f a.out 

run:
	./a.out

gdb:
	gdb --args a.out

clang:
	clang-check --analyze cacheSim.c -- -g -O0
