use strict;
use warnings;

use Test::More tests => 5;

use blib;

my @subs = qw( mbftoieee ieeetombf mbdtoieee ieeetombd );

BEGIN { use_ok( 'Convert::Float::MBF', @subs ) || BAIL_OUT($@); }

foreach (@subs) {
	can_ok( 'Convert::Float::MBF', $_ ) || BAIL_OUT($@);

diag("Testing Convert-Float-MBF $Convert::Float::MBF::VERSION, Perl $], $^X");
