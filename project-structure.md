# IMAGERY Project Structure

```
/home/skr/projects/IMAGERY/
├── .env                           # Environment variables for MinIO and MariaDB
├── README.md                      # Project documentation
├── docker-compose.yaml            # Docker Compose configuration
├── config/
│   └── mcp_register.yaml          # MCP units configuration
├── scripts/
│   ├── enable_portproxy_minio.bat # Windows script for port forwarding
│   ├── init_minio_buckets.sh      # Script to initialize MinIO buckets
│   └── mount_minio.cmd            # Windows script to mount MinIO buckets as drives
└── data/                          # Data directory (created by Docker)
    ├── db/                        # MariaDB data
    └── minio/                     # MinIO data
```

## File Descriptions

### Root Directory

- **`.env`**: Contains environment variables for MinIO and MariaDB configurations
  - MinIO credentials (MINIO_ROOT_USER, MINIO_ROOT_PASSWORD)
  - MariaDB credentials (MARIADB_ROOT_PASSWORD) and database name (MARIADB_DATABASE)

- **`README.md`**: Basic documentation for starting the services and accessing them
  - Instructions to start with `docker compose up -d`
  - URLs for accessing MinIO buckets
  - Information about MariaDB access

- **`docker-compose.yaml`**: Defines the Docker services
  - MariaDB service (port 3306)
  - MinIO service (ports 9000, 9001)

### Config Directory

- **`config/mcp_register.yaml`**: Configuration for MCP (Model Context Protocol) units
  - MARIADB unit (type: database, role: metadata)
  - MINIO unit (type: objectstore, role: media-storage) with buckets (staging, images, videos)

### Scripts Directory

- **`scripts/init_minio_buckets.sh`**: Bash script to initialize MinIO buckets
  - Creates three buckets: staging, images, and videos
  - Uses MinIO Client (mc) to interact with MinIO

- **`scripts/enable_portproxy_minio.bat`**: Windows batch script for port forwarding
  - Sets up port forwarding from Windows to WSL for MinIO ports (9001, 9002, 9003)
  - Uses the Windows netsh command

- **`scripts/mount_minio.cmd`**: Windows command script to mount MinIO buckets as drives
  - Uses rclone to mount the three MinIO buckets as Windows drive letters
  - Staging bucket → X:
  - Images bucket → Y:
  - Videos bucket → Z:

### Data Directory

- **`data/db/`**: Directory for MariaDB data (mounted as volume)
- **`data/minio/`**: Directory for MinIO data (mounted as volume)