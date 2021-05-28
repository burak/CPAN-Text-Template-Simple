package TTSConnector;
use strict;
use warnings;
use parent qw(Text::Template::Simple);

my %CONNECTOR = ( # Default classes list
   'Cache'     => 'TTS::Cache',
   'Cache::ID' => 'TTS::Cache::ID',
   'IO'        => 'TTS::IO',
   'Tokenizer' => 'TTS::Tokenizer',
);

sub connector {
    my $self = shift;
    my $id   = shift;
    return $CONNECTOR{ $id };
}

package TTS::Cache;
use parent qw(Text::Template::Simple::Cache);

package TTS::Cache::ID;
use parent qw(Text::Template::Simple::Cache::ID);

package TTS::IO;
use parent qw(Text::Template::Simple::IO);

package TTS::Tokenizer;
use parent qw(Text::Template::Simple::Tokenizer);

1;

__END__
