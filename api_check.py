import sys
import subprocess

services = sys.argv[1:]

if len(sys.argv) < 2:
    print("Usage: python3 api_check.py <service1> <service2>")
    sys.exit(1)  # Останавливаем скрипт с кодом ошибки

for svc in services:
    result = subprocess.run(["systemctl", "is-active", "--quiet", svc], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"[OK] Сервис {svc} работает!")
    else:
        print(f"[FAIL] Сервис {svc} не работает!")
