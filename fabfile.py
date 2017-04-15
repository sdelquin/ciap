from fabric.api import env, local, prefix, cd, run

env.hosts = ["production"]


def deploy():
    local("git push")
    with prefix("source ~/.virtualenvs/ciap/bin/activate"):
        with cd("~/ciap"):
            run("git pull")
            run("pip install -r requirements.txt")
            run("bower install")
            run("supctl restart ciap")
