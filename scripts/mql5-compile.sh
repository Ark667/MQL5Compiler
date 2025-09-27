#!/usr/bin/env bash

# Use: ./mql5-compile.sh Experts/Testing/ConfigurationTest.mq5

if [ $# -lt 1 ]; then
  echo "Use: $0 <Path to .mq5 realtive to /work>"
  exit 1
fi

# Compile the EA
wine /opt/mql/metaeditor64.exe  \
    /portable  \
    /compile:"Z:/work/$1"  \
    /inc:Z:/work   \
    /log:"Z:/work/compile.log"

# Show compile log and delete it
cat /work/compile.log
rm /work/compile.log
