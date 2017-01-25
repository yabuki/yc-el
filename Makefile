#
#
#
######################################
# Chose Eemacs Type
EMACS = emacs
#EMACS = xemacs

#######################################
# Default settings
#
prefix = /usr/local
elispdir = $(prefix)/share/emacs/site-lisp
#elispdir = $(prefix)/lib/$(EMACS)/site-lisp
#elispdir = $(prefix)/lib/emacs
INSTALL_PATH = $(prefix)/bin
#######################################
# For Windows
#
#exesuffix = .exe # for Windows
#######################################
# For Debian GNU/Linux
#
#
#OS-TYPE=Linux
#DISTRO=Debian
#ifeq ($(OS-TYPE), Linux)
#  ifeq ($(DISTRO), Debian)
prefix = $(DESTDIR)
elispdir = $(prefix)/usr/share/emacs/site-lisp/yc-el
INSTALL_PATH = $(prefix)/usr/lib/yc-el
#  endif
#endif


elc = yc.elc
PROGRAM = icanna$(exesuffix)
OBJS = icanna.o
#CFLAGS = -g
CFLAGS = -Wall -O2 -g
CFLAGS:=$(shell dpkg-buildflags --get CFLAGS)
CC = gcc
INSTALL = install
CPPFLAGS:=$(shell dpkg-buildflags --get CPPFLAGS)
LDFLAGS:=$(shell dpkg-buildflags --get LDFLAGS)

#ifeq ($(DISTRO), Debian)
all: $(PROGRAM)
#else
#.SUFFIXES: .el .elc
#
#.el.elc:
#	$(EMACS) -batch -f batch-byte-compile $<
#
#
#all: $(PROGRAM) $(elc)
#endif


$(PROGRAM): $(OBJS)
	$(CC) $(CPPFLAGS) $(CFLANGS) $(LDFLAGS) -o $(PROGRAM) $(OBJS)

clean:
#ifeq ($(DISTRO), Debian)
	@rm -f $(OBJS) $(PROGRAM)
#else
#	@rm $(OBJS) $(PROGRAM) $(elc)
#endif

install: install-bin install-el

install-bin: $(PROGRAM)
#ifneq ($(DISTRO), Debian)
#	$(INSTALL) -m 755 -s $(PROGRAM) $(INSTALL_PATH)/$(PROGRAM)
#endif
	$(INSTALL) -m 755 $(prefix)/../../$(PROGRAM) $(INSTALL_PATH)/$(PROGRAM)

install-el: $(ELCS) $(SRCS)
#ifneq ($(DISTRO), Debian)
#	$(INSTALL) -m 644 $(elc) $(elispdir)/$(elc)
#endif
	$(INSTALL) -m 644 $(elc:.elc=.el) $(elispdir)/$(elc:.elc=.el)

uninstall: uninstall-bin uninstall-el

uninstall-bin:
	@rm $(INSTALL_PATH)/$(PROGRAM)

uninstall-el:
	@for i in $(elc:.elc=.el) $(elc); do rm $(elispdir)/$$i; done
