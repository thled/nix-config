#!/usr/bin/env -S just --justfile

alias r := run
alias t := test

default:
    @just --choose

update:
    nix flake update

test host:
    sudo nixos-rebuild test --flake .#{{ host }}

run host:
    sudo nixos-rebuild switch --flake .#{{ host }}

build host:
    sudo nixos-rebuild boot --flake .#{{ host }}

fix:
    just --fmt --unstable
    alejandra ./

lint:
    just --fmt --check --unstable
    alejandra --check ./

add: fix
    git add .
    git status

optimise:
    nix store optimise
