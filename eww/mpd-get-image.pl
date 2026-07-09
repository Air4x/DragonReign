#!/usr/bin/env perl
use v5.36;
use utf8;
use File::Spec;

my $base_dir = File::Spec->catdir($ENV{HOME}, "Musica/");
my $fallback_cover = File::Spec->catdir($ENV{HOME}. "Immagini/", "fallback_cover.png");

my $current_file = `mpc --format %file% current`;
chomp $current_file;
my ($volume, $dir, $file) = File::Spec->splitpath($current_file);

my $cover_path = File::Spec->catdir($base_dir, $dir,"cover.jpg");

if (-e $cover_path) {
  print $cover_path;
} else {
  print $fallback_cover;
}
