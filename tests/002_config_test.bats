#!/usr/bin/env -S bats
# Config for git-synchronize.

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"
load "local.bash"

# bats file_tags=config

setup_file() {
    setup_environment
    report "Config tests for git-synchronize"
    docker compose up -d
    setup_git_repository
}

teardown_file() {
    docker compose down
}

@test "Empty config file in home directory" {
    run_on_client_1 'touch ~/.git-synchronize'
    run_on_client_1 "cd /test-repo && echo 'Empty config file' > config-test.md"
    run_on_client_1 'cd /test-repo && git synchronize'
    run_on_client_2 'cd /test-repo && git synchronize'
    run_on_client_2 'cd /test-repo && cat config-test.md'
    assert_success
    assert_output -p "Empty config file"
}

@test "Config file in home directory" {
    run_on_client_1 'echo -e "message=Message from configuration file\nbranch=configuration-test" > ~/.git-synchronize'
    run_on_client_1 "cd /test-repo && echo 'Config file' > config-test.md"
    run_on_client_1 'cd /test-repo && git synchronize'
    run_on_client_2 'cd /test-repo && git synchronize'
    run_on_client_2 'cd /test-repo && git checkout configuration-test'
    run_on_client_2 'cd /test-repo && cat config-test.md'
    assert_success
    assert_output -p "Config file"
    run_on_client_2 'cd /test-repo && git log -1 --pretty=%B'
    assert_success
    assert_output -p "Message from configuration file"
}

@test "Config file in git repository" {
    run_on_client_1 'cd /test-repo && echo -e "message=Message from Git configuration file\nbranch=configuration-git-test" > .git-synchronize'
    run_on_client_1 "cd /test-repo && echo 'Config file from repository' > config-test.md"
    run_on_client_1 'cd /test-repo && git synchronize'
    run_on_client_1 'cd /test-repo && git branch'
    assert_success
    assert_output -p "* configuration-git-test"
    run_on_client_2 'cd /test-repo && git synchronize'
    run_on_client_2 'cd /test-repo && git checkout configuration-git-test'
    run_on_client_2 'cd /test-repo && cat config-test.md'
    assert_success
    assert_output -p "Config file from repository"
    run_on_client_2 'cd /test-repo && git log -1 --pretty=%B'
    assert_success
    assert_output -p "Message from Git configuration file"
}
