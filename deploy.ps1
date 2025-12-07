# Скрипт для деплоя на сервер (PowerShell для Windows)

Write-Host "🚀 Начало деплоя..." -ForegroundColor Green

# Проверка наличия Docker
try {
    docker --version | Out-Null
    Write-Host "✅ Docker установлен" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker не установлен. Установите Docker и повторите попытку." -ForegroundColor Red
    exit 1
}

# Проверка наличия Docker Compose
try {
    docker-compose --version | Out-Null
    Write-Host "✅ Docker Compose установлен" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker Compose не установлен. Установите Docker Compose и повторите попытку." -ForegroundColor Red
    exit 1
}

# Остановка старых контейнеров
Write-Host "🛑 Остановка старых контейнеров..." -ForegroundColor Yellow
docker-compose down

# Удаление старых образов (опционально)
$removeImages = Read-Host "Удалить старые образы? (y/n)"
if ($removeImages -eq "y" -or $removeImages -eq "Y") {
    Write-Host "🗑️  Удаление старых образов..." -ForegroundColor Yellow
    docker-compose rm -f
    docker system prune -f
}

# Сборка новых образов
Write-Host "🔨 Сборка новых образов..." -ForegroundColor Yellow
docker-compose build --no-cache

# Запуск контейнеров
Write-Host "▶️  Запуск контейнеров..." -ForegroundColor Yellow
docker-compose up -d

# Ожидание готовности сервисов
Write-Host "⏳ Ожидание готовности сервисов..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Проверка статуса
Write-Host "📊 Проверка статуса контейнеров..." -ForegroundColor Yellow
docker-compose ps

Write-Host "✅ Деплой завершен!" -ForegroundColor Green
Write-Host "🌐 Backend доступен по адресу: http://localhost:8000" -ForegroundColor Green
Write-Host "🌐 Frontend доступен по адресу: http://localhost:3000" -ForegroundColor Green
Write-Host "📚 API документация: http://localhost:8000/docs" -ForegroundColor Green

