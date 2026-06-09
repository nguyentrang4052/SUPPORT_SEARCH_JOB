FROM python:3.11-slim
WORKDIR /ai_service
COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt
COPY . . 
CMD sh -c "uvicorn src.api:app --host 0.0.0.0 --port ${PORT:-8000}"
