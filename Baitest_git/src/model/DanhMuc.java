package com.asuka.model;

public class DanhMuc {
    private int id;
    private String tenDanhMuc;
    private String duongDan;
    private String moTa;
    private Integer maCha;

    public DanhMuc() {}

    public DanhMuc(int id, String tenDanhMuc, String duongDan, String moTa, Integer maCha) {
        this.id = id;
        this.tenDanhMuc = tenDanhMuc;
        this.duongDan = duongDan;
        this.moTa = moTa;
        this.maCha = maCha;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenDanhMuc() { return tenDanhMuc; }
    public void setTenDanhMuc(String tenDanhMuc) { this.tenDanhMuc = tenDanhMuc; }

    public String getDuongDan() { return duongDan; }
    public void setDuongDan(String duongDan) { this.duongDan = duongDan; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public Integer getMaCha() { return maCha; }
    public void setMaCha(Integer maCha) { this.maCha = maCha; }
}
