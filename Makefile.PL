use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	'NAME'         => 'Mail::Date',
	'VERSION_FROM' => 'Date.pm',
	'PREREQ_PM'    => {
		'Exporter' => '5.566',
	},
	($] >= 5.005 ? (
		'ABSTRACT' => 'convert to RFC2822 compliant date-time',
		'AUTHOR'   => 'Masanori HATA <lovewing@geocities.co.jp>',
	) : ()),
);
