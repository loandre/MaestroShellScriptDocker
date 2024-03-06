# Usar a imagem base
FROM budtmo/docker-android:emulator_11.0

# Definir as variáveis de ambiente necessárias
ENV EMULATOR_DEVICE="Samsung Galaxy S10" \
    WEB_VNC=true

# Expor as portas necessárias
EXPOSE 6080 9999

# Instalar Maestro CLI
RUN curl -Ls "https://get.maestro.mobile.dev" | bash

# Atualiza o PATH para incluir o diretório de instalação do Maestro CLI
ENV PATH="/home/androidusr/.maestro/bin:${PATH}"

# Copiar APKs para o contêiner
COPY testIDVouTeHomologar.apk /home/androidusr/

# Copiar run_test.sh e template_test.yaml para o contêiner
COPY run_test.sh /home/androidusr/
COPY template_test.yaml /home/androidusr/
COPY start.sh /home/androidusr/

