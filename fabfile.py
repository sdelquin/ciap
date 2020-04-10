from fabric.api import cd, env, local, prefix, run

env.hosts = ['cloud']


def deploy():
    local('git push')
    with cd('~/code/ciap'):
        run('git pull')
        with prefix('source ~/.virtualenvs/ciap/bin/activate'):
            with cd('~/code/ciap'):
                run('pip install -r requirements.txt')
                run('bower install')
                run('supervisorctl restart ciap')
