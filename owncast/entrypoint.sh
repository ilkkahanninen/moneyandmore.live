#!/bin/sh
./owncast & pid=$!
./setup.sh

trap "kill $pid" SIGINT
wait $pid
