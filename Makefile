binext=
target=pj64tosrm$(binext)
objects=pj64tosrm.o
cflags=-Wall
lflags=
libs=

ifeq ($(debug),1)
    cflags += -ggdb
else
    cflags += -s -O2
endif

cflags += $(extracflags)

all: $(target)
clean:
	-rm -f  $(target) $(objects)

$(target): $(objects)
	$(CC) $(cflags) $(lflags) -o $@ $< $(libs)

%.o: %.c
	$(CC) $(cflags) -c -o $@ $<
