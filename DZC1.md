ДЗ Курсовая

###### **1. Задание**

Установка и настройка UFW

```
vagrant@vagrant:~$ sudo ufw status
Status: inactive
vagrant@vagrant:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
vagrant@vagrant:~$

vagrant@vagrant:~$ sudo ufw allow 22
Rule added
Rule added (v6)
vagrant@vagrant:~$ sudo ufw allow 443
Rule added
Rule added (v6)
vagrant@vagrant:~$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere
443                        ALLOW       Anywhere
Anywhere on lo             ALLOW       Anywhere
22 (v6)                    ALLOW       Anywhere (v6)
443 (v6)                   ALLOW       Anywhere (v6)
Anywhere (v6) on lo        ALLOW       Anywhere (v6)


```



###### **2. Задание**

Процесс установки и выпуска сертификата с помощью hashicorp vault

```
vagrant@vagrant:~$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
OK
vagrant@vagrant:~$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease
Get:3 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:4 https://apt.releases.hashicorp.com focal InRelease [9,495 B]
Get:5 http://security.ubuntu.com/ubuntu focal-security/main i386 Packages [345 kB]
Get:6 https://apt.releases.hashicorp.com focal/main amd64 Packages [41.1 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1,400 kB]
Get:9 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [1,069 kB]
Get:10 http://security.ubuntu.com/ubuntu focal-security/main Translation-en [197 kB]
Get:11 http://security.ubuntu.com/ubuntu focal-security/restricted i386 Packages [20.5 kB]
Get:12 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [566 kB]
Get:13 http://security.ubuntu.com/ubuntu focal-security/restricted Translation-en [80.9 kB]
Get:14 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [668 kB]
Get:15 http://security.ubuntu.com/ubuntu focal-security/universe i386 Packages [525 kB]
Get:16 http://security.ubuntu.com/ubuntu focal-security/universe Translation-en [112 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal-updates/main i386 Packages [574 kB]
Get:18 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [21.9 kB]
Get:19 http://security.ubuntu.com/ubuntu focal-security/multiverse i386 Packages [7,212 B]
Get:20 http://security.ubuntu.com/ubuntu focal-security/multiverse Translation-en [4,948 B]
Get:21 http://archive.ubuntu.com/ubuntu focal-updates/main Translation-en [283 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [616 kB]
Get:23 http://archive.ubuntu.com/ubuntu focal-updates/restricted i386 Packages [21.8 kB]
Get:24 http://archive.ubuntu.com/ubuntu focal-updates/restricted Translation-en [88.1 kB]
Get:25 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [884 kB]
Get:26 http://archive.ubuntu.com/ubuntu focal-updates/universe i386 Packages [654 kB]
Get:27 http://archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [193 kB]
Get:28 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [24.8 kB]
Get:29 http://archive.ubuntu.com/ubuntu focal-updates/multiverse i386 Packages [8,456 B]
Get:30 http://archive.ubuntu.com/ubuntu focal-updates/multiverse Translation-en [6,928 B]
Get:31 http://archive.ubuntu.com/ubuntu focal-backports/main i386 Packages [34.5 kB]
Get:32 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [42.0 kB]
Get:33 http://archive.ubuntu.com/ubuntu focal-backports/main Translation-en [10.0 kB]
Get:34 http://archive.ubuntu.com/ubuntu focal-backports/universe i386 Packages [10.5 kB]
Get:35 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [18.9 kB]
Get:36 http://archive.ubuntu.com/ubuntu focal-backports/universe Translation-en [7,492 B]
Fetched 8,881 kB in 8s (1,045 kB/s)
Reading package lists... Done
vagrant@vagrant:~$ sudo apt-get update && sudo apt-get install vault
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:3 http://security.ubuntu.com/ubuntu focal-security InRelease
Hit:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Hit:5 https://apt.releases.hashicorp.com focal InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  vault
0 upgraded, 1 newly installed, 0 to remove and 108 not upgraded.
Need to get 69.4 MB of archives.
After this operation, 188 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com focal/main amd64 vault amd64 1.9.2 [69.4 MB]
Fetched 69.4 MB in 1min 50s (630 kB/s)
Selecting previously unselected package vault.
(Reading database ... 41552 files and directories currently installed.)
Preparing to unpack .../archives/vault_1.9.2_amd64.deb ...
Unpacking vault (1.9.2) ...
Setting up vault (1.9.2) ...
Generating Vault TLS key and self-signed certificate...
Generating a RSA private key
...............................................................................................................................................................................++++
..........................................................++++
writing new private key to 'tls.key'
-----
Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.
vagrant@vagrant:~$


vagrant@vagrant:~$ export VAULT_ADDR=http://127.0.0.1:8200
vagrant@vagrant:~$ export VAULT_TOKEN=root
vagrant@vagrant:~$ vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/
vagrant@vagrant:~$ vault secrets tune -max-lease-ttl=87600h pki
Success! Tuned the secrets engine at: pki/
vagrant@vagrant:~$ vault write -field=certificate pki/root/generate/internal \
>      common_name="example.com" \
>      ttl=87600h > CA_cert.crt
vagrant@vagrant:~$ vault write pki/config/urls \
>      issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
>      crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
vagrant@vagrant:~$ vault secrets enable -path=pki_int pki
Success! Enabled the pki secrets engine at: pki_int/
vagrant@vagrant:~$ vault secrets tune -max-lease-ttl=43800h pki_int
Success! Tuned the secrets engine at: pki_int/
vagrant@vagrant:~$ vault write -format=json pki_int/intermediate/generate/internal \
>      common_name="example.com Intermediate Authority" \
>      | jq -r '.data.csr' > pki_intermediate.csr
vagrant@vagrant:~$ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
>      format=pem_bundle ttl="43800h" \
>      | jq -r '.data.certificate' > intermediate.cert.pem
vagrant@vagrant:~$ vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
Success! Data written to: pki_int/intermediate/set-signed
vagrant@vagrant:~$
vagrant@vagrant:~$ vault write pki_int/roles/example-dot-com \
>      allowed_domains="example.com" \
>      allow_subdomains=true \
>      max_ttl="720h"
Success! Data written to: pki_int/roles/example-dot-com

vagrant@vagrant:~$ vault write pki_int/issue/example-dot-com common_name="test.example.com" ttl="24h"
Key                 Value
---                 -----
ca_chain            [-----BEGIN CERTIFICATE-----
MIIDpjCCAo6gAwIBAgIUeZh08uvhpFK9ntRv6CetzD7AqygwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjExMjI1MTYxMDMyWhcNMjYx
MjI0MTYxMTAyWjAtMSswKQYDVQQDEyJleGFtcGxlLmNvbSBJbnRlcm1lZGlhdGUg
QXV0aG9yaXR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtdKKmbmr
qLcbeRIOr9Cpk1iz38zAEfUnYeY1vdeiUZyo2SWGcVs0B6jhDBAarlqqe1udFXrt
Ck7GXFp6KpVxb5Y7QoTACq/3NyAsDqw5uNqWWM1IHBa3N7oATVFiTlNBSemy7Oga
2mGLcYlgzzG/8hffCDciiCIAEP+AyKG4SCvqNPWSDAe5fjOq7ybxODQZqsBgN45n
uUGK9nr3QkyQS8R7ErJ6+6wHwOXIFvF7PG1XbpBW4XJ7OdNK/GeHjR5mpFqJIXXP
NpIWcPHIxxBzZpI3VB+BGpDVDU72rHKpU/37LlcMzW1cYTA2bJyRHDYFhBh6BA2x
dgu+mywVETlqvQIDAQABo4HUMIHRMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSJhmsb+GIK+Oqb5MspsgHgtFMB4jAfBgNVHSMEGDAW
gBTjvZTOEim65ngXiu2O/G3R6ZHkHDA7BggrBgEFBQcBAQQvMC0wKwYIKwYBBQUH
MAKGH2h0dHA6Ly8xMjcuMC4wLjE6ODIwMC92MS9wa2kvY2EwMQYDVR0fBCowKDAm
oCSgIoYgaHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jcmwwDQYJKoZIhvcN
AQELBQADggEBAIL4JhNBJRvsN4NDMDz+VxSCC7C+eFEySyJyr4NUjL4Aq20aFPI0
lwYswiu4+ezkb+X83NnScafoEXp1yUVlV39cdfb+rIDBF2kfR8xm0WSNoWsnnx6D
LWItHTF1VtfIEHY5BKRZoBrGydDSIPYZrikwAw5NLpBFpkpThYYgJi29vvBDmLNC
A2KpEc2Y3hvvYKWj1DjXbVvyDPj1wAFl5J3CRfgX3+6e7tNO8xy0d4PDrjnqTW4U
m3X2Hwpg2PwszG23dxzfzS0ewRtefRyeB1ZeFJV0jYy67pnAgPYm7gYXnW0/xSo/
WuRmtCzn3Ehq0vQnmetPNA/wh96m9zBcoL0=
-----END CERTIFICATE-----]
certificate         -----BEGIN CERTIFICATE-----
MIIDZjCCAk6gAwIBAgIUTURMSfBG1FKoABw3GKAnJdFJ2RgwDQYJKoZIhvcNAQEL
BQAwLTErMCkGA1UEAxMiZXhhbXBsZS5jb20gSW50ZXJtZWRpYXRlIEF1dGhvcml0
eTAeFw0yMTEyMjUxNjEzMjBaFw0yMTEyMjYxNjEzNTBaMBsxGTAXBgNVBAMTEHRl
c3QuZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCw
4XIJ6T1OFFd5POkBkVp5BlOyBeBLFu2YwPKucBIhn46ygob8eD7nyYs7Akob3STA
wZIzhWXtswrx+DdEytmuVs/M/i4GAh8MRk32SpXRHOV1y98VlTMbobg8TvJ49+AL
bE9EnlIfh26j6QFTTdMDODaufvPSAAKAEkqZ0JoHmDJhk9zHiJ14TdjwXzO/SBbD
UXUflIGqXhlqgXSUpVpcV07R878AxPqwpsu8K8oRcp37gSoRB3feaiQucwgNJWw1
3Fra0T/qqeE8ew89k8VBd0lA1EIkHiRanDqA7H4SaHl1QLk5wHeg7p9bRS7lbOP/
K6w+742uixm90Xri5n/9AgMBAAGjgY8wgYwwDgYDVR0PAQH/BAQDAgOoMB0GA1Ud
JQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAdBgNVHQ4EFgQUyXEck09G296zA3ae
kFkaPvnZh0QwHwYDVR0jBBgwFoAUiYZrG/hiCvjqm+TLKbIB4LRTAeIwGwYDVR0R
BBQwEoIQdGVzdC5leGFtcGxlLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAHiVJJe5r
yblbEqAklAwpIFwJBIVR8Y5i5Xo7AZMmTwHzLAJxasiB2C17Xk4/xKiBbgT9z57p
NN3m+cW+A6oVqdpK+3uOXsb82Ia8DPWe4GyAW5QKkGR3jpqRZwfihgRD/MT9vwRJ
6YTuoFprJ82AerqgigmjktfOtn5kAfJ2ZHfMFpgpIWfO93O9XunMZVohvMcDkVRz
Cnk2ohb4u3eMZFWU+SddUoOJJwr16BLxhClwnYGHObq1m1LXMgGNUENHZNqekxl6
Z9qkL24N8LljmElVQ0xYY7DxD4PJ+S0fqpyc5xZfxImR6u8zKLkSK2vQlml9fY0N
NwXr04R50RZIHg==
-----END CERTIFICATE-----
expiration          1640535230
issuing_ca          -----BEGIN CERTIFICATE-----
MIIDpjCCAo6gAwIBAgIUeZh08uvhpFK9ntRv6CetzD7AqygwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjExMjI1MTYxMDMyWhcNMjYx
MjI0MTYxMTAyWjAtMSswKQYDVQQDEyJleGFtcGxlLmNvbSBJbnRlcm1lZGlhdGUg
QXV0aG9yaXR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtdKKmbmr
qLcbeRIOr9Cpk1iz38zAEfUnYeY1vdeiUZyo2SWGcVs0B6jhDBAarlqqe1udFXrt
Ck7GXFp6KpVxb5Y7QoTACq/3NyAsDqw5uNqWWM1IHBa3N7oATVFiTlNBSemy7Oga
2mGLcYlgzzG/8hffCDciiCIAEP+AyKG4SCvqNPWSDAe5fjOq7ybxODQZqsBgN45n
uUGK9nr3QkyQS8R7ErJ6+6wHwOXIFvF7PG1XbpBW4XJ7OdNK/GeHjR5mpFqJIXXP
NpIWcPHIxxBzZpI3VB+BGpDVDU72rHKpU/37LlcMzW1cYTA2bJyRHDYFhBh6BA2x
dgu+mywVETlqvQIDAQABo4HUMIHRMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSJhmsb+GIK+Oqb5MspsgHgtFMB4jAfBgNVHSMEGDAW
gBTjvZTOEim65ngXiu2O/G3R6ZHkHDA7BggrBgEFBQcBAQQvMC0wKwYIKwYBBQUH
MAKGH2h0dHA6Ly8xMjcuMC4wLjE6ODIwMC92MS9wa2kvY2EwMQYDVR0fBCowKDAm
oCSgIoYgaHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jcmwwDQYJKoZIhvcN
AQELBQADggEBAIL4JhNBJRvsN4NDMDz+VxSCC7C+eFEySyJyr4NUjL4Aq20aFPI0
lwYswiu4+ezkb+X83NnScafoEXp1yUVlV39cdfb+rIDBF2kfR8xm0WSNoWsnnx6D
LWItHTF1VtfIEHY5BKRZoBrGydDSIPYZrikwAw5NLpBFpkpThYYgJi29vvBDmLNC
A2KpEc2Y3hvvYKWj1DjXbVvyDPj1wAFl5J3CRfgX3+6e7tNO8xy0d4PDrjnqTW4U
m3X2Hwpg2PwszG23dxzfzS0ewRtefRyeB1ZeFJV0jYy67pnAgPYm7gYXnW0/xSo/
WuRmtCzn3Ehq0vQnmetPNA/wh96m9zBcoL0=
-----END CERTIFICATE-----
private_key         -----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAsOFyCek9ThRXeTzpAZFaeQZTsgXgSxbtmMDyrnASIZ+OsoKG
/Hg+58mLOwJKG90kwMGSM4Vl7bMK8fg3RMrZrlbPzP4uBgIfDEZN9kqV0Rzldcvf
FZUzG6G4PE7yePfgC2xPRJ5SH4duo+kBU03TAzg2rn7z0gACgBJKmdCaB5gyYZPc
x4ideE3Y8F8zv0gWw1F1H5SBql4ZaoF0lKVaXFdO0fO/AMT6sKbLvCvKEXKd+4Eq
EQd33mokLnMIDSVsNdxa2tE/6qnhPHsPPZPFQXdJQNRCJB4kWpw6gOx+Emh5dUC5
OcB3oO6fW0Uu5Wzj/yusPu+NrosZvdF64uZ//QIDAQABAoIBAAEhf9wmXJj6MlD5
Hbg/2Kc7bh+OQA/a1qwKV8LbvpHudjgX84r7rdNHi5dV/WlOMaT119xyduNdKK3B
W4EaFugxb+Ssn1i0fMRUUr1HXsvWdnUZV5TIvmnnz8i67HvvgcQw7hTPOlEvSXrM
y5BfyACWRGs7Lo3iKCHvfACdv85anQZsEL4lkkkMMhj07QzI4DKHXltuNkSELACy
JGN5o516nK1JaOjeryLbWHGkg15nGWMYuuKCw5PXTPWjWzbZnwFdv1JqDzz2swVq
ecJJcBNCB+VO+NiK6U9+f1R8ZlqsVVKXDhAir9j79g2oXblVr28V/yL8eDVHCM+k
pNvRa0ECgYEAyoIDa17F1x434tYYpP9vDRABDi8H/Rk27zoPRwoJfJx4e8jwM//T
uy71z3CRh1ruF5RFBHC9W1lGqfblgZO2uoCvrg64GaikF/kDxog+Q+Wv/Bely70q
nA8TSZf6m6nAFMfSqdxbpfRuIZWI2+EQJ4LazrqGdK19foO3nKNvI9ECgYEA35p3
5zLNgiexD6uslkIIGB3jt7YogHTHiPjCKhwBO8Sek44neIDilLaNXXK7Pxk11lJj
3zdqcHcpGRvdp1dRdJ4bwhUuvv0FLzn/bOaz/FnhesblDP/YIMq8XuVxrTWGysH4
9s8wSQP9G6NDunSIQdGW/ejaAo1uFjsLglGgQG0CgYBLzaciBfPgtnsM+j93Y/ZZ
2WfLu2cuIsYhfoZBfUxXzOp8y5a+oEDNjKKO6ABRvoPpZ6L+KoV3ME/3R2hZvMVl
ws4ARZo8YJgsMRZstos4Nz5NCz0QqtrMWAhMQAubQUuZe8MrukTENl8TSzpTtEer
wpvNTp0OB/M17HBKvhLYQQKBgAjZsllCV4QJUibOorwnzO43cKX63cuH08YGIplM
FnhpJeWtQL6yS0WbnCjQu7yZoNnk1PMm3F2rOcM2qSVQfXbiMzMRZ5JDrYra/tMu
pn0ciaI0cSh8j+9sVtxitIcokTdBSjtqo/yf3crUQYAF0MbaJuHR758ePfc/SwtT
c8ZZAoGAFQ3zlM6eY1v/wGG3DZLHqoemaXAuv7Wl/8i0eUIzqI52irA0grdyx+dD
7p1DMv4sTPFKPVy4NI0dM8ouV3vUqQkHb+WMa3ckD3abFs19byxBQZRAY997zUu3
NScAcR1LFbKXDHYKG5f/drJRuxjMxL9tRrWQMc4728GAd0MB/VM=
-----END RSA PRIVATE KEY-----
private_key_type    rsa
serial_number       4d:44:4c:49:f0:46:d4:52:a8:00:1c:37:18:a0:27:25:d1:49:d9:18
vagrant@vagrant:~$

```


