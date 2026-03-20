#!/bin/bash
dunstctl set-paused true

env \
  XSECURELOCK_SAVER="$HOME/bin/lock-saver.sh" \
  XSECURELOCK_SHOW_DATETIME=1 \
  XSECURELOCK_DATETIME_FORMAT="%H:%M" \
  XSECURELOCK_BLANK_TIMEOUT=300 \
  XSECURELOCK_BLANK_DPMS_STATE="off" \
  XSECURELOCK_NO_COMPOSITE=1 \
  xsecurelock

dunstctl set-paused false
