# !/bin/bash


while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
	echo "$(date) - waiting database start"
	sleep 1
done

if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
	echo "database $PGDATABASE doesnt exist. Creating..."
	createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
	echo "database $PGDATABASE created"
fi

mix ecto.migrate

elixir --cookie katana --name katana@socket --no-halt -S mix run

# echo ${PASSWD} | sudo -S npm i -g wait-on broken-link-checker

# wait-on http://localhost:7000 --timeout=600000
# blc --recursive http://localhost:7000
