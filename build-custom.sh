if [ $# -eq 0 ]
    then
        echo "Usage: ./build-custom.sh SS_RELEASE BASE_NAME"
        echo
        echo "Example: ./build-custom.sh v3.2.0 minimal"
        exit 1
fi

SS_RELEASE=$1
BASE_NAME=$2

docker build --build-arg BASE_CONTAINER=graphblas/pygraphblas-${BASE_NAME}:${SS_RELEASE} -t graphblas/pygraphblas-${BASE_NAME}:custom . -f custom.Dockerfile
