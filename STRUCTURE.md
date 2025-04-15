# 📁 Projektstruktur – IMAGERY Stack (MCP-konform)

Dies ist die aktuelle Struktur deines Projekts mit Beschreibung aller Komponenten. Sie ist vollständig MCP-konform aufgebaut und eignet sich für lokale, modulare Entwicklung und Betrieb.

## 🔧 Projektbaum

```
IMAGERY/
├── .env                         # Umgebungsvariablen für MinIO und MariaDB
├── README.md                    # Projektübersicht und Nutzung
├── STRUCTURE.md                 # (diese Datei) Projektstruktur-Übersicht
├── docker-compose.yaml          # Docker Compose Definition (MinIO, MariaDB)
├── config/
│   └── mcp_register.yaml        # MCP-Registry für automatisch erkennbare Dienste
├── scripts/
│   ├── enable_portproxy_minio.bat   # Windows-Portweiterleitung (localhost)
│   ├── init_minio_buckets.sh        # Erstellt Buckets über MinIO-Client
│   └── mount_minio.cmd              # rclone Mounts als Netzlaufwerke X:/Y:/Z:
├── mcp_units/
│   ├── mcp_host_MARIADB/            # Dienstspezifische Datenbank-Unit
│   ├── mcp_host_MINIO/              # MinIO Unit für MCP-Verwaltung
│   └── mcp_host_RCLONE_MOUNTER/     # Mount-Einheit für Windows-Bucket-Zugriff
└── data/
    ├── db/                          # Persistente Daten von MariaDB
    └── minio/
        ├── staging/                 # Bucket staging
        ├── images/                  # Bucket images
        └── videos/                  # Bucket videos
```

## 📌 Hinweise

- Alle persistenten Daten befinden sich ausschließlich im `data/`-Verzeichnis
- Nur ein MinIO-Container mit `/data` wird verwendet (nicht mehrere Sub-Mounts!)
- MCP-Registry (`config/mcp_register.yaml`) erkennt Dienste automatisch
- `mcp_units/` enthält technische Schnittstellen für Automatisierung

