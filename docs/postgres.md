# Docker
```bash
docker run --name postgres -e POSTGRES_PASSWORD=masterkey -p 5432:5432 -d postgres:18
```

# Create backup
```bash
pg_dump -U postgres -d mydb -F tar -f ./mydb.tar
```

# Restorign db from backup
```bash
docker exec -e PGPASSWORD=masterkey postgres psql -U postgres -c "CREATE DATABASE mydb;"
```

```bash
docker cp ~/Documents/mydb.tar postgres:/tmp/mydb.tar
docker exec -e PGPASSWORD=masterkey -i postgres pg_restore -U postgres -d mydb /tmp/dump.tar
```