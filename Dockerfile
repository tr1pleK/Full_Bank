FROM python:3.11-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Копируем файл зависимостей
COPY backend/requirements.txt .

# Устанавливаем Python зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код приложения
COPY backend/ .

# Открываем порт
EXPOSE 8000

# Команда для запуска приложения (без --reload для продакшена)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

