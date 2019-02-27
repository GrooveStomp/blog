---
date: 2019-02-27
url: /2019/02/27/vps-learning/
title: "VPS Learning"
tags: [vps, linux, sysops]
---

Today we learn how little I know about system administration.

I host most of my own "cloud" services on a VPS I rent from SSDNodes. Recently I purchased an upgraded KVM node for reasons of which I'll get into later.  Anyway, I ran into a hiccup while trying to start migrating from my older VPS.

    └─ curl 142.44.184.204
    curl: (56) Recv failure: Connection reset by peer

Hmm.

NOTE: First of all, I know the machine is reachable because I can SSH into it.

I tried to audit all my stuff from the VPS itself.

Nginx systemd unit:

    $ sudo systemctl status nginx
    [sudo] password for gs:
    ● nginx.service - A high performance web server and a reverse proxy server
       Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
       Active: active (running) since Tue 2019-02-26 21:16:49 UTC; 24min ago
         Docs: man:nginx(8)
      Process: 877 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
      Process: 840 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
     Main PID: 883 (nginx)
        Tasks: 2 (limit: 4915)
       CGroup: /system.slice/nginx.service
               ├─883 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
               └─884 nginx: worker process

    Feb 26 21:16:49 ssdnodes-83291 systemd[1]: Starting A high performance web server and a reverse proxy server...
    Feb 26 21:16:49 ssdnodes-83291 systemd[1]: nginx.service: Failed to read PID from file /run/nginx.pid: Invalid argume
    Feb 26 21:16:49 ssdnodes-83291 systemd[1]: Started A high performance web server and a reverse proxy server.

Nginx enabled sites:

    $ sudo ls /etc/nginx/sites-enabled/
    default

    $ sudo cat /etc/nginx/sites-enabled/default
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;

      index index.html index.htm index.nginx-debian.html;

      server_name _;

      location / {
        try_files $uri $uri/ =404;
      }
    }

    $ ls -lh /var/www/html
    total 4.0K
    -rw-r--r-- 1 www-data www-data 612 Feb 11 18:41 index.nginx-debian.html

And the firewall rules:

    142.44.184.204gs@ssdnodes-83291:~$ sudo ufw status
    Status: active

    To                         Action      From
    --                         ------      ----
    Nginx HTTP                 ALLOW       Anywhere
    OpenSSH                    ALLOW       Anywhere
    Nginx HTTP (v6)            ALLOW       Anywhere (v6)
    OpenSSH (v6)               ALLOW       Anywhere (v6)

All of this looks good - no obvious issues.

I also checked iptables via `sudo iptables -L` and noticed a *ton* of crap in there.

Something else to note is that the old system is running on Debian 8 but this server is running on Debian 9.

Okay, long story short, SSDNodes ran this for me:

    firewall-cmd --zone=public --add-port=80/tcp --permanent
    firewall-cmd --reload

I had actually seen a reference to this while searching for random stuff but it was correlated with Fedora, so I chose to ignore it.  (Also, it was late and I was tired of stabbing at this here and there when I had a spare half hour or so over multiple days.)

----

Okay, so why did I upgrade to a KVM instance?

Primarily for `FUSE` support so I can use `s3fs` to mount an AWS S3 bucket locally as a block device and have Nextcloud Files write to S3 instead of local disk.