#!/bin/bash
set -e

# Moodle 디렉토리로 이동
MOODLE_DIR="/var/www/html/moodle"
if [ -d "$MOODLE_DIR" ]; then
    cd "$MOODLE_DIR"
    
    # Composer 의존성 설치 (vendor 디렉토리가 없거나 composer.json이 변경된 경우)
    if [ -f "composer.json" ]; then
        if [ ! -d "vendor" ] || [ "composer.json" -nt "vendor" ]; then
            echo "Running composer install --no-dev --classmap-authoritative..."
            composer install --no-dev --classmap-authoritative --no-interaction --prefer-dist
        else
            echo "Composer dependencies are up to date."
        fi
    fi
fi

# Apache 실행
exec apache2-foreground
