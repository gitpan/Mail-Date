use 5.006;
use ExtUtils::MakeMaker;

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
