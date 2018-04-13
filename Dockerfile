FROM centos:7
MAINTAINER Jason Gurney <jason.gurney@ngc.com>

ADD yarn.lock /yarn.lock
ADD package.json /package.json

LABEL RUN="" \
      STOP="" \
      name="react-app" \
      vendor="Northrop Grumman" \
      license="No License"

ENV http_proxy="http://157.127.239.146:80/"
ENV https_proxy="http://157.127.239.146:80/"
ENV no_proxy="localhost,gep-tools.sp.c2fse.northgrum.com,gep-ci.sp.c2fse.northgrum.com"

RUN echo "#Proxy">>/etc/yum.conf
RUN echo "proxy=http://157.127.239.146:80">>/etc/yum.conf

RUN yum update -y

# install main packages:
# install curl
RUN yum install -y curl
# download and install nodejs
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash
RUN yum install -y nodejs
# download and install yarn
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN yum install -y yarn

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin
RUN yarn

WORKDIR /app
ADD . /app

EXPOSE 3000
EXPOSE 35729

ENTRYPOINT ["/bin/bash", "/app/run.sh"]
CMD ["start"]

