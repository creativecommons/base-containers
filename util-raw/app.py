# Standard library
import re

SKIP_HEADERS = re.compile(
    r"""
    ^gunicorn
    |^http_host
    |^path
    |^query
    |^raw
    |^remote
    |^request
    |^script
    |^server
    |^wsgi
    """,
    re.VERBOSE,
)


def app(env, start_response):
    start_response("200 OK", [("Content-Type", "plain/text; charset=UTF-8")])
    data = []
    data.append(
        f"{env['REQUEST_METHOD']} {env['PATH_INFO']} {env['SERVER_PROTOCOL']}"
    )
    data.append(f"Host: {env['HTTP_HOST']}")
    data.append("")
    info = {}
    for key, value in env.items():
        name = key.lower()
        if SKIP_HEADERS.match(name):
            continue
        name = name.title().replace("_", "-").removeprefix("Http-")
        info[name] = value
    del env
    for key in sorted(info.keys()):
        value = info[key]
        data.append(f"{key}: {value}")
    del info
    data = "\n".join(data).encode()
    return [data]
