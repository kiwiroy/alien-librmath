# -*- mode: perl; -*-

requires 'Alien::Build'   => '1.41';
requires 'HTTP::Tiny'     => '>= 0.044';
requires 'Mojo::DOM58'    => '0';
requires 'Sort::Versions' => '0';
requires 'URI'            => '0';
requires 'URI::Escape'    => '0';

test_requires 'Test::More'    => '0.80';
test_requires 'FFI::Platypus' => '0.12';

on develop => sub {
    requires 'App::af';
    # --with-develop --with-recommends
    recommends 'Inline::C';
};
