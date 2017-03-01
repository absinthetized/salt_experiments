{% if grains['os'] == 'CentOS' %}

install/check autoupdate tools:
  pkg.installed:
    - name: yum-cron

prepare to configure auto-update:
  service.dead:
    - name: yum-cron

/etc/yum/yum-cron.conf:
  file.managed:
    - source: salt://centos.yumcron.std

enable auto updates:
  service.running:
    - name: yum-cron
    - enable: True

cron reboot every sunday:
  cron.present:
    - name: /usr/sbin/reboot
    - hour: 0
    - minute: 0
    - dayweek: 0
    - identifier: reboot-machine

{% elif grains['os'] == 'Ubuntu' %}

install/check autoupdate tools:
  pkg.installed:
    - name: unattended-upgrades

/etc/apt/apt.conf.d/50unattended-upgrades:
  file.managed:
    - source: salt://ubuntu.unattended.std

/etc/apt/apt.conf.d/10periodic:
  file.managed:
    - source: salt://ubuntu.periodic.std
{% endif %}