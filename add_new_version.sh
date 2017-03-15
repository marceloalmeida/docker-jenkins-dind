#!/bin/bash
set -x
if [ $(dirname $(readlink -f $0 || realpath $0)) != $PWD ]
  then
    echo Please go to the correct filepath \"$(dirname $(readlink -f $0 || realpath $0))\"
    exit 1
fi

version=$1

if [[ "$version" == "" ]]
  then
    echo "Please specify a valid version. Ex. 2.48"
    exit 2
fi

if [ -d $version ]
  then
    echo "Version $version already exists"
    exit 3
fi

rm Dockerfile supervisord.conf wrapdocker
mkdir $version
cp TPL/* $version/
sed -i "s/JENKINS_VERSION_TPL/$version/" $version/Dockerfile
ln -s $version/* .
