@ECHO OFF
REM  SLIPDOWN.BAT - uninstall SLIP packet driver
REM  Copyright (C) 2018 David McMackins II

REM  Copying and distribution of this file, with or without modification,
REM  are permitted in any medium without royalty provided the copyright
REM  notice and this notice are preserved. This file is offered as-is,
REM  without any warranty.

ETHERSL -u 0x60
SET MTCPSLIP=
