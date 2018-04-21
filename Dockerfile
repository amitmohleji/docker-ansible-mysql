FROM frolvlad/alpine-glibc
RUN apk add --no-cache openssh supervisor ansible curl
ADD resources/supervisord.conf /etc/supervisord.conf
ADD resources/sshd_config /etc/ssh/sshd_config
ADD ansible /root/
RUN ssh-keygen -A && echo "root:xebialabs" | chpasswd
ENV MYSQL_ROOT_PASSWORD secret

ENV OC_VERSION=v3.9.0 \
    OC_HASH=191fece

RUN curl -L https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_HASH}-linux-64bit.tar.gz \
      | tar xz && install openshift-origin-client-tools-${OC_VERSION}-${OC_HASH}-linux-64bit/oc /usr/bin/oc && rm -rf openshift*

RUN cp /usr/bin/oc /usr/local/bin/
RUN oc login https://api.starter-us-east-1.openshift.com --token=<<your token >>
CMD ["/usr/bin/supervisord"]
EXPOSE 22
