package Mail::Date;

use 5.008;
use strict;
use warnings;
use Carp;

our $VERSION = '0.08'; # 2003-04-18 (since 1999)

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(datetime_rfc2822);

sub datetime_rfc2822 ($;$) {
	my($universal_time, $timezone) = @_;
	
	unless ($timezone) {
		$timezone = '-0000';
    }
	
	unless ($timezone =~ /^[\+\-]\d{4}$/) {
		croak 'Invalid timezone expression: it must be in a format like +hhmm or -hhmm';
	}
	my $plus_minus    = substr($timezone, 0, 1);
	my $timezone_hour = substr($timezone, 1, 2);
	my $timezone_min  = substr($timezone, 3, 2);
	unless ($timezone_min < 60) {
		croak 'Invalid timezone expression: it must be within the range -9959 through +9959';
	}
	my $timezone_sec  = $plus_minus .
		($timezone_hour * 3600 + $timezone_min * 60);
	
	my $local_standard_time = $universal_time + $timezone_sec;
	my($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
		gmtime($local_standard_time);
	
	$year +=  1900;
	$mon  = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)[$mon];
	$wday = qw(Sun Mon Tue Wed Thu Fri Sat)[$wday];
	
	foreach my $digit ($mday, $hour, $min, $sec) {
		$digit = sprintf('%02d', $digit);
	}
	
	return "$wday, $mday $mon $year $hour:$min:$sec $timezone";
}

1;
__END__

=head1 NAME

Mail::Date - convert to RFC2822 compliant date-time

=head1 SYNOPSIS

  use Mail::Date;
  print datetime_rfc2822(time, '+0900');

=head1 DESCRIPTION

Here it is a rfc2822 compliant date-time converter. The well-known RFC822 has already been obsoleted by RFC2822 on April 2001. And the standard format of expression for date-time has been updated in the RFC2822. An example which is shown next is obsoleted one:

 Thu, 06 Mar 2003 19:14:05 GMT

Because it has an alphabetical string C<GMT> for indicating a timezone. Now the RFC2822 specifies a timezone should be expressed in a numerical string like C<+hhmm> or C<-hhmm>. The former example should be displayed as next:

 Thu, 06 Mar 2003 19:14:05 -0000

Moreover, the RFC2822 describes timezone SHOULD express local-time. The timezone C<-0000> does not mean the local-time of GMT (Greenwich Mean Time) but does universal-time (UTC). If it mean local-time at an area of GMT, the timezone C<+0000> SHOULD be used. So you know your area's local timezone's offset from UTC that you should specify timezone and local-time. For example, at the time of above (2nd) example in UTC, and you were at an area of Japanese local-time, where it is ahead of nine hours from UTC, the date-time expression is:

 Fri, 07 Mar 2003 04:14:05 +0900

(Don't overlook that it is not only timezone but the date and time-of-day are also altered.)

Please consult RFC2822 (section 3.3, 4.3) for the actual infomation.

=head1 FUNCTIONS

=over

=item datetime_rfc2822($unix_time [, $timezone])

This function returns RFC2822 compliant date-time string which is converted from a C<$unix_time> which is offset in seconds from the unix epoch time (1970-01-01 00:00:00 UTC). Though $timezone value is optional, it is said that in the RFC2822 I<The date and time-of-day SHOULD express local time>. If $timezone value is not given (omitted), it will be not taken as a local-time but as a universal-time (UTC) to be expressed C<-0000>.

The time zone expression should be compliant to the RFC2822 specification. It must be within the range -9959 through +9959. The "+" or "-" indicates whether the time-of-day is ahead of (i.e., east of) or behind (i.e., west of) Universal Time. The first two digits indicate the number of hours difference from Universal Time, and the last two digits indicate the number of minutes difference from Universal Time. (Hence, +hhmm means +(hh * 60 + mm) minutes, and -hhmm means -(hh * 60 + mm) minutes). The form "+0000" should be used to indicate a time zone at Universal Time.

=back

=head1 SEE ALSO

=over

=item RFC2822: L<http://www.ietf.org/rfc/rfc2822.txt>

=item L<HTTP::Date> (for the RFC822 compliant date-time)

=back

=head1 AUTHOR

Masanori HATA E<lt>lovewing@geocities.co.jpE<gt> (Saitama, JAPAN)

=head1 COPYRIGHT

Copyright (c) 1999-2003 Masanori HATA. All rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

