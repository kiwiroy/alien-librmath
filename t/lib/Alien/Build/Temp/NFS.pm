package
    Alien::Build::Temp::NFS;
use strict;
use warnings;

eval {
    require Inline;
    Inline->import (C => Config =>
                    BUILD_NOISY => $ENV{TEST_VERBOSE});
    Inline->import (C => 'DATA');
};

*is_nfs = \&is_nfs_pp if $@;

sub is_nfs_pp { return !!((stat(shift))[0] < 0) }

1;

__DATA__
__C__
#include <sys/statfs.h>

/* check is file is on NFS mount */    
int is_nfs(char *file) {
    int result = 0;

    struct statfs foo;
    if (statfs (file, &foo)) {
        /* error handling */
    }
    if (foo.f_type == 0x6969) {
        printf("%s\n", "is NFS");
        result = 1;
    }
    return result;
} 
