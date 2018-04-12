FROM alpine
RUN apk add --no-cache openssh supervisor ansible
ADD resources/supervisord.conf /etc/supervisord.conf
ADD resources/sshd_config /etc/ssh/sshd_config
ADD ansible /root/
RUN ssh-keygen -A && echo "root:xebialabs" | chpasswd
ENV MYSQL_ROOT_PASSWORD secret
CMD ["/usr/bin/supervisord"]
EXPOSE 22
