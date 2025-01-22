# Use Python 3.10.10 (or higher) image as a base
FROM python:3.10.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest of your project files into the container
COPY . .

# Install swi-prolog
RUN apt-get update && \
    apt-get install -y swi-prolog

# Expose the port your app will run on
EXPOSE 8080

# Run the Python app
CMD ["python", "main.py"]
