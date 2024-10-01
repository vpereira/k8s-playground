# Use the SUSE BCI Python 3.11 base image
FROM registry.suse.com/bci/python:3.11

# Set the working directory inside the container
WORKDIR /app

# Copy the Python script to the container
COPY server.py /app/server.py

# Expose port 8080 for the server
EXPOSE 8080

# Command to run the Python server script
CMD ["python3", "server.py"]

