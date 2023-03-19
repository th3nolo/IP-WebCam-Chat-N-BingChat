FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install required packages
RUN apt-get update && apt-get install -y \
    bash \
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
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/*

# Set up environment variables for Java
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Copy the local cmdline-tools folder to the Docker image
COPY cmdline-tools /opt/android-sdk/cmdline-tools/latest

# Set up environment variables
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH=$PATH:/opt/android-sdk/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/tools/bin

# Create sdkmanager.sh script
RUN echo '#!/bin/bash\nexport PATH=$PATH:/opt/android-sdk/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/tools/bin\nsdkmanager "$@"' > /usr/local/bin/sdkmanager.sh && \
    chmod +x /usr/local/bin/sdkmanager.sh

# Accept licenses and install Android SDK components
RUN yes | sdkmanager.sh --licenses
RUN sdkmanager.sh "platform-tools" "build-tools;30.0.3" "platforms;android-30"

# Download and set up noVNC
RUN mkdir -p /opt/noVNC/utils/websockify \
    && curl -L https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz --strip 1 -C /opt/noVNC \
    && curl -L https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C /opt/noVNC/utils/websockify \
    && ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html

# Create start-novnc.sh script
RUN echo '#!/bin/bash\n/opt/noVNC/utils/launch.sh --vnc localhost:5901' > /usr/local/bin/start-novnc.sh && \
    chmod +x /usr/local/bin/start-novnc.sh

# Copy the modified start-vnc.sh and start-android-studio.sh scripts
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Set execute permissions for the scripts
ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
