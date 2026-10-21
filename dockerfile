# FROM python:3.10-slim-buster
# WORKDIR /app
# COPY . /app
# RUN pip install -r requirements.txt
# CMD ["python3", "app.py"]
FROM python:3.10-slim-bookworm

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Install CPU-only PyTorch (avoid large NVIDIA CUDA libraries)
RUN pip install --no-cache-dir torch \
    --index-url https://download.pytorch.org/whl/cpu

# Copy requirements
COPY requirements.txt .

# Copy project files (needed because requirements contains -e .)
COPY . .

# Install application dependencies without pip cache
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ["python3", "app.py"]
