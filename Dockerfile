FROM unidata/idv-gui

MAINTAINER Julien Chastang <chastang@ucar.edu>

USER root

###
# install emacs, git, jython
###

RUN apt-get update

###
#
# http://stackoverflow.com/questions/25193161/chfn-pam-system-error-intermittently-in-docker-hub-builds
#
# The following makes colord installation not fail, whatever colord is.
# 
###

#RUN ln -s -f /bin/true /usr/bin/chfn

RUN apt-get install -y curl emacs git

RUN curl -SL \
 http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar \
  -o ~/jython-installer-2.7.0.jar

RUN /home/idv/IDV/jre/bin/java -jar ~/jython-installer-2.7.0.jar -s -d /usr/local/lib/jython/bin/jython

RUN ln -s /usr/local/lib/jython/bin/jython/bin/jython /usr/local/bin/jython

# Create some directories
RUN mkdir -p  /home/idv/.emacs.d/git 
RUN mkdir -p  /home/idv/work

# Clone emacs config

WORKDIR /home/idv/.emacs.d/git

RUN git clone -b master  https://github.com/julienchastang/dotemacs

ADD init.el /home/idv/.emacs.d/init.el

# kludge just to force emacs to run once to grab elpa

RUN emacs --batch -l /home/idv/.emacs.d/init.el || true

# set classpath

ENV CLASSPATH /home/idv/IDV/auxdata.jar:\
/home/idv/IDV/external.jar:\
/home/idv/IDV/idv.jar:\
/home/idv/IDV/local-visad.jar:\
/home/idv/IDV/ncIdv.jar:\
/home/idv/IDV/sunjce_provider.jar:\
/home/idv/IDV/visad.jar

ENV JAVA_HOME /home/idv/IDV/jre

WORKDIR /home/idv/work 

VOLUME /home/idv/work

RUN chown -R idv:idv /home/idv/

USER idv

CMD "emacs"
