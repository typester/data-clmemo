package Data::Clmemo::Item;
use Moose;

has 'title'   => ( is => 'rw' );
has 'tags'    => ( is => 'rw', default => sub { [] } );
has 'content' => ( is => 'rw' );

sub parse {
    my ($class, @lines) = @_;

    my ($title, $tag, $body) = (shift @lines) =~ /\*(.*?)(\[.*\])?:(.*)/;
    return unless $title;

    $title =~ s/(^\s*|\s*$)//g;
    $body  =~ s/^\s+//;
    my @tags = grep { $_ } split /[\[\]]/, $tag || '';

    for my $line (@lines) {
        if ($line =~ /^\t/) {
            $line =~ s/^\t//;
            $body .= $line;
        }
        elsif ($line =~ /^\s*$/) {
            $body .= $line;
        }
    }

    my $self = $class->new(
        title   => $title,
        tags    => \@tags,
        content => $body,
    );
}

1;

