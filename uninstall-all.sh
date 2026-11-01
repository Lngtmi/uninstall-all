#!/usr/bin/env bash
# Uninstall SEMUA komponen panel Reviactyl + Pterodactyl dari VPS.
#
# Script standalone dari fitur /uninstall_all di bot Reviactyl Remote
# (fungsi remove_existing) — daftar targetnya sama persis dengan versi bot,
# ditambah 3 sisa versi sekarang yang belum dikenal versi bot:
# /etc/cron.d/pterodactyl dan sudoers Guard/Protect Manager.
#
# YANG DIHAPUS: folder panel, Wings/Agent + service-nya, queue worker,
# Cloudflare Tunnel panel, config Nginx panel, cron panel, docker network
# panel, database "panel" + user databasenya.
# YANG DIPERTAHANKAN: Docker, Nginx, dan MariaDB itu sendiri, tunnel
# Cloudflare lain, dan semua data di luar daftar di atas.
#
# PERINGATAN: tidak bisa dibatalkan. Semua server game (termasuk
# /var/lib/pterodactyl/volumes) ikut terhapus.
set -u
[[ ${EUID:-999} -eq 0 ]] || { echo 'Run as root'; exit 1; }

if [[ ${1:-} != '--yes' ]]; then
  read -r -p 'Ketik HAPUS-SEMUA untuk menghapus semua komponen panel: ' CONFIRM
  [[ $CONFIRM == 'HAPUS-SEMUA' ]] || { echo 'Dibatalkan.'; exit 1; }
fi

systemctl disable --now wings agent pteroq reviq cloudflared-pterodactyl cloudflared-reviactyl 2>/dev/null || true
rm -rf /var/www/pterodactyl /var/www/reviactyl /etc/pterodactyl /etc/reviactyl /var/lib/pterodactyl /var/lib/reviactyl
rm -f /etc/cloudflared/pterodactyl.yml /etc/cloudflared/reviactyl.yml \
  /usr/local/bin/wings /usr/local/bin/agent \
  /etc/systemd/system/wings.service /etc/systemd/system/agent.service \
  /etc/systemd/system/pteroq.service /etc/systemd/system/reviq.service \
  /etc/systemd/system/cloudflared-pterodactyl.service /etc/systemd/system/cloudflared-reviactyl.service \
  /etc/nginx/sites-enabled/pterodactyl.conf /etc/nginx/sites-enabled/reviactyl \
  /etc/nginx/sites-available/pterodactyl.conf /etc/nginx/sites-available/reviactyl \
  /etc/cron.d/reviactyl /etc/cron.d/pterodactyl \
  /etc/sudoers.d/reviactyl-guard /etc/sudoers.d/pterodactyl-protect
docker network rm pterodactyl_nw reviactyl_nw 2>/dev/null || true
mariadb -e "DROP DATABASE IF EXISTS panel; DROP USER IF EXISTS 'pterodactyl'@'127.0.0.1'; DROP USER IF EXISTS 'pterodactyl'@'localhost'; DROP USER IF EXISTS 'reviactyl'@'127.0.0.1'; DROP USER IF EXISTS 'reviactyl'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null || true
systemctl daemon-reload
echo 'Pembersihan selesai. Docker/Nginx/MariaDB umum dipertahankan. Credential/tunnel Cloudflare lain tidak disentuh.'
