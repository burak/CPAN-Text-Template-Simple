package Text::Template::Simple::Compiler;

# the "normal" compiler
use strict;
use warnings;
use Text::Template::Simple::Dummy;

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
