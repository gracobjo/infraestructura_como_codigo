# Fase 1: Traemos Java 21
FROM eclipse-temurin:21-jdk AS java-storage

# Fase 2: Imagen de Hadoop
FROM apache/hadoop:3.4.2

USER root

# Copiamos Java 21
COPY --from=java-storage /opt/java/openjdk /usr/lib/jvm/java-21-openjdk

# Variables de entorno del sistema
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

# Forzamos a Hadoop a usar este Java específicamente
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-21-openjdk" >> /etc/hadoop/hadoop-env.sh && \
    echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/hadoop/hadoop-env.sh

# Aseguramos permisos para las carpetas de datos
RUN mkdir -p /opt/hadoop/data/nameNode /opt/hadoop/data/dataNode && \
    chown -R hadoop:hadoop /opt/hadoop/data

USER hadoop