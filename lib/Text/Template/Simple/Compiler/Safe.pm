package Text::Template::Simple::Compiler::Safe;
# Safe compiler. Totally experimental
use strict;
use vars qw($VERSION);
use Text::Template::Simple::Dummy;

$VERSION = '0.80';

sub _compile { shift; return __PACKAGE__->_object->reval(shift) }

sub _object {
   my $class = shift;
   if ( $class->can('object') ) {
      my $safe = $class->object;
      if ( $safe && ref($safe) ) {
         return $safe if eval { $safe->isa('Safe'); 'Safe-is-OK' };
      }
      my $end = $@ ? ': '.$@ : '.';
      warn "Safe object failed. Falling back to default" . $end;
   }
   require Safe;
   my $safe = Safe->new('Text::Template::Simple::Dummy');
   $safe->permit( $class->_permit );
   return $safe;
}

sub _permit {
   my $class = shift;
   return $class->permit if $class->can('permit');
   return qw( :default require caller );
}

1;

__END__

=head1 NAME

Text::Template::Simple::Compiler::Safe - Safe compiler

=head1 SYNOPSIS

Private module.

=head1 DESCRIPTION

Safe template compiler.

=cut
