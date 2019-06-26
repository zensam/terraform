FROM hashicorp/terraform:0.12.3

ENV TERM=xterm KUBEVER=1.12.9


RUN apk add --update --no-cache \
        make \
        bash \
        python3 \
        wget \
        jq && \
    pip3 install --upgrade pip && \
    pip3 install \
        google \
        google-api-python-client \
        google-auth \
        awscli --upgrade --user

# add aws cli location to path
ENV PATH=~/.local/bin:$PATH

RUN mkdir ~/.aws && touch ~/.aws/credentials

################################
# Install Kubectl
################################

# Download kubectl for linux
RUN wget https://storage.googleapis.com/kubernetes-release/release/v${KUBEVER}/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

ENTRYPOINT ["terraform"]
