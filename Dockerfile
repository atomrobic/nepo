# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project files
COPY . .

# Collect static files
ENV DJANGO_SETTINGS_MODULE=student_register.settings
RUN mkdir -p /app/staticfiles
RUN python manage.py collectstatic --noinput || true

# Expose port
EXPOSE 8000

# ✅ Use shell form so $PORT expands correctly
CMD ["gunicorn", "student_register.wsgi:application", "--bind", "0.0.0.0:8000"]
