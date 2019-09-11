# -*- mode: perl; -*-
use strict;
use warnings;
use Test::More;
use Test::Alien qw{alien_ok ffi_ok};
use Alien::libRmath;

alien_ok 'Alien::libRmath';

my $symbols = do { local $/ = undef; <DATA> };

ffi_ok {
    # dnorm, pnorm, qnorm are #defines
    symbols => [ grep { m/^[^#]/ } split $/ => $symbols ]
}, 'ffi symbols';

{
    local $TODO = 'investigate these';
    # log1pexp does not exist, Rf_log1pexp does
    # dpois_raw exists, but is optimised away?
    # rnbeta does not exist
    ffi_ok {
        symbols => [ map { s/^#//; $_ } grep { m/^#/ } split $/ => $symbols ]
    }, 'ffi symbols';

}

done_testing;

# grep ^double blib/lib/auto/share/dist/Alien-libRmath/include/Rmath.h | perl -lnE 's/double\s+([^\(]+).*/$1/; say' >> t/02.ffi.t
# and tweak
__END__
log1p
R_pow
R_pow_di
norm_rand
unif_rand
R_unif_index
exp_rand
dnorm4
pnorm5
qnorm5
rnorm
dunif
punif
qunif
runif
dgamma
pgamma
qgamma
rgamma
log1pmx
#log1pexp
lgamma1p
logspace_add
logspace_sub
logspace_sum
dbeta
pbeta
qbeta
rbeta
dlnorm
plnorm
qlnorm
rlnorm
dchisq
pchisq
qchisq
rchisq
dnchisq
pnchisq
qnchisq
rnchisq
df
pf
qf
rf
dt
pt
qt
rt
dbinom_raw
dbinom
pbinom
qbinom
rbinom
dcauchy
pcauchy
qcauchy
rcauchy
dexp
pexp
qexp
rexp
dgeom
pgeom
qgeom
rgeom
dhyper
phyper
qhyper
rhyper
dnbinom
pnbinom
qnbinom
rnbinom
dnbinom_mu
pnbinom_mu
qnbinom_mu
rnbinom_mu
#dpois_raw 
dpois
ppois
qpois
rpois
dweibull
pweibull
qweibull
rweibull
dlogis
plogis
qlogis
rlogis
dnbeta
pnbeta
qnbeta
#rnbeta
dnf
pnf
qnf
dnt
pnt
qnt
ptukey
qtukey
dwilcox
pwilcox
qwilcox
rwilcox
dsignrank
psignrank
qsignrank
rsignrank
gammafn
lgammafn
lgammafn_sign
psigamma
digamma
trigamma
tetragamma
pentagamma
beta
lbeta
choose
lchoose
bessel_i
bessel_j
bessel_k
bessel_y
bessel_i_ex
bessel_j_ex
bessel_k_ex
bessel_y_ex
fmax2
fmin2
sign
fprec
fround
fsign
ftrunc
log1pmx
lgamma1p
cospi
sinpi
tanpi
logspace_add
logspace_sub
