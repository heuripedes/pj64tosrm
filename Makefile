binext=
target=pj64tosrm$(binext)
objects=pj64tosrm.o
cflags=-Wall -g -O2 $(extracflags)
lflags=
libs=

all: $(target)
clean:
	-rm -f  $(target) $(objects)

$(target): $(objects)
	$(CC) $(cflags) $(lflags) -o $@ $< $(libs)

%.o: %.c
	$(CC) $(cflags) -c -o $@ $<
