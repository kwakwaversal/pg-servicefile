requires 'perl', '5.008005';

requires 'Config::INI::Reader';
requires 'Moo';
requires 'Types::Path::Tiny';
requires 'Types::Standard';

on test => sub {
    requires 'Data::Section';
    requires 'Test2::Suite';
};
