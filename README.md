# Modern C/C++ Project Structure

A modular C/C++ project template built for maximum flexibility, speed, and adaptability. This structure uses Meson as the build system, Conan 2 for dependency management, mold as the default linker, pkgconf to handle package configurations and doxygen for documentation.

## Features
- Modular Build System: Uses Meson for fast and efficient incremental builds.
- Flexible Dependency Management: Integrates Conan 2 to manage dependencies with custom options.
- High-Speed Linking: Leverages mold for faster linking times, improving build performance.
- pkgconf for Package Configuration: Uses pkgconf as a lightweight alternative to pkg-config for handling package metadata.

## Prerequisites
- gcc: GNU Compiler Collection.
- Meson: A high-performance build system.
- Conan 2: For managing dependencies.
- mold: Linker for fast builds.
- pkgconf: For handling package metadata in place of pkg-config.
- doxygen: For generating documentation.
