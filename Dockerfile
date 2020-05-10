FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine3.11

WORKDIR /build

# Install JDK.
# From https://github.com/docker-library/openjdk/blob/ee26e3735002dfb83551faf0f3b73822addc4799/15/jdk/alpine/Dockerfile
ENV JAVA_HOME /opt/openjdk-15
ENV PATH $JAVA_HOME/bin:$PATH
ENV JAVA_VERSION 15-ea+10
ENV JAVA_URL https://download.java.net/java/early_access/alpine/10/binaries/openjdk-15-ea+10_linux-x64-musl_bin.tar.gz
ENV JAVA_SHA256 15a5e8002e24ed129b82bfe55ffe4bdbf3cfd0a7e5ad3399879cdd44175bfd06
# "For Alpine Linux, builds are produced on a reduced schedule and may not be in sync with the other platforms."
RUN set -eux; \
  \
  wget -O /openjdk.tgz "$JAVA_URL"; \
  echo "$JAVA_SHA256 */openjdk.tgz" | sha256sum -c -; \
  mkdir -p "$JAVA_HOME"; \
  tar --extract --file /openjdk.tgz --directory "$JAVA_HOME" --strip-components 1; \
  rm /openjdk.tgz; \
  \
  # https://github.com/docker-library/openjdk/issues/212#issuecomment-420979840
  # https://openjdk.java.net/jeps/341
  java -Xshare:dump; \
  \
  # basic smoke test
  java --version; \
  javac --version

# Install GraphViz and wget.
RUN \
  apk add --no-cache graphviz wget ca-certificates && \
  apk add --no-cache graphviz wget ca-certificates ttf-dejavu fontconfig

# Download PlantUML.
RUN wget "http://sourceforge.net/projects/plantuml/files/plantuml.1.2020.8.jar/download" -O plantuml.jar

# Install PlantUmlClassDiagramGenerator.
RUN dotnet tool install --global PlantUmlClassDiagramGenerator --version 1.2.0
ENV PATH $PATH:/root/.dotnet/tools

# Declare the volume for the source code we're going to operate on
VOLUME /code

# Generation variables.
ENV PUML_GEN_ARGS "-public"

# Run the final script.
COPY gen.sh .
RUN chmod +x gen.sh
ENTRYPOINT ["./gen.sh"]
