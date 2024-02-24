#!/bin/bash

for i in "$@";
do
		youtube-dl --extract-audio \
		--audio-format mp3 \
		--audio-quality 0 \
		--output "~/Music/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" \
		"$i"
done
