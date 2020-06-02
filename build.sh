if [ $# -eq 0 ]
    then
        echo "Usage: ./build.sh SS_RELEASE BASE_NAME"
        echo
        echo "Example: ./build.sh v3.2.0 minimal"
        exit 1
fi

SS_RELEASE=$1
BASE_NAME=$2
SS_COMPACT=${SS_COMPACT:-0}

docker build -f Dockerfile-${BASE_NAME} --build-arg SS_RELEASE=${SS_RELEASE} --build-arg SS_COMPACT=${SS_COMPACT} -t graphblas/pygraphblas-${BASE_NAME}:${SS_RELEASE} .
docker push graphblas/pygraphblas-${BASE_NAME}:${SS_RELEASE}
docker tag graphblas/pygraphblas-${BASE_NAME}:${SS_RELEASE} graphblas/pygraphblas-${BASE_NAME}:latest
docker push graphblas/pygraphblas-${BASE_NAME}:latest
