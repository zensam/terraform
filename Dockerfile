FROM ubuntu:latest

ENV TERM=xterm PATH=~/.local/bin:$PATH TFVER=0.11.14 KUBEVER=1.12.9

RUN apt-get update -y \
&& apt-get install jq unzip wget vim -y

################################
# Install Kubectl
################################

# Download kubectl for linux
RUN wget https://storage.googleapis.com/kubernetes-release/release/v${KUBEVER}/bin/linux/amd64/kubectl \
&& chmod +x kubectl \
&& mv kubectl /usr/local/bin/

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/${TFVER}/terraform_${TFVER}_linux_amd64.zip \
&& unzip terraform_${TFVER}_linux_amd64.zip \
&& mv terraform /usr/local/bin/

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

ENTRYPOINT ["terraform"]
