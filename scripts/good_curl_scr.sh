#! /bin/bash
#

# saved good scripts for used curl

curl -I https://pai-bx.com 2>/dev/null | head -n 1 | cut -d$' ' -f2
