package com.asuka.model;

public class ThuongHieu {
    private int id;
    private String tenThuongHieu;
    private String logoUrl;

    public ThuongHieu() {}

    public ThuongHieu(int id, String tenThuongHieu, String logoUrl) {
        this.id = id;
        this.tenThuongHieu = tenThuongHieu;
        this.logoUrl = logoUrl;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenThuongHieu() { return tenThuongHieu; }
    public void setTenThuongHieu(String tenThuongHieu) { this.tenThuongHieu = tenThuongHieu; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }
}
