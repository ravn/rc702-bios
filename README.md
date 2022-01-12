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

    curl -o - http://www.retroarchive.org/cpm/lang/MASM-80.ZIP 
    unzip MASM-80.ZIP '*.COM'

Documentation:

* m80 - http://www.retroarchive.org/cpm/lang/MACRO-80.PDF
* l80 - http://www.retroarchive.org/cpm/lang/LINK-80.PDF

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
