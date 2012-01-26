libdir = $(shell pkg-config --variable=libdir vlc-plugin )
vlclibdir = $(libdir)/vlc

all: libwatcheditscrobbler_plugin.so

libx264_plugin.so: libwatcheditscrobbler_plugin.o
        gcc -shared -std=gnu99 $< `pkg-config  --libs vlc-plugin watcheditscrobbler`  -Wl,-soname -Wl,$@ -o $@

libx264_plugin.o: src/scrobbler.c
        gcc -c -std=gnu99  $< `pkg-config  --cflags vlc-plugin watcheditscrobbler` -D__PLUGIN__  -DMODULE_STRING=\"x264\" -o $@

clean:
        rm -f libwatcheditscrobbler.o libwatcheditscrobbler.so

install: all
        mkdir -p $(DESTDIR)$(vlclibdir)/
        install -m 0755 libwatcheditscrobbler_plugin.so $(DESTDIR)$(vlclibdir)/

install-strip: all
        mkdir -p $(DESTDIR)$(vlclibdir)/
        install -s -m 0755 libwatcheditscrobbler_plugin.so $(DESTDIR)$(vlclibdir)/

uninstall:
        rm -f -- $(DESTDIR)$(vlclibdir)/libwatcheditscrobbler.so

.PHONY: all clean install uninstall
