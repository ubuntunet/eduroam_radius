freeradius-eduroam Ansible role
===============================

Install FreeRADIUS and configure it to use PAM for EAP authentication in a way that is compatible with eduroam.

Requirements
------------

This role is designed to be played on Ubuntu. It has been tested with Ubuntu 16.04 LTS.

Users will need RADIUS detail from their own eduroam national roaming operator.

FreeRADIUS config is largely in accordance with GÉANT's documentation, available at <https://wiki.geant.org/display/H2eduroam/freeradius-idp>

Role Variables
--------------

### Basic eduroam configuration:

 * `eduroam_flr_servers` - a list of eduroam federation-level RADIUS servers. For each server, the following should be provided (defaults to using the South African eduroam FLR servers):
   * `name` - hostname of the FLR server
   * `ip` - IP address of the FLR server
   * `port` - port of the FLR server
   * `secret` - the RADIUS secret negotiated with the NRO/FLR operator
 * `radius_realm` - the Realm to use for your users, typically your primary DNS domain name (defaults to `example.ac.za`)
 * `radius_local_users` - a list of local "files" users to create. For each user, the following should be provided (defaults to creating an nren_radius_test user):
   * `username`
   * `password`

### Authentication backend configuration:
   
 * Pluggable Authentication Module (PAM)
   * `use_pam` - set to `yes` to enable use of PAM for authentication (defaults to `no`)
   * `pam_service_name` - the name of the PAM service we should install (defaults to `radiusd`)

### Optional enhancements:

 * `send_cui` - whether to send Chargeable-User-Identity (defaults to `yes`)
 * `send_username` - whether to send a real User-Name back (defaults to `no`). Setting this to `yes` has privacy implications, but can be useful for debugging.

Dependencies
------------

Since Ubuntu 16.04 LTS still uses [FreeRADIUS 2.2.8](https://packages.ubuntu.com/xenial/amd64/freeradius), this role installs a FreeRADIUS 3.0.x series package from an [Ubuntu PPA](https://launchpad.net/~freeradius/+archive/ubuntu/stable-3.0/).

Example Playbook
----------------

See <https://github.com/safire-ac-za/eduroam-imap-playbook/>

License
-------

MIT <https://github.com/safire-ac-za/eduroam-imap-playbook/LICENSE>

Author Information
------------------

Guy Halse <http://orcid.org/0000-0002-9388-8592>,
[Tertiary Education and Research Network of South Africa](http://www.tenet.ac.za/).
