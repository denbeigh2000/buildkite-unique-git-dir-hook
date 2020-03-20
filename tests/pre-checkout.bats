#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

export BUILDKITE_AGENT_NAME="elastic-builder"
export BUILDKITE_BUILD_CHECKOUT_PATH="/builds/my-pipeline"
export BUILDKITE_PIPELINE_SLUG="my-pipeline"

@test "sets \$BUILDKITE_BUILD_CHECKOUT_PATH" {
  export BKUNIQUENAMEHOOK_TEST="1"
  run $PWD/hooks/pre-checkout

  assert_success
  assert_output --partial "BUILDKITE_BUILD_CHECKOUT_PATH=/builds/elastic-builder/my-pipeline"
}

@test "moves old checkout" {
  mkdir -p $BUILDKITE_BUILD_CHECKOUT_PATH
  run $PWD/hooks/pre-checkout

  assert_success
  assert_output --partial "Moving old checkout"
}

@test "doesn't move non-existant checkout" {
  run $PWD/hooks/pre-checkout

  assert_success
  refute_output --partial "Moving old checkout"
}
