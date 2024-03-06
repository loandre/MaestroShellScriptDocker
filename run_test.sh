#!/bin/bash

# Argumentos passados para o script
TAP_ON_VALUE=$1

# Caminhos relativos com base no diretório atual
TEMPLATE_FILE="./template_test.yaml"
GENERATED_TEST_FILE="test_temp.yaml"

# Diretório de saída do Maestro (usando variável de ambiente para home do usuário)
MAESTRO_OUTPUT_DIR="$HOME/.maestro/tests"

# Diretório atual
SCRIPT_DIR=$(pwd)

# Encontra o número da última pasta de teste e incrementa para o próximo
LAST_TEST_DIR=$(find $SCRIPT_DIR -type d -name "test-*" | sort -V | tail -n1 | grep -o '[^-]*$')
NEXT_TEST_NUM=$((LAST_TEST_DIR + 1))

# Cria um diretório para esta execução do teste
TEST_DIR="$SCRIPT_DIR/test-$NEXT_TEST_NUM"
mkdir -p $TEST_DIR

# Substitui o placeholder no arquivo de template pelo valor fornecido
sed "s/{{tapOnValue}}/$TAP_ON_VALUE/g" $TEMPLATE_FILE > "$TEST_DIR/$GENERATED_TEST_FILE"

# Executa o teste com o Maestro Studio
maestro test "$TEST_DIR/$GENERATED_TEST_FILE"

# Identifica o diretório mais recente de saída do teste do Maestro
LATEST_TEST_DIR=$(ls -dt $MAESTRO_OUTPUT_DIR/* | head -1)

# Verifica se houve erro (presença de 'FAILED' no maestro.log) e exibe a linha do erro
if grep -q "FAILED" "$LATEST_TEST_DIR/maestro.log"; then
    echo "Erro encontrado durante a execução do teste. Detalhes:"
    grep "FAILED" "$LATEST_TEST_DIR/maestro.log"
else
    echo "Teste concluído sem erros."
fi
