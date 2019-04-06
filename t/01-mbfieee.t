use strict;
use warnings;

use Test::More;

use blib;

use Convert::Float::MBF qw( mbftoieee );

my %MS_Single = (
    '00002084' => {
        expect => [ '00', '00', '20', '41' ],
        test   => '10',
    },
    '00000081' => {
        expect => [ '00', '00', '80', '3f' ],
        test   => '1',
    },
    '00000080' => {
        expect => [ '00', '00', '00', '3f' ],
        test   => '.5',
    },
    '0000007f' => {
        expect => [ '00', '00', '80', '3e' ],
        test   => '.25',
    },
    '00008080' => {
        expect => [ '00', '00', '00', 'bf' ],
        test   => '-.5',
    },
    '00c0158a' => {
        expect => [ '00', 'c0', '15', '44' ],
        test   => '599',
    },
    '00c0958a' => {
        expect => [ '00', 'c0', '15', 'c4' ],
        test   => '-599',
    },
    'f3043580' => {
        expect => [ 'f3', '04', '35', '3f' ],
        test   => 'sqrt(.5)',
    },
    'f3043581' => {
        expect => [ 'f3', '04', 'b5', '3f' ],
        test   => 'sqrt(2)',
    },
    '18723180' => {
        expect => [ '18', '72', '31', '3f' ],
        test   => 'ln(2)',
    },
    '3baa3881' => {
        expect => [ '3b', 'aa', 'b8', '3f' ],
        test   => 'log2(e)',
    },
    'db0f4981' => {
        expect => [ 'db', '0f', 'c9', '3f' ],
        test   => 'pi/2',
    },
    'db0f4983' => {
        expect => [ 'db', '0f', 'c9', '40' ],
        test   => '2pi',
    },
    '286b6e9e' => {
        expect => [ '28', '6b', '6e', '4e' ],
        test   => '10^9',
    },
    '5f700963' => {
        expect => [ '5f', '70', '89', '30' ],
        test   => '10^-9',
    },
);

plan tests => keys(%MS_Single) * 1;

my ( @src,     $float );
my ( $mbf_str, $expect );
for $mbf_str ( sort keys(%MS_Single) ) {
    $expect = $MS_Single{$mbf_str}->{expect};
    for ( my $i = 0 ; $i < 4 ; $i++ ) {
        $src[$i] = hex( substr $mbf_str, $i * 2, 2 );
    }

    mbftoieee( \@src, \$float );
    is_deeply( [ unpack( 'H2' x 4, pack( 'f', $float ) ) ],
        $expect, "Test of " . $MS_Single{$mbf_str}->{test} );
    @src = ();
}

diag("Testing mbftoieee");
