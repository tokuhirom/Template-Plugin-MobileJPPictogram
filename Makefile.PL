use inc::Module::Install;
name 'Template-Plugin-MobileJPPictogram';
all_from 'lib/Template/Plugin/MobileJPPictogram.pm';

requires $_ for (qw/Template Encode::JP::Mobile Encode::JP::Mobile::Charnames/);

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
