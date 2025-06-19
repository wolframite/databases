PLATFORMS := "linux/amd64,linux/arm64"

default:
  @just -l

# Setup buildx builder for multi-arch builds
setup-builder:
    #!/usr/bin/env bash
    echo "Setting up buildx builder for multi-architecture builds..."
    
    # Create a new builder instance if it doesn't exist
    if ! docker buildx ls | grep -q "multiarch-builder"; then
        docker buildx create --name multiarch-builder --use --bootstrap
        echo "✅ Created multiarch-builder"
    else
        docker buildx use multiarch-builder
        echo "✅ Using existing multiarch-builder"
    fi

    # Verify the builder supports our target platforms
    echo "Supported platforms:"
    docker buildx inspect --bootstrap | grep Platforms

# Do mulit-arch build, pull base images, tag and push all databases to the registry
build-push: setup-builder
  docker buildx build --platform {{PLATFORMS}} -t registry.paswolf.com/mysql:8.0 --no-cache --pull --push -f mysql/Dockerfile mysql/
  docker buildx build --platform {{PLATFORMS}} -t registry.paswolf.com/postgres:16-alpine-ssl --no-cache --pull --push -f postgres/Dockerfile postgres/

# Do the whole shit for mysql
build-push-mysql: setup-builder
  docker buildx build --platform {{PLATFORMS}} -t registry.paswolf.com/mysql:8.0 --no-cache --pull --push -f mysql/Dockerfile mysql/

# Do the whole shit for postgres
build-push-postgres: setup-builder
  docker buildx build --platform {{PLATFORMS}} -t registry.paswolf.com/postgres:16-alpine-ssl --no-cache --pull --push -f postgres/Dockerfile postgres/
