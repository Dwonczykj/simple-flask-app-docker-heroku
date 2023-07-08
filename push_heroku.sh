#! /bin/sh

chmod +x entrypoint.sh

# condaVenvName=esc-llm
condaVenvName=simple-flask-app-conda-env
imageName=simple-flask-app-distroless-buildkit
dockerFileName=Dockerfile.distroless_first
herokuWebAppName=simple-flask-app

conda activate $condaVenvName
read -p "Do you want to recreate conda-lock environment from the $condaVenvName virtual conda environment? (y/n): " response

if [ "$response" = "y" ]; then
    unset response
    read -p "Do you want to export a new $condaVenvName env --from-history? (y/n): " response
    if [ "$response" = "y" ]; then
        conda env export --from-history > environment.yml
        cp environment.yml predict-environment.yml
    fi
    conda-lock \
        -f predict-environment.yml \
        -p linux-64 \
        -k explicit \
        --filename-template "predict-{platform}.lock"
    # conda-lock \
    #     -f predict-environment.yml \
    #     -f pot-environment.yml \
    #     -p linux-64 \
    #     -k explicit \
    #     --filename-template "predict-{platform}.lock"
else
    echo "Skipping recreation of conda-lock environment."
fi

unset response
read -p "Do you want to rebuild the docker image? (y/n): " response

if [ "$response" = "y" ]; then
    # NOTE: Our setup.py file that is called to install a module into /pkg in the dockerfile has the package named to my_distinct_package_name in the setup.py file
    DOCKER_BUILDKIT=1 \
        docker buildx build \
        --platform=linux/amd64 \
        --tag $imageName \
        --load -f $dockerFileName \
        .
else
    echo "Skipping rebuild of docker image."
fi

# Tag the image for Heroku's container registry
docker tag $imageName registry.heroku.com/$herokuWebAppName/web

# Push the image to Heroku
docker push registry.heroku.com/$herokuWebAppName/web

# if get an error here about being unauthorised, then need `heroku login -i & heroku containers:login`

heroku open --app $herokuWebAppName
