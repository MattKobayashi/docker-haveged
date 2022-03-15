# docker-haveged

Haveged in an Alpine-based Docker image. Small, lightweight and (most importantly) up-to-date with source.

## Running

To run docker-haveged from the command line:

`docker run -d --name docker-haveged ghcr.io/mattkobayashi/docker-haveged`

## Docker Compose

An example Compose script:

```
services:
  docker-haveged:
    container_name: docker-haveged
      image: "ghcr.io/mattkobayashi/docker-haveged"
      restart: unless-stopped
      cap_add:
        - SYS_ADMIN
```

## Explanatory notes

- The `SYS_ADMIN` capability is required to allow write access to /dev/random so that the haveged daemon can add to the entropy pool.
