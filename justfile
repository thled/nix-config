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

lint:
    just --fmt --check --unstable
