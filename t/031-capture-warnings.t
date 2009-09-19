#!/usr/bin/env perl -w
use strict;
use warnings;
use Test::More qw( no_plan );
use Text::Template::Simple;

my $t = Text::Template::Simple->new(
            capture_warnings => 1,
        );

my $got = $t->compile(q/Warn<%= my $r %>this/);
my $want = $] < 5.006
         ? "Warnthis[warning] Use of uninitialized value at <ANON> line 1.\n"
         : "Warnthis[warning] Use of uninitialized value in concatenation (.) or string at <ANON> line 1.\n"
         ;

is( $got, $want, "Warning captured" );
