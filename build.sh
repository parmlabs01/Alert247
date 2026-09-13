#!/bin/bash
set -e

git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:$(pwd)/flutter/bin"

flutter doctor
flutter config --enable-web

# Generate the missing web/ platform folder (safe to re-run — it won't
# touch your existing lib/ code, only adds platform scaffolding)
flutter create . --platforms web

flutter pub get
flutter build web --release
