FROM debian:stretch
MAINTAINER davidgovea

RUN apt-get update && \
    apt-get install -y apt-transport-https git

RUN echo deb https://www.lesbonscomptes.com/recoll/debian/ stretch main > \
	/etc/apt/sources.list.d/recoll.list

RUN echo deb-src https://www.lesbonscomptes.com/recoll/debian/ stretch main >> \
	/etc/apt/sources.list.d/recoll.list

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated --force-yes recollcmd python3-recoll python-recoll python wv poppler-utils && \
    apt-get clean
    
RUN apt-get install -y --force-yes unzip xsltproc unrtf untex libimage-exiftool-perl antiword pstotext 

RUN mkdir /homes && mkdir /root/.recoll

RUN git clone https://github.com/dsheyp/recoll-webui.git

VOLUME /homes
EXPOSE 8080

CMD ["/usr/bin/python", "/recoll-webui/webui-standalone.py", "-a", "0.0.0.0"]
