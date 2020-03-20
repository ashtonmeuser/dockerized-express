#!/bin/sh

oc process -f openshift/nsp.json -p NAMESPACE="$INPUT_NAMESPACE" APP_NAME="$INPUT_APP_NAME" | oc apply -n "$INPUT_NAMESPACE" -f -
oc process -f openshift/bc.json -p NAMESPACE="$INPUT_NAMESPACE" APP_NAME="$INPUT_APP_NAME" REPO="$INPUT_REPO" BRANCH="$INPUT_BRANCH" | oc apply -n "$INPUT_NAMESPACE" -f -
oc process -f openshift/dc.json -p NAMESPACE="$INPUT_NAMESPACE" APP_NAME="$INPUT_APP_NAME" | oc apply -n "$INPUT_NAMESPACE" -f -
oc rollout status "dc/$APP_NAME"-server -n "$INPUT_NAMESPACE"