###### **3.Задание**

Процесс установки и настройки сервера nginx

```
vagrant@vagrant:~$ sudo apt-add-repository ppa:nginx/stable
 This PPA contains the latest Stable Release version of the nginx web server software.

**Only Non-End-of-Life Ubuntu Releases are supported in this PPA**

**Development releases of Ubuntu are not officially supported by this PPA, and uploads for those will not be available until actual final releases for those versions**
 More info: https://launchpad.net/~nginx/+archive/ubuntu/stable
Press [ENTER] to continue or Ctrl-c to cancel adding it.

Get:1 http://ppa.launchpad.net/nginx/stable/ubuntu focal InRelease [17.5 kB]
Hit:2 https://apt.releases.hashicorp.com focal InRelease
Hit:3 http://security.ubuntu.com/ubuntu focal-security InRelease
Get:4 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 Packages [4,944 B]
Hit:5 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:6 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Get:7 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main i386 Packages [1,224 B]
Hit:8 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Get:9 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main Translation-en [4,572 B]
Fetched 28.3 kB in 1s (27.2 kB/s)
Reading package lists... Done
vagrant@vagrant:~$ sudo apt update
Hit:1 http://ppa.launchpad.net/nginx/stable/ubuntu focal InRelease
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:3 https://apt.releases.hashicorp.com focal InRelease
Hit:4 http://security.ubuntu.com/ubuntu focal-security InRelease
Hit:5 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Reading package lists... Done
Building dependency tree
Reading state information... Done
108 packages can be upgraded. Run 'apt list --upgradable' to see them.
vagrant@vagrant:~$ sudo apt install nginx
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core geoip-database libfontconfig1 libgd3 libgeoip1 libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-image-filter
  libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream libnginx-mod-stream-geoip libtiff5 libwebp6 libx11-6 libx11-data libxcb1 libxpm4
  nginx-common nginx-core
Suggested packages:
  libgd-tools geoip-bin fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core geoip-database libfontconfig1 libgd3 libgeoip1 libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-image-filter
  libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream libnginx-mod-stream-geoip libtiff5 libwebp6 libx11-6 libx11-data libxcb1 libxpm4 nginx
  nginx-common nginx-core
0 upgraded, 23 newly installed, 0 to remove and 108 not upgraded.
Need to get 6,522 kB of archives.
After this operation, 21.7 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libxcb1 amd64 1.14-2 [44.7 kB]
Get:2 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 nginx-common all 1.18.0-3ubuntu1+focal2 [68.6 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libx11-data all 2:1.6.9-2ubuntu1.2 [113 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libx11-6 amd64 2:1.6.9-2ubuntu1.2 [575 kB]
Get:5 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 libnginx-mod-http-xslt-filter amd64 1.18.0-3ubuntu1+focal2 [43.0 kB]
Get:6 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 libnginx-mod-mail amd64 1.18.0-3ubuntu1+focal2 [72.9 kB]
Get:7 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 libnginx-mod-stream amd64 1.18.0-3ubuntu1+focal2 [97.5 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal/main amd64 fonts-dejavu-core all 2.37-1 [1,041 kB]
Get:9 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 libnginx-mod-stream-geoip amd64 1.18.0-3ubuntu1+focal2 [40.4 kB]
Get:10 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 nginx-core amd64 1.18.0-3ubuntu1+focal2 [457 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal/main amd64 fontconfig-config all 2.13.1-2ubuntu3 [28.8 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal/universe amd64 geoip-database all 20191224-2 [3,029 kB]
Get:13 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 libnginx-mod-http-image-filter amd64 1.18.0-3ubuntu1+focal2 [44.8 kB]
Get:14 http://ppa.launchpad.net/nginx/stable/ubuntu focal/main amd64 nginx all 1.18.0-3ubuntu1+focal2 [35.6 kB]
Get:15 http://archive.ubuntu.com/ubuntu focal/main amd64 libfontconfig1 amd64 2.13.1-2ubuntu3 [114 kB]
Get:16 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libjpeg-turbo8 amd64 2.0.3-0ubuntu1.20.04.1 [117 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal/main amd64 libjpeg8 amd64 8c-2ubuntu8 [2,194 B]
Get:18 http://archive.ubuntu.com/ubuntu focal/main amd64 libjbig0 amd64 2.1-3.1build1 [26.7 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libwebp6 amd64 0.6.1-2ubuntu0.20.04.1 [185 kB]
Get:20 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libtiff5 amd64 4.1.0+git191117-2ubuntu0.20.04.2 [162 kB]
Get:21 http://archive.ubuntu.com/ubuntu focal/main amd64 libxpm4 amd64 1:3.5.12-1 [34.0 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libgd3 amd64 2.2.5-5.2ubuntu2.1 [118 kB]
Get:23 http://archive.ubuntu.com/ubuntu focal/universe amd64 libgeoip1 amd64 1.6.12-6build1 [70.5 kB]
Fetched 6,522 kB in 6s (1,031 kB/s)
Preconfiguring packages ...
Selecting previously unselected package libxcb1:amd64.
(Reading database ... 41575 files and directories currently installed.)
Preparing to unpack .../00-libxcb1_1.14-2_amd64.deb ...
Unpacking libxcb1:amd64 (1.14-2) ...
Selecting previously unselected package libx11-data.
Preparing to unpack .../01-libx11-data_2%3a1.6.9-2ubuntu1.2_all.deb ...
Unpacking libx11-data (2:1.6.9-2ubuntu1.2) ...
Selecting previously unselected package libx11-6:amd64.
Preparing to unpack .../02-libx11-6_2%3a1.6.9-2ubuntu1.2_amd64.deb ...
Unpacking libx11-6:amd64 (2:1.6.9-2ubuntu1.2) ...
Selecting previously unselected package fonts-dejavu-core.
Preparing to unpack .../03-fonts-dejavu-core_2.37-1_all.deb ...
Unpacking fonts-dejavu-core (2.37-1) ...
Selecting previously unselected package fontconfig-config.
Preparing to unpack .../04-fontconfig-config_2.13.1-2ubuntu3_all.deb ...
Unpacking fontconfig-config (2.13.1-2ubuntu3) ...
Selecting previously unselected package geoip-database.
Preparing to unpack .../05-geoip-database_20191224-2_all.deb ...
Unpacking geoip-database (20191224-2) ...
Selecting previously unselected package libfontconfig1:amd64.
Preparing to unpack .../06-libfontconfig1_2.13.1-2ubuntu3_amd64.deb ...
Unpacking libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Selecting previously unselected package libjpeg-turbo8:amd64.
Preparing to unpack .../07-libjpeg-turbo8_2.0.3-0ubuntu1.20.04.1_amd64.deb ...
Unpacking libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Selecting previously unselected package libjpeg8:amd64.
Preparing to unpack .../08-libjpeg8_8c-2ubuntu8_amd64.deb ...
Unpacking libjpeg8:amd64 (8c-2ubuntu8) ...
Selecting previously unselected package libjbig0:amd64.
Preparing to unpack .../09-libjbig0_2.1-3.1build1_amd64.deb ...
Unpacking libjbig0:amd64 (2.1-3.1build1) ...
Selecting previously unselected package libwebp6:amd64.
Preparing to unpack .../10-libwebp6_0.6.1-2ubuntu0.20.04.1_amd64.deb ...
Unpacking libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Selecting previously unselected package libtiff5:amd64.
Preparing to unpack .../11-libtiff5_4.1.0+git191117-2ubuntu0.20.04.2_amd64.deb ...
Unpacking libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Selecting previously unselected package libxpm4:amd64.
Preparing to unpack .../12-libxpm4_1%3a3.5.12-1_amd64.deb ...
Unpacking libxpm4:amd64 (1:3.5.12-1) ...
Selecting previously unselected package libgd3:amd64.
Preparing to unpack .../13-libgd3_2.2.5-5.2ubuntu2.1_amd64.deb ...
Unpacking libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Selecting previously unselected package libgeoip1:amd64.
Preparing to unpack .../14-libgeoip1_1.6.12-6build1_amd64.deb ...
Unpacking libgeoip1:amd64 (1.6.12-6build1) ...
Selecting previously unselected package nginx-common.
Preparing to unpack .../15-nginx-common_1.18.0-3ubuntu1+focal2_all.deb ...
Unpacking nginx-common (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package libnginx-mod-http-xslt-filter.
Preparing to unpack .../16-libnginx-mod-http-xslt-filter_1.18.0-3ubuntu1+focal2_amd64.deb ...
Unpacking libnginx-mod-http-xslt-filter (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package libnginx-mod-mail.
Preparing to unpack .../17-libnginx-mod-mail_1.18.0-3ubuntu1+focal2_amd64.deb ...
Unpacking libnginx-mod-mail (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package libnginx-mod-stream.
Preparing to unpack .../18-libnginx-mod-stream_1.18.0-3ubuntu1+focal2_amd64.deb ...
Unpacking libnginx-mod-stream (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package libnginx-mod-stream-geoip.
Preparing to unpack .../19-libnginx-mod-stream-geoip_1.18.0-3ubuntu1+focal2_amd64.deb ...
Unpacking libnginx-mod-stream-geoip (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package nginx-core.
Preparing to unpack .../20-nginx-core_1.18.0-3ubuntu1+focal2_amd64.deb ...
Unpacking nginx-core (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package libnginx-mod-http-image-filter.
Preparing to unpack .../21-libnginx-mod-http-image-filter_1.18.0-3ubuntu1+focal2_amd64.deb ...
Unpacking libnginx-mod-http-image-filter (1.18.0-3ubuntu1+focal2) ...
Selecting previously unselected package nginx.
Preparing to unpack .../22-nginx_1.18.0-3ubuntu1+focal2_all.deb ...
Unpacking nginx (1.18.0-3ubuntu1+focal2) ...
Setting up libxcb1:amd64 (1.14-2) ...
Setting up nginx-common (1.18.0-3ubuntu1+focal2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service в†’ /lib/systemd/system/nginx.service.
Setting up libjbig0:amd64 (2.1-3.1build1) ...
Setting up libx11-data (2:1.6.9-2ubuntu1.2) ...
Setting up libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Setting up fonts-dejavu-core (2.37-1) ...
Setting up libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Setting up libgeoip1:amd64 (1.6.12-6build1) ...
Setting up libx11-6:amd64 (2:1.6.9-2ubuntu1.2) ...
Setting up geoip-database (20191224-2) ...
Setting up libjpeg8:amd64 (8c-2ubuntu8) ...
Setting up libxpm4:amd64 (1:3.5.12-1) ...
Setting up fontconfig-config (2.13.1-2ubuntu3) ...
Setting up libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Setting up libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Setting up libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Setting up libnginx-mod-stream (1.18.0-3ubuntu1+focal2) ...
Setting up nginx-core (1.18.0-3ubuntu1+focal2) ...
 * Upgrading binary nginx                                                                                                                               [ OK ]
Setting up libnginx-mod-mail (1.18.0-3ubuntu1+focal2) ...
Setting up nginx (1.18.0-3ubuntu1+focal2) ...
Setting up libnginx-mod-http-image-filter (1.18.0-3ubuntu1+focal2) ...
Setting up libnginx-mod-stream-geoip (1.18.0-3ubuntu1+focal2) ...
Setting up libnginx-mod-http-xslt-filter (1.18.0-3ubuntu1+focal2) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Processing triggers for ufw (0.36-6) ...
Processing triggers for systemd (245.4-4ubuntu3.11) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for nginx-core (1.18.0-3ubuntu1+focal2) ...
Triggering nginx reload ...
vagrant@vagrant:~$



vagrant@vagrant:~$ cat /etc/nginx/nginx.conf
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##

        gzip on;

        # gzip_vary on;
        # gzip_proxied any;
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        # gzip_http_version 1.1;
        # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

        ##
        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;

server {
    listen              443 ssl;
    server_name         test.example.com;
    ssl_certificate     /home/vagrant/test.example.com.crt.pem;
    ssl_certificate_key /home/vagrant/test.example.com.crt.key;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;

}


}

vagrant@vagrant:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
vagrant@vagrant:~$ sudo service nginx reload
vagrant@vagrant:~$ sudo service nginx restart




```

