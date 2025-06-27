# 📘 راهنمای اجرای اسکریپت بررسی CDN در کلاینت‌ها (Client Help)

این راهنما به شما نشان می‌دهد چگونه اسکریپت بررسی اتصال به CDNها را در سیستم‌های مختلف کلاینت (ویندوز، لینوکس، ترمینال اندروید) اجرا کنید.

---

## 🖥️ ویندوز (Windows) - روش توصیه‌شده: استفاده از WSL

### مراحل:

1. **نصب WSL (زیرسیستم لینوکس در ویندوز)**:
   ترمینال PowerShell را با دسترسی Administrator باز کرده و دستور زیر را اجرا کنید:
   ```powershell
   wsl --install
   ```

2. **اجرای Ubuntu**:
   پس از نصب، سیستم ری‌استارت می‌شود و از طریق منوی استارت، Ubuntu را اجرا کنید.

3. **نصب ابزارهای مورد نیاز در ترمینال Ubuntu**:
   ```bash
   sudo apt update
   sudo apt install curl iputils-ping coreutils
   ```

4. **ایجاد فایل اسکریپت با nano**:
   ```bash
   nano cdn-check.sh
   ```

   سپس کد اسکریپت را در آن وارد کرده و با `Ctrl+O` ذخیره و با `Ctrl+X` خارج شوید.

5. **اجرا**:
   ```bash
   chmod +x cdn-check.sh
   ./cdn-check.sh
   ```

---

## 🧰 جایگزین برای ویندوز: Git Bash

- می‌توانید از [Git Bash](https://git-scm.com/downloads) استفاده کنید، اما توجه داشته باشید:
  - `ping` و `/dev/tcp` در آن به‌صورت کامل پشتیبانی نمی‌شوند.
  - فقط بخش `curl` ممکن است به‌درستی کار کند.

---

## 🐧 لینوکس (Ubuntu/Debian/CentOS)

1. نصب ابزارها:
   ```bash
   sudo apt update
   sudo apt install curl iputils-ping coreutils
   ```

2. ایجاد فایل اسکریپت:
   ```bash
   nano cdn-check.sh
   ```

3. اجرا:
   ```bash
   chmod +x cdn-check.sh
   ./cdn-check.sh
   ```

---

## 📱 اندروید (با Termux)

1. نصب ترمینال Termux از F-Droid یا GitHub.
2. نصب ابزارهای لازم:
   ```bash
   pkg update
   pkg install curl coreutils
   ```

3. ایجاد فایل اسکریپت:
   ```bash
   nano cdn-check.sh
   ```

4. اجرا:
   ```bash
   chmod +x cdn-check.sh
   ./cdn-check.sh
   ```

---

## 📦 ذخیره خروجی در فایل (در همه سیستم‌ها)

برای ذخیره خروجی بررسی‌ها در فایل متنی:
```bash
./cdn-check.sh | tee cdn-log-$(date +%F-%H%M).log
```

---

در صورت نیاز به راهنمایی بیشتر، خوشحال می‌شویم در بخش Issues گیت‌هاب پاسخگو باشیم.