FROM python:3.11-slim

WORKDIR /usr/src/dbt

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir "dbt-postgres==1.11.0"

COPY . .

CMD ["sh", "-c", "dbt deps --profiles-dir profiles && dbt seed --full-refresh --profiles-dir profiles --vars '{\"load_source_data\": true}' && dbt build --profiles-dir profiles && sleep infinity"]