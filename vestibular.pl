#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use List::Util 'shuffle';
use constant APPLICANTS => 20_000;
use constant POSITIONS => 500;
use constant CATEGORIES => 'A'..'Z';


my %categories=();
my %stats_candidates=();
my %stats_selected=();

for my $category (CATEGORIES) {
  $categories{$category}=rand();
  $stats_candidates{$category}=0;
  $stats_selected{$category}=0;
}


my @candidates=();

for my $n (1..APPLICANTS) {
  my $candidate={};
  
  push(@candidates, $candidate);  
  
  for my $category (keys %categories) {
    my $dice=rand();
    
    if($dice<$categories{$category}) {
      $candidate->{$category}=1;
      $stats_candidates{$category}++;
    } else {
      $candidate->{$category}=0;
    }
  }
}

my @selected=pick(POSITIONS, @candidates);

for my $winner (@selected) {
  for my $category (keys %$winner) {
    $stats_selected{$category}++ if $winner->{$category}==1;
  }
}


for my $category (CATEGORIES) {
  print "$category => ".$stats_selected{$category}/POSITIONS." (".$stats_candidates{$category}/APPLICANTS.")\n";
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
