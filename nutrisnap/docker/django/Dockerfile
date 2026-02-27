# FROM python:3.11-slim

# ENV PYTHONDONTWRITEBYTECODE=1 \
#     PYTHONUNBUFFERED=1 \
#     PIP_NO_CACHE_DIR=off

# WORKDIR /app

# # Instalar dependências do sistema
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     gcc \
#     libpq-dev \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# # Copiar requirements
# COPY src/requirements.txt .

# # Instalar dependências Python
# RUN pip install --no-cache-dir -r requirements.txt

# # Copiar código
# COPY src/ .

# # Criar usuário não-root
# RUN adduser --disabled-password --gecos '' appuser && \
#     chown -R appuser:appuser /app
# USER appuser

# EXPOSE 8000

# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "core.wsgi:application"]


FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY backend/requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY src /app/

EXPOSE 8000