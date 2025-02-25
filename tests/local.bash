setup_git_repository() {
    run_on_client_1 "ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ''"
    run_on_client_2 "ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ''"
    run_on_client_1 "ssh-keyscan -p 22 git-server >> /root/.ssh/known_hosts"
    run_on_client_2 "ssh-keyscan -p 22 git-server >> /root/.ssh/known_hosts"
    run_on_client_1 "sshpass -p root ssh-copy-id root@git-server"
    run_on_client_2 "sshpass -p root ssh-copy-id root@git-server"
    run_on_server "cat /root/.ssh/authorized_keys >> /home/git/.ssh/authorized_keys"
    run_on_client_1 "git clone git@git-server:repositories/test-repo.git"
    run_on_client_1 "cd /test-repo && git config user.name \"Test User\" && git config user.email \"test1@example.local\""
    run_on_client_2 "git clone git@git-server:repositories/test-repo.git"
    run_on_client_2 "cd /test-repo && git config user.name \"Test User\" && git config user.email \"test2@example.local\""
}

run_on_server() {
    run -0 docker compose exec -it git-server bash -c "${@}"
}

run_on_client_1() {
    run -0 docker compose exec -it git-client-1 bash -c "${@}"
}

run_on_client_2() {
    run -0 docker compose exec -it git-client-2 bash -c "${@}"
}
