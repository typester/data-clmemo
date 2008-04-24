use inc::Module::Install;
name 'Data-Clmemo';
all_from 'lib/Data/Clmemo.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
