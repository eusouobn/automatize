#!/bin/bash -eux

sleep 35

BT="bluez_output.85_F0_F0_82_51_21.a2dp-sink"



INPUTS=`pactl list sink-inputs short | cut -f 1`
for i in $INPUTS; do
  pactl move-sink-input $i "${BT}"
done