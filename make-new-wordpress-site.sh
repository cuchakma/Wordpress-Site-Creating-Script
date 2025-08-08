#!/bin/bash

#store the current path in a variable.
current_path=$(pwd)

#read the split string in array | split the array by '/' delimiter.
IFS='/' read -ra splitted_path <<< "$current_path"

#get the current folder.
last_index=$(( ${#splitted_path[@]} - 1 ))

#use these constants.
DB_NAME=${splitted_path[${last_index}]}
SITE_NAME=${splitted_path[${last_index}]}
SITE_TITLE="${splitted_path[${last_index}]}-TITLE"
SITE_USERNAME='root'
SITE_PASSWORD='admin'
SITE_EMAIL='greendaycu20@gmail.com'
SITE_URL="${splitted_path[${last_index}]}.test"
DB_USER=root
THEME_ARRAY=("astra")
PLUGIN_ARRAY=("woocommerce")

#download wordpress core files inside the current folder.
wp core download

#create config.
wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass=''

#create DB
wp db create

#install wordpress
wp core install --url="${SITE_URL}" --title="${SITE_TITLE}" --admin_user="${SITE_USERNAME}" --admin_password="${SITE_PASSWORD}" --admin_email="${SITE_EMAIL}"

#download and activate woocommerce 
for plugin in "${PLUGIN_ARRAY[@]}"; do
   wp plugin install ${plugin} --activate
done

#download and acivate new theme (astra)
for theme in "${THEME_ARRAY[@]}"; do
   wp theme install ${theme} --activate
done