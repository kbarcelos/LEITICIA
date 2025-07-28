#!/usr/bin/env bash
set -euo pipefail

echo "📂 SITE_ROOT: $(pwd)"

# 1) Cria/atualiza o .htaccess
cat > .htaccess << 'EOF'
################################################################################
# .htaccess – raiz de public_html
################################################################################

<IfModule mod_rewrite.c>
    RewriteEngine On

    # --- 1) www-only
    RewriteCond %{HTTP_HOST} ^leiticia\.com\.br$ [NC]
    RewriteRule ^ https://www.leiticia.com.br%{REQUEST_URI} [L,R=301]

    # --- 2) (opcional) força HTTPS – descomente no futuro
    # RewriteCond %{HTTPS} !=on
    # RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

    # --- 3) EXCLUI estatics da reescrita
    RewriteRule ^(manifest\.json|service-worker\.js|offline\.html|favicon\.png)$ - [L]
    RewriteRule ^(assets|css|js|fonts|vendor|data|db)/ - [L]

    # --- 4) front-controller: tudo que não existir fisicamente vai pro index.php
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^ index.php [L,QSA]
</IfModule>

# 5) Arquivos “index” padrão
DirectoryIndex index.php default.php index.html

# 6) Bloqueia listagem de diretórios
Options -Indexes

# 7) Proteção extra a config/, db/, etc.
<IfModule mod_rewrite.c>
    RewriteRule ^(config|db|data|vendor)/ - [F,L]
</IfModule>
<FilesMatch "(?i)^config\.php$">
    <IfModule mod_authz_core.c>
        Require all denied
    </IfModule>
    <IfModule !mod_authz_core.c>
        Order allow,deny
        Deny from all
    </IfModule>
</FilesMatch>

# 8) Cache estático (7 dias)
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/css                 "access plus 7 days"
    ExpiresByType application/javascript   "access plus 7 days"
    ExpiresByType image/jpeg               "access plus 7 days"
    ExpiresByType image/png                "access plus 7 days"
    ExpiresByType image/gif                "access plus 7 days"
    ExpiresByType image/svg+xml            "access plus 7 days"
    ExpiresByType font/woff                "access plus 7 days"
    ExpiresByType font/woff2               "access plus 7 days"
</IfModule>

# 9) Compressão GZIP
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain text/html text/xml
    AddOutputFilterByType DEFLATE text/css application/javascript application/json
    AddOutputFilterByType DEFLATE application/xml image/svg+xml
</IfModule>
################################################################################
EOF

# 2) Ajusta permissões para evitar 403
echo "🔒 Definindo pastas=755 e arquivos=644"
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

echo "✅ .htaccess atualizado e permissões corrigidas!"
