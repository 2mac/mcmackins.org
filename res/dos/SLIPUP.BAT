@ECHO OFF
REM  SLIPUP.BAT - install SLIP packet driver
REM  Copyright (C) 2018 David McMackins II

REM  Copying and distribution of this file, with or without modification,
REM  are permitted in any medium without royalty provided the copyright
REM  notice and this notice are preserved. This file is offered as-is,
REM  without any warranty.

SET INT=0x60
SET IRQ=4
SET IOADDR=0x3f8
SET BAUD=115200

ETHERSL %INT% %IRQ% %IOADDR% %BAUD%
SET MTCPSLIP=true

