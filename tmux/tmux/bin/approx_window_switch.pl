#!/bin/perl

use strict;
use warnings;
#use Data::Dump qw(dump);

sub tmux_select_window($) {
   system("tmux", "select-window", "-t", shift);
}

sub tmux_approx_select_window($) {
   my $win = shift;
   my @windows = sort {$a <=> $b} split("\n", `tmux list-windows -F '#I'`);

   # only one window, do nothing
   return if ($#windows == 0);

   if ($win <= $windows[0]) {
      return tmux_select_window($windows[0]);
   }

   if ($win >= $windows[$#windows]) {
      return tmux_select_window($windows[$#windows]);
   }

   my $approx_left;

   for (@windows) {
      $approx_left = $_;

      if ($win == $_) {
         return tmux_select_window($win);
      }
      elsif ($_ > $win) {
         if ($win - $approx_left < $_ - $win) {
            return tmux_select_window($approx_left);
         } else {
            return tmux_select_window($_);
         }
      }
   }

   die "I don't know why I reached here.";
}

if ( $#ARGV != 0 ) {
   die "Usage: $0 <WINDOW>\n";
}

my $win = $ARGV[0];

tmux_approx_select_window($win);
