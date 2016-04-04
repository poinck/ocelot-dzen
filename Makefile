# ocelot-dzen
# 	changes since 4.4.2016 by André Klausnitzer, CC0
# dzen2
#   (C)opyright MMVII Robert Manea

include config.mk

SRC = draw.c main.c util.c action.c
OBJ = ${SRC:.c=.o}

all: options ocelot-dzen

options:
	@echo oceleot-dzen build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo "LD       = ${LD}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: dzen.h action.h config.mk

ocelot-dzen: ${OBJ}
	@echo LD $@
	@${LD} -o $@ ${OBJ} ${LDFLAGS}
	@strip $@
	@echo "Run ./help for documentation"

clean:
	@echo cleaning
	@rm -f ocelot-dzen ${OBJ} ocelot-dzen-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p ocelot-dzen-${VERSION}
	@mkdir -p ocelot-dzen-${VERSION}/gadgets
	@mkdir -p ocelot-dzen-${VERSION}/bitmaps
	@cp -R CREDITS LICENSE Makefile INSTALL README.dzen README help config.mk action.h dzen.h ${SRC} ocelot-dzen-${VERSION}
	@cp -R gadgets/Makefile  gadgets/config.mk gadgets/README.dbar gadgets/textwidth.c gadgets/README.textwidth gadgets/dbar.c gadgets/gdbar.c gadgets/README.gdbar gadgets/gcpubar.c gadgets/README.gcpubar gadgets/kittscanner.sh gadgets/README.kittscanner gadgets/noisyalert.sh ocelot-dzen-${VERSION}/gadgets
	@cp -R bitmaps/alert.xbm bitmaps/ball.xbm bitmaps/battery.xbm bitmaps/envelope.xbm bitmaps/volume.xbm bitmaps/pause.xbm bitmaps/play.xbm bitmaps/music.xbm  ocelot-dzen-${VERSION}/bitmaps
	@tar -cf ocelot-dzen-${VERSION}.tar ocelot-dzen-${VERSION}
	@gzip ocelot-dzen-${VERSION}.tar
	@rm -rf ocelot-dzen-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ocelot-dzen ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/ocelot-dzen

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/ocelot-dzen

.PHONY: all options clean dist install uninstall
