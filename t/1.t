# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

use Test::More tests => 7;

BEGIN { use_ok('Mail::Date') };

my $Time = 1047278957;

my $date = datetime_rfc2822($Time, '+0000');
is( $date, 'Mon, 10 Mar 2003 06:49:17 +0000',
	'for the prepared time: +0000 (GMT)' );

$date = datetime_rfc2822($Time, '+0927');
is( $date, 'Mon, 10 Mar 2003 16:16:17 +0927',
	'for the prepared time: +0927' );

$date = datetime_rfc2822($Time, '-0927');
is( $date, 'Sun, 09 Mar 2003 21:22:17 -0927',
	'for the prepared time: -0927' );

$date = datetime_rfc2822($Time, '-0000');
is( $date, 'Mon, 10 Mar 2003 06:49:17 -0000',
	'for the prepared time: Universal Time' );

$date = datetime_rfc2822($Time);
is( $date, 'Mon, 10 Mar 2003 06:49:17 -0000',
	'for the prepared time: omit timezone (Universal Time)' );

$date = datetime_rfc2822($Time, '+0927');
my $Wday = '(Sun|Mon|Tue|Wed|Thu|Fri|Sat)';
my $Mday =
	'(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)';
my $Mon = '(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)';
my $Hour =
	'(00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23)';
my $Sec =
	'(00|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60)';
like( $date,
	qr/$Wday, $Mday $Mon \d{4} $Hour:[0-5]\d:$Sec [\+\-]\d\d[0-5]\d/o,
	'for the current time: matching to regexp' );
