#!/usr/bin/env perl
use v5.36;
use IPC::Open2;
use JSON::PP;
use English;

$OUTPUT_AUTOFLUSH = 1;

my @ws = ({name =>  "1",	focus => JSON::PP::false},
	  {name =>  "2",	focus => JSON::PP::false},
	  {name =>  "3",	focus => JSON::PP::false},
	  {name =>  "4",	focus => JSON::PP::false},
	  {name =>  "5",	focus => JSON::PP::false},
	  {name =>  "6",	focus => JSON::PP::false},
	  {name =>  "7",	focus => JSON::PP::false},
	  {name =>  "8",	focus => JSON::PP::false},
	  {name =>  "9",	focus => JSON::PP::false},
	  {name => "10",	focus => JSON::PP::false});

sub get_ws_data ($data_ref, $ws_ref) {
  foreach my $ws (@$ws_ref) {
    $ws->{focus} = JSON::PP::false;
  }
  foreach my $workspace (@$data_ref) {
    $ws_ref->[$workspace->{num}-1] = {name => $workspace->{name},
				    focus => $workspace->{focused}};
  }
}



# we start swaymsg with --monitor and every time it produce
# something we call swaymsg with get_workspaces and we do
# some wrangling to output a json string with just the needed
# data

my $monitor_pid = open2(my $monitor_out, my $monitor_in,
			'swaymsg',
			'--raw',
			'--monitor',
			'-t' ,
			'subscribe' ,
			'["workspace"]');

while (my $ignore = <$monitor_out>) {
  my $out = `swaymsg -t get_workspaces --raw`;
  my $data = decode_json($out);
  get_ws_data($data, \@ws);
  print encode_json(\@ws), "\n";
}
