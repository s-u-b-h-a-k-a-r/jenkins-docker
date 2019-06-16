FROM jenkins/jenkins:lts

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="jenkins-docker" \
      org.label-schema.description="Image jenkins with docker installed" \
      org.label-schema.url="https://hub.docker.com/r/subhakarkotta/jenkins-docker/" \
      org.label-schema.vcs-url="https://github.com/subhakarkotta/jenkins-docker" \
      org.label-schema.build-date=$BUILD_DATE
 
USER root

RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# https://docs.docker.com/install/linux/docker-ce/debian/
ENV DOCKER_VERSION="18.03.1~ce-0~debian"

RUN apt-get update  -qq \
    && apt-get install docker-ce=${DOCKER_VERSION} -y

RUN usermod -aG docker jenkins

