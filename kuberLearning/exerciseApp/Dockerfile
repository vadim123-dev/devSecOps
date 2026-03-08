FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ARG SCRIPT_NAME_ARG
ENV SCRIPT_NAME=${SCRIPT_NAME_ARG}
COPY ${SCRIPT_NAME_ARG}.py .
CMD ["sh", "-c", "python $SCRIPT_NAME.py"]
