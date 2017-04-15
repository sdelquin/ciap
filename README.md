# CIAP
CIAP stands for **C**anary **I**slands **A**mazon **P**rice.

It allows you to get the "approximate" **real cost** of a product in [Amazon Spain](http://amazon.es) that will be delivered to Canary Islands.

## Configuration

```console
$> cp config.py.example config.example
$> cp uwsgi.cfg.example uwsgi.cfg
```

Set the corresponding values in the files.

### Virtualenv

The program expects to have a virtualenv with *Python3* installed in `~/.virtualenvs/ciap`.

### Project directory (production)

The program expects to have the project deployed in `~/ciap`.

### Server name (production)

The program expects to have the name of the production server as `production`. You can change it in `/etc/hosts`.
