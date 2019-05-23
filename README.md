# muxViz, dockerized

## Build

```bash
#Clone repo
git clone https://github.com/xgaia/docker-muxviz
cd docker-muxviz
# Build
docker build -t muxviz .
```

## Or pull

```bash
docker pull xgaia/muxviz
```

## Run

```bash
docker container run -p 8080:8080 --name muxviz xgaia/muxviz
```



Based on [fkraeutli/muxViz-docker](https://github.com/fkraeutli/muxViz-docker)