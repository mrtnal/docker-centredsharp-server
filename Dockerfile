ARG LINUX_IMAGE="ubuntu"
ARG LINUX_IMAGE_VERSION="25.04"


FROM --platform=$BUILDPLATFORM ${LINUX_IMAGE}:${LINUX_IMAGE_VERSION}

ARG CED_VERSION="0.6.5.22"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        unzip wget dotnet-sdk-9.0 && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /cedserver
WORKDIR "/cedserver"
RUN wget "https://github.com/kaczy93/centredsharp/releases/download/${CED_VERSION}/Cedserver-Linux-x64.zip" -O cedserver.zip
RUN unzip cedserver.zip
RUN mv /cedserver/artifacts/Server-Linux-X64/Cedserver /cedserver/Cedserver

RUN chmod +x /cedserver/Cedserver
RUN rm -rf /cedserver/artifacts
RUN rm cedserver.zip

EXPOSE 2597

ENTRYPOINT ["./Cedserver"]