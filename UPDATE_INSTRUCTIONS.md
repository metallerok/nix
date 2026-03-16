# Как обновить конфигурацию на установленной NixOS системе

## Установка конфигурации из Git репозитория

### Шаг 1: Клонирование репозитория


```bash
# Перейти в домашнюю директорию
cd ~

# Клонировать репозиторий (замените URL на ваш реальный репозиторий)
git clone <ваш-git-репозиторий-url> nix-config

# Или если у вас есть ssh ключи:
# git clone git@github.com:username/nix-config.git
```

### Шаг 2: Обновление системной конфигурации

```bash
# Перейти в директорию с конфигом
cd ~/nix-config

# Обновить системную конфигурацию
sudo nixos-rebuild switch --flake .#default

# Или если вы используете другую конфигурацию:
# sudo nixos-rebuild switch --flake .#имя-конфигурации
```

### Шаг 3: Обновление Home Manager конфигурации

```bash
# Обновить home manager конфигурацию
home-manager switch --flake .#default@administrator

# Или просто:
# home-manager switch
```

### Шаг 4: Перезагрузка (если необходимо)

```bash
# Перезагрузить систему
sudo reboot
```

## Обновление из существующего репозитория

Если конфиг уже склонирован:

```bash
# Перейти в директорию с конфигом
cd ~/nix-config

# Получить последние изменения
git pull

# Обновить конфигурацию
sudo nixos-rebuild switch --flake .#default

# Обновить home manager
home-manager switch --flake .#default@administrator
```

## Откат изменений

```bash
# Перейти к предыдущей версии
cd ~/nix-config
git checkout HEAD~1

# Восстановить конфигурацию
sudo nixos-rebuild switch --flake .#default

# Или использовать поколение NixOS
sudo nixos-rebuild switch --rollback
```