#!/bin/perl

use strict;
use warnings;
#use Data::Dump qw(dump);

sub tmux_select_window($) {
   system('tmux', 'select-window', '-t', shift);
}

sub tmux_approx_select_window($) {
   my $win = shift;
   my @windows = sort {$a <=> $b} split("\n", `tmux list-windows -F '#I'`);

   # only one (or no?!) window, do nothing
   return if ($#windows <= 0);

   if ($win <= $windows[0]) {
      return tmux_select_window($windows[0]);
   }
   elsif ($win >= $windows[$#windows]) {
      return tmux_select_window($windows[$#windows]);
   }

   my $approx_left;

   for (@windows) {
      # wanted window is available
      return tmux_select_window($win) if ($win == $_);

      if ($_ > $win) {
         # check if right or left window is closed to the wanted window
         if ($win - $approx_left < $_ - $win) {
            return tmux_select_window($approx_left);
         }
         else {
            return tmux_select_window($_);
         }
      }

      $approx_left = $_;
   }
}

if ( $#ARGV != 0 ) {
   die "Usage: $0 <WINDOW>\n";
}

my $win = $ARGV[0];

tmux_approx_select_window($win);