###### **4.Задание**
Страница сервера nginx в браузере хоста не содержит предупреждений

Корневой сертивикат установлен в системе как доверенный 
![](DZC1.jpg)

Работа ssl в двух браузерах 

![](DZC2.jpg)
![](DZC3.jpg)


###### **5.Задание**
Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")

``` bash
vagrant@vagrant:~$ cat recreatekey
#!/usr/bin/env bash

vault write -format=json pki_int/issue/example-dot-com common_name="test.example.com" ttl="720h" > /home/vagrant/test.example.com
cat /home/vagrant/test.example.com | jq -r .data.certificate > /home/vagrant/test.example.com.crt.pem
cat /home/vagrant/test.example.com | jq -r .data.issuing_ca >> /home/vagrant/test.example.com.crt.pem
cat /home/vagrant/test.example.com | jq -r .data.private_key > /home/vagrant/test.example.com.crt.key


sudo service nginx reload
sudo service nginx restart

```


###### **6.Задание**
Crontab работает (выберите число и время так, чтобы показать что crontab запускается и делает что надо)

```

vagrant@vagrant:~$ crontab -l
13 23 25 * * cd /home/vagrant && /home/vagrant/recreatekey
vagrant@vagrant:~$

Вывод каталога до выполнения скрипа по крону
 
vagrant@vagrant:~$ ls -lha
total 88K
drwxr-xr-x 6 vagrant vagrant 4.0K Dec 25 22:37 .
drwxr-xr-x 3 root    root    4.0K Jul 28 20:50 ..
-rw-r--r-- 1 vagrant vagrant  220 Jul 28 20:50 .bash_logout
-rw-r--r-- 1 vagrant vagrant 3.7K Jul 28 20:50 .bashrc
-rw-rw-r-- 1 vagrant vagrant 1.2K Dec 25 19:07 CA_cert.crt
drwx------ 4 vagrant vagrant 4.0K Dec 25 19:32 .cache
drwx------ 3 vagrant vagrant 4.0K Dec 25 19:32 .config
-rw-rw-r-- 1 vagrant vagrant 1.3K Dec 25 19:11 intermediate.cert.pem
drwx------ 3 vagrant vagrant 4.0K Dec 25 19:32 .local
-rw-rw-r-- 1 vagrant vagrant  924 Dec 25 19:10 pki_intermediate.csr
-rw-r--r-- 1 vagrant vagrant  807 Jul 28 20:50 .profile
-rwxr-xr-x 1 vagrant vagrant  513 Dec 25 22:37 recreatekey
-rw-rw-r-- 1 vagrant vagrant   74 Dec 25 22:31 .selected_editor
drwx------ 2 vagrant root    4.0K Dec 25 18:35 .ssh
-rw-r--r-- 1 vagrant vagrant    0 Jul 28 20:51 .sudo_as_admin_successful
-rw-rw-r-- 1 vagrant vagrant 6.0K Dec 25 23:06 test.example.com
-rw-rw-r-- 1 vagrant vagrant 1.7K Dec 25 23:06 test.example.com.crt.key
-rw-rw-r-- 1 vagrant vagrant 2.6K Dec 25 23:06 test.example.com.crt.pem
-rw------- 1 vagrant vagrant    4 Dec 25 18:58 .vault-token
-rw-r--r-- 1 vagrant vagrant    6 Jul 28 20:51 .vbox_version
-rw------- 1 vagrant vagrant  812 Dec 25 22:37 .viminfo
-rw-r--r-- 1 root    root     180 Jul 28 20:55 .wget-hsts


Вывод каталога после выполнения скрипа по крону 

vagrant@vagrant:~$ ls -lha
total 72K
drwxr-xr-x 6 vagrant vagrant 4.0K Dec 25 22:37 .
drwxr-xr-x 3 root    root    4.0K Jul 28 20:50 ..
-rw-r--r-- 1 vagrant vagrant  220 Jul 28 20:50 .bash_logout
-rw-r--r-- 1 vagrant vagrant 3.7K Jul 28 20:50 .bashrc
-rw-rw-r-- 1 vagrant vagrant 1.2K Dec 25 19:07 CA_cert.crt
drwx------ 4 vagrant vagrant 4.0K Dec 25 19:32 .cache
drwx------ 3 vagrant vagrant 4.0K Dec 25 19:32 .config
-rw-rw-r-- 1 vagrant vagrant 1.3K Dec 25 19:11 intermediate.cert.pem
drwx------ 3 vagrant vagrant 4.0K Dec 25 19:32 .local
-rw-rw-r-- 1 vagrant vagrant  924 Dec 25 19:10 pki_intermediate.csr
-rw-r--r-- 1 vagrant vagrant  807 Jul 28 20:50 .profile
-rwxr-xr-x 1 vagrant vagrant  513 Dec 25 22:37 recreatekey
-rw-rw-r-- 1 vagrant vagrant   74 Dec 25 22:31 .selected_editor
drwx------ 2 vagrant root    4.0K Dec 25 18:35 .ssh
-rw-r--r-- 1 vagrant vagrant    0 Jul 28 20:51 .sudo_as_admin_successful
-rw-rw-r-- 1 vagrant vagrant    0 Dec 25 23:13 test.example.com
-rw-rw-r-- 1 vagrant vagrant    0 Dec 25 23:13 test.example.com.crt.key
-rw-rw-r-- 1 vagrant vagrant    0 Dec 25 23:13 test.example.com.crt.pem
-rw------- 1 vagrant vagrant    4 Dec 25 18:58 .vault-token
-rw-r--r-- 1 vagrant vagrant    6 Jul 28 20:51 .vbox_version
-rw------- 1 vagrant vagrant  812 Dec 25 22:37 .viminfo
-rw-r--r-- 1 root    root     180 Jul 28 20:55 .wget-hsts

```