FROM hashicorp/terraform:0.11.14

ENV TERM=xterm TF_LOG=INFO PATH=~/.local/bin:$PATH

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
        rsa==3.4.2 \
        awscli --upgrade \
        # awscli --upgrade --user \
        ekscli --upgrade

RUN mkdir ~/.aws \
&& touch ~/.aws/credentials \
&& rm /var/cache/apk/*

# Install AWS IAM Authenticator
RUN wget -q https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
&& chmod +x ./aws-iam-authenticator \
&& mv ./aws-iam-authenticator /usr/local/bin/

# Install kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v1.14.3/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

ENTRYPOINT ["terraform"]
