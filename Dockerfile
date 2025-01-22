# Use the official SWI-Prolog image as the base image
FROM swi-prolog:latest

# Install Python 3 and other dependencies
RUN apt-get update && apt-get install -y python3 python3-pip

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Copy the rest of your project files into the container
COPY . .

# Expose the port your app will run on
EXPOSE 8080

# Run the Python app
CMD ["python3", "main.py"]
