package com.asuka.model;

import java.util.Date;

public class SanPham {
    private int id;
    private String tenSanPham;
    private String duongDan;
    private String moTa;
    private double gia;
    private int soLuongTon;
    private Integer maThuongHieu;
    private Integer maDanhMuc;
    private Date ngayTao;
    private Date ngayCapNhat;

    public SanPham() {}

    public SanPham(int id, String tenSanPham, String duongDan, String moTa, double gia,
                   int soLuongTon, Integer maThuongHieu, Integer maDanhMuc, Date ngayTao, Date ngayCapNhat) {
        this.id = id;
        this.tenSanPham = tenSanPham;
        this.duongDan = duongDan;
        this.moTa = moTa;
        this.gia = gia;
        this.soLuongTon = soLuongTon;
        this.maThuongHieu = maThuongHieu;
        this.maDanhMuc = maDanhMuc;
        this.ngayTao = ngayTao;
        this.ngayCapNhat = ngayCapNhat;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }

    public String getDuongDan() { return duongDan; }
    public void setDuongDan(String duongDan) { this.duongDan = duongDan; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }

    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }

    public Integer getMaThuongHieu() { return maThuongHieu; }
    public void setMaThuongHieu(Integer maThuongHieu) { this.maThuongHieu = maThuongHieu; }

    public Integer getMaDanhMuc() { return maDanhMuc; }
    public void setMaDanhMuc(Integer maDanhMuc) { this.maDanhMuc = maDanhMuc; }

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }

    public Date getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Date ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}
