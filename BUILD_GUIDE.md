# Tibia Canary Server - Versão Clean para Git

Este repositório contém apenas os arquivos essenciais do Canary 14.02 para facilitar o controle de versão e distribuição. 

## 📁 Estrutura do Projeto

- `src/` - Código fonte C++ do servidor
- `data/` - Scripts Lua, configurações e dados do jogo
- `data-canary/` - Dados específicos do Canary (monstros, mapas, etc.)
- `cmake/` - Arquivos de configuração do CMake
- `docker/` - Configurações para Docker
- `config.lua` - Arquivo principal de configuração
- `schema.sql` - Schema do banco de dados
- `vcpkg.json` - Dependências do projeto

## ⚠️ Arquivos Não Incluídos (Tamanho Otimizado)

Para manter o repositório leve (~200MB ao invés de 6GB), os seguintes arquivos foram excluídos:

- `build/` - Pasta de compilação (5.7GB)
- `data-otservbr-global/` - Dados do OTServBR Global (200MB)
- `.vs/` - Arquivos do Visual Studio
- Executáveis compilados (`.exe`, `.dll`, `.pdb`)
- Bibliotecas compiladas (`.lib`)

## 🛠️ Pré-requisitos

### Windows
- Visual Studio 2019 ou superior com C++
- vcpkg package manager
- CMake 3.16+
- MySQL 8.0+
- Git

### Dependências (instaladas via vcpkg)
```bash
# Instalar vcpkg se não tiver
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
.\bootstrap-vcpkg.bat

# Instalar dependências do projeto
.\vcpkg.exe integrate install
.\vcpkg.exe install --triplet x64-windows
```

## 🔧 Compilação

### 1. Clonar o repositório
```bash
git clone <seu-repositorio-url>
cd tibia-canary
```

### 2. Configurar CMake
```bash
# Criar pasta de build
mkdir build
cd build

# Configurar projeto
cmake .. -DCMAKE_TOOLCHAIN_FILE=C:/caminho/para/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
```

### 3. Compilar
```bash
# Compilar o projeto
cmake --build . --config Release

# Ou abrir no Visual Studio
start canary.sln
```

## ⚙️ Configuração

### 1. Banco de Dados
```sql
-- Criar banco de dados
CREATE DATABASE canary;

-- Importar schema
mysql -u root -p canary < schema.sql
```

### 2. Configurar config.lua
Edite o arquivo `config.lua` e configure:

```lua
-- Database
sqlType = "mysql"
sqlHost = "localhost"
sqlPort = 3306
sqlUser = "root"
sqlPass = "sua_senha"
sqlDatabase = "canary"

-- Server
ip = "127.0.0.1"
loginPort = 7171
gamePort = 7172
statusPort = 7171

-- Map
mapName = "canary"  -- ou "otservbr" se usar o global
mapAuthor = "Canary Team"
```

### 3. Arquivos de Mapa (Se necessário)
Se você quiser usar o mapa do OTServBR Global:

1. Baixe de: https://github.com/opentibiabr/otservbr-global
2. Copie `data-otservbr-global/` para a raiz do projeto
3. Configure `mapName = "otservbr"` no config.lua

## 🚀 Executar

### Desenvolvimento
```bash
# A partir da pasta build
.\canary.exe
```

### Docker (Produção)
```bash
# Configurar variáveis no docker/.env
cp docker/.env.dist docker/.env

# Editar docker/.env com suas configurações
# Executar
docker-compose -f docker/docker-compose.yml up -d
```

## 📝 Arquivos de Configuração Importantes

- `config.lua` - Configuração principal do servidor
- `data/XML/vocations.xml` - Configuração das vocações
- `data/XML/groups.xml` - Grupos de acesso (players, GMs, etc.)
- `data/items/items.xml` - Definições dos itens
- `data/monster/` - Definições dos monstros
- `data/scripts/` - Scripts Lua do servidor

## 🔍 Diferenças do Canary 14.02 Original

Este repositório mantém:
- ✅ Todo o código fonte
- ✅ Todos os scripts e configurações
- ✅ Dados essenciais do Canary
- ✅ Configurações Docker
- ✅ Schema do banco

Mas remove:
- ❌ Arquivos de build compilados
- ❌ Bibliotecas pré-compiladas
- ❌ Arquivos temporários
- ❌ Dados do OTServBR Global (opcional)

## 📞 Suporte

Para problemas específicos de compilação, consulte:
- [Documentação oficial do Canary](https://docs.opentibiabr.com/)
- [Issues do projeto original](https://github.com/opentibiabr/canary)

## 📜 Licença

Mantém a mesma licença do projeto original Canary.

---

**Baseado em:** Canary 14.02  
**Otimizado para:** Controle de versão Git  
**Tamanho:** ~200MB (vs 6GB original)