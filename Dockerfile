FROM perl:5

RUN git clone --depth 1 --branch 4.0-trunk git://github.com/bestpractical/rt.git /opt/rt

WORKDIR /opt/rt

RUN autoconf
RUN ./configure

# Configure CPAN shell and install RT dependencies
RUN perl -MCPAN -e o conf init
RUN make testdeps | grep MISSING | awk '{print $1}' | uniq -u | grep -v SOME | cpanm --notest --force --
RUN make testdeps

# Install and configure RT
RUN make install

# Install Extension and dependencies
RUN cpanm --notest --force Module::Install::RTx Dist::Zilla::MintingProfile::RTx
COPY RT-Extension-TimeSync/ /opt/RT-Extension-TimeSync/
RUN cd /opt/RT-Extension-TimeSync && perl Makefile.PL
