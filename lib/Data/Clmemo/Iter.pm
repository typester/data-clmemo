package Data::Clmemo::Iter;
use Moose;

use overload '@{}' => sub { shift->list };

has 'list' => ( is => 'rw', default => sub { [] } );

sub clear {
    my $self = shift;
    $self->list([]);
}

sub count {
    my $self = shift;
    scalar @{ $self->list };
}

sub push {
    my $self = shift;
    push @{ $self->list }, @_;
}

sub unshift {
    my $self = shift;
    unshift @{ $self->list }, @_;
}

sub pop {
    my $self = shift;
    pop @{ $self->list };
}

sub shift {
    my $self = shift;
    shift @{ $self->list };
}

1;


