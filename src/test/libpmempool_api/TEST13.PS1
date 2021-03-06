# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2016-2018, Intel Corporation
#
#
# libpmempool_api/TEST13 -- test for checking API
#

. ..\unittest\unittest.ps1

require_test_type medium

require_fs_type any

setup

$POOL="$DIR\file.pool"
$LOG="out${Env:UNITTEST_NUM}.log"
$LOG_TEMP="out${Env:UNITTEST_NUM}_part.log"

rm $LOG -Force -ea si
rm $LOG_TEMP -Force -ea si

expect_normal_exit $PMEMPOOL create log $POOL

expect_normal_exit $Env:EXE_DIR\libpmempool_test$Env:EXESUFFIX -s 0 $POOL
cat -Encoding Ascii $LOG | out-file -append -encoding ascii -literalpath $LOG_TEMP
expect_normal_exit $Env:EXE_DIR\libpmempool_test$Env:EXESUFFIX -s 999999 $POOL
cat -Encoding Ascii $LOG | out-file -append -encoding ascii -literalpath $LOG_TEMP

rm $LOG -Force
mv $LOG_TEMP $LOG

check
pass
