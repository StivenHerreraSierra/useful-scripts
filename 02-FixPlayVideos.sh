#!/bin/bash

# The next commands were copied from: https://www.reddit.com/r/Fedora/comments/du3lhg/after_the_update_to_fedora_31_trying_to_watch/

sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf -y install ffmpeg --allowerasing
