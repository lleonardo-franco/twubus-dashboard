#!/bin/bash

BACKUP_DIR="/var/backups/twubus"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=7

mkdir -p $BACKUP_DIR

echo "🔄 Iniciando backup em $(date)"

# Backup do banco de dados
echo "📊 Backup do banco de dados..."
sudo -u postgres pg_dump twubus_db > $BACKUP_DIR/twubus_db_$DATE.sql

# Backup dos arquivos da aplicação
echo "📁 Backup dos arquivos..."
tar -czf $BACKUP_DIR/app_files_$DATE.tar.gz \
    /var/www/twubus/.env \
    /var/www/twubus/uploads \
    /etc/nginx/sites-available/twubus.tech

# Backup das configurações do sistema
echo "⚙️ Backup das configurações..."
tar -czf $BACKUP_DIR/system_config_$DATE.tar.gz \
    /etc/nginx/nginx.conf \
    /etc/fail2ban/jail.local \
    /etc/ssh/sshd_config

# Remover backups antigos
echo "🧹 Limpando backups antigos..."
find $BACKUP_DIR -type f -mtime +$RETENTION_DAYS -delete

# Listar backups
echo "📋 Backups disponíveis:"
ls -lah $BACKUP_DIR/

echo "✅ Backup concluído em $(date)"

# Enviar para storage externo (opcional)
# rsync -av $BACKUP_DIR/ user@backup-server:/backups/twubus/
