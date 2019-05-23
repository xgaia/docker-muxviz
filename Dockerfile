FROM ubuntu:14.04
MAINTAINER "Xavier Garnier <xavier.garnier@irisa.fr>"

WORKDIR /root

ENV MUXVIZ_VERSION="1.0.6"
ENV MUXVIZ_REPO="https://github.com/manlius/muxViz/archive/v${MUXVIZ_VERSION}.tar.gz"
ENV MUXVIZ_TGZ="v${MUXVIZ_VERSION}.tar.gz"
ENV MUXVIZ_DIR="muxViz-v${MUXVIZ_VERSION}"

RUN apt update && apt upgrade -y
RUN apt-get install -y wget git r-base-core libgdal1-dev libproj-dev xorg-dev
RUN wget http://cran.es.r-project.org/src/base/R-3/R-3.2.0.tar.gz
RUN tar -xvf R-3.2.0.tar.gz
RUN cd R-3.2.0 && ./configure && make -j4 && make install
RUN wget ${MUXVIZ_REPO}
RUN tar -xvf ${MUXVIZ_TGZ}

WORKDIR /root/${MUXVIZ_DIR}

RUN R -e "options('repos'='http://cran.us.r-project.org'); install.packages('devtools'); install.packages('stringi'); install.packages('XML'); install.packages('rgl'); install.packages('sp'); install.packages('rgdal'); install.packages('shiny'); devtools::install_github('trestletech/ShinyDash'); "
RUN cp muxVizGUI.R initialise.R
RUN sed -i.bu 's/runApp(getwd())//' initialise.R
RUN R -e "options('repos'='http://cran.us.r-project.org'); source('/root/${MUXVIZ_DIR}/initialise.R')"
RUN sed -i.bu 's/runApp(getwd())/runApp(getwd(),8080, "false", "0.0.0.0")/' muxVizGUI.R

EXPOSE 8080
CMD R -e "options('repos'='http://cran.us.r-project.org');options(rgl.useNULL = FALSE);source('/root/${MUXVIZ_DIR}/muxVizGUI.R')"
