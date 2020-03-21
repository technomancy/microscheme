# Microscheme makefile
# (C) 2014 Ryan Suchocki
# microscheme.org

PREFIX?=/usr/local

microscheme: src/assembly_hex.c src/microscheme_hex.c src/*.c
	gcc -ggdb -std=gnu99 -Wall -Wextra -o microscheme src/*.c

src/assembly_hex.c: src/preamble.s
	echo "// Hexified internal microscheme files." > src/assembly_hex.c
	xxd -i src/preamble.s >> src/assembly_hex.c

src/microscheme_hex.c: src/primitives.ms src/stdlib.ms
	echo "// Hexified internal microscheme files." > src/microscheme_hex.c
	xxd -i src/primitives.ms >> src/microscheme_hex.c
	xxd -i src/stdlib.ms >> src/microscheme_hex.c

install: microscheme
	install -d $(PREFIX)/bin/
	install -m755 ./microscheme $(PREFIX)/bin/microscheme
	install -d $(PREFIX)/share/microscheme/
	cp -r examples/ $(PREFIX)/share/microscheme/

clean:
	rm -f microscheme src/preamble.s src/primitives.ms src/stdlib.ms

.PHONY: install clean
