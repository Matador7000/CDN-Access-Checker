# 🌐 CDN Access Checker

This is a powerful and portable Bash script designed to test accessibility to both **global** and **local (Iranian)** Content Delivery Networks (CDNs). It performs a set of checks for each CDN, including:

- ✅ ICMP Ping (when available)
- ✅ TCP port reachability (ports: 80, 443, 8080, 8443, etc.)
- ✅ HTTP and HTTPS response status via `curl`

> Useful for system admins, VPN developers, censorship researchers, or anyone interested in network diagnostics under restricted environments (e.g., Iran, China).

---

## 📦 Features

- Covers **18+ popular CDNs** including Cloudflare, Fastly, Akamai, Google, Amazon CloudFront, Shatel, Asiatech, and more
- Works with only basic system tools: `ping`, `curl`, `bash`, `timeout`
- Color-coded output for quick interpretation
- English-only, clean terminal-friendly format
- Supports result logging to file (via `tee`)

---

## 📜 How to Use

```bash
chmod +x cdn-ultimate-check.sh
./cdn-ultimate-check.sh | tee result-$(date +%F).log
```

---

## 🔧 Requirements

- bash (v4+)
- curl
- timeout (GNU coreutils)
- ping (if ICMP is not blocked)

---

## 🚀 Contribution

Feel free to fork, improve, and submit pull requests! If you know more CDNs or better IPs for testing, you are welcome to contribute.

---

## ⚠️ Disclaimer

This script is for diagnostic and educational use only. The availability of CDN endpoints can vary based on geolocation, DNS configuration, and network filtering policies.