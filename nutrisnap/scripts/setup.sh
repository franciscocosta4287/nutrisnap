#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== Configurando Nutrisnap com Docker ===${NC}"

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker não encontrado. Instalando...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
fi

# Verificar se Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}Docker Compose não encontrado. Instalando...${NC}"
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Criar projeto Django se não existir
if [ ! -f "src/manage.py" ]; then
    echo -e "${YELLOW}Criando projeto Django...${NC}"
    cd src
    django-admin startproject core .
    cd ..
fi

# Construir e iniciar containers
echo -e "${YELLOW}Construindo containers...${NC}"
docker-compose build

echo -e "${YELLOW}Iniciando containers...${NC}"
docker-compose up -d

# Aguardar banco de dados
echo -e "${YELLOW}Aguardando banco de dados...${NC}"
sleep 10

# Executar migrations
echo -e "${YELLOW}Executando migrations...${NC}"
docker-compose exec web python manage.py migrate

# Coletar arquivos estáticos
echo -e "${YELLOW}Coletando arquivos estáticos...${NC}"
docker-compose exec web python manage.py collectstatic --noinput

# Criar superusuário
echo -e "${YELLOW}Criar superusuário? (s/n)${NC}"
read -r CREATE_SUPER
if [ "$CREATE_SUPER" = "s" ]; then
    docker-compose exec web python manage.py createsuperuser
fi

echo -e "${GREEN}✅ Setup completo!${NC}"
echo -e "${GREEN}Acesse: http://localhost${NC}"
echo -e "${GREEN}Admin: http://localhost/admin${NC}"
