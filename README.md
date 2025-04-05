# Python Gunicorn Server Template

A simple gunicorn container layout to enable usage as server with a suitable
Python WSGI application.

It enables dynamic mounting for any WSGI application supplied to it via a
mounted directory.

## Prerequisites

- Docker on host(best to use with compose)
- Python WSGI application (e.g. via [Flask](https://flask.palletsprojects.com/en/stable/))

## Usage

Best experience can be have with a Docker compose setup. Simply create a compose
file that sets up the container with a mounted `app` directory.

```yaml
services:
  webserver:
    image: ghcr.io/akablur/py-gunicorn-base:latest
    volumes:
      - "./app:/app"
    ports:
      - 80:80
```

This server will expose port 80 for a web interface.

## Application Structure

This container will simply run the application server given a predefined layout
of the server application. This layout should follow at least:

- Mounted as `/app` inside container
- Initial `bootstrap.sh` inside `/app`

The `bootstrap.sh` file will act as startup for the application. It can for
example run the application with gunicorn (intended way).

`bootstrap.sh`:
```bash
#!/bin/bash

cd "/app"

su -c 'gunicorn -w 4 -b 0.0.0.0:80 "serv:create_app()"'
```

This expects either a Python package `serv` or a module `serv` inside `/app` to
be existing. In it the call to `create_app()` will run the WSGI application.

> [!NOTE]
> The working directory of the container is initially `/root`. It is therefore
> recommended to switch working directories inside the `bootstrap.sh` script.

**Optionally** a `requirements.txt` file for pip installation can be created
inside the mounted `/app` directory. This file will be installed **once** when
the container is first started.
