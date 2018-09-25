#!/bin/bash

rm -f /usr/share/info/dir
for f in /usr/share/info/* ; do
	install-info $f dir 2> /dev/null
done
