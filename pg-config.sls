{%set smb_mount_point = '/mnt/pgbackup' %}
{%set fstab_mount_string = "//192.168.0.@@@/@@@@@@/@@@@ {{smb_mount_point}} cifs user=@@@,pass=@@@,file_mode=0766,dir_mode=0777 0 0"%}
{%set pg_dump_cmd = "pg_dump -d postgresql://@@:xxxx@192.168.100.10/db > /mnt/pgbackup/db_pa/$(date +%Y-%m-%d-%H-%M)"%}

config activities for pg backup:
  file.directory:
    - name: "{{smb_mount_point}}"

add smb share in fstab:
  file.append:
    - name: "/etc/fstab"
    - text: "{{fstab_mount_string}}"

schedule a pg_dump backup:
  cron.present:
    - name: "{{pg_dump_cmd}}"
    - hour: 6
    - minute: 0
    - identifier: backup-pgsql
