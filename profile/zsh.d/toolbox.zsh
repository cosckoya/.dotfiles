toolbox() {
    local repo_url="https://raw.githubusercontent.com/cosckoya/toolbox/main/Dockerfile"
    local dockerfile_path="/tmp/toolbox-dockerfile"
    local image_name="toolbox-image"
    local container_name="toolbox-container"

    echo "🔧 Toolbox - Downloading latest Dockerfile..."

    # Download the latest Dockerfile
    if curl -fsSL "$repo_url" -o "$dockerfile_path"; then
        echo "✅ Dockerfile downloaded successfully"
    else
        echo "❌ Failed to download Dockerfile from $repo_url"
        return 1
    fi

    echo "🔨 Building toolbox image..."
    if docker build -f "$dockerfile_path" -t "$image_name" /tmp; then
        echo "✅ Build completed successfully"
    else
        echo "❌ Build failed!"
        rm -f "$dockerfile_path"
        return 1
    fi

    # Clean up the temporary dockerfile
    rm -f "$dockerfile_path"

    echo "🚀 Starting toolbox container..."

    # Create workspace directory if it doesn't exist
    local workspace_dir="/home/cosckoya/hack/toolbox-tmp"
    mkdir -p "$workspace_dir"

    docker run -it --rm \
        --name "$container_name" \
        -v "$workspace_dir":/workspace \
        -w /workspace \
        "$image_name" "$@"
}

# Alternative version with more options
toolbox-advanced() {
    local repo_url="https://raw.githubusercontent.com/cosckoya/toolbox/main/Dockerfile"
    local dockerfile_path="/tmp/toolbox-dockerfile"
    local image_name="toolbox-image"
    local container_name="toolbox-container"
    local force_rebuild=false
    local no_cache=false

    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            -f|--force)
                force_rebuild=true
                shift
                ;;
            --no-cache)
                no_cache=true
                shift
                ;;
            -h|--help)
                echo "Usage: toolbox [OPTIONS] [COMMAND]"
                echo ""
                echo "Downloads and runs the latest toolbox from:"
                echo "https://github.com/cosckoya/toolbox"
                echo ""
                echo "Options:"
                echo "  -f, --force     Force rebuild even if image exists"
                echo "  --no-cache      Build without using Docker cache"
                echo "  -h, --help      Show this help"
                echo ""
                echo "Examples:"
                echo "  toolbox                    # Interactive shell"
                echo "  toolbox ls -la            # Run specific command"
                echo "  toolbox --force           # Force rebuild and run"
                return 0
                ;;
            *)
                break
                ;;
        esac
    done

    # Check if image exists and force rebuild is not set
    if docker image inspect "$image_name" >/dev/null 2>&1 && [ "$force_rebuild" = false ]; then
        echo "🚀 Using existing toolbox image (use --force to rebuild)"
    else
        echo "🔧 Toolbox - Downloading latest Dockerfile..."

        # Download the latest Dockerfile
        if curl -fsSL "$repo_url" -o "$dockerfile_path"; then
            echo "✅ Dockerfile downloaded successfully"
        else
            echo "❌ Failed to download Dockerfile from $repo_url"
            return 1
        fi

        echo "🔨 Building toolbox image..."
        local build_args=""
        if [ "$no_cache" = true ]; then
            build_args="--no-cache"
        fi

        if docker build $build_args -f "$dockerfile_path" -t "$image_name" /tmp; then
            echo "✅ Build completed successfully"
        else
            echo "❌ Build failed!"
            rm -f "$dockerfile_path"
            return 1
        fi

        # Clean up the temporary dockerfile
        rm -f "$dockerfile_path"
    fi

    echo "🚀 Starting toolbox container..."

    # Create workspace directory if it doesn't exist
    local workspace_dir="/home/cosckoya/hack/toolbox-tmp"
    mkdir -p "$workspace_dir"

    docker run -it --rm \
        --name "$container_name-$(date +%s)" \
        -v "$workspace_dir":/workspace \
        -w /workspace \
        -e "PS1=\[\033[01;32m\]toolbox\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ " \
        "$image_name" "$@"
}

# Simple alias version (choose one)
alias toolbox='toolbox-advanced'
