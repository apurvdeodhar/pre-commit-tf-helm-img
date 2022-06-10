ARG BASE_IMAGE_VERSION

FROM python:${BASE_IMAGE_VERSION}-buster

WORKDIR /tmp

ARG TERRAFORM_VERSION
ARG HELMFILE_VERSION
ARG K8S
ARG HELM
ARG PRE_COMMIT

RUN	apt-get update -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

################################
# Install Terraform
################################
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget --progress=dot:mega https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    chmod +x /usr/local/bin/terraform
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

################################
# Install Tflint
################################
RUN wget --progress=dot:mega https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

################################
# Install Kubectl, Helm, Helmfile
################################
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    set -o pipefail && \
    # Kubectl
    wget --progress=dot:mega https://storage.googleapis.com/kubernetes-release/release/${K8S}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    # Helm
    wget --progress=dot:mega https://get.helm.sh/helm-${HELM}-linux-amd64.tar.gz && \
    tar xzf helm-${HELM}-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 && \
    # Helmfile
    wget --progress=dot:mega https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    chmod +x helmfile_linux_amd64 && \
    mv helmfile_linux_amd64 /usr/local/bin/helmfile
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

################################
# Install pre-commit
################################
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN python -m pip install --upgrade pip && \
    pip install pre-commit==${PRE_COMMIT}
