# Используем официальный образ PHP с Apache
FROM php:8.3-apache

# Устанавливаем рабочую директорию
WORKDIR /var/www/html

# Устанавливаем системные зависимости и расширения PHP
RUN apt-get update && apt-get install -y \
   libzip-dev \
   unzip \
   npm \
   && docker-php-ext-install pdo_mysql zip

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем файлы проекта
COPY . /var/www/html

# Устанавливаем зависимости PHP
RUN composer install --no-dev --optimize-autoloader

# Устанавливаем зависимости JS и собираем фронтенд для продакшена
RUN npm install
RUN npm run build

# Настраиваем Apache для работы с Laravel
RUN a2enmod rewrite
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Настраиваем права доступа
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Экспонируем порт 80
EXPOSE 80

# Запускаем Apache в форграунде
CMD ["apache2-foreground"]