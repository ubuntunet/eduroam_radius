[0.7.2] - 2017/07/11
------------------
 * Remove NewRelice role

[0.7] - 2017/05/16
------------------

* Enable the playbook to run on RedHat6 as well
* Minor bugfixes
* Variables/Inventory for EthERNet Radius

[0.6.4] 2016/12/13
------------------
* Rename tz_ternet to tz_or_ternet

[0.6.3] 2016/12/13
-----------------
* Variables/Inventory for TERNET.or.tz

[0.6.2] 2016/12/8
-----------------
* Variables/Inventory for MaliREN


[0.6] 2016/12/08
----------------

* [Breaking] Replace ldap_password and flr_secret with [ldap|flr].password, which gets set in group_vars file. This means that the tasks don't query secrets.yml directly anymore.
* Replace local NewRelic role with the one from Ansible Galaxy. In order to continue using this role, it needs to be downloaded first: ansible-galaxy install franklinkim.newrelic
* Variables/Inventory for TogoREN
