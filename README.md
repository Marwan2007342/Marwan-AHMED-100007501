# 100007510_Marwan_AP

## Ink Marker Manufacturing Production Line Simulation

**Student:** Marwan Ahmed  
**Student ID:** 100007510  
**University:** SRH Fernhochschule  
**Course:** Advanced Programming Project

This project simulates an Industry 4.0 ink marker manufacturing production line. It combines an object-oriented Python backend, a Pygame human-machine interface (HMI), InfluxDB telemetry, Grafana dashboards, Docker Compose infrastructure, and a static project website.

Repository: 100007510_Marwan_AP

---

## Features

- Five-stage ink marker production simulation
- Object-oriented backend with `Product`, `Machine`, `QualityControl`, and `ProductionLine`
- Pygame HMI with Start, Stop, Reset, and Emergency Stop controls
- Machine state banner, stage cards, progress bars, production statistics, and defect messages
- Defect detection with configurable defect rates per stage
- Non-blocking telemetry writer for InfluxDB
- Auto-provisioned Grafana datasource and dashboard
- Docker Compose setup for InfluxDB and Grafana
- Static project website in `website/`

---

## Production Stages

| Stage | Name | Purpose | Duration | Defect Rate |
|---|---|---|---:|---:|
| 1 | Plastic Barrel Molding | Mold and cool the plastic marker barrel | 3.0 s | 12% |
| 2 | Ink Reservoir Filling | Fill the internal reservoir with metered ink volume | 4.0 s | 10% |
| 3 | Marker Tip Installation | Insert and seat the fiber tip into the barrel nose | 2.5 s | 8% |
| 4 | Cap Assembly | Fit the cap and verify snap retention force | 2.0 s | 7% |
| 5 | Quality Control | Inspect ink flow, cap seal, dimensions, and appearance | 3.5 s | 6% |

---

## Requirements

- Python 3.11 or newer
- pip
- Docker Desktop or Docker Engine with Compose support

The Python dependencies are listed in `requirements.txt` and are compatible with macOS, Windows, and Linux.

---

## Installation

```bash
git clone <repository-url>
cd 100007510_Marwan_AP

python -m venv .venv
```

Activate the virtual environment:

```bash
# macOS / Linux
source .venv/bin/activate

# Windows PowerShell
.venv\Scripts\Activate.ps1
```

Install dependencies:

```bash
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

---

## Run the HMI

```bash
python production_line/hmi/main.py
```

Keyboard shortcuts:

| Key | Action |
|---|---|
| `S` | Start or resume production |
| `X` | Stop production |
| `R` | Reset machine and counters |
| `E` | Emergency stop |
| `Esc` | Quit |

If InfluxDB is not running, the HMI still works and shows the telemetry status as offline.

---

## Docker Setup

Start the monitoring stack:

```bash
docker compose up -d
```

Services:

| Service | URL | Credentials |
|---|---|---|
| InfluxDB | <http://localhost:8086> | `admin` / `marker_admin_2026` |
| Grafana | <http://localhost:3000> | `admin` / `marker_grafana_2026` |

A headless container run for the HMI is available with:

```bash
docker compose --profile hmi up --build app
```

---

## Grafana Setup

Grafana is provisioned automatically from:

- `grafana/provisioning/datasources/influxdb.yml`
- `grafana/provisioning/dashboards/dashboard.yml`
- `grafana/provisioning/dashboards/marker_production.json`

Open Grafana at <http://localhost:3000>, then navigate to the **Production** folder and open **Ink Marker Production Line Dashboard**.

Dashboard panels include:

- Parts Produced
- Total Defects
- Defect Rate
- Machine State
- Current Stage
- Production Trend
- Defect Trend
- Production Log

---

## Telemetry Metrics

InfluxDB measurement: `marker_production`

Fields:

- `parts_produced`
- `defects_total`
- `defect_rate_pct`
- `current_stage`
- `machine_state`
- `uptime_seconds`
- `cycles_started`
- `active_fault`
- `cycle_result` on completed or defective cycles

Tags:

- `machine_id`
- `state`

---

## Project Structure

```text
100007510_Marwan_AP/
├── production_line/
│   ├── backend/
│   │   ├── production_logic.py
│   │   └── influx_client.py
│   └── hmi/
│       ├── main.py
│       └── ui_components.py
├── grafana/
│   └── provisioning/
│       ├── dashboards/
│       └── datasources/
├── report/
│   └── report.md
├── website/
│   ├── screenshots/
│   ├── index.html
│   └── style.css
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
└── README.md
```

---

## Screenshots

### Pygame HMI - Main Screen

![Pygame HMI main idle screen](website/screenshots/hmi_main.png)

### Pygame HMI - Running State

![Pygame HMI running state](website/screenshots/hmi_running.png)

### Pygame HMI - Fault State

![Pygame HMI fault state](website/screenshots/fault_state.png)

### Grafana Dashboard

![Representative Grafana dashboard layout](website/screenshots/grafana_dashboard.png)

This image is a representative dashboard layout for documentation purposes when Docker/Grafana is not available in the execution environment. The real dashboard is provisioned from `grafana/provisioning/dashboards/marker_production.json` when running `docker compose up -d`.

---

## Verification Commands

```bash
python -m compileall production_line
python production_line/hmi/main.py
docker compose config
docker compose up -d
```

---

## AI Tools Used

Google Gemini and GitHub Copilot were used for planning support, boilerplate generation, and code completion. All generated material was reviewed, corrected, and integrated manually. Details are documented in `report/report.md`.
