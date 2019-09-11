# -*- mode: perl; -*-
use strict;
use warnings;
use Test::More;
use File::Temp 'tempdir';
use Path::Tiny 'path';
use Test::Alien qw{alien_ok with_subtest xs_ok};
use Alien::libRmath;

alien_ok 'Alien::libRmath';

my $xs = do { local $/ = undef; <DATA> };

use lib 't/lib';
use Alien::Build::Temp::NFS;
no lib 't/lib';

my %root;
# avoid NFS
# diag __FILE__, ' nfs = ',
#     Alien::Build::Temp::NFS::is_nfs(path(__FILE__)->absolute);

if (eval { symlink("",""); 1 } && Alien::Build::Temp::NFS::is_nfs(__FILE__)) {
    my $temp = tempdir(CLEANUP => 1);
    my $root = path(-d "_alien" ? "_alien/tmp" : ".tmp")->absolute;
    symlink $temp, $root;
    $root{$root} = 1;
}

END {
    for my $link(keys %root) { unlink $link if -l $link; }
}

xs_ok {
    xs => $xs,
    verbose => $ENV{TEST_VERBOSE},
}, with_subtest {
    is CompileTest->check(), 'CompileTest',
    'CompileTest::check() returns CompileTest';
};

done_testing;

__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#define MATHLIB_STANDALONE
#include <Rmath.h>
#include <stdio.h>
typedef enum {
    BUGGY_KINDERMAN_RAMAGE,
    AHRENS_DIETER,
    BOX_MULLER,
    USER_NORM,
    INVERSION,
    KINDERMAN_RAMAGE
} N01type;

MODULE = CompileTest PACKAGE = CompileTest

char *check(class)
    char *class;
  CODE:
    qnorm(0.7, 0.0, 1.0, 0, 0);
    rbinom(1.0, 0.1);
    RETVAL = class;
  OUTPUT:
    RETVAL
