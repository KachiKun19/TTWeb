package com.asuka.model;

import java.util.Date;

public class DanhGia {
    private int id;
    private int maSanPham;
    private int maNguoiDung;
    private int soSao;
    private String noiDung;
    private Date ngayTao;

    public DanhGia() {}

    public DanhGia(int id, int maSanPham, int maNguoiDung, int soSao, String noiDung, Date ngayTao) {
        this.id = id;
        this.maSanPham = maSanPham;
        this.maNguoiDung = maNguoiDung;
        this.soSao = soSao;
        this.noiDung = noiDung;
        this.ngayTao = ngayTao;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMaSanPham() { return maSanPham; }
    public void setMaSanPham(int maSanPham) { this.maSanPham = maSanPham; }

    public int getMaNguoiDung() { return maNguoiDung; }
    public void setMaNguoiDung(int maNguoiDung) { this.maNguoiDung = maNguoiDung; }

    public int getSoSao() { return soSao; }
    public void setSoSao(int soSao) { this.soSao = soSao; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }
}
