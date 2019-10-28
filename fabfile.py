from fabric.api import env, local, cd, run

env.hosts = ['cloud']


def deploy():
    local('git push')
    with cd('~/ciap'):
        run('git pull')
        run('pipenv install')
        run('bower install')
        run('supervisorctl restart ciap')
