# Test K8s

The app is written in Python using [Flask](https://palletsprojects.com/p/flask/) framework to deploy in local Kubernetes cluster using Helm.

Directories and files:

- **directDeployk8s:** Deploy without helm
- **myApp**: python app
- **myapp-chart**: helm files
- **Dockerfile** : Image for docker
- **script.sh** : BASH script to deploy the app

## Python App
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

Before pushing, you need login.
        
    $ docker login


## Kubernetes and Helm
First I test the deploy without Helm, so. I created manuel the 3 manifest.
- Deployment (*01-deployment.yaml*), I define the image to use, the replicas (2 pods min), el livenessProbe (for check pod's health) and some resource limits.
- Services *(02-services.yaml)*, to expose our app to network instead the direct access to pod.

- Ingress (*03-ingress.yaml*), firts we need 'activate it', it's depende of your cluster o infraestructure. In this case, I used minikube, so to activate: 
    
    $ minikube addons enable ingress

    The *Ingress* is the way access to our apps like a proxy. There are several types of "ingress", in my case I used NGinx, other option can be Traefik.

    If you have a different cluster, you need review with this page base on your cluster, to 'activa it':
    https://kubernetes.github.io/ingress-nginx/deploy/

### Helm

Helm can be help, because you is easier than write manifest directly. Review the [installation page](https://helm.sh/docs/intro/install/) according your OS or infraestructure.

- 1st. Create a template with *helm create foo*. This will create the follow files: 

    foo/
    ├── .helmignore   # Contains patterns to ignore when packaging Helm charts.
    ├── Chart.yaml    # Information about your chart
    ├── values.yaml   # The default values for your templates
    ├── charts/       # Charts that this chart depends on
    └── templates/    # The template files
└── tests/    # The test files