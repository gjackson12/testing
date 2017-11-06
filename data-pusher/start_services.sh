#/bin/bash

. /usr/lib/ckan/default/bin/activate

cd datapusher

python datapusher/main.py deployment/datapusher_settings.py
