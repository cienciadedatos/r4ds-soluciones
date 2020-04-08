#!/bin/sh

if [ -d diagrams_w_text_as_path ]; then
	rm -rf diagrams_w_text_as_path
fi

if [ ! -d diagrams_w_text_as_path ]; then
	cp -r diagrams diagrams_w_text_as_path

  for file in diagrams_w_text_as_path/*/*.svg
    do
      inkscape $file --export-text-to-path --export-plain-svg=$file
    done
fi
