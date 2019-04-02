use strict;
use warnings;

use Test::More tests => 1;

use blib;

my @subs = ();

BEGIN { use_ok( '', @subs ) || BAIL_OUT($@); }

diag("Testing Convert-Float-MBF $::VERSION, Perl $], $^X");
