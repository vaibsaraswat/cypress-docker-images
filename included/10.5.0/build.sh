# WARNING: this file was autogenerated by generate-included-image.js
# using
#   npm run add:included -- 10.5.0 cypress/browsers:node16.14.2-slim-chrome100-ff99-edge
set e+x

LOCAL_NAME=cypress/included:10.5.0
echo "Building $LOCAL_NAME"
docker build -t $LOCAL_NAME .
