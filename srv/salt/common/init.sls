include:
  - common.packages



#enyamada:
#  user.present:
#    - fullname: Edson Yamada
#    - shell: /bin/bash
#    - home: /home/enyamada
#    - uid: 5000
#    - gid: 5000

# Data structure
# login["enyamada"]["full name"]
# login["enyamada"]["shell"]
# 

# For each group defined in pillar, create it with
# the additional meta information (gid etc)
{% for groupname, meta in pillar.get('groups', {}).items() %}
{{ groupname }}:

  group.present:
    - gid: {{ meta.get('gid','') }}
    - system: {{ meta.get('system', 'False') }}

{% endfor %}



# For each user defined in pillar, create it with
# the additional meta information (uid, gid, ssh key etc)
{% for username, meta in pillar.get('users', {}).items() %}
{{ username }}:

  user.present:
    - fullname: {{ meta.get('fullname','') }}
    - name: {{ username }}
    - shell: {{ meta.get('shell', '/bin/bash') }}
    - home: /home/{{ username }}
    - uid: {{ meta.get('uid', '') }}
    - gid: {{ meta.get('gid', '') }}
    - password: {{ meta.get('password','') }}
    {% if 'groups' in meta %}
    - groups:
      {% for group in meta.get('groups', []) %}
      - {{ group }}
      {% endfor %}
    {% endif %}

  {% if 'pub_ssh_keys' in meta %}
  ssh_auth.present:
    - user: {{ username }}
    - names:
    {% for pub_ssh_key in meta.get('pub_ssh_keys', []) %}
      - {{ pub_ssh_key }}
    {% endfor %}
    - require:
      - user: {{ username }}
  {% endif %}

{% endfor %}
