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

dd=dd if=/dev/urandom count=1

all: $(target)
clean:
	-rm -f  $(target) $(objects)
test: all
	@rm -f test.*
	@echo 4kbit eeprom test
	@rm -f test.*
	@$(dd) of=test.eep bs=512 &> /dev/null
	@md5sum test.eep &> test.md5
	@./$(target) test.eep  > /dev/null
	@rm -f test.eep
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	
	@rm -f test.*
	@echo 16kbit eeprom test
	@rm -f test.*
	@$(dd) of=test.eep bs=2048 &> /dev/null
	@md5sum test.eep &> test.md5
	@./$(target) test.eep  > /dev/null
	@rm -f test.eep
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	
	@rm -f test.*
	@echo mempack test
	@rm -f test.*
	@$(dd) of=test.mpk bs=131072 &> /dev/null
	@md5sum test.mpk &> test.md5
	@./$(target) test.mpk  > /dev/null
	@rm -f test.mpk
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	
	@rm -f test.*
	@echo sram test
	@rm -f test.*
	@$(dd) of=test.sra bs=32768 &> /dev/null
	@md5sum test.sra &> test.md5
	@./$(target) test.sra  > /dev/null
	@rm -f test.sra
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	
	@rm -f test.*
	@echo flashram test
	@rm -f test.*
	@$(dd) of=test.fla bs=131072 &> /dev/null
	@md5sum test.fla &> test.md5
	@./$(target) test.fla  > /dev/null
	@rm -f test.fla
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	
	@echo full file 4kbit eeprom test
	@rm -f test.*
	@$(dd) of=test.eep bs=512 &> /dev/null
	@$(dd) of=test.mpk bs=131072 &> /dev/null
	@$(dd) of=test.sra bs=32768 &> /dev/null
	@$(dd) of=test.fla bs=131072 &> /dev/null
	@md5sum test.eep test.mpk test.sra test.fla &> test.md5
	@./$(target) test.eep test.mpk test.sra test.fla > /dev/null
	@rm -f test.eep test.mpk test.sra test.fla
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	
	@echo full file 16kbit eeprom test
	@rm -f test.*
	@$(dd) of=test.eep bs=2048 &> /dev/null
	@$(dd) of=test.mpk bs=131072 &> /dev/null
	@$(dd) of=test.sra bs=32768 &> /dev/null
	@$(dd) of=test.fla bs=131072 &> /dev/null
	@md5sum test.eep test.mpk test.sra test.fla &> test.md5
	@./$(target) test.eep test.mpk test.sra test.fla > /dev/null
	@rm -f test.eep test.mpk test.sra test.fla
	@./$(target) test.srm > /dev/null
	@md5sum --check < test.md5
	@rm -f test.md5
	

$(target): $(objects)
	$(CC) $(cflags) $(lflags) -o $@ $< $(libs)

%.o: %.c
	$(CC) $(cflags) -c -o $@ $<
