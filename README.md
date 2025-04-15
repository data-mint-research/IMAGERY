# 📘 IMAGERY – MCP-kompatibler Foto- und Medienstack

## 🚀 Schnellstart

```bash
docker compose up -d
docker compose down
```

## 🌐 MinIO-Buckets erreichbar über

- [http://localhost:9001](http://localhost:9001) – staging (inkl. S3 API Port 9000)
- [http://localhost:9002](http://localhost:9002) – images *(UI-Port optional, nicht aktiv)*
- [http://localhost:9003](http://localhost:9003) – videos *(UI-Port optional, nicht aktiv)*

> 💡 Achtung: Aktuell läuft nur **ein gemeinsamer MinIO-Container**, alle Buckets werden per API verwaltet.

## 🛢️ MariaDB

- Host: `localhost`
- Port: `3306`
- Login: `root`
- Passwort: siehe `.env`

---

## 📂 Zugriff von Windows auf Projektverzeichnis in WSL

Dein WSL-Projekt liegt unter:

```bash
/home/skr/projects/IMAGERY
```

➡ In Windows erreichbar über:

```plaintext
\\wsl.localhost\Ubuntu-22.04\home\skr\projects\IMAGERY\
```

Du kannst von dort aus:

- Skripte wie `mount_minio.cmd` oder `enable_portproxy_minio.bat` direkt ausführen
- Logs, Configs und Daten einsehen
- rclone aus Windows heraus auf die MinIO-Buckets zugreifen

---

## 🔧 Aktuelle IP in WSL (z. B. für Portproxy)

```bash
hostname -I
```

Beispielausgabe:

```plaintext
172.23.117.225 172.17.0.1
```

Nutze diese IP z. B. in deinem `enable_portproxy_minio.bat`, um Zugriffe aus Windows auf localhost zu ermöglichen.

---

