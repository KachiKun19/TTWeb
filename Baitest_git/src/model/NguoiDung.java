package com.asuka.model;

import java.util.Date;

public class NguoiDung {
    private int id;
    private String tenDangNhap;
    private String email;
    private String matKhau;
    private String hoTen;
    private String soDienThoai;
    private String vaiTro;
    private Date ngayTao;
    private boolean kichHoat;

    public NguoiDung() {}

    public NguoiDung(int id, String tenDangNhap, String email, String matKhau, String hoTen,
                     String soDienThoai, String vaiTro, Date ngayTao, boolean kichHoat) {
        this.id = id;
        this.tenDangNhap = tenDangNhap;
        this.email = email;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.soDienThoai = soDienThoai;
        this.vaiTro = vaiTro;
        this.ngayTao = ngayTao;
        this.kichHoat = kichHoat;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenDangNhap() { return tenDangNhap; }
    public void setTenDangNhap(String tenDangNhap) { this.tenDangNhap = tenDangNhap; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }

    public boolean isKichHoat() { return kichHoat; }
    public void setKichHoat(boolean kichHoat) { this.kichHoat = kichHoat; }
}
