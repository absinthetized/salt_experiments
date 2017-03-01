#install required stuff on system: smbclient and postgresql client
install required packages:
  pkg.installed:
    - pkgs:
        - cifs-utils
      {% if grains['os'] == 'CentOS' %}
        - samba-client
        - postgresql
        - centos-release-scl
     {% elif grains['os'] == 'Ubuntu' %}
        - smbclient
        - postgresql-client
        - python3
        - python3-pip
     {% endif %}

#centos requires an additional step after SCL are installed
{% if grains['os'] == 'CentOS' %}
python collection for readhat:
  pkg.installed:
    - name: rh-python35
{% endif %}