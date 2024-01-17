#!/usr/bin/env -S just --justfile

alias t := test

default:
    @just --choose

update:
    nix flake update

test:
    sudo nixos-rebuild test --upgrade

run:
    sudo nixos-rebuild switch --upgrade

build:
    sudo nixos-rebuild boot --upgrade

fix:
    just --fmt --unstable
    statix fix

lint:
    just --fmt --check --unstable
    statix check

add: fix
    git add .
    git status
