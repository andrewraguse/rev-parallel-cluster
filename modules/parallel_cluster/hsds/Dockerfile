# Use a base image with Python 3.10 and ensure architecture compatibility
FROM --platform=linux/amd64 python:3.10-slim

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    python3-dev \
    libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install the required Python dependencies
RUN pip install --upgrade pip
RUN pip install "nrel-rex[hsds]>=0.2.88"

# Set environment variables for HSDS to access AWS S3
ENV AWS_S3_GATEWAY="http://s3.us-west-2.amazonaws.com"
ENV AWS_S3_NO_SIGN_REQUEST=1
ENV BUCKET_NAME="nrel-pds-nsrdb"
ENV AWS_REGION="us-west-2"
ENV SN_PORT=5101
ENV HSDS_ENDPOINT="http://localhost:5101"
ENV LOG_LEVEL="INFO"

# Copy HSDS config file into the container
COPY .hscfg /root/.hscfg

# Expose the HSDS service port
EXPOSE 5101

# Command to start HSDS service
CMD ["hsds"]