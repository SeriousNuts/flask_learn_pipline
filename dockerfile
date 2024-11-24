# Используем официальный образ Python
FROM python:3.9-slim
RUN apt-get update && apt-get install python3-pip -y && pip install --upgrade pip
# Устанавливаем рабочую директорию
RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

# Копируем файлы зависимостей
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код приложения
COPY . COPY . /usr/src/app/
ENV FLASK_APP=app.py
EXPOSE 5000
# Указываем команду для запуска приложения
RUN chmod +x app.py

CMD ["python", "app.py"]