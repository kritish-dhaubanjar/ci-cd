#! /bin/bash


TIME=$(TZ=Asia/Kathmandu date)
#  ============ CONFIGURATION PER PROJECT BASIS ================= #
HOSTPROVIDER="Babal.Host"
HOSTPROVIDERURL="https://babal.host/"
SITEURL="https://myunepal.com"
FOOTERTEXT=""
# ============= GET FROM USER =================================== #

usage()
{
        echo "Usage: ./test.sh < main_content_msg > < embedded_title > < embedded_description >"
}

# IF POSITIONAL ARGUMENTS COUNT IS LESS THAN 3 THEN SHOW USAGE MESSAGE AND EXIT
if (($# < 3)); then
        echo $(usage)
        exit
fi

CONTENT="$1"
TITLE="$2"
DESCRIPTION="$3"

generate_post_data()
{
  cat <<EOF
  {
    "username": "DeploymentNotifier",
    "content": "$CONTENT",
    "embeds": [
      {
        "author": {
          "name": "$HOSTPROVIDER",
          "url": "$HOSTPROVIDERURL",
          "icon_url": "https://i.imgur.com/R66g1Pe.jpg"
        },
        "title": "$TITLE",
        "url": "$SITEURL",
        "description": "$DESCRIPTION",
        "color": 15258703,
        "fields": [
          {
            "name": "Time",
            "value": "$TIME",
            "inline": true
          },
          {
            "name": "Site Link",
            "value": "$SITEURL"
          }
        ],
        "footer": {
          "text": "$FOOTERTEXT",
          "icon_url": "https://i.imgur.com/fKL31aD.jpg"
        }
      }
    ]
  }
EOF
}

# SEND POST REQUEST TO DISCORD WEBHOOK FOR DEVELOPMENT CHANNEL
curl -v \
    -H "Content-Type: application/json" \
    -X POST \
    -d "$(generate_post_data)" \
    https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
