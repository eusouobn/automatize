#!/bin/bash -eux

HEADSET="alsa_output.usb-Logitech_Logitech_USB_Headset-00.analog-stereo"
HEADSET_MIC="alsa_input.usb-Logitech_Logitech_USB_Headset-00.analog-mono"


#pacmd list-sink-inputs
#pacmd list-source-outputs

pacmd stat | grep -E '^Default (sink|source) name'

pacmd "set-default-sink ${HEADSET}"
pacmd "set-default-source ${HEADSET_MIC}"

pactl set-sink-mute "${HEADSET}" 0
pactl set-sink-volume "${HEADSET}" 70%

pactl set-source-mute "${HEADSET_MIC}" 0
pactl set-source-volume "${HEADSET_MIC}" 50%


INPUTS=`pactl list sink-inputs short | cut -f 1`
for i in $INPUTS; do
  pactl move-sink-input $i "${HEADSET}"
done

OUTPUTS=`pactl list source-outputs short | cut -f 1`
for i in $OUTPUTS; do
  pactl move-source-output $i "${HEADSET_MIC}"
done

pacmd stat | grep -E '^Default (sink|source) name'