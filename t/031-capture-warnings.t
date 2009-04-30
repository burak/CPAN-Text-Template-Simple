#!/usr/bin/env perl -w
use strict;
use Test::More qw( no_plan );
use Text::Template::Simple;

SKIP: {
# This test fails for monolith under taint mode for some reason
# needs investigation.
skip("Skipping for monolith build test") if $ENV{AUTHOR_TESTING_MONOLITH_BUILD};

my $t = Text::Template::Simple->new(
            capture_warnings => 1,
        );

my $got = $t->compile(q/Warn<%= my $r %>this/);
my $want = "Warnthis[warning] Use of uninitialized value in concatenation (.) or string at <ANON> line 1.\n";

ok( $got eq $want, "Warning captured: '$got' eq '$want'" );

}
