# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы зависимостей
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код приложения
COPY . .
ENV FLASK_APP=app.py
EXPOSE 5000
# Указываем команду для запуска приложения
RUN chmod +x app.py

CMD ["python", "app.py"]