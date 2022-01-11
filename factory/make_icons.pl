#!/usr/bin/perl -w

use v5.14;
use strict;

my $ExportPng = 0;
my $ExportPdf = 0;

sub ReadFileOrDie {
	my ($fileName) = @_;
	my ($data);
	local $/ = undef;   # Read complete files

	if (open(IN, "<$fileName")) {
		$data=<IN>;
		close IN;
		return $data;
	}
	die "ReadFileOrDie: not found: $fileName";
}

sub WriteStringToFile {
	my ($file, $string) = @_;

	# print "Writing $file\n";
	open (OUT, ">$file") or confess("cant write $file: $!");
	binmode OUT, ":utf8";
	print OUT  $string;
	close OUT;
}

sub OffsetPath {
	my ($path, $dx, $dy) = @_;

	$path =~ s/<path/<path transform="translate($dx, $dy)"/ or die;
	return $path;
}

sub DuplicatePath {
	my ($path, $number) = @_;

	if ($number == 2) {
		return &OffsetPath($path, 0, -30) . &OffsetPath($path, 0, 30)
	} else {
		return &OffsetPath($path, -31, 0) . &OffsetPath($path, 31, -31) . &OffsetPath($path, 31, 31);
	}
}

sub MakeSvg {
	my ($input, $color, $pattern, $number) = @_;
	
	my $svg = &ReadFileOrDie($input);

	# Apply the color
	$svg =~ s/#00ff00/$color/ig;

	# Apply the pattern
	given ($pattern) {
		when ('solid') {
			$svg =~ s/fill:url\(.*?\)/fill:$color/g;
		}
		when ('outline') {
			$svg =~ s/fill:url\(.*?\)/fill:none/g;
		}
	}

	# Apply the number
	if ($number > 1) {
		$svg =~ s/(<path\s[^>]*d="m.*?>)/&DuplicatePath($1, $number)/se  or die 'Could not find duplicate path.';
	}

	return $svg;
}

sub Run {
	my @filenames = qw/ circle.svg triangle.svg star.svg /;
	my @colors = qw/ #2b9e27 #c92552 #2557c9 /;
	my @patterns = qw/ solid outline wavy /;

	for (my $i = 0; $i < 3; ++$i) {
		for (my $j = 0; $j < 3; ++$j) {
			for (my $k = 0; $k < 3; ++$k) {
				for (my $l = 0; $l < 3; ++$l) {
					my $svg = &MakeSvg($filenames[$i], $colors[$j], $patterns[$k], $l + 1);
					my $svgFile = "card_$i$j$k$l.svg";
					&WriteStringToFile($svgFile, $svg);
					`/Applications/Inkscape.app/Contents/MacOS/inkscape  --export-type=png $svgFile`  if $ExportPng;
					`/Applications/Inkscape.app/Contents/MacOS/inkscape  --export-type=pdf $svgFile`  if $ExportPdf;
				}
			}
		}
	}
}

$ExportPng = 1  if $ARGV[0] eq '--export-png';
$ExportPdf = 1  if $ARGV[0] eq '--export-pdf';
&WriteStringToFile('appicon.svg', &MakeSvg('star.svg', '#2b9e27', 'wavy', 1));
#&Run();
