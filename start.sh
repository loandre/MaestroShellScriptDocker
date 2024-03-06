#!/bin/bash

# Caminho do arquivo APK no container
APK_PATH="/home/androidusr/testIDVouTeHomologar.apk"

# Esperar até que o ADB esteja pronto e o emulador seja carregado
echo "Esperando o ADB estar pronto e o emulador carregar..."
until adb devices | grep 'device$'; do
    echo "Aguardando o emulador..."
    sleep 10
done

echo "Emulador carregado e pronto."
sleep 20 

echo "Instalando APK..."
adb install $APK_PATH
echo "APK instalado com sucesso."

