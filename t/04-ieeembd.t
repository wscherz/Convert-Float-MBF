use strict;
use warnings;

use Test::More;

use blib;

use Convert::Float::MBF qw( ieeetombd );

my %Double = (
    '0000000000002440' => {
        expect => [ '00', '00', '00', '00', '00', '00', '20', '84' ],
        test   => '10',
    },
    '000000000000f03f' => {
        expect => [ '00', '00', '00', '00', '00', '00', '00', '81' ],
        test   => '1',
    },
    '000000000000e03f' => {
        expect => [ '00', '00', '00', '00', '00', '00', '00', '80' ],
        test   => '.5',
    },
    '000000000000d03f' => {
        expect => [ '00', '00', '00', '00', '00', '00', '00', '7f' ],
        test   => '.25',
    },
    '000000000000e0bf' => {
        expect => [ '00', '00', '00', '00', '00', '00', '80', '80' ],
        test   => '-.5',
    },
    '0000000000b88240' => {
        expect => [ '00', '00', '00', '00', '00', 'c0', '15', '8a' ],
        test   => '599',
    },
    '0000000000b882c0' => {
        expect => [ '00', '00', '00', '00', '00', 'c0', '95', '8a' ],
        test   => '-599',
    },
    'd13b7f669ea0e63f' => {
        expect => [ '88', 'de', 'f9', '33', 'f3', '04', '35', '80' ],
        test   => 'sqrt(.5)',
    },
    'e33b7f669ea0f63f' => {
        expect => [ '18', 'df', 'f9', '33', 'f3', '04', '35', '81' ],
        test   => 'sqrt(2)',
    },
    'ec39fafe422ee63f' => {
        expect => [ '60', 'cf', 'd1', 'f7', '17', '72', '31', '80' ],
        test   => 'ln(2)',
    },
    'ef822b654715f73f' => {
        expect => [ '78', '17', '5c', '29', '3b', 'aa', '38', '81' ],
        test   => 'log2(e)',
    },
    '282d4454fb21f93f' => {
        expect => [ '40', '69', '21', 'a2', 'da', '0f', '49', '81' ],
        test   => 'pi/2',
    },
    '1c2d4454fb211940' => {
        expect => [ 'e0', '68', '21', 'a2', 'da', '0f', '49', '83' ],
        test   => '2pi',
    },
    '0000000065cdcd41' => {
        expect => [ '00', '00', '00', '00', '28', '6b', '6e', '9e' ],
        test   => '10^9',
    },
    '95d626e80b2e113e' => {
        expect => [ 'a8', 'b4', '36', '41', '5f', '70', '09', '63' ],
        test   => '10^-9',
    },
);

plan tests => keys(%Double) * 1;

my ( @src,      $float );
my ( $ieee_str, $expect );
for $ieee_str ( sort keys(%Double) ) {
    $expect = $Double{$ieee_str}->{expect};
    for ( my $i = 0 ; $i < 8 ; $i++ ) {
        $src[$i] = hex( substr $ieee_str, $i * 2, 2 );
    }

    ieeetombd( \@src, \$float );
    is_deeply( [ unpack 'H2' x 8, pack 'd', $float ],
        $expect, "Test of " . $Double{$ieee_str}->{test} );
    @src = ();
}

diag("Testing ifeeetombd");

