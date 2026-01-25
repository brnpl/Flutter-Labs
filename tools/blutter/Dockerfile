FROM debian:trixie-slim

# install all dependencies in a single layer
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    python3-pyelftools \
    python3-requests \
    python3-capstone \
    git \
    cmake \
    ninja-build \
    build-essential \
    pkg-config \
    libicu-dev \
    libcapstone-dev \
    && rm -rf /var/lib/apt/lists/*

# create non-root user
RUN useradd -m -u 1000 blutter && \
    mkdir -p /app && \
    chown -R blutter:blutter /app

# switch to non-root user
USER blutter

# clone blutter to /app
WORKDIR /app
RUN git clone https://github.com/worawit/blutter.git .

# set entrypoint to run blutter directly
ENTRYPOINT ["python3", "blutter.py"]
CMD ["--help"]

# docker build -t blutter .
# docker run --rm -v $(pwd):/data blutter /data/<app.apk> /data/output