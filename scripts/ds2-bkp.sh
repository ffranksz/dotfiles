#!/bin/bash

# Franklin Souza
# @ffranksz

# Caminho do save do Dark Souls II
save_path="$HOME/.steam/steam/steamapps/compatdata/335300/pfx/drive_c/users/steamuser/AppData/Roaming/DarkSoulsII/011000010b6ae7b4"

# Caminho da pasta de backup
backup_folder="$HOME/Franks/BKP_DarkSoulsII"

# Verifica se a pasta de backup existe
if [ ! -d "$backup_folder" ]; then
  # Se não existir, cria a pasta
  echo "Pasta de backup não encontrada. Criando a pasta: $backup_folder"
  mkdir -p "$backup_folder"
else
  # Se a pasta existir, continua
  echo "Pasta de backup já existe: $backup_folder"
fi

# Data para adicionar ao nome do arquivo de backup
current_date=$(date +"%Y-%m-%d_%H-%M-%S")

# Caminho do arquivo de backup
backup_file="$backup_folder/ds2_save_$current_date"

# Copiar o arquivo de save para o backup
cp -r "$save_path" "$backup_file"

# Exibir mensagem de sucesso
echo "Backup realizado com sucesso: $backup_file"

