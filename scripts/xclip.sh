#! /bin/bash
# Copy xhronx ssh key to clipboard

# sudo apt install xclip -y
xclip -selection clipboard -in ~/.ssh/id_rsa.pub
