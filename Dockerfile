FROM ubuntu:latest

ENV TFVER=0.11.14 KUBEVER=1.12.9

RUN \
# Update
apt-get update -y && \
apt-get install jq unzip wget vim -y

################################
# Install Kubectl
################################

# Download kubectl for linux
RUN wget https://storage.googleapis.com/kubernetes-release/release/v${KUBEVER}/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/${TFVER}/terraform_${TFVER}_linux_amd64.zip
RUN unzip terraform_${TFVER}_linux_amd64.zip
RUN mv terraform /usr/local/bin/
# Check that it's installed
RUN terraform --version

################################
# Install python
################################

RUN apt-get install -y python3-pip
#RUN ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip
RUN python3 -V
RUN pip --version

################################
# Install AWS CLI
################################
RUN pip install awscli --upgrade --user

# add aws cli location to path
ENV PATH=~/.local/bin:$PATH

RUN mkdir ~/.aws && touch ~/.aws/credentials
