# ─────────────────────────────────────────────────────────────────
#  Ink Marker Production Line  –  Dockerfile
#  Python 3.11 + Pygame + InfluxDB client
# ─────────────────────────────────────────────────────────────────

FROM python:3.11-slim

# System dependencies for Pygame (SDL2) and virtual display
RUN apt-get update && apt-get install -y --no-install-recommends \
        libsdl2-2.0-0 \
        libsdl2-image-2.0-0 \
        libsdl2-mixer-2.0-0 \
        libsdl2-ttf-2.0-0 \
        libgl1-mesa-glx \
        libglib2.0-0 \
        xvfb \
        x11-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY production_line/ ./production_line/

# Environment variable defaults (overridden by docker-compose)
ENV DISPLAY=:0 \
    PYTHONUNBUFFERED=1 \
    INFLUX_URL=http://influxdb:8086 \
    INFLUX_TOKEN=marker_admin_token_2026 \
    INFLUX_ORG=marker_org \
    INFLUX_BUCKET=marker_production

# Start Xvfb virtual display then launch the HMI
CMD ["bash", "-c", "Xvfb :99 -screen 0 1100x700x24 & sleep 1 && DISPLAY=:99 python production_line/hmi/main.py"]
