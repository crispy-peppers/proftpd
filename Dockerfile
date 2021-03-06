# docker build -t packed4rmadillo/proftpd:1.3.5_4 .
# docker run --rm --network splunk --hostname proftpd -e "splunk_domain_name=so1" -it packed4rmadillo/proftpd:1.3.5_4
# docker push packed4rmadillo/proftpd:1.3.5_4
FROM debian
RUN apt-get update &&     apt-get upgrade -y &&     DEBIAN_FRONTEND=noninteractive apt-get install -y     wget curl apache2 php gcc make expect    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz &&     tar xfz proftpd-1.3.5.tar.gz &&     cd proftpd-1.3.5 &&     ./configure --with-modules=mod_copy &&     make && make install
RUN chmod 777 -R /var/www/html/
COPY Dockerfile /
COPY main.sh /
RUN chmod +x main.sh
ENTRYPOINT ["/main.sh"]
