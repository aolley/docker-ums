# docker-ums

docker image for Universal Media Server (UMS)
based off of mbentley/ums

Example usage:
```
docker run -d --net=host --restart=always --name ums \
  -v /path/to/your/UMS.conf:/opt/ums/UMS.conf \
  -v /path/to/your/UMS.cred:/opt/ums/UMS.cred \
  -v /path/to/data:/opt/ums/data \
  -v /path/to/database:/opt/ums/database \
  -v /path/to/your/media:/media \
  aolley/ums
```

Note: Volumes for `UMS.conf` and `database` are optional but the data in them will not persist otherwise.
Universal Media Server container
