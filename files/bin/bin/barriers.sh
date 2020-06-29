#!/bin/bash
screen -dmSL barriers barriers -c /home/dave10/barrier.conf -d INFO -n dave-kubuntu --screen-change-script /home/dave10/scripts/barrier/onchange.sh -f
