# RC700-bios

![front of old print][IMG_9878.jpeg]

I reverse engineered the RC702 bios to get keyboard and serial buffering (otherwise the 19.2k modem was too fast).

This is the various files I've found on the 8" floppies I still had around in 2021.

To get the utilities on MacOS, run

    curl -o - http://www.retroarchive.org/cpm/lang/MASM-80.ZIP 
    unzip MASM-80.ZIP '*.COM'

Documentation:

* m80 - http://www.retroarchive.org/cpm/lang/MACRO-80.PDF
* l80 - http://www.retroarchive.org/cpm/lang/LINK-80.PDF
