# http cache

Packer is able to start an HTTP server, but the variables for IP and port are only available while running the boot command.
So we have to run another HTTP server.

This http cache directory is used to speed up the installation of the https://aka.ms/ContainerOSImage

## Build the cache

```
$ curl -L -o ContainerOSImage https://aka.ms/ContainerOSImage
```

## Run the http cache server

```
$ go build webserver.go
$ ./webserver
```

As an alternative you might try this HTTP server

```
python -m SimpleHTTPServer 8000
```

## Build the packer box

```
$ cd ..
$ packer build --only=vmware-iso windows_2016.json
```
