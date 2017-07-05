set e+x

# build image with Cypress dependencies
LOCAL_NAME=cypress/base:0.12

echo "Building $LOCAL_NAME"
docker build -t $LOCAL_NAME .
