package Data::Clmemo::Header;
use Moose;

has 'date'   => ( is => 'ro' );
has 'author' => ( is => 'ro' );

sub parse {
    my ($class, $data) = @_;

    chomp $data;
    my ($date, $author) = $data =~ /^(\d{4}-\d{2}-\d{2})\s*(.*)$/;

    my $self = $class->new( date => $date, author => $author );
}

1;


