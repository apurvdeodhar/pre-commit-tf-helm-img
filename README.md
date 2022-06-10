# List of packages  
* python
* terraform
* Helm
* Kubectl
* pre-commit
* Helmfile
* tflint

- I recommend to use these versions to get started with 
    ```
    BASE_IMAGE_VERSION=3.9.13
    TERRAFORM_VERSION=1.2.2
    HELMFILE_VERSION=0.144.0
    K8S=v1.24.1
    HELM=v3.9.0
    PRE_COMMIT=2.19.0
  ```
# Build image locally
1. Using `--build-args`
    ```bash
    docker build --build-arg BASE_IMAGE_VERSION=3.9.13 --build-arg TERRAFORM_VERSION=1.2.2 --build-arg HELMFILE_VERSION=0.144.0 --build-arg K8S=v1.24.1 --build-arg HELM=v3.9.0
    ```
2. If 1 does not work you can also directly substitute the `ARGs` in Dockerfile and build it without `--build-agrs` using command line.
    ```
    ARG BASE_IMAGE_VERSION=3.9.13
    ARG TERRAFORM_VERSION=1.2.2
    ARG HELMFILE_VERSION=0.144.0
    ARG K8S=v1.24.1
    ARG HELM=v3.9.0
    ARG PRE_COMMIT=2.19.0
    ```
