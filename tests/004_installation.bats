#!/usr/bin/env -S bats
# Man page tests for git-synchronize.

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"
load "local.bash"

# bats file_tags=man

setup_file() {
    setup_environment
    report "Installation tests for git-synchronize"
    docker compose up -d
    setup_git_repository
}

teardown_file() {
    docker compose down
}

@test "Check install.sh for git-synchronize" {
    run_on_client_1 "rm -f /usr/bin/git-synchronize"
    run_on_client_1 "cd /app && bash install.sh"
    assert_success
    run_on_client_1 "stat ~/.local/bin/git-synchronize"
    run_on_client_1 "bash ~/.local/bin/git-synchronize --version"
}
