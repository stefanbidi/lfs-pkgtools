#!/bin/sh

# Enable shadowed user and group passwords.
# There are no ill side-effects in running these programs when shadow is
# already enabled.
pwconv
grpconv
