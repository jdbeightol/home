#!/bin/bash

# To install yabai from head, run the following command.
#brew install koekeishiya/formulae/yabai --HEAD
codesign -fs 'yabai-cert' $(which yabai)

