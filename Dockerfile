FROM python:3.10-alpine AS builder

RUN apk add --no-cache gcc musl-dev libpq-dev

WORKDIR /code

COPY requirements.txt /code/

RUN pip install --no-cache-dir -r requirements.txt

#Легковесный контейнер с приложением
FROM python:3.10-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /code

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY . .

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED=1

USER appuser

# Команда для запуска приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

