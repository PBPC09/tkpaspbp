# LembarPena 📖

[![Develop](https://github.com/PBPC09/tkpaspbp/actions/workflows/develop.yml/badge.svg?branch=main)](https://github.com/PBPC09/tkpaspbp/actions/workflows/develop.yml)
[![Pre-Release](https://github.com/PBPC09/tkpaspbp/actions/workflows/pre-release.yml/badge.svg?branch=main)](https://github.com/PBPC09/tkpaspbp/actions/workflows/pre-release.yml)
[![Release](https://github.com/PBPC09/tkpaspbp/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/PBPC09/tkpaspbp/actions/workflows/release.yml)
[![Build status](https://build.appcenter.ms/v0.1/apps/272d2892-6343-403a-b952-c497ff4e2559/branches/main/badge)](https://appcenter.ms)

# Aplikasi

📱 File APK dapat diunduh di halaman [releases](https://github.com/PBPC09/tkpaspbp/releases) repositori atau melalui [Microsoft Visual Studio App Center](https://install.appcenter.ms/orgs/c09/apps/lembarpena/distribution_groups/public).
Untuk saat ini, *LembarPena* hanya tersedia di platform Android.  
🌐 Untuk versi web, kunjungi website kami di [LembarPena](https://lembarpena-c09-tk.pbp.cs.ui.ac.id/).

## Nama-nama anggota kelompok
Bryan Jeshua Mario Timung - 2206027021</br>
Clarista - 2206815541</br>
Muhammad Hilal Darul Fauzan - 2206830542</br>
Sabrina Aviana Dewi - 2206030520</br>
Rifqi Rahmatuloh - 2206820365</br>

## Nama Aplikasi
LembarPena  

## Deskripsi Aplikasi
LembarPena adalah tempat seluruh komunitas literasi berkumpul. Pembaca dapat membeli buku incaran mereka. Perusahaan memiliki banyak administrator yang akan membantu menjual buku. Penulis buku dapat mempromosikan karya mereka pada satu aplikasi ini melalui fitur forum diskusi. Terdapat juga fitur wishlist sehingga pembaca bisa menyimpan buku yang hendak dibeli. Aplikasi ini ditujukan kepada para peminat literasi yang selama ini harus mencari, membeli, menyimpan, dan mengulas buku pada platform yang berbeda-beda sehingga menimbulkan anggapan bahwa untuk menjadi penggiat literasi itu rumit dan ribet. Dengan efisiensi yang ditawarkan, aplikasi ini bermanfaat untuk meningkatkan minat literasi di kalangan masyarakat, meningkatkan daya beli buku, dan menyediakan tempat untuk pembaca serta penulis berinteraksi.


## Daftar modul yang akan diimplementasikan
### 📚 Modul Buy Book 📚 - Rifqi Rahmatuloh - 2206820365
Modul ini memungkinkan pengguna untuk memilih dan membeli buku dari katalog yang tersedia di aplikasi mobile. Fitur-fitur utama dari modul ini akan meliputi:
- Menampilkan daftar buku yang tersedia untuk dibeli. Pengguna bisa melakukan add to cart. Jendela cart akan menampilkan keranjang belanja dan bisa meminta input jumlah dan akan mengoperasikan total harga.
- Opsi untuk pengguna mencari buku berdasarkan rating buku.
- Saat pengguna mengklik buku tertentu, halaman detail buku akan menampilkan informasi yang lebih lengkap

### 🛒 Modul Checkout Book 🛒 - Sabrina Aviana Dewi - 2206030520
Modul ini untuk proses finalisasi pembelian buku yang telah dipilih oleh pengguna. Fitur-fitur utama dari modul ini akan meliputi:
- Menyimpan buku yang dipilih oleh pengguna sebelum melakukan pembayaran
- Memberi konfirmasi kepada pengguna untuk mengisi form, seperti alamat dan pilihan pembayaran
- Integrasikan dengan sistem pembayaran

### 🎁 Modul Wishlist 🎁 - Clarista - 2206815541
Modul ini memungkinkan pengguna untuk menyimpan daftar buku yang mereka inginkan tetapi belum siap dibeli. Fitur-fitur utama dari modul ini akan sebagai berikut:
- Melihat daftar buku yang ada dalam wishlist pengguna
- Menambah buku ke dalam wishlist dari jendela rekomendasi. Di jendela rekomendasi, saat pengguna mengklik buku tertentu, halaman detail buku akan menampilkan informasi yang lebih lengkap
- Menghapus buku dari wishlist
  
### 📝 Modul Book Forum 📝 - Bryan Jeshua Mario Timung - 2206027021
Modul ini memungkinkan pengguna untuk menulis dan berbagi opini, ulasan, serta dapat berdiskusi mengenai buku dengan pengguna lain. Fitur-fitur utama dari modul ini akan meliputi:
- Pengguna bisa memberikan pertanyaan dan tanggapan untuk buku tertentu
- Berdiskusi dengan pengguna lain mengenai buku tersebut
- Filter untuk hanya menampilkan diskusi terhadap buku dengan rating > 4.5

### 📥 Modul Register Book to Sell 📥 - Muhammad Hilal Darul Fauzan - 2206830542
Modul ini memungkinkan admin untuk mendaftarkan buku yang ingin dijual di aplikasi mobile. Fitur-fitur utama dari modul ini akan meliputi:
- Sebuah form yang harus diisi dengan informasi detail buku seperti judul, penulis, harga, dan lainnya
- Proses verifikasi oleh admin sebelum buku ditampilkan di katalog untuk dijual

---


## Role atau peran pengguna beserta deskripsinya
1. Admin </br>
Admin merupakan profil untuk mengatur pengelolaan penjualan buku lewat perusahaan lembarpena.

2. Buyer </br>
Buyer atau pembeli ini dapat membeli buku yang dicari dan diinginkan dari para penjual buku. Nantinya buyer ini juga bisa berdiskusi di forum dengan buyer yang lain.

---

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
- Mengimplementasikan sistem autentikasi pada Flutter yang berasal dari Django menggunakan _package_.
- Setiap modul pada tugas sebelumnya akan di implementasikan API yang dapat mengembalikan response dalam bentuk JSON.
- Menggunakan method GET akan menampilkan data dan mengirim input dengan method POST untuk update data baru, serta diintegrasi dengan konsep async HTTP.
- Mengimplementasikan desain front-end untuk aplikasi berdasarkan desain website yang sudah ada sebelumnya.
- Melakukan integrasi antara front-end dengan back-end dengan menggunakan konsep asynchronous HTTP.

## Tautan berita acara
https://docs.google.com/spreadsheets/d/1aLd6a_5FYw1JCtUQhUpf20rKJz-rOGFrzNmi5X7d4zQ/edit?usp=sharing