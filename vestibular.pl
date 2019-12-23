#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use List::Util 'shuffle';
use constant APPLICANTS => 20_000;
use constant POSITIONS => 500;
use constant CATEGORIES => 'A'..'B';


my %categories=();
my %stats=();

for my $category (CATEGORIES) {
  $categories{$category}=rand();
  $stats{$category}=0;
}


my @candidates=();

for my $n (1..APPLICANTS) {
  my $candidate={};
  
  push(@candidates, $candidate);  
  
  for my $category (keys %categories) {
    my $dice=rand();
    
    if($dice<$categories{$category}) {
      $candidate->{$category}=1;
    } else {
      $candidate->{$category}=0;
    }
  }
}

my @selected=pick(POSITIONS, @candidates);

for my $winner (@selected) {
  for my $category (keys %$winner) {
    $stats{$category}++ if $winner->{$category}==1;
  }
}


for my $category (sort keys %stats) {
  print "$category => ".($stats{$category}/POSITIONS)." (".$categories{$category}.")\n";
}

sub pick {
  my $num_picks=shift;
  my @candidates=@_;
  
  # Shuffled list of indexes into @candidates
  my @shuffled_indexes = shuffle(0..$#candidates);

  # Get just N of them.
  my @pick_indexes = @shuffled_indexes[ 0 .. $num_picks - 1 ];  

  # Pick candidates from @candidates
  my @picks = @candidates[ @pick_indexes ];
  
  return @picks;
}
