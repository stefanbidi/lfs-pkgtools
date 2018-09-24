# Pkgtools for Linux From Scratch

This project provides instructions and build scripts for packages in the Linux
From Scratch book, allowing users to more easily keep track of and upgrade
packages in the LFS system using the `pkgtools` utilities.

Pkgtools is the package management system used by
[Slackware](https://www.slackware.com). It is one of the simplest package
systems available. The tools are actully shell scripts requiring only a Bourne-
compatible shell and tar version 1.13. This package management system does not
provide any dependency tracking, and build scripts are very simple.

## Getting the Required Packages

### Tar version 1.13 - 1028 KB:
Dowload: [https://ftp.gnu.org/gnu/tar/tar-1.13.tar.gz](https://ftp.gnu.org/gnu/tar/tar-1.13.tar.gz)

MD5 sum: `402a54bdde58dec411ea844b75cf5804`

### Dialog - 295 KB
Download: [https://mirrors.slackware.com/slackware/slackware-14.2/source/a/dialog/dialog-1.2-20130523.tar.xz](https://mirrors.slackware.com/slackware/slackware-14.2/source/a/dialog/dialog-1.2-20130523.tar.xz)

MD5 sum: `2c2b7dd7d1bc6f809ed00739f152648f`

## How to Install in the Temporary System

Adding pkgtools to Linux From Scratch is very easy. After building all packages
in the temporary system (Chapter 5), but before stripping and changing
ownership, install the additional packages described in this section.

### Installation Tar version 1.13

Configure tar:

	./configure --prefix=/tools \
		--disable-nls

Compile the package:

	make

If desired, run the test suite. This step is not mandatory. To run the Tar test
suite, issue the following command:

	make check

Install tar-1.13:

	install -m0755 src/tar /tools/bin/tar-1.13

### Installation of Pkgtools

Install the shell scripts into the `/tools/sbin` directory:

	for prog in installpkg makepkg removepkg; do
		install -m755 $prog /tools/sbin/
	done

## Installing in the LFS System

This is the easiest part. Simply run the .SlackBuild scripts provided to create
the corresponding package in the same order as is the LFS book. Before we can
use the build scripts, however, add the following instructions to Section 6.6 -
Creating Essential Files and Symlinks:

	for prog in installpkg makepkg removepkg; do
		ln -sv /tools/sbin/$prog /sbin/
	done
	export USE_TMP_TOOLS=yes

Make sure to run the `pkgtools.SlackBuild` script before any other scripts.
This will ensure that the necessary tools are available during the installation
process.

Additionally, run the `dialog.SlackBuild` script to install the `dialog`
program. Dialog is used by the `pkgtool` utility to provide a menu-driven,
and interactive system in install, remove, or view software packages.

All packages are created in the `/tmp` directory, and must be installed before
creating the next package. To install packages run the following command:

	/sbin/installpkg /tmp/<name of package file>

