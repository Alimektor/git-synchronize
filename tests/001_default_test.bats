#!/usr/bin/env -S bats
# Default for git-synchronize.

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"
load "local.bash"

# bats file_tags=default

setup_file() {
    setup_environment
    report "Default tests for git-synchronize"
    docker compose up -d
    setup_git_repository
}

teardown_file() {
    docker compose down
}

@test "git synchronize -h" {
    run_on_client_1 "git synchronize -h"
    assert_success
    assert_output -p "Usage: git-synchronize [-v|--version | -h | -m|--message | -b|--branch]"
    assert_output -p "Automatically synchronize local Git repository with remote Git repository."
    assert_output -p "Options:"
    assert_output -p "Example:"
    assert_output -p "git-synchronize"
    assert_output -p 'git-synchronize -m "Update README" -b "main"'
    assert_output -p "-v | --version"
    assert_output -p "-h | --help"
    assert_output -p "-m | --message"
    assert_output -p "-b | --branch"
}

@test "git synchronize -v" {
    run_on_client_1 "git synchronize -v"
    assert_success
    assert_output -e "git-synchronize, [0-9]+\.[0-9]+\.[0-9]+"
}

@test "git synchronize: Hello world" {
    run_on_client_1 "cd /test-repo && echo 'Hello world' > README.md"
    run_on_client_1 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && cat README.md"
    assert_success
    assert_output -p "Hello world"
}

@test "git synchronize: Hello world 2" {
    run_on_client_1 "cd /test-repo && echo 'Hello world 2' > README.md"
    run_on_client_1 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && cat README.md"
    assert_success
    assert_output -p "Hello world 2"
}

@test "git synchronize: Changes on others clients" {
    run_on_client_1 "cd /test-repo && echo 'First client change' > README.md"
    run_on_client_1 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && echo 'Second client change' > README.md"
    run_on_client_2 "cd /test-repo && git synchronize"
    run_on_client_1 "cd /test-repo && git synchronize"
    run_on_client_1 "cd /test-repo && cat README.md"
    assert_success
    assert_line --index 0 "<<<<<<< Updated upstream"
    assert_line --index 1 "First client change"
    assert_line --index 2 "======="
    assert_line --index 3 "Second client change"
    assert_line --index 4 ">>>>>>> Stashed changes"
}

@test "git synchronize -m 'Custom message'" {
    run_on_client_1 "cd /test-repo && echo 'Custom' > README.md"
    run_on_client_1 "cd /test-repo && git synchronize -m 'Custom message'"
    run_on_client_2 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && cat README.md"
    assert_success
    assert_output -p "Custom"
    run_on_client_2 "cd /test-repo && git log -1 --pretty=%B"
    assert_success
    assert_output -p "Custom message"
}

@test "git synchronize -b 'custom-branch'" {
    run_on_client_1 "cd /test-repo && echo 'Another branch' > README.md"
    run_on_client_1 "cd /test-repo && git synchronize -b 'custom-branch'"
    run_on_client_2 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && git checkout custom-branch"
    run_on_client_2 "cd /test-repo && cat README.md"
    assert_success
    assert_output -p "Another branch"
}

@test "git synchronize -b 'another-custom-branch' -m 'Custom message from another branch'" {
    run_on_client_1 "cd /test-repo && echo 'Another branch with custom message' > README.md"
    run_on_client_1 "cd /test-repo && git synchronize -b 'another-custom-branch' -m 'Custom message from another branch'"
    run_on_client_2 "cd /test-repo && git synchronize"
    run_on_client_2 "cd /test-repo && git checkout another-custom-branch"
    run_on_client_2 "cd /test-repo && cat README.md"
    assert_success
    assert_output -p "Another branch with custom message"
    run_on_client_2 "cd /test-repo && git log -1 --pretty=%B"
    assert_success
    assert_output -p "Custom message from another branch"
}
