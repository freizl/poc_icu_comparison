# Compiler and compilation options
CC = gcc
CFLAGS = -Wall -Wextra
LDFLAGS = -I/opt/homebrew/Cellar/icu4c/73.2/include -L/opt/homebrew/Cellar/icu4c/73.2/lib
LIBS = -licui18n -licuuc -licudata

# Source and executable files
SRC = icu_string_comparison.c
EXEC = icu_string_comparison

all: $(EXEC)

$(EXEC): $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)

clean:
	rm -f $(EXEC)

run: $(EXEC)
	./$(EXEC)

helloworld:
	(echo "locked_by"; echo "lock_note";) | LC_COLLATE=en_US.UTF-8 sort --debug

versions:
	sort --version
	uname -a
	uconv --version
	# icu-config --version

.PHONY: all clean
