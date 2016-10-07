=======================
Tripleo Debugging Tools
=======================

Scripts
=======

- check-puppet-errors.sh
  After running an overcloud, heat will sometimes return error code 6. This
  returns when puppet has errored in the overcloud. ``check-puppet-errors.sh``
  will search though the overcloud nodes and return where the puppet error
  occured and the logs associated with it.

- monitor-updates.sh
  When updating or upgrading an overcloud, you will need to monitor the logs
  of all the affected nodes to for any changes.  The script
  ``monitor-updates.sh`` will accpet a regex as input and runs ``multitail`` on
  all the matching nodes.  Multitail will tail journalctl and filter for
  messages from ``os-collect-config`` and ``yum`` and output them to the
  terminal.

Ansible
=======

The ansible bits in here are WIP.  The goal is to have them replace the
check-puppet-errors script.  The playbooks would be more robust and better
for production use.
