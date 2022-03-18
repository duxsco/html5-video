#!/usr/bin/env bash

set -euo pipefail

if [ $# -ne 1 ] || [ -z $1 ]; then
  echo "You need to pass one input video file: bash encode.sh videoFile"
  exit 1
fi

SRC="$1"
ORIG_HEIGHT="$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of default=nw=1:nk=1 "${SRC}")"

# video quality (-crf #): https://developers.google.com/media/vp9/settings/vod/#quality
declare -A WEBM_VIDEO_QUALITY
WEBM_VIDEO_QUALITY[240]=37
WEBM_VIDEO_QUALITY[360]=36
WEBM_VIDEO_QUALITY[480]=33
WEBM_VIDEO_QUALITY[720]=32
WEBM_VIDEO_QUALITY[1080]=31
WEBM_VIDEO_QUALITY[1440]=24
WEBM_VIDEO_QUALITY[2160]=15

for HEIGHT in "${!WEBM_VIDEO_QUALITY[@]}"; do
  if [[ ${HEIGHT} -le ${ORIG_HEIGHT} ]]; then
    if [[ ${HEIGHT} -ne ${ORIG_HEIGHT} ]]; then
      SCALE="-vf scale=-2:${HEIGHT}"
    else
      SCALE=""
    fi

    # audio quality (-q:a #): https://wiki.hydrogenaud.io/index.php?title=Recommended_Ogg_Vorbis#Recommended_Encoder_Settings
    # shellcheck disable=SC2086
    ffmpeg -i "${SRC}" \
      ${SCALE} \
      -movflags +faststart \
      -c:v libvpx-vp9 -b:v 0 -crf "${WEBM_VIDEO_QUALITY[${HEIGHT}]}" \
      -c:a libvorbis -q:a 3 \
      "${SRC%.*}_vp9_${HEIGHT}p.webm"

    # shellcheck disable=SC2086
    ffmpeg -i "${SRC}" \
      ${SCALE} \
      -movflags +faststart \
      -c:v libaom-av1 -b:v 0 -crf "${WEBM_VIDEO_QUALITY[${HEIGHT}]}" \
      -c:a libopus -b:a 128k \
      "${SRC%.*}_av1_${HEIGHT}p.webm"

    # shellcheck disable=SC2086
    ffmpeg -i "${SRC}" \
      ${SCALE} \
      -movflags +faststart \
      -c:v libx264 -preset slow -crf 23 \
      -c:a aac -b:a 128k \
      "${SRC%.*}_h264_${HEIGHT}p.mp4"
    
    # shellcheck disable=SC2086
    ffmpeg -i "${SRC}" \
      ${SCALE} \
      -movflags +faststart \
      -c:v libx265 -tag:v hvc1 -preset slow -crf 28 \
      -c:a aac -b:a 128k \
      "${SRC%.*}_h265_${HEIGHT}p.mp4"
  fi
done
