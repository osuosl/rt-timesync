FROM openknowledge/rt:latest

COPY ./RT-Extension-TimeSync /opt/RT-Extension-TimeSync
WORKDIR /opt/RT-Extension-TimeSync

RUN cpan install Module::Install::RTx && perl Makefile.PL && make && make install

# Make SiteConfig writable
RUN chmod 666 /opt/rt4/etc/RT_SiteConfig.pm
