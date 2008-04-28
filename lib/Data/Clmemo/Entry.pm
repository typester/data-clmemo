package Data::Clmemo::Entry;
use Moose;

use Data::Clmemo::Header;
use Data::Clmemo::Item;
use Data::Clmemo::Items;

has 'header' => (is => 'rw' );
has 'items'  => (is => 'rw', isa => 'Data::Clmemo::Items', default => sub { Data::Clmemo::Items->new } );

sub parse {
    my ($self, @inputs) = @_;
    $self = $self->new unless ref $self;

    $self->{header} = Data::Clmemo::Header->parse( shift @inputs )
        or return;

    my $add_item = sub {
        my @lines = @_ or return;
        my $item = Data::Clmemo::Item->parse(@lines) or return;
        $self->items->unshift($item);
    };

    my @buf;
    for my $line (@inputs) {
        if ($line =~ /^\t\*.+:/) {
            $add_item->(@buf);
            @buf = ($line);
        }
        else {
            push @buf, $line;
        }
    }
    $add_item->(@buf);

    $self;
}

1;

