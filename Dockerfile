# Use the latest official Playwright image (includes browsers)
FROM mcr.microsoft.com/playwright/python:v1.48.0-jammy

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && playwright install --with-deps

# Default command to run tests
CMD ["pytest", "-v", "--alluredir=allure-results"]
