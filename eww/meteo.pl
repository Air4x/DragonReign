#!/usr/bin/env perl
use v5.36;
use utf8;
use HTTP::Tiny;
use JSON::PP;
use File::Spec;

sub get_key ($path) {
  open my $fh, "<", $path or die "get_key: can't open $path";
  my $key = <$fh>;
  close $fh;
  return $key;
}

# hash of icon codes -> icon character
my %icons = (
	     '01d' => "󰖙",
	     '02d' => "󰖕",
	     '03d' => "󰖐",
	     '04d' => "",
	     '09d' => "",
	     '10d' => "󰼳",
	     '11d' => "󰖓",
	     '13d' => "󰼶",
	     '50d' => "󰖑",
	     '01n' => "󰖔",
	     '02n' => "󰼱",
	     '03n' => "󰖐",
	     '04n' => "",
	     '09n' => "",
	     '10n' => "󰖖",
	     '11n' => "󰖓",
	     '13n' => "󰼶",
	     '50n' => "󰖑",
	     );

my $key_path = File::Spec->catdir($ENV{HOME}, ".config", "openweathermap", "key");
my $base_url = "http://api.openweathermap.org/data/2.5/weather?";
my $lat = 41.24;
my $lon = 13.93;
my $key = get_key($key_path);

# hash containig all the data we care about
my %weather = ();

my $url = $base_url . "lat=" . $lat . "&lon=" . $lon . "&appid=" . $key . "&units=metric"."&lang=it";

my $response = HTTP::Tiny->new->get($url);
die "Failed!\n" unless $response->{success};

# it gives back a hash
my $data = decode_json $response->{content};

$weather{temp} = $data->{main}->{temp};
$weather{temp_felt} = $data->{main}->{feels_like};
$weather{humidity} = $data->{main}->{humidity};
$weather{condition} = $data->{weather}[0]->{description};
$weather{wind_speed} = $data->{wind}->{gust};
$weather{icon} = $icons{$data->{weather}[0]->{icon}};


print encode_json(\%weather);
