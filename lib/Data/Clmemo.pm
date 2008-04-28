package Data::Clmemo;
use Moose;

use Data::Clmemo::Header;
use Data::Clmemo::Entry;

use Data::Clmemo::Entries;

our $VERSION = '0.01';

has 'encoding' => ( is => 'rw', default => 'utf-8' );
has 'format'   => ( is => 'rw', default => 'plain' );
has 'entries'  => ( is => 'rw', default => sub { Data::Clmemo::Entries->new } );

sub parse {
    my ($self, $file) = @_;

    $self->entries->clear;

    open my $fh, "$file";
    binmode $fh, ":encoding($self->{encoding})";

    my $add_entry = sub {
        my @lines = @_ or return;
        my $entry = Data::Clmemo::Entry->parse(@_) or return;
        $self->entries->add($entry);
    };

    my @lines;
    while (my $line = <$fh>) {
        if ($line =~ /^\d{4}-\d{2}-\d{2}/) {
            $add_entry->(@lines);
            @lines = ($line);
        }
        else {
            push @lines, $line;
        }
    }
    $add_entry->(@lines);

    close $fh;

    $self;
}

=head1 NAME

Data::Clmemo - Module abstract (<= 44 characters) goes here

=head1 SYNOPSIS

  use Data::Clmemo;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for this module was created by ExtUtils::ModuleMaker.
It looks like the author of the extension was negligent enough
to leave the stub unedited.

Blah blah blah.

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
