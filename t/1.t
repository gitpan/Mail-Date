# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

use Test::More tests => 5;

BEGIN { use_ok('Mail::Date') };

my $date = Mail::Date->new();

isa_ok( $date, 'Mail::Date' );
is( $date->convert(1047278957, '+0900')->output(),
	'Mon, 10 Mar 2003 15:49:17 +0900',
	'convert() then output()' );
is( Mail::Date->rfc2822(1047278958, '+0900'),
	'Mon, 10 Mar 2003 15:49:18 +0900',
	'rfc2822() for the prepared time' );
like( Mail::Date->rfc2822(time, '+0900'),
	'/[A-Z][a-z][a-z], \d\d [A-Z][a-z][a-z] \d\d\d\d \d\d:\d\d:\d\d [\+\-]\d\d\d\d/',
	'rfc2822() for the present time' );
