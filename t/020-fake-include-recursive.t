#!/usr/bin/env perl -w
use strict;
use warnings;
use Test::More qw( no_plan );
use Text::Template::Simple;
use Text::Template::Simple::Constants qw(MAX_RECURSION);

my $t = Text::Template::Simple->new();

sub test {
    my $rv = $t->compile( q{<%* t/data/test_var.tts %>} );
    print "GOT: $rv\n";
    return is( $$, $rv, "Compile OK" );
}

test() for 0..MAX_RECURSION+10;

ok( 1, "Fake recursive test did not fail");
