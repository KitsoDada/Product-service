#!/bin/sh

echo "⏳ Waiting for MySQL to be ready..."

# Keep checking until MySQL is available
until nc -z product-db 3306; do
  echo "📡 Waiting for MySQL..."
  sleep 1
done

echo "✅ MySQL is up. Running migrations..."
php artisan migrate --force

echo "🚀 Starting Apache..."
exec apache2-foreground
