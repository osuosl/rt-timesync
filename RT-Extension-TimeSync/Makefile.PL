use inc::Module::Install;

RTx     'RT-Extension-TimeSync';
license 'apachev2';
repository 'https://github.com/osuosl/rt-timesync';

requires_rt '4.0.0';

sign;
WriteAll;
