# Test K8s

## Python App
The app is written in Python using [Flask](https://palletsprojects.com/p/flask/) framework to deploy in local Kubernetes cluster using Helm.

### Flask
"Flask is a lightweight WSGI web application framework". I use the *Hello World* Flask app described [here](https://flask.palletsprojects.com/en/1.1.x/quickstart/#a-minimal-application). The only mod was the way to run the app and the default port, check *myApp.py* file.


## Docker image
To run a deploy/app in Kubernetes, you need a Docker container image with your app.

### Build
Because this app run over Python, you need choose a base docker image and is better use image of Python to build your app, you can start with [this doc](https://docs.docker.com/engine/reference/commandline/build/). 

The best way to build a image, is use a specific version of Python instated the latest version, because if in the future you want build again the image with new code, maybe the Python image version in DockerHub is updated and maybe cause future problems with your app. Also, I choose an image based on Alpine, because is lightweight. 

When you have the python app, finally you can build:
    
    docker build . -t TAG:VERSION

In my case TAG = mlmnz/myapp

### Pushing to repository
After the creation of our image, you need to push the image to Container Registry, in this case I use [DockerHub](https://hub.docker.com/). 

Before pushing, you need login. In my case is:
        
    $ docker login


## Kubernetes and Helm









https://kubernetes.github.io/ingress-nginx/deploy/