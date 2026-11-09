services = [
    {"name": "nginx", "expected_status": "running"},
    {"name": "ssh", "expected_status": "running"},
    {"name": "cron", "expected_status": "stopped"}
]

for svc in services:
    service_name = svc["name"]
    expected = svc["expected_status"]
    real_status = "running"
    if expected == real_status:
        print(f"[OK] Сервис {service_name} работает!")
    else:
        print(f"[FAIL] Сервис {service_name} должен быть {expected}, но он {real_status}!")
