use strict;
use warnings;

use Test::More;

use blib;

use Convert::Float::MBF qw( ieeetombf );

my %Single = (
    '00002041' => {
        expect => [ '00', '00', '20', '84' ],
        test   => '10',
    },
    '0000803f' => {
        expect => [ '00', '00', '00', '81' ],
        test   => '1',
    },
    '0000003f' => {
        expect => [ '00', '00', '00', '80' ],
        test   => '.5',
    },
    '0000803e' => {
        expect => [ '00', '00', '00', '7f' ],
        test   => '.25',
    },
    '000000bf' => {
        expect => [ '00', '00', '80', '80' ],
        test   => '-.5',
    },
    '00c01544' => {
        expect => [ '00', 'c0', '15', '8a' ],
        test   => '599',
    },
    '00c015c4' => {
        expect => [ '00', 'c0', '95', '8a' ],
        test   => '-599',
    },
    'f304353f' => {
        expect => [ 'f3', '04', '35', '80' ],
        test   => 'sqrt(.5)',
    },
    'f304b53f' => {
        expect => [ 'f3', '04', '35', '81' ],
        test   => 'sqrt(2)',
    },
    '1872313f' => {
        expect => [ '18', '72', '31', '80' ],
        test   => 'ln(2)',
    },
    '3baab83f' => {
        expect => [ '3b', 'aa', '38', '81' ],
        test   => 'log2(e)',
    },
    'db0fc93f' => {
        expect => [ 'db', '0f', '49', '81' ],
        test   => 'pi/2',
    },
    'db0fc940' => {
        expect => [ 'db', '0f', '49', '83' ],
        test   => '2pi',
    },
    '286b6e4e' => {
        expect => [ '28', '6b', '6e', '9e' ],
        test   => '10^9',
    },
    '5f708930' => {
        expect => [ '5f', '70', '09', '63' ],
        test   => '10^-9',
    },
);

plan tests => keys(%Single) * 1;

my ( @src,      $float );
my ( $ieee_str, $expect );
for $ieee_str ( sort keys(%Single) ) {
    $expect = $Single{$ieee_str}->{expect};
    for ( my $i = 0 ; $i < 4 ; $i++ ) {
        $src[$i] = hex( substr $ieee_str, $i * 2, 2 );
    }

    ieeetombf( \@src, \$float );
    is_deeply( [ unpack 'H2' x 4, pack 'f', $float ],
        $expect, "Test of " . $Single{$ieee_str}->{test} );
    @src = ();
}

diag("Testing ieeetombf");

