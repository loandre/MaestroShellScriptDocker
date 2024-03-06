#!/bin/bash

# Caminho do arquivo APK no container
APK_PATH="/home/androidusr/testIDVouTeHomologar.apk"

# Argumento para o script run_test.sh
#TEST_SCRIPT_ARG="hml704appsPro"

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

#echo "Executando o script de teste após 20 segundos de espera..."
#sleep 20  # Garante tempo para a instalação da APK

# Diretamente executa o run_test.sh dentro do container
#./run_test.sh $TEST_SCRIPT_ARG

#echo "Script de teste executado."

