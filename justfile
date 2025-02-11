# List all tasks
all:
    just --list

# Install Python dependencies, using CPU for Pytorch.
install-cpu:
    just install cpu
# Install Python dependencies, using CUDA for Pytorch.
install-cuda:
    just install cuda
# Install Python dependencies, using ROCm for Pytorch.
install-rocm:
    just install rocm

install target:
    uv sync --extra {{target}}

# Rebuild the Rust part.
build-rust-plugin:
    cd rust-plugin && maturin develop -r

dev: build-rust-plugin
    python3
