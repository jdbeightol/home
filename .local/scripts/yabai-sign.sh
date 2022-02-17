#!/bin/bash

brew install koekeishiya/formulae/yabai --HEAD
codesign -fs 'yabai-cert' $(which yabai)

