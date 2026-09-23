#!/usr/bin/env bash
# examshell kurulumu — Ubuntu / Debian
set -e
cd "$(dirname "$0")"
need=()
command -v node >/dev/null || need+=(nodejs)
command -v gcc  >/dev/null || need+=(build-essential)
command -v git  >/dev/null || need+=(git)
command -v nm   >/dev/null || need+=(binutils)
if [ ${#need[@]} -gt 0 ]; then
  echo "Eksik paketler kuruluyor: ${need[*]}"
  sudo apt-get update -q && sudo apt-get install -y "${need[@]}"
fi
mkdir -p "$HOME/.local/bin"
install -m 755 examshell "$HOME/.local/bin/examshell"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
     echo "PATH güncellendi — yeni bir terminal aç veya: source ~/.bashrc" ;;
esac
echo "Kuruldu: $HOME/.local/bin/examshell  ($(node --version))"
echo "Başlatmak için: examshell"
