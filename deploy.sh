#!/bin/sh
set -xe

REPO="https://github.com/$GITHUB_REPOSITORY"

oc login "$INPUT_CLUSTER" --token="$INPUT_AUTH_TOKEN"
oc process -f openshift/nsp.json -p NAMESPACE="$INPUT_NAMESPACE" APP_NAME="$INPUT_APP_NAME" | oc apply -n "$INPUT_NAMESPACE" -f -
oc process -f openshift/bc.json -p NAMESPACE="$INPUT_NAMESPACE" APP_NAME="$INPUT_APP_NAME" REPO="$REPO" BRANCH="$INPUT_BRANCH" | oc apply -n "$INPUT_NAMESPACE" -f -
oc process -f openshift/dc.json -p NAMESPACE="$INPUT_NAMESPACE" APP_NAME="$INPUT_APP_NAME" | oc apply -n "$INPUT_NAMESPACE" -f -
oc rollout status "dc/$INPUT_APP_NAME-server" -n "$INPUT_NAMESPACE"
