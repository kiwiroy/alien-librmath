# -*- mode: perl; -*-
use strict;
use warnings;
use ExtUtils::MakeMaker;
use Alien::Build::MM;
 
my $abmm = Alien::Build::MM->new(clean_install => 1);
 
WriteMakefile(
    $abmm->mm_args(
        ABSTRACT => 'Discover or download and install libRmath',
        DISTNAME => 'Alien-libRmath',
        NAME     => 'Alien::libRmath',
        VERSION_FROM => 'lib/Alien/libRmath.pm',
        META_MERGE    => {
            resources => {
                bugtracker => 'https://github.com/kiwiroy/alien-librmath/issues',
                homepage   => 'https://github.com/kiwiroy/alien-librmath',
                repository => 'https://github.com/kiwiroy/alien-librmath.git',
            },
        },
        PREREQ_PM => {
            'Alien::Build'   => '1.41',
            'Mojo::DOM58'    => '0',
            'Sort::Versions' => '0',
            'URI'            => '0',
            'URI::Escape'    => '0',
        },
        TEST_REQUIRES => {
            'FFI::Platypus' => '0.12',
            'Test::More'    => '0.80',
        },
        test => {TESTS => (-e 'META.yml' ? 't/*.t' : 't/*.t xt/*.t')},
    ),

    );
 
sub MY::postamble {
    $abmm->mm_postamble;
}

sub MY::install {
    $abmm->mm_install(@_);
}
