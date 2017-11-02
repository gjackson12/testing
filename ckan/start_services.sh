#/bin/bash


#check_psql () {
#        curl gjackson-ckan-postgres:5432 2>/dev/null
#        if [ $? -ne 52 ]
#        then
#                return 1
#        fi
#        return 0
#}

#while ! check_psql
#do
#  echo "$(date) - still checking if docker image gjackson-ckan-postgres is running on port 5432, this will not end until it is running"
#  sleep 1
#done
#echo "$(date) - gjackson-ckan-postgres is running on port 5432"

#if [ ! -f /var/lib/ckan/default/db_initialized ]; then
#    . /usr/lib/ckan/default/bin/activate
#    cd /usr/lib/ckan/default/src/ckan

#    if paster db init -c /etc/ckan/default/development.ini | grep -q 'SUCCES'; then
#       echo "$(date) ckan database initialized"
#       touch /var/lib/ckan/default/db_initialized
#       echo "delete this file if you want to reinitialize the ckan database" >> /var/lib/ckan/default/db_initialized
#    fi
#fi

echo "Waiting on Postgres to start..."

sleep 1m

. /usr/lib/ckan/default/bin/activate

cd /usr/lib/ckan/default/src/ckan

paster db init -c /etc/ckan/default/development.ini

cd /usr/lib/ckan/default/src/ckan

paster serve /etc/ckan/default/development.ini
