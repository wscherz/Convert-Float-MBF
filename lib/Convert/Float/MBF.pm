use strict;
use warnings;

package Convert::Float::MBF;

use Exporter;

our @ISA         = qw(Exporter);
our @EXPORT      = ();
our %EXPORT_TAGS = (
    single => [qw (mbftoieee ieeetombf)],
    double => [qw (mbdtoieee ieeetombd)],
    all    => [qw (single double)],
);
our @EXPORT_OK = ();

# ABSTRACT: MBF to IEEE754-1985 conversion module

=head1 EXPORTS

Convert::Float::MBF exports nothing by default, the following exports and tags are available

=begin :list
=begin :over8

 * mbftoieee
 * ieeetombf
 * mbdtoieee
 * ieeetombd

=end :list

Tags

=begin :list

 * single - mbftoieee ieeetombf
 * double - mbdtoieee ieeetombd
 * all

=end :list

=head1 SYNOPSIS

 my @ms_single = (0,0,0,128);
 my $float;
 my $rv = mbftoieee(\@ms_single, \$float);

 my @single = (0,0,0,63);
 my $mbf;
 my $rv = ieeetombf(\@single, \$mbf);

 my @ms_double = (0,0,0,0,0,0,0,128);
 my $ieee;
 my $rv = mbdtoieee(\@ms_double, \$ieee);

 my @double = (0,0,0,0,0,0,224,63);
 my $mbd;
 my $rv = ieeetombd(\@double, \$mbd);
 
=cut

=head1 DESCRIPTION

Convert::Float::MBF converts between MS Binary Float values and IEEE 754-1985 floating point values.
The methods expect an array 
=cut

1;
