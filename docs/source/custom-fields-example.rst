.. _rt-custom-fields-example:

Custom Fields Example
=====================

Summary
-------

This doc describes Custom Fields in RT by example of creating one on ticket
transactions and accessing the field through a scrip. I assume the version of
RT is ``4.0.4``, we are installed on ``Centos6.7``, and the path to ``RT`` is
at ``/usr/local/rt``

Permissions
-----------

You must be logged into RT as username ``root`` to do this.

Output
------

We will be writing a ``scrip`` which will print the value put into a custom
field. In order to see the output we will need to be watching a debug log.
Edit RT's configuration file ``/usr/local/rt/etc/RT_SiteConfig.pm`` and make
sure we have the following lines.

::

  Set($LogToFile, debug);
  Set($LogDir, 'var/log');
  Set($LogToFileNamed, 'rt.log');


Restart your server

::

  service httpd restart

We should now be able to watch this file in a terminal with the command

::

  tail -f /usr/local/rt/var/log/rt.log

Creation
--------

Navigate to:

+-------+---------------+---------------+--------+
| Tools | Configuration | Custom Fields | Create |
+-------+---------------+---------------+--------+

Fill out the information you want, but be sure to name the field ``Activity``.
You do not need to fill out the ``link values`` or the ``include page``. But
make sure you set the ``applies to`` field to be set to ``ticket transactions``

I chose the following settings:

+-------------+---------------------+
| Name        | Activity            |
+-------------+---------------------+
| Description | A timesync field.   |
+-------------+---------------------+
| Type        | Select one value    |
+-------------+---------------------+
| Render Type | Select Box          |
+-------------+---------------------+
| Applies to  | Ticket Transactions |
+-------------+---------------------+
| Validation  | (?#Mandatory).      |
+-------------+---------------------+

Add some values if you choose those settings: ``Coding``, ``Documenting``,
``TPS Reporting``

Navigate to:

+-------+---------------+--------+---------------+---------------------+
| Tools | Configuration | Global | Custom Fields | Ticket Transactions |
+-------+---------------+--------+---------------+---------------------+

Your custom field should now appear under ``Unselected Custom Fields``. Now all
you need to do is click the check box on the left and click ``submit``. The
field should now appear on any ticket transaction.

Accessing Within a Scrip
------------------------

Navigate to:

+-------+---------------+--------+--------+--------+
| Tools | Configuration | Global | Scrips | Create |
+-------+---------------+--------+--------+--------+

Name your scrip anything you like, and set the following fields:

+-----------+------------------------------+
| Condition | On Comment                   |
+-----------+------------------------------+
| Action    | User Defined                 |
+-----------+------------------------------+
| Template  | Global template: Transaction |
+-----------+------------------------------+
| Stage     | TransactionBatch             |
+-----------+------------------------------+

Leave the ``Custom condition`` text field empty (since it is not
``User Defined``)

Fill in the other text fields with the following code:

``Custom action preparation code``:

::

  return 1;

``Custom action cleanup code``:

::

  $RT::Logger->debug("###################################");
  my $val = $self->TransactionObj->FirstCustomFieldValue("Activity");
  $RT::Logger->debug("Activity value: $val");
  $RT::Logger->debug("###################################");

  return 1;

Save your changes.

Testing
-------

While watching the log, try commenting on a ticket and selecting
a value in the custom field.

The output will look familiar, however the end of the lines will have some
funky output. Each debug statement printed with RT's debug `Logger`_ will end
with the filename and line number where the debug method was called. In our
case there is no perl file in which our scrip lives, because it is stored in
one of RT's objects, so we see the eval expression there, but the line number
should be correct.

.. _Logger: https://github.com/bestpractical/rt/blob/4.0-trunk/lib/RT.pm#L288
