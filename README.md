# Uninstall All — Panel Reviactyl & Pterodactyl

Script untuk **menghapus SEMUA komponen panel** (Reviactyl + Pterodactyl) dari VPS: folder panel, Wings/Agent, queue worker, Cloudflare Tunnel panel, config Nginx panel, cron panel, docker network panel, dan database panel.

Ini versi standalone dari fitur `/uninstall_all` di bot Reviactyl Remote.

> ⚠️ **PERINGATAN — TIDAK BISA DIBATALKAN.** Semua server game ikut terhapus, termasuk isi `/var/lib/pterodactyl/volumes`. Pakai hanya bila VPS memang mau dibersihkan total dari panel. Untuk melepas protect saja (panel tetap utuh), pakai [uninstall-all-protect](https://github.com/Lngtmi/uninstall-all-protect).

```
uninstall-all.sh
```

## Yang dipertahankan

Docker, Nginx, dan MariaDB itu sendiri tetap terinstall; tunnel Cloudflare lain dan data di luar komponen panel tidak disentuh.

## Kebutuhan

- Dijalankan sebagai **root** di VPS panel (Ubuntu/Debian dengan systemd)

## Cara Pakai — Bash (1 perintah)

Ini satu-satunya cara pakai yang disarankan. Tidak perlu download apa pun — jalankan di VPS panel sebagai root:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Lngtmi/uninstall-all/main/uninstall-all.sh)
```

Script akan meminta kamu mengetik `HAPUS-SEMUA` sebelum menghapus apa pun. Untuk pemakaian non-interaktif (otomatisasi), tambahkan `--yes` di akhir perintah yang sama.

## Kontak

Ada pertanyaan atau butuh bantuan? Hubungi saya di Telegram: [@pratamanie](https://t.me/pratamanie)

---
SOURCE CODE BY PRATAMA
