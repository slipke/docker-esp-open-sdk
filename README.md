# docker-esp-open-sdk

Docker image based on ubuntu:16.04, which simply installs the toolchain.

## Used tools

* https://github.com/pfalcon/esp-open-sdk

## How to use

### Build

Build with the following command:

`docker build .`

### Run

```
docker run --rm -it --privileged \
  -v /yourdata:/data \
  slipke/docker-esp-open-sdk
```

## Credits

Inspired by: https://github.com/speakinghedge/docker-esp-open-sdk