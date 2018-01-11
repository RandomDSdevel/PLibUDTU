#!/usr/bin/env perl

# Derived from the script given by Unix & Linux Stack Exchange (<https://unix.stackexchange.com/>) user devtell (<https://unix.stackexchange.com/users/9960/dewtell>) in <https://unix.stackexchange.com/a/18979/86927>.  
#
# Changes made in this copy:  
# * Used `/usr/bin/env` to find Perl in this script's shebang line for portability and future-proofing.  
# * Manually linted this script's embedded comments to suit my stylistic proclivities.  In particular:  
#   * Normalized capitalization.  
#   * Made sure each comment was a near-complete sentence for slight (debatable) readability improvements.  
# * Changed this script's indentation style from using 3 spaces for each level of indentation to using 2 spaces for each level of indentation.  
# * Normalized ellipses to use their single-character Unicode encoding/representation.  
#
# Usage:  
#
#      Run this program over an arbitrary text file produced by another, such as one run inside a shell, that litters its output with ANSI control sequences.  Alternatively, insert this script into the path of output which would, when saved to a text file, likewise be littered with ANSI control sequences, either by adding it to a pipeline or involving it in a process substitution.  

while (<>) {
  s/ \e[ #%()*+\-.\/]. |
    \r | # Also remove extra carriage returns.  
    (?:\e\[|\x9b) [ -?]* [@-~] | # CSI … Cmd
    (?:\e\]|\x9d) .*? (?:\e\\|[\a\x9c]) | # OSC … (ST|BEL)
    (?:\e[P^_]|[\x90\x9e\x9f]) .*? (?:\e\\|\x9c) | # (DCS|PM|APC) … ST
    \e.|[\x80-\x9f] //xg;
    1 while s/[^\b][\b]//g; # Remove all non-backspace characters followed by backspaces.  
  print;
}
