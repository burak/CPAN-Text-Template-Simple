package Text::Template::Simple::Cache::ID;

use strict;
use warnings;
use overload q{""} => 'get';

use Text::Template::Simple::Constants qw(
   MAX_FILENAME_LENGTH
   RE_INVALID_CID
);
use Text::Template::Simple::Util qw(
   LOG
   DEBUG
   DIGEST
   fatal
);

sub new {
   my $class = shift;
   my $self  = bless do { \my $anon }, $class;
   return $self;
}

sub get {
   my $self = shift;
   return ${$self};
}

sub set { ## no critic (ProhibitAmbiguousNames)
   my $self = shift;
   my $val  = shift;
   ${$self} = $val if defined $val;
   return;
}

sub generate { # cache id generator
   my($self, $data, $custom, $regex) = @_;

   if ( ! $data ) {
      fatal('tts.cache.id.generate.data') if ! defined $data;
      LOG( IDGEN => 'Generating ID from empty data' ) if DEBUG;
   }

   $self->set(
      $custom ? $self->_custom( $data, $regex )
              : $self->DIGEST->add( $data )->hexdigest
   );

   return $self->get;
}

sub _custom {
   my $self  = shift;
   my $data  = shift or fatal('tts.cache.id._custom.data');
   my $regex = shift || RE_INVALID_CID;
      $data  =~ s{$regex}{_}xmsg; # remove bogus characters
   my $len   = length $data;

   # limit file name length
   if ( $len > MAX_FILENAME_LENGTH ) {
      $data = substr $data,
                     $len - MAX_FILENAME_LENGTH,
                     MAX_FILENAME_LENGTH;
   }

   return $data;
}

sub DESTROY {
   my $self = shift || return;
   LOG( DESTROY => ref $self ) if DEBUG;
   return;
}

1;

__END__

=head1 NAME

Text::Template::Simple::Cache::ID - Cache ID generator

=head1 SYNOPSIS

   TODO

=head1 DESCRIPTION

   TODO

=head1 METHODS

=head2 new

Constructor

=head2 generate DATA [, CUSTOM, INVALID_CHARS_REGEX ]

Generates an unique cache id for the supplied data.

=head2 get

Returns the generated cache ID.

=head2 set

Set the cache ID.

=cut
