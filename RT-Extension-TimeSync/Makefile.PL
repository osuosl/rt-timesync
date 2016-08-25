use inc::Module::Install;

RTx     'RT-Extension-TimeSync';
license 'apachev2';
repository 'https://github.com/osuosl/rt-timesync';

requires_rt '4.0.0';
rt_too_new '4.2.0';

sign;
WriteAll;
