show_help()
{
    echo ------------------------------------------------------
    echo Builds the dockerfile on the target host
    echo
    echo USAGE:
    echo ./build.sh docker_ip phusion_tag
    echo
    echo docker_ip: ip of docker host
    echo phusion_tag: 0.10.2 or 0.11
    echo
    echo EXAMPLE:
    echo ./build.sh 192.168.2.96 0.10.2
    echo ------------------------------------------------------
    echo
}

num_of_params=2
docker_host=$1
phusion_tag=$2

#checks number of parameters
if [ "$#" -ne $num_of_params ]; then
    echo "Illegal number of parameters."
    echo
    show_help
    exit 1
fi

#EDIT TO YOUR NEEDS--------------------
default_repo="arturol76"
default_image="phusion-baseimage"
default_tag="${phusion_tag}"
#--------------------------------------

echo

echo building image...
read -p "which repo? [$default_repo]: " repo
repo=${repo:-$default_repo}
read -p "which image? [$default_image]: " image
image=${image:-$default_image}
read -p "which tag? [$default_tag]: " tag
tag=${tag:-$default_tag}

echo building image "$repo/$image:$tag"...
docker -H $docker_host build -f Dockerfile-${phusion_tag} -t $repo/$image:$tag .

read -p "Do you want to push image to docker repository? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo

    echo pushing to $repo/$image:$tag...
    docker -H $docker_host push $repo/$image:$tag
else
    echo
fi

if [[ $tag != "latest" ]]; then
    read -p "Do you want to tag it also with 'latest'? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then 
        echo pushing to $repo/$image:latest...
        docker -H $docker_host push $repo/$image:latest
    else echo; fi
else
    echo
fi

exit 0