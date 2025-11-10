.PHONY: all clean run test

all: asm c cpp hs java rs

asm: dirs
	nasm -f elf64 -o mndlasm.o -w-label-orphan src/mndl.asm && ld -o bin/mndlasm mndlasm.o
	rm mndlasm.o

c: dirs
	gcc src/mndl.c -lm -o bin/mndlc
	
cpp: dirs
	g++ src/mndl.cpp -o bin/mndlcpp

hs: dirs
	ghc src/mndl.hs -o bin/mndlhs -outputdir .
	rm Main.hi Main.o

java: dirs
	javac src/Mndl.java -d bin
	
rs: dirs
	rustc src/mndl.rs -o bin/mndlrs


dirs:
	mkdir bin test
	
clean:
	rm -f bin/*
	rm -f test/*
	rmdir bin test
	
run:
	echo "***mndlasm***";\
	bin/mndlasm;\
	echo "***mndlc***";\
	bin/mndlc;\
	echo "***mndlcpp***";\
	bin/mndlcpp;\
	echo "***mndlhs***";\
	bin/mndlhs;\
	echo "***Mndl.class***";\
	java -cp bin Mndl;\
	echo "***mndl.lua***";\
	lua src/mndl.lua;\
	echo "***mndl.py***";\
	python3 src/mndl.py;\
	echo "***mndlrs***";\
	bin/mndlrs

test:
	bin/mndlasm > test/asm
	bin/mndlc > test/c
	bin/mndlcpp > test/cpp
	bin/mndlhs > test/hs
	java -cp bin Mndl > test/java
	lua src/mndl.lua > test/lua
	python3 src/mndl.py > test/py
	bin/mndlrs > test/rs
	diff test/asm test/c > test/diffs
	diff test/asm test/cpp >> test/diffs
	diff test/asm test/hs >> test/diffs
	diff test/asm test/java >> test/diffs
	diff test/asm test/lua >> test/diffs
	diff test/asm test/py >> test/diffs
	diff test/asm test/rs >> test/diffs
	if [ -f test/diffs ] && [ ! -s test/diffs ]; then echo "Tests succeeded"; else echo "Tests failed"; fi
