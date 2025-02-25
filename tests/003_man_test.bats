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
    report "Man page tests for git-synchronize"
    docker compose up -d
    setup_git_repository
}

teardown_file() {
    docker compose down
}

check_fields() {
    assert_line -p "S^HSY^HYN^HNO^HOP^HPS^HSI^HIS^HS$"
    assert_line -p "D^HDE^HES^HSC^HCR^HRI^HIP^HPT^HTI^HIO^HON^HN$"
    assert_line -p "O^HOP^HPT^HTI^HIO^HON^HNS^HS$"
    assert_line -p "F^HFI^HIL^HLE^HES^HS$"
    assert_line -p "B^HBU^HUG^HGS^HS$"
    assert_line -p "E^HEX^HXA^HAM^HMP^HPL^HLE^HE$"
    assert_line -p "A^HAU^HUT^HTH^HHO^HOR^HRS^HS$"
}

check_man_page() {
    check_fields
    assert_line -e "git-synchronize\(1\)[[:space:]]*git-synchronize documentation[[:space:]]*git-synchronize\(1\)"
    assert_line -p "g^Hgi^Hit^Ht-^H-s^Hsy^Hyn^Hnc^Hch^Hhr^Hro^Hon^Hni^Hiz^Hze^He M-bM-^@M-^T is a Git command that helps you synchronize your$"
    assert_line -p "local git repository with a remote repository with automatic commit$"
    assert_line -p "git-synchronize [-m|--message message] [-b|--branch branch]"
    assert_line -p "git-synchronize [-h|--help|-v|--version]"
    assert_line -e "Just[[:space:]]*run git[[:space:]]*synchronize[[:space:]]*in[[:space:]]*your[[:space:]]*local[[:space:]]*git[[:space:]]*repository.[[:space:]]*You[[:space:]]*can[[:space:]]*change"
    assert_line -e "the[[:space:]]*commit[[:space:]]*message[[:space:]]*with[[:space:]]*-m[[:space:]]*and[[:space:]]*the[[:space:]]*push remote[[:space:]]*branch with[[:space:]]*-b.[[:space:]]*Also"
    assert_line -e "you[[:space:]]*can[[:space:]]*use[[:space:]]*.git-synchronize[[:space:]]*to[[:space:]]*set[[:space:]]*default[[:space:]]*values[[:space:]]*for[[:space:]]*these[[:space:]]*options."
    assert_line -p "Print this help message.$"
    assert_line -p "Print utility version.$"
    assert_line -p "Commit message.  Default: M-bM-^@M-^\Automatic updateM-bM-^@M-^].$"
    assert_line -p "Branch name.  Default: M-bM-^@M-^\mainM-bM-^@M-^].$"
    assert_line -p "Alimektor <alimektor@gmail.com>"
}

@test "Check man page" {
    run_on_client_1 'man git-synchronize > man-page.txt'
    run_on_client_1 'cat -A man-page.txt'
    assert_success
    check_man_page
}

@test "Check Git help for git-synchronize" {
    run_on_client_1 'git synchronize --help > help-page.txt'
    run_on_client_1 'cat -A help-page.txt'
    assert_success
    check_man_page
}
