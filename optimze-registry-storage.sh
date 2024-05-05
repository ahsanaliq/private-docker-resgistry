#!/bin/bash

REGISTRY=docker-registry # specify Registry Location
REPO="${REGISTRY}/docker/registry/v2/repositories" # List of all namespaces in registry
for repo in "$REPO"/*; do # List images in a namespace recursively
        if [ -d "$repo/_manifests/tags" ]; then
            list=$(ls -t1 "$repo/_manifests/tags" | grep -v latest | tail -n +5) # list all tags in specific image
            for tag in $list; do
                tagpathtodelete="$repo/_manifests/tags/$tag"  # maintain dir path of tag
                digest=$(ls -t1 "$tagpathtodelete/index/sha256") # get the digest of image
                for value in $digest; do
                    rm -rvf "$repo/_manifests/revisions/sha256/$value"
                done
                   rm -rvf "$tagpathtodelete"
            done
        fi
done
