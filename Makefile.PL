use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	'NAME'		=> 'Mail::Date',
	'VERSION_FROM'	=> 'Date.pm',
#	'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
	($] >= 5.005 ? (
		'ABSTRACT' => 'generates RFC2822 compliant date-time',
		'AUTHOR'   => 'Masanori HATA <lovewing@geocities.co.jp>',
	) : ()),
);