use Test::Base;
use Test::Exception;

plan 'no_plan';

use FindBin;
use File::Spec;

use_ok('Data::Clmemo');

my $clmemo = Data::Clmemo->new;
isa_ok($clmemo, 'Data::Clmemo');

$clmemo->parse( File::Spec->catfile( $FindBin::Bin, qw/data basic.txt/ ) );
is( $clmemo->entries->count, 1, 'clmemo has 1 entry' );

my $entry = $clmemo->entries->[0];
isa_ok( $entry, 'Data::Clmemo::Entry' );
isa_ok( $entry->header, 'Data::Clmemo::Header' );
is( $entry->header->date, '2004-07-07');
is( $entry->header->author, 'Daisuke Murase <typester@cpan.org>' );

is( $entry->items->count, 2, 'first entry has 2 items');

my $item1 = $entry->items->[0];
is( $item1->title, 'title' );
like( $item1->content, qr/^this line is/ );

my $item2 = $entry->items->[1];
is( $item2->title, 'title' );
like( $item2->content, qr/Blank line is not considered as item separator./);
is_deeply( $item2->tags, ['tag'] );







