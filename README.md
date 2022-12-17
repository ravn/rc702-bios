# RC700-bios

![front of old print](IMG_9878.jpeg)

I reverse engineered the RC702 bios on the system I got from DIKU when
they upgraded their computer terminal rooms in the early eighties to
get keyboard and serial buffering (otherwise the 19.2k modem was too
fast).

This is the various files I've found on the 8" floppies I still had
around in 2021. It turned out that since I printed out the listing on
1993-04-19 I added LaTeX, Disk and ISO-8859-1 keyboard support
labelled 1993-07-25 (most likely for QTERM modem communications to
IMADA).

To get the utilities on MacOS, run

    curl -O http://www.retroarchive.org/cpm/lang/MASM-80.ZIP 
    unzip MASM-80.ZIP '*.COM'

Manuals at http://www.jbox.dk/rc702/manuals.shtm and
http://www.cpm.z80.de/manuals/zsid-m.pdf

I've used RunCPM (https://github.com/MockbaTheBorg/RunCPM)
to run the build on my Mac.  What took five minutes now takes 1-2 seconds.

To build inside CP/M (or an emulator), run

```
m80 =ccore/z/c
m80 =c/z/c
l80 ccore,c,c/n/y/e
cref80 =c
```

A `m.sub` file for compiling, linking and debugging:

```
m80 =$1
link $1
zsid $1.com $1.sym
```


Documentation:

* m80 - http://www.retroarchive.org/cpm/lang/MACRO-80.PDF
* l80 - http://www.retroarchive.org/cpm/lang/LINK-80.PDF

Note about CREF80 `.CRF` file:

* ^A marks start of "identifier _defined_ on this line"
* ^B marks start of "identifier _referred to_ on this line".  They come in the same order as in the source.
* ^C rest of the line is a source line, copy it, and increment the line number.

so 

    dummy2: DW	terminit+linelength-printbyte

becomes

    ^BDUMMY2^ATERMINIT^ALINELENGTH^APRINTBYTE^C  E927    003E                  dummy2: DW	terminit+linelength-printbyte

## Note on SUBMIT

SUBMIT is a simple tool to submit multiple commands at once from a file.

From http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch1.htm#Section_1.6.7: 
Command line parameters are on the form `$1`..`$9`.  $ is `$$`.  Control characters are on the form `^X`.

The `$$$.SUB´ file written contains one 128-byte record pr line in _reverse_ order.  Each record starts with a byte indicating the length of that command
line, and the command line, and a ASCII zero. The rest is padding.

Work in progress: 

    echo DIR A: |  perl -ne 's/[\r\n]//g; print chr(length($_)).$_.chr(0)' > '../RunCPM/RunCPM/A/0/$$$.SUB'

## Using a PC to read RC702/RC759 diskettes

A long while back I spent some time making 22DISK from Sydex
read/write the CP/M 5¼ diskettes I had laying around.

The following definitions worked with version 1.40 of 22DISK:


```
BEGIN R702 Rc702 Piccolo - SSDD 48 tpi 5.25"
DENSITY MFM ,LOW
CYLINDERS 36
SIDES 2
SECTORS 9,512
SIDE1 0 1,3,5,7,9,2,4,6,8
SIDE2 1 1,3,5,7,9,2,4,6,8
BSH 4 BLM 15 EXM 1 DSM 135 DRM 127 AL0 0C0H AL1 0 SOFS 36
END

BEGIN LINE RC Piccoline - 5.25" DSHD
DENSITY MFM ,HIGH
CYLINDERS 77
SIDES 2
SECTORS 8,1024
SIDE1 0 1,2,3,4,5,6,7,8
SIDE2 1 1,2,3,4,5,6,7,8
ORDER SIDES
BSH 4 BLM 15 EXM 0 DSM 616 DRM 511 AL0 011111111b AL1 0 SOFS 32
END
```
