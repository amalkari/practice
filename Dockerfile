FROM ubuntu:20.04  # Specify a version to ensure stability

WORKDIR /app

# Install Python, pip, and other necessary tools
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy application files
COPY requirements.txt /app
COPY devops /app/devops

# Set up a virtual environment and install dependencies
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Set the virtual environment as default
ENV PATH="/app/venv/bin:$PATH"

# Set the entry point and command
ENTRYPOINT ["python3"]
CMD ["devops/manage.py", "runserver", "0.0.0.0:8000"]
