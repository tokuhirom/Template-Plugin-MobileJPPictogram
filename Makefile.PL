use inc::Module::Install;
name 'Template-Plugin-MobileJPPictogram';
all_from 'lib/Template/Plugin/MobileJPPictogram.pm';

requires $_ for (qw/Template Encode::JP::Mobile Encode::JP::Mobile::Charnames/);

test_requires 'Test::More';
test_requires 'YAML';
use_test_base;
auto_include;
WriteAll;
