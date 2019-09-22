echo ------------------------------------------------------
echo USAGE:
echo ./build.sh docker_ip
echo
echo example:
echo    ./build.sh 192.168.2.96
echo ------------------------------------------------------
echo

default_repo="arturol76"
default_image="phusion-baseimage"
default_tag="latest"

echo

echo building image...
read -p "which repo? [$default_repo]: " repo
repo=${repo:-$default_repo}
read -p "which image? [$default_image]: " image
image=${image:-$default_image}
read -p "which tag? [$default_tag]: " tag
tag=${tag:-$default_tag}

echo building image "$repo/$image:$tag"...
#docker -H $1 build --no-cache -t $repo/$image:$tag --build-arg ZM_VERS=$2 .
docker -H $1 build -t $repo/$image:$tag .

read -p "Do you want to push image to docker repository? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo

    echo pushing to $repo/$image:$tag...
    docker -H $1 push $repo/$image:$tag
else
    echo
fi

if [[ $tag != "latest" ]]; then
    read -p "Do you want to tag it also with 'latest'? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then 
        echo pushing to $repo/$image:latest...
        docker -H $1 push $repo/$image:latest
    else echo; fi
else
    echo
fi