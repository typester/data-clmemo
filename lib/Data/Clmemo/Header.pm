package Data::Clmemo::Header;
use Moose;

use Mail::Address;

has 'date'   => ( is => 'ro' );
has 'author' => ( is => 'ro' );
has 'author_name' => ( is => 'ro' );
has 'author_address' => ( is => 'ro' );

sub parse {
    my ($class, $data) = @_;

    chomp $data;
    my ($date, $author) = $data =~ /^(\d{4}-\d{2}-\d{2}(?: \(.{3}\))?)\s*(.*)$/;

    my $addr = (Mail::Address->parse($author))[0];

    my $self = $class->new(
        date           => $date,
        author         => $author,
        author_name    => $addr->name,
        author_address => $addr->address,
    );
}

1;


