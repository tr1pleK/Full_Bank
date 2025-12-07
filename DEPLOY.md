# Инструкция по деплою на сервер

## Быстрый старт

1. **Клонируй репозиторий на сервер:**
```bash
git clone <твой-репозиторий>
cd Hahaton_Bank
```

2. **Если деплоишь на удаленный сервер, измени URL API в docker-compose.yml:**
   - Открой `docker-compose.yml`
   - Найди секцию `frontend` → `args` → `VITE_API_URL`
   - Замени `http://localhost:8000` на `http://ТВОЙ_IP:8000` или `http://твой-домен:8000`

3. **Запусти всё через Docker:**
```bash
docker-compose up -d --build
```

4. **Проверь что всё работает:**
- Backend: http://твой-сервер:8000/docs
- Frontend: http://твой-сервер
- База данных: localhost:5432 (внутри сети Docker)

## Остановка

```bash
docker-compose down
```

## Перезапуск после изменений

```bash
docker-compose down
docker-compose up -d --build
```

## Логи

```bash
# Все сервисы
docker-compose logs -f

# Только backend
docker-compose logs -f backend

# Только frontend
docker-compose logs -f frontend

# Только база данных
docker-compose logs -f db
```

## Проблемы?

1. **Порт занят?** Измени порты в `docker-compose.yml`
2. **База не подключается?** Подожди 10-15 секунд после старта
3. **Frontend не видит API?** Проверь `VITE_API_URL` в `docker-compose.yml` (должен быть реальный URL сервера, не localhost)

## Структура

- Backend: порт 8000
- Frontend: порт 80
- PostgreSQL: порт 5432 (только внутри Docker сети)

Всё работает из коробки, никаких .env файлов не нужно!

