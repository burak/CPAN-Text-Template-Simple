package Text::Template::Simple::Compiler;
# the "normal" compiler
use strict;
use warnings;
use vars qw($VERSION);
use Text::Template::Simple::Dummy;

$VERSION = '0.80';

sub compile {
    shift;
    my $code = eval shift;
    return $code;
}

1;

__END__

=head1 NAME

Text::Template::Simple::Compiler - Compiler

=head1 SYNOPSIS

Private module.

=head1 METHODS

=head2 compile STRING

=head1 DESCRIPTION

Template compiler.

=cut
