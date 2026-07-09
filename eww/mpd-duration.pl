#!/usr/bin/env perl
use v5.36;
use utf8;
use JSON::PP;


my %state = ();

$state{current_time} =`mpc status %currenttime%`;
$state{total_time} = `mpc status %totaltime%`;
chomp $state{current_time};
chomp $state{total_time};
$state{text} = "$state{current_time}/$state{total_time}";

my ($elapsed_m, $elapsed_s) = split /:/, $state{current_time};
my ($total_m, $total_s) = split /:/, $state{total_time};

my $elapsed = $elapsed_s + ($elapsed_m * 60);
my $total = $total_s + ($total_m * 60);
my $done = ($elapsed / $total) * 100;
$state{done} = int($done * 100) / 100;
print encode_json(\%state);
