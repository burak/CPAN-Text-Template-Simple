package Text::Template::Simple::Compiler;
# the "normal" compiler
use strict;
use vars qw($VERSION);
use Text::Template::Simple::Dummy;

$VERSION = '0.80';

sub _compile { shift; return eval shift }

1;

__END__

=head1 NAME

Text::Template::Simple::Compiler - Compiler

=head1 SYNOPSIS

Private module.

=head1 DESCRIPTION

Template compiler.

=cut
