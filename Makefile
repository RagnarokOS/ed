# Makefile for OpenBSD's ed
# $Ragnarok: Makefile,v 1.2 2024/03/01 16:41:47 lecorbeau Exp $

CC =		clang
CFLAGS +=	-g -O2 -I. -D_GNU_SOURCE -flto=thin -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security \
		-fstack-clash-protection -fstack-protector-strong -fcf-protection
LDFLAGS +=	-flto=thin -Wl,-O2 -Wl,-z,relro,-z,now -Wl,--as-needed

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
	install -c -s -m 755 ${PROG} ${DESTDIR}/bin
	install -c -m 644 ed.1 ${DESTDIR}/usr/share/man/man1

test:
	@echo "No tests"

distclean:
	rm -f ${PROG} ${OBJS}
