# !/bin/bash

while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
	echo "$(date) - waiting database start"
	sleep 1
done

if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
	echo "database $PGDATABASE doesnt exist. Creating..."
	createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
	# mix run priv/repo/seeds.exs
	echo "database $PGDATABASE created"
fi
mix ecto.create
mix ecto.migrate

exec elixir --cookie katana --name api@alura --no-halt -S mix phx.server

# echo ${PASSWD} | sudo -S npm i -g wait-on broken-link-checker

# wait-on http://localhost:7000 --timeout=600000
# blc --recursive http://localhost:7000
