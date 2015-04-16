#!perl

use strict;
use warnings;
use Test::More tests => 2;
use I18N::Langinfo qw/langinfo CODESET/;
use PerlIO::locale;
use Test::Output;
use POD2::RU;

use POSIX qw(locale_h);

SKIP: {
    setlocale( LC_CTYPE, "en_US.UTF-8" )
      or skip( "no such locale", 1 )
      if langinfo(CODESET) ne 'UTF-8';

    my $pod2 = POD2::RU->new();

    $pod2->prepare_encoding_console();

    sub writer {
        $pod2->print_pod('perlretut');
    }

    stdout_isnt(
        \&writer,
qq{\t'perlretut' переведен на русский Perl 5.18.0.1\n},
        'Test STDOUT of print_pod'
    );

    is( $pod2->print_pod('perlxstypemap'), 1, 'get 1' );

}
