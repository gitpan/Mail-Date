package Mail::Date;

use 5.008;
use strict;
use warnings;

our $VERSION = '0.03'; # 2003-03-10

use Carp;

sub rfc2822 {
	my ($class, $universal_time, $timezone) = @_;
	my $self = $class->new();
	$self->convert($universal_time, $timezone);
	return $self->output();
}

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub output {
	my $self = shift;
	return $$self{'date_time'};
}

sub convert {
	my ($self, $universal_time, $timezone) = @_;
	
	unless ($timezone =~ /^[\+\-]\d{4}$/) {
		croak 'Invalid timezone expression: it must be in the format like +hhmm or -hhmm';
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
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, undef, undef) =
		gmtime($local_standard_time);
	
	$year = $year + 1900;
	$mon  = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)[$mon];
	$wday = qw(Sun Mon Tue Wed Thu Fri Sat)[$wday];
	
	foreach my $digit ($mday, $hour, $min, $sec) {
		$digit = sprintf("%02d", $digit);
	}
	
	$$self{'date_time'} = "$wday, $mday $mon $year $hour:$min:$sec $timezone";
	
	return $self;
}

1;
__END__

=head1 NAME

Mail::Date - generates RFC2822 compliant date-time

=head1 SYNOPSIS

  use Mail::Date;
  print Mail::Date->rfc2822(time, '+0900');

=head1 DESCRIPTION

Here it is rfc2822 compliant email date-time string generator. The well-known RFC822 has already been obsoleted by RFC2822 on April 2001. Then the standard format of date-time expression has been changed in RFC2822. You should not use such an old format like:

 Thu, 06 Mar 2003 19:14:05 GMT

any more. Instead of that you should use the local time in such a format +hhmm or -hhmm like:

 Fri, 07 Mar 2003 04:14:05 +0900

Please refer to RFC2822 (section 3.3, 4.3) for the futher infomation.

=head1 METHODS

=over

=item rfc2822($machine_time, $timezone)

Returns rfc2822 compliant date-time string which is converted from machine time. The time zone expression should be compliant to the RFC2822 specification. The "+" or "-" indicates whether the time-of-day is ahead of (i.e., east of) or behind (i.e., west of) Universal Time. The first two digits indicate the number of hours difference from Universal Time, and the last two digits indicate the number of minutes difference from Universal Time. (Hence, +hhmm means +(hh * 60 + mm) minutes, and -hhmm means -(hh * 60 + mm) minutes). The form "+0000" should be used to indicate a time zone at Universal Time. It must be within the range -9959 through +9959.

=item new()

Just creates a new object.

=item convert($machine_time, $timezone)

Just converts from machine time to date-time string.

=item output()

Just output the converted date-time string.

=back

=head1 SEE ALSO

L<HTTP::Date>

=head1 AUTHOR

Masanori HATA E<lt>lovewing@geocities.co.jpE<gt> (Saitama, JAPAN)

=head1 COPYRIGHT

Copyright (c) 1999-2003 Masanori HATA. All rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut
