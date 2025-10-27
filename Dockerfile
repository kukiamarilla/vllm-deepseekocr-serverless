FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Configuración de entorno
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV RUNPOD_HANDLER=handler.handler

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y python3 python3-pip git && \
    rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos
COPY requirements.txt .
COPY handler.py .

# Instalar dependencias estrictamente versionadas
RUN pip install --no-cache-dir -r requirements.txt

# Ejecutar el runtime serverless de RunPod
CMD ["python3", "-u", "-m", "runpod"]