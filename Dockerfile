# Use the latest Ubuntu base image
FROM ubuntu:latest

# Update package lists and install packages (Apache)
# -y flag automatically answers yes to prompts
# Clean up apt-get cache to reduce image size
RUN apt-get update && \
    apt-get install -y apache2 && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the contents of the local "scripts" directory into the container's working directory
COPY scripts/ .

# Make all shell scripts in the working directory executable
RUN chmod +x *.sh

# Set the default command to open an interactive bash shell
# This allows you to manually run any of your scripts for testing.
CMD service apache2 start && /bin/bash