# salt-logins

## Creating one login per user

In a nutshell:
- The Pillars [groups.sls](https://github.com/enyamada/salt-logins/blob/master/srv/pillar/groups.sls) and [users.sls](https://github.com/enyamada/salt-logins/blob/master/srv/pillar/users.sls) define a list of groups and logins to be pushed to every host. There you can include each ssh public key to be used to authorize access. A password hash may be got by using `openssl password -1`.
- [This state file](https://github.com/enyamada/salt-logins/blob/master/srv/salt/common/groups_and_users.sls) ensures that all groups and logins are created as specified.
