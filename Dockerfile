FROM python:3.9-alpine

RUN apk add --no-cache gcc musl-dev libpq-dev

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /code/
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]