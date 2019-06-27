FROM ubuntu:latest

ENV TERM=xterm PATH=~/.local/bin:$PATH TFVER=0.11.14 KUBEVER=1.12.9

RUN apt-get update -y \
&& apt-get install awscli jq unzip wget -y

# Install Kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBEVER}/bin/linux/amd64/kubectl \
&& chmod +x ./kubectl \
&& mv ./kubectl /usr/local/bin/

# Install Terraform
RUN wget -q https://releases.hashicorp.com/terraform/${TFVER}/terraform_${TFVER}_linux_amd64.zip \
&& unzip terraform_${TFVER}_linux_amd64.zip \
&& mv terraform /usr/local/bin/

# Install python
# RUN apt-get install -y python3-pip
# #RUN ln -s /usr/bin/python3 python
# RUN pip3 install --upgrade pip
# RUN python3 -V
# RUN pip --version

# Install AWS CLI
# RUN pip install awscli --upgrade --user
RUN mkdir ~/.aws && touch ~/.aws/credentials

RUN wget -q https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
&& chmod +x ./aws-iam-authenticator \
&& mv ./aws-iam-authenticator /usr/local/bin/

# Install AWS EKS CLI
RUN wget -q https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz \
&& tar -xvzf eksctl_$(uname -s)_amd64.tar.gz \
&& chmod +x ./eksctl \
&& mv eksctl /usr/local/bin/

# RUN terraform version
# RUN aws-iam-authenticator help
# RUN jq --version
# RUN aws --version

ENTRYPOINT ["terraform"]
