package com.asuka.model;

public class AnhSanPham {
    private int id;
    private int maSanPham;
    private String duongDanAnh;

    public AnhSanPham() {}

    public AnhSanPham(int id, int maSanPham, String duongDanAnh) {
        this.id = id;
        this.maSanPham = maSanPham;
        this.duongDanAnh = duongDanAnh;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMaSanPham() { return maSanPham; }
    public void setMaSanPham(int maSanPham) { this.maSanPham = maSanPham; }

    public String getDuongDanAnh() { return duongDanAnh; }
    public void setDuongDanAnh(String duongDanAnh) { this.duongDanAnh = duongDanAnh; }
}
