FROM microsoft/dotnet:2.1.402-sdk-stretch AS builder

# Install mono
ENV MONO_VERSION 5.14.0.177

RUN apt update
RUN apt install -y apt-transport-https dirmngr 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt update \
  && apt-get install -y mono-complete \
  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN apt-get update \
  && apt-get install -y binutils curl mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl \
  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN apt-get update \
  && apt-get install -y git openssh-client tar gzip \
  && rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /sln

LABEL com.circleci.preserve-entrypoint=true

ENTRYPOINT ["sleep", "infinity"]
