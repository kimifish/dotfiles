#!/usr/bin/env bash

text="$1"
ccol="$2"
pcol="$3"
fgcol="$4"

printf '<span stretch="ultracondensed" foreground="%s" background="%s"></span>' "$ccol" "$fgcol"
printf '<span foreground="%s" background="%s">%s</span>' "$fgcol" "$ccol" "$text"
printf '<span foreground="%s" background="%s"></span>' "$pcol" "$ccol"
printf '<span stretch="ultracondensed" foreground="%s" background="%s"></span>\n' "$fgcol" "$pcol"
