// Kelas Abstrak Transportasi
abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi({required this.id, required this.nama, required double tarifDasar, required this.kapasitas})
      : _tarifDasar = tarifDasar;

  double hitungTarif(int jumlahPenumpang);

  void tampilInfo() {
    print("ID: $id");
    print("Nama: $nama");
    print("Tarif Dasar: $_tarifDasar");
    print("Kapasitas: $kapasitas");
  }

  double get tarifDasar => _tarifDasar;
}

// Kelas Turunan Taksi
class Taksi extends Transportasi {
  double jarak;

  Taksi({required String id, required String nama, required double tarifDasar, required int kapasitas, required this.jarak})
      : super(id: id, nama: nama, tarifDasar: tarifDasar, kapasitas: kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jarak;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Jarak: $jarak km");
  }
}

// Kelas Turunan Bus
class Bus extends Transportasi {
  bool adaWifi;

  Bus({required String id, required String nama, required double tarifDasar, required int kapasitas, required this.adaWifi})
      : super(id: id, nama: nama, tarifDasar: tarifDasar, kapasitas: kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Ada Wifi: ${adaWifi ? 'Ya' : 'Tidak'}");
  }
}

// Kelas Turunan Pesawat
class Pesawat extends Transportasi {
  String kelas;

  Pesawat({required String id, required String nama, required double tarifDasar, required int kapasitas, required this.kelas})
      : super(id: id, nama: nama, tarifDasar: tarifDasar, kapasitas: kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jumlahPenumpang * (kelas == "Bisnis" ? 1.5 : 1.0);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Kelas: $kelas");
  }
}

// Kelas Pemesanan
class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan({required this.idPemesanan, required this.namaPelanggan, required this.transportasi, required this.jumlahPenumpang, required this.totalTarif});

  void cetakStruk() {
    print("ID Pemesanan: $idPemesanan");
    print("Nama Pelanggan: $namaPelanggan");
    transportasi.tampilInfo();
    print("Jumlah Penumpang: $jumlahPenumpang");
    print("Total Tarif: $totalTarif");
  }

  Map<String, dynamic> toMap() {
    return {
      'idPemesanan': idPemesanan,
      'namaPelanggan': namaPelanggan,
      'transportasi': transportasi.nama,
      'jumlahPenumpang': jumlahPenumpang,
      'totalTarif': totalTarif,
    };
  }
}

// Fungsi Global
Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  double totalTarif = t.hitungTarif(jumlahPenumpang);
  return Pemesanan(idPemesanan: DateTime.now().millisecondsSinceEpoch.toString(), namaPelanggan: nama, transportasi: t, jumlahPenumpang: jumlahPenumpang, totalTarif: totalTarif);
}

void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  for (var pemesanan in daftar) {
    pemesanan.cetakStruk();
    print("--------------------------------");
  }
}

void main() {
  // Membuat objek transportasi
  Taksi taksi = Taksi(id: "T001", nama: "Taksi Jakarta", tarifDasar: 5000, kapasitas: 4, jarak: 10);
  Bus bus = Bus(id: "B001", nama: "Bus TransJakarta", tarifDasar: 2000, kapasitas: 50, adaWifi: true);
  Pesawat pesawat = Pesawat(id: "P001", nama: "Garuda Indonesia", tarifDasar: 1000000, kapasitas: 200, kelas: "Ekonomi");

  // Membuat data pemesanan
  List<Pemesanan> daftarPemesanan = [
    buatPemesanan(taksi, "John Doe", 2),
    buatPemesanan(bus, "Jane Doe", 30),
    buatPemesanan(pesawat, "Bob Smith", 1),
  ];

  // Menampilkan seluruh hasil transaksi
  tampilSemuaPemesanan(daftarPemesanan);
}
