FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install required packages
RUN apt-get update && apt-get install -y \
    x11vnc \
    xvfb \
    net-tools \
    curl \
    wget \
    unzip \
    android-sdk \
    qemu-kvm \
    openjdk-8-jdk \
    libpulse0 \
    libgl1-mesa-glx \
    libnss3 \
    && rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/*

# Set up environment variables for Java
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Download and install Android Studio
RUN wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.25/android-studio-2020.3.1.25-linux.tar.gz -P /tmp \
    && tar -xvf /tmp/android-studio-2020.3.1.25-linux.tar.gz -C /opt \
    && rm /tmp/android-studio-2020.3.1.25-linux.tar.gz

# Set up environment variables
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH $PATH:/opt/android-studio/bin

# Download and set up noVNC
RUN mkdir -p /opt/noVNC/utils/websockify \
    && curl -L https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz --strip 1 -C /opt/noVNC \
    && curl -L https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C /opt/noVNC/utils/websockify \
    && ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html

# Copy the start-vnc.sh and start-android-studio.sh scripts
COPY start-vnc.sh /usr/local/bin/start-vnc.sh
COPY start-android-studio.sh /usr/local/bin/start-android-studio.sh
# Set execute permissions for the scripts
RUN chmod +x /usr/local/bin/start-vnc.sh /usr/local/bin/start-android-studio.sh
