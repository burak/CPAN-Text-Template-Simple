package Text::Template::Simple::Base::Examine;
use strict;
use warnings;
use vars qw($VERSION);
use Text::Template::Simple::Util qw(:all);
use Text::Template::Simple::Constants qw(:all);

$VERSION = '0.80';

sub _examine {
   my $self   = shift;
   my $TMP    = shift;
   my($type, $thing) = $self->_examine_type( $TMP );
   my $rv;

   if ( $type eq 'ERROR' ) {
      $rv           = $thing;
      $self->[TYPE] = $type;
   }
   elsif ( $type eq 'GLOB' ) {
      $rv           = $self->_examine_glob( $thing );
      $self->[TYPE] = $type;
   }
   else {
      if ( my $path = $self->io->file_exists( $thing ) ) {
         $rv                = $self->io->slurp( $path );
         $self->[TYPE]      = 'FILE';
         $self->[TYPE_FILE] = $path;
      }
      else {
         # just die if file is absent, but user forced the type as FILE
         $self->io->slurp( $thing ) if $type eq 'FILE';
         $rv           = $thing;
         $self->[TYPE] = 'STRING';
      }
   }

   LOG( EXAMINE => sprintf q{%s; LENGTH: %s}, $self->[TYPE], length $rv ) if DEBUG;
   return $rv;
}

sub _examine_glob {
   my($self, $thing) = @_;
   fatal( 'tts.base.examine.notglob' => ref $thing ) if ref $thing ne 'GLOB';
   fatal( 'tts.base.examine.notfh' ) if ! fileno $thing;
   return $self->io->slurp( $thing );
}

sub _examine_type {
   my $self = shift;
   my $TMP  = shift;
   my $ref  = ref $TMP;

   return EMPTY_STRING ,  $TMP if ! $ref;
   return GLOB         => $TMP if   $ref eq 'GLOB';

   if ( isaref( $TMP ) ) {
      my $ftype  = shift @{ $TMP } || fatal('tts.base.examine._examine_type.ftype');
      my $fthing = shift @{ $TMP } || fatal('tts.base.examine._examine_type.fthing');
      fatal('tts.base.examine._examine_type.extra') if @{ $TMP };
      return uc $ftype, $fthing;
   }

   return fatal('tts.base.examine._examine_type.unknown', $ref);
}

1;

__END__

=head1 NAME

Text::Template::Simple::Base::Examine - Base class for Text::Template::Simple

=head1 SYNOPSIS

Private module.

=head1 DESCRIPTION

Private module.

=cut
