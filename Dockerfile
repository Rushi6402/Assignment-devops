FROM python:3.10-slim
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY backend ./backend

RUN pip install --upgrade pip \
    && pip install --root-user-action=ignore django django-cors-headers psycopg2-binary

WORKDIR /app
COPY frontend/package*.json ./frontend/
RUN npm install --prefix ./frontend

COPY frontend ./frontend/
EXPOSE 8000 5173

CMD ["sh", "-c", "cd backend && python manage.py runserver 0.0.0.0:8000 & cd frontend && npm run dev -- --host"]



