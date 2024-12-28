FROM python:3.10-alpine

RUN apk add --no-cache gcc musl-dev libpq-dev

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

WORKDIR /code

# Копируем все файлы в контейнер
COPY . .


RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED=1

# Команда для запуска приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
