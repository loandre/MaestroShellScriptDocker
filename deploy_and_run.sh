#!/bin/bash

echo "Construindo a imagem Docker..."
docker build -t minha-imagem-android .

echo "Iniciando o contêiner..."
docker run -d -p 6080:6080 -p 9999:9999 -e EMULATOR_DEVICE="Samsung Galaxy S10" -e WEB_VNC=true --device /dev/kvm --name android-container minha-imagem-android

echo "Aguardando o contêiner inicializar..."
sleep 40

echo "Executando script start.sh no contêiner..."
docker exec android-container /bin/bash -c "/home/androidusr/start.sh"

echo "Deploy e execução concluídos."

