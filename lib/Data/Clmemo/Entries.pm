package Data::Clmemo::Entries;
use Moose;

use overload '@{}' => sub { shift->entries };

has 'entries' => ( is => 'rw', default => sub { [] } );

sub clear {
    my $self = shift;
    $self->entries([]);
}

sub add {
    my $self = shift;
    push @{ $self->entries }, @_;
}

sub count {
    my $self = shift;
    scalar @{ $self->entries };
}

1;
