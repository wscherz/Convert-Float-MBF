use strict;
use warnings;

use Test::More;

use blib;

use Convert::Float::MBF qw( mbdtoieee );

my %MS_Double = (
    '0000000000002084' => {
        expect => [ '00', '00', '00', '00', '00', '00', '24', '40' ],
        test   => '10',
    },
    '0000000000000081' => {
        expect => [ '00', '00', '00', '00', '00', '00', 'f0', '3f' ],
        test   => '1',
    },
    '0000000000000080' => {
        expect => [ '00', '00', '00', '00', '00', '00', 'e0', '3f' ],
        test   => '.5',
    },
    '000000000000007f' => {
        expect => [ '00', '00', '00', '00', '00', '00', 'd0', '3f' ],
        test   => '.25',
    },
    '0000000000008080' => {
        expect => [ '00', '00', '00', '00', '00', '00', 'e0', 'bf' ],
        test   => '-.5',
    },
    '0000000000c0158a' => {
        expect => [ '00', '00', '00', '00', '00', 'b8', '82', '40' ],
        test   => '599',
    },
    '0000000000c0958a' => {
        expect => [ '00', '00', '00', '00', '00', 'b8', '82', 'c0' ],
        test   => '-599',
    },
    '88def933f3043580' => {
        expect => [ 'd1', '3b', '7f', '66', '9e', 'a0', 'e6', '3f' ],
        test   => 'sqrt(.5)',
    },
    '18dff933f3043581' => {
        expect => [ 'e3', '3b', '7f', '66', '9e', 'a0', 'f6', '3f' ],
        test   => 'sqrt(2)',
    },
    '60cfd1f717723180' => {
        expect => [ 'ec', '39', 'fa', 'fe', '42', '2e', 'e6', '3f' ],
        test   => 'ln(2)',
    },
    '78175c293baa3881' => {
        expect => [ 'ef', '82', '2b', '65', '47', '15', 'f7', '3f' ],
        test   => 'log2(e)',
    },
    '406921a2da0f4981' => {
        expect => [ '28', '2d', '44', '54', 'fb', '21', 'f9', '3f' ],
        test   => 'pi/2',
    },
    'e06821a2da0f4983' => {
        expect => [ '1c', '2d', '44', '54', 'fb', '21', '19', '40' ],
        test   => '2pi',
    },
    '00000000286b6e9e' => {
        expect => [ '00', '00', '00', '00', '65', 'cd', 'cd', '41' ],
        test   => '10^9',
    },
    'a8b436415f700963' => {
        expect => [ '95', 'd6', '26', 'e8', '0b', '2e', '11', '3e' ],
        test   => '10^-9',
    },
);

plan tests => keys(%MS_Double) * 1;

my ( @src,     $float );
my ( $mbf_str, $expect );
for $mbf_str ( sort keys(%MS_Double) ) {
    $expect = $MS_Double{$mbf_str}->{expect};
    for ( my $i = 0 ; $i < 8 ; $i++ ) {
        $src[$i] = hex( substr $mbf_str, $i * 2, 2 );
    }

    mbdtoieee( \@src, \$float );
    is_deeply( [ unpack( 'H2' x 8, pack( 'd', $float ) ) ],
        $expect, "Test of " . $MS_Double{$mbf_str}->{test} );
    @src = ();
}

diag("Testing mbdtoieee");

