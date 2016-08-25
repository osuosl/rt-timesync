use strict;
use warnings;
package RT::Extension::TimeSync;

our $VERSION = '0.01';

=head1 NAME

RT-Extension-TimeSync - TimeSync integration for RT

=head1 DESCRIPTION

This extension adds support for TimeSync fields and automatically logs
times to TimeSync.

=head1 RT VERSION

Works with RT 4.0

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

Add this line:

    Set(@Plugins, qw(RT::Extension::TimeSync));

or add C<RT::Extension::TimeSync> to your existing C<@Plugins> line.

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

=head1 AUTHOR

OSU Open Source Lab E<lt>https://osuosl.orgE<gt>

=head1 BUGS

All bugs should be reported on our Github respository at

    https://github.com/osuosl/rt-timesync

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2016 by OSU Open Source Lab

This is free software, licensed under:

    The Apache License, Version 2.0

=cut

1;
