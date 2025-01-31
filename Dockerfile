# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install SWI-Prolog in the container
RUN apt-get update && \
    apt-get install -y swi-prolog

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt /app/
# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire server code into the container
COPY . /app/

# Expose the port the app runs on (adjust the port if needed)
EXPOSE 5000

# Command to run the server
CMD ["python", "./scripts/server.py"]
