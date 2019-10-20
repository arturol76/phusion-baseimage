## SSH Keys
Scripts to create a new SSH key pair or to use an existing one are provided in folder ./keys.

### Create a key pair
To create a new key pair (and automatically add the pub key to the docker's authorized_keys and to export the pair to the local machine):

```
./keys-create.sh docker_ip container_name key_filename key_passphrase key_comment
```

EXAMPLE:
```
./keys-create.sh 192.168.2.96 phusion-baseimage-test art_keyfile mypassword "this is my key"
```

The script will export the key pair (pub/private) to the local machine. The key pair can be then imported into [pageant](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) for authentication into the docker.

### Import existing key pair
To import an existing key (and automatically add it to the docker's authorized_keys):

```
./keys-inject.sh docker_ip container_name pub_key_to_import
```

EXAMPLE:
```
./keys-inject.sh 192.168.2.96 phusion-baseimage-test art.pub
```

Note that only the pub key is needed.