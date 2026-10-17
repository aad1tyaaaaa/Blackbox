FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends libgomp1 && rm -rf /var/lib/apt/lists/*
COPY pyproject.toml ./
COPY blackbox ./blackbox
RUN pip install --no-cache-dir .
# ponytail: artifacts/ and data/ are gitignored; mount a volume or build them on the host (bb train) for diagnosis to work
CMD uvicorn blackbox.api:app --host 0.0.0.0 --port ${PORT:-8000}
