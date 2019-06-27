FROM hashicorp/terraform:0.11.14

ENV TERM=xterm PATH=~/.local/bin:$PATH

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
        awscli --upgrade \
        ekscli
        # awscli --upgrade --user

RUN mkdir ~/.aws && touch ~/.aws/credentials

# Install kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v1.12.9/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

RUN terraform version
# RUN aws-iam-authenticator help
RUN jq --version
RUN aws --version

ENTRYPOINT ["terraform"]
