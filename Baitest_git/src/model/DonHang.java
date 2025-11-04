package com.asuka.model;

import java.util.Date;

public class DonHang {
    private int id;
    private int maNguoiDung;
    private double tongTien;
    private String trangThai;
    private String phuongThucThanhToan;
    private Date ngayTao;
    private Date ngayCapNhat;

    public DonHang() {}

    public DonHang(int id, int maNguoiDung, double tongTien, String trangThai,
                   String phuongThucThanhToan, Date ngayTao, Date ngayCapNhat) {
        this.id = id;
        this.maNguoiDung = maNguoiDung;
        this.tongTien = tongTien;
        this.trangThai = trangThai;
        this.phuongThucThanhToan = phuongThucThanhToan;
        this.ngayTao = ngayTao;
        this.ngayCapNhat = ngayCapNhat;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMaNguoiDung() { return maNguoiDung; }
    public void setMaNguoiDung(int maNguoiDung) { this.maNguoiDung = maNguoiDung; }

    public double getTongTien() { return tongTien; }
    public void setTongTien(double tongTien) { this.tongTien = tongTien; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public String getPhuongThucThanhToan() { return phuongThucThanhToan; }
    public void setPhuongThucThanhToan(String phuongThucThanhToan) { this.phuongThucThanhToan = phuongThucThanhToan; }

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }

    public Date getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Date ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}
