# Makefile for OpenBSD's ed
# $Ragnarok: Makefile,v 1.3 2025/03/04 00:26:24 lecorbeau Exp $

CFLAGS +=	-g -O2 -I. -D_GNU_SOURCE
CPPFLAGS +=
LDFLAGS +=

PROG =	ed
OBJS =	buf.o glbl.o io.o main.o re.o sub.o undo.o \
	regcomp.o regerror.o regexec.o regfree.o \
	reallocarray.o strlcat.o strlcpy.o

all: ${PROG}

${PROG}: ${OBJS}
	${CC} ${LDFLAGS} -o ${PROG} ${OBJS}

install:
	install -d ${DESTDIR}/bin
	install -d ${DESTDIR}/usr/share/man/man1
	install -c -m 755 ${PROG} ${DESTDIR}/bin
	install -c -m 644 ed.1 ${DESTDIR}/usr/share/man/man1

test:
	@echo "No tests"

distclean:
	rm -f ${PROG} ${OBJS}
