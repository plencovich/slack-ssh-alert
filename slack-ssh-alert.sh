#! /bin/bash

SLACK_WEBHOOK="https://hooks.slack.com/services/SLACK_WEBHOOK_URL" #Configurar la URL proporcionada por SLACK para el Hook
SLACK_CHANNEL="canal" #Nombre del canal donde recibis la info del servidor
SLACK_USERNAME="usuairo" #Nombre del usuario seteado en el hook
IP=`echo $SSH_CONNECTION | cut -d " " -f 1`
HOSTNAME=`hostname`

[ -z $SLACK_WEBHOOK ] && { echo "SLACK_WEBHOOK no está configurado!"; exit 1; }

statusMessage() {
    echo -e ":exclamation: Alguien se conectó a *${HOSTNAME}* por SSH desde la *IP ${IP}*\n"
}

PAYLOAD="{\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"${SLACK_USERNAME}\", \"text\": \"`statusMessage`\"}"
curl -X POST --data-urlencode "payload=$PAYLOAD" $SLACK_WEBHOOK

${SSH_ORIGINAL_COMMAND:-bash}
