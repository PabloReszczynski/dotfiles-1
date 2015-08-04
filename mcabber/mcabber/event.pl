#!/bin/perl

use strict;
use warnings;

my @play = ( "mpv", "/usr/share/sounds/freedesktop/stereo/message.oga" );
my @notify = ( "notify-send" );

my ($action, $type, $source, $file) = @ARGV;

my $msg;
if ($file)
{
   open(my $fh, "<", $file);

   $msg = <$fh>;
   $msg = substr($msg, 0, 100) . "..."
      if (length($msg) > 100);
  
   close($fh);
   unlink($file);
}

if ($action eq "MSG")
{
   if ($type eq "IN" || $type eq "MUC")
   {
      system @notify, "-i", "main-unread", $source, $msg;
      system @play;
   }
}
elsif ($action eq "STATUS")
{
   exit;

   $type =~ s/_/Offline/ ||
   $type =~ s/A/Away/ ||
   $type =~ s/D/DND/ ||
   $type =~ s/F/Free/ ||
   $type =~ s/O/Online/ ||
   $type =~ s/N/Not available/;

   system @notify, "$type $source";
}
