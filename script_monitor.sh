#!/bin/bash

# Nome do script a ser verificado
script_name="/bin/python3 /var/lib/sippulse/opensips-agent/agent.py"

# Tempo limite em segundos
timeout=300

# Obtém os PIDs dos scripts
pids=$(pgrep -f "$script_name")

# Verifica se há pelo menos um script rodando
if [ -n "$pids" ]; then

  # Percorre os PIDs
  for pid in $pids; do

    # Verifica se o script está rodando a mais tempo que o definido no timeout
    start_time=$(date +%s -d "$(date +%s -r $pid)")
    now=$(date +%s)
    if [ $(($now - $start_time)) -gt $timeout ]; then

      # Encerra o script
      kill -9 $pid

    fi

  done

fi
