#!/usr/bin/env bash

set -x

# Command line flags affecting module generation.

module_flags=(
  # Add include directory of fcft
  $(pkg-config --cflags fcft) # Word splitting here is intentional
  # C has a global namespace. Providing a unique ID ensures the C wrappers
  # have unique names.
  --unique-id saygo.bindings.fcft
  # Base output directory of generated bindings.
  --hs-output-dir bindings
  --create-output-dirs
  --overwrite-files
  # Base module name. Submodules will have name `Generated.Pcap.Safe`, for
  # example.
  --module Generated.Fcft
)

# We only generate bindings for a sub-set of all parsed/reified declarations.
# These flags configure the selection step.
select_flags=(
  --enable-program-slicing
  --select-except-deprecated
)

# Increase the verbosity of `hs-bindgen` to learn something about its internals.
# For example, activate Info-level log messages to see which declarations are
# selected/not selected, or which C macros we succeed or fail to parse.
debug_flags=(
  # # Run `hs-bindgen` with log level "Info".
  -v3
  # # Run `hs-bindgen` with log level "Debug".
  # -v4
)

hs-bindgen-cli preprocess \
  "${module_flags[@]}" \
  "${select_flags[@]}" \
  "${debug_flags[@]}" \
  $(pkg-config --variable=includedir fcft)/fcft/fcft.h # Word splitting here is intentional
