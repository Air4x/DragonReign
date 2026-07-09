#!/usr/bin/env perl
use v5.36;

sub update_cache($path, $total_time, $idle_time){
  open my $fh, '>', $path or die "Can't open $path";
  print $fh "$total_time\n";
  print $fh "$idle_time\n";
  close $fh;
}

sub get_timings() {
  my @timings = ();
  open my $fh, '<', "/proc/stat" or die "Can't open /proc/stat";
  while (my $line = <$fh>) {
    if ($line =~ /^cpu/) {
      @timings = split(" ", $line);
      last;
    }
  }
  shift @timings;
  close $fh;
  return @timings;
}
my $cache_path = "/tmp/cputimes";

my $current_total_time = 0;
my $current_idle_time = 0;

my $old_total_time = 0;
my $old_idle_time = 0;

my $total_delta = 0;
my $idle_delta = 0;

my $busy_delta = 0;
my $cpu_load = 0;

my @timings = get_timings();

foreach (@timings) {
  $current_total_time += $_;
}

$current_idle_time = $timings[3] + $timings[4];

if (-s $cache_path){
  open my $ch, '<', $cache_path;
  $old_total_time = <$ch>;
  $old_idle_time = <$ch>;
  close $ch;
  $idle_delta = $current_idle_time - $old_idle_time;
  $total_delta = $current_total_time - $old_total_time;
  $busy_delta = $total_delta - $idle_delta;
  $cpu_load = ($busy_delta / $total_delta)*100;
  update_cache($cache_path, $current_total_time, $current_idle_time);
} else {
  my $new_total_time = 0;
  my $new_idle_time = 0; 
  sleep(2);
  @timings = get_timings();
  foreach (@timings) {
    $new_total_time += $_;
  }

  $new_idle_time = $timings[3] + $timings[4];
  $idle_delta = $new_idle_time - $current_idle_time;
  $total_delta = $new_total_time - $current_total_time;
  $busy_delta = $total_delta - $idle_delta;
  $cpu_load = ($busy_delta / $total_delta)*100;
  update_cache($cache_path, $new_total_time, $new_idle_time);
}

printf "%.2f%%\n", $cpu_load;
