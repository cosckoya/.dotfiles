# Dockerfile for testing dotfiles configuration
# Based on Ubuntu with all profile tools installed

FROM ubuntu:22.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Install base dependencies
RUN apt-get update && apt-get install -y \
    # Essential tools
    curl \
    git \
    make \
    wget \
    ca-certificates \
    gnupg \
    locales \
    sudo \
    # ZSH and dependencies
    zsh \
    # Tmux
    tmux \
    # Neovim
    neovim \
    # Clipboard support
    xsel \
    xclip \
    # Development tools
    build-essential \
    # Utilities
    unzip \
    tar \
    gzip \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# Generate locale
RUN locale-gen en_US.UTF-8

# Create non-root user for testing
RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser:testuser" | chpasswd && \
    usermod -aG sudo testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy dotfiles to container
COPY --chown=testuser:testuser . /home/testuser/.dotfiles

# Run Makefile to install profile
RUN cd /home/testuser/.dotfiles && \
    make profile

# Set ZSH as default shell
ENV SHELL=/bin/zsh

# Start with ZSH
CMD ["/bin/zsh"]
