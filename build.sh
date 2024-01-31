#!/usr/bin/env bash

# Create binaries for bar, qux, foo for Linux and Macos profiles
conan create recipes/bar/all/conanfile.py --version=1.0.0 --profile:host profiles/linux --profile:build profiles/linux --test-folder=''
conan create recipes/bar/all/conanfile.py --version=1.0.0 --profile:host profiles/macos --profile:build profiles/macos --test-folder=''

conan create recipes/qux/all/conanfile.py --version=1.0.0 --profile:host profiles/linux --profile:build profiles/linux --test-folder=''
conan create recipes/qux/all/conanfile.py --version=1.0.0 --profile:host profiles/macos --profile:build profiles/macos --test-folder=''

conan create recipes/foo/all/conanfile.py --version=1.0.0 --profile:host profiles/linux --profile:build profiles/linux --test-folder=''
conan create recipes/foo/all/conanfile.py --version=1.0.0 --profile:host profiles/macos --profile:build profiles/macos --test-folder=''

# Modify foo recipe, so we have a new rrev that needs binaries
sed -i '' -e 's/pass/pass #comment/g' recipes/foo/all/conanfile.py

# Export new rrev
conan export recipes/foo/all/conanfile.py --version=1.0.0

# Discard changes in original git tracked file
git restore recipes/foo/all/conanfile.py

# Compute build order for both profiles:
conan graph build-order --require="foo/1.0.0#66760017d033d9c7e17936011fbad3fb" --build="missing:foo/1.0.0" --profile:host profiles/linux --profile:build profiles/linux --order=configuration --format=json > build_order_linux.json
conan graph build-order --require="foo/1.0.0#66760017d033d9c7e17936011fbad3fb" --build="missing:foo/1.0.0" --profile:host profiles/macos --profile:build profiles/macos --order=configuration --format=json > build_order_macos.json

# Merge build order
conan graph build-order-merge --file=build_order_linux.json --file=build_order_macos.json --format=json > merged_build_order.json