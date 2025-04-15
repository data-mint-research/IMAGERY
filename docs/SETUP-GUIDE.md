# 📘 IMAGERY – Initiale Einrichtung (MCP-kompatibler Foto-Stack)

## 🧽 Ziel

Aufbau einer performanten, modularen Foto- und Medienverarbeitungsumgebung auf Basis von:

- **digiKam (GUI) nativ in WSL2**
    
- **MinIO** als skalierbarer Medienspeicher (3 Buckets: `staging`, `images`, `videos`)
    
- **MariaDB** für Metadaten
    
- **CUDA-Unterstützung (RTX 5090)** für KI-basierte Verarbeitung
    
- **rclone** für optionale Mounts unter Windows
    
- **MCP-konformer Architektur** mit MCP SDK (Python) und `uv` als Paketmanager
    

---

## 🧱 Stack-Struktur

```plaintext
IMAGERY/
├── docker-compose.yaml               # zentrales Startsystem für alle Container (MCP Units)
├── config/
│   └── mcp_register.yaml            # zentrale Komponentenregistrierung (automatisierbar)
├── mcp_units/
│   ├── mcp_host_MARIADB
│   ├── mcp_host_MINIO_STAGING
│   ├── mcp_host_MINIO_IMAGES
│   ├── mcp_host_MINIO_VIDEOS
│   └── mcp_host_RCLONE_MOUNTER
├── data/
│   ├── staging/                     # entspricht Bucket „staging“
│   ├── images/                      # entspricht Bucket „images“
│   └── videos/                      # entspricht Bucket „videos“
├── logs/
│   └── startup.log
└── .env                             # Umgebungsvariablen für Services (Ports, Secrets etc.)
```

---

## 🐧 1. WSL2 + Ubuntu 22.04 einrichten

### Windows Terminal (als Admin):

```powershell
wsl --install -d Ubuntu-22.04
```

➡ Danach PC **neu starten**

---

## 🎮 2. NVIDIA Studio Treiber installieren (WHQL)

Download: [https://www.nvidia.de/Download/driverResults.aspx/221782/de](https://www.nvidia.de/Download/driverResults.aspx/221782/de)  
Produkt: RTX 5090 → Typ: **Studio-Treiber (WHQL)**  
➡ Installieren & neu starten

---

## 🐳 3. Docker Desktop einrichten (WSL-basiert)

- **Settings > General**:
    
    - ✅ „Use the WSL 2 based engine“
        
- **Settings > Resources > WSL Integration**:
    
    - ✅ Nur `Ubuntu-22.04` aktivieren
        
- ❌ Kein Autostart, keine Telemetrie
    

➡ Danach **Docker Desktop schließen** → ab jetzt **nur CLI verwenden**

---

## 🧰 4. Docker, NVIDIA & Tools in WSL

### In Ubuntu (WSL Terminal):

```bash
sudo apt update
sudo apt install -y \
    ca-certificates curl gnupg lsb-release \
    docker-compose flatpak python3 python3-pip
```

#### NVIDIA Container Toolkit:

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt update
sudo apt install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo service docker restart
```

---

## ✅ 5. CUDA testen

```bash
docker run --rm --gpus all nvidia/cuda:12.3.2-base-ubuntu22.04 nvidia-smi
```

---

## 📷 6. digiKam in WSL installieren (Flatpak, WSL-kompatibel)

### Schritt 1: Flatpak-Remote "flathub" manuell registrieren

```bash
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
```

➡ Bestätigen mit:

```bash
flatpak remotes
```

→ Ausgabe muss `flathub` enthalten (Typ: user)

### Schritt 2: digiKam installieren (nur für den Benutzer!)

```bash
flatpak install --user flathub org.kde.digikam
```

➡ Falls Abhängigkeiten wie `org.kde.Platform` nicht automatisch installiert werden:

```bash
flatpak install --user flathub org.kde.Platform//6.8
```

➡ Danach erneut versuchen:

```bash
flatpak install --user flathub org.kde.digikam
```

### Schritt 3: digiKam starten

```bash
flatpak run org.kde.digikam
```

➡ GUI startet über WSLg direkt unter Windows

**Wichtig:** Keine systemweiten Flatpak-Installationen unter WSL verwenden – `--user` ist zwingend notwendig, da systemd & PolicyKit fehlen.

---

## 🐍 7. MCP SDK + uv (benutzerspezifisch)

### Schritt 1: uv installieren (lokal)

```bash
curl -Ls https://astral.sh/uv/install.sh | bash
```

Falls nach Installation `uv` nicht erkannt wird:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Optional dauerhaft in `.bashrc` eintragen:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Schritt 2: Virtuelle Umgebung erstellen

```bash
uv venv .venv
source .venv/bin/activate
```

### Schritt 3: MCP SDK installieren

```bash
uv pip install git+https://github.com/modelcontextprotocol/python-sdk.git

```

---

## 📁 8. Projektstruktur vorbereiten

```bash
cd ~
mkdir -p projects/IMAGERY/{data/{staging,images,videos},logs,config,mcp_units}
touch projects/IMAGERY/docker-compose.yaml
```

➡ optional Mount auf `F:\\docker\\IMAGERY` vorbereiten

---

## 🔐 9. GPU-Zugriff ohne sudo (optional, empfohlen)

```bash
sudo usermod -aG video $USER
sudo usermod -aG docker $USER
wsl --shutdown   # danach neu starten
```

➡ Test:

```bash
nvidia-smi
```

✅ sollte ohne `sudo` funktionieren

---

## ✅ Fertig – Stack bereit

|Funktion|Testbefehl|
|---|---|
|digiKam starten|`flatpak run org.kde.digikam`|
|GPU sichtbar|`nvidia-smi` (ohne sudo)|
|Docker GPU-Test|`docker run --rm --gpus all ... nvidia-smi`|
|MCP SDK aktiviert|`python -c 'import mcp'` (in .venv)|

---