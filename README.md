# phusion-baseimage
A baseimage for dockers using phusion with SSH server enabled.

Additional features:
* nano editor
* scripts to inject ssh keys and create/export keys
* scripts to build, run

Current version: 
* base image: phusion 0.10.2

## Build
Have a look to script build.sh.
Such script will build the dockerfile on the target host specified by docker_ip.

USAGE:
`./build.sh docker_ip`

EXAMPLE:
`./build.sh 192.168.2.96`


## Run
Have a look to script run.sh.
Such script will run image "arturol76/phusion-baseimage" on the target "docker-ip" host.
Container name is specified by "container_name".
Container will expose SSH service on port "docker_port".

NOTE: it will create and mount a named volume for the persistent storage of .ssh files.

USAGE:
`./run.sh docker_ip container_name docker_port`

EXAMPLE:
`./run.sh 192.168.2.96 phusion-baseimage-test 6022`

## VSCODE: sample config file for the SFTP extension
Assuming you use pageant to manage the key authentication:
```
{
    "name": "mydocker",
    "host": "192.168.2.96",
    "protocol": "sftp",
    "port": 7122,
    "username": "root",
    "remotePath": "/",
    "agent": "pageant",
    "passphrase": true,
    "uploadOnSave": true
}
```

NOTE: 
* change "port" to match the SSH port of the container
* change "remotePath" to match the target folder 

## Usage


## Change Log
2019-09-22
- 1st version.