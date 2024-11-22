# List all tasks
all:
    just --list

# Rebuild the Rust part.
build-rust-plugin:
    cd rust-plugin && maturin develop -r

dev: build-rust-plugin
    python3
