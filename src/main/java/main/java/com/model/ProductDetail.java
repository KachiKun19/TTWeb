package main.java.com.model;

import java.util.List;

public class ProductDetail {
    private int productDetailId;
    private Product product;
    private List<String> imageGallery; // Danh sách ảnh chi tiết
    private String specifications; // Thông số kỹ thuật
    private String sizeGuide; // Hướng dẫn chọn size
    private String careInstructions; // Hướng dẫn bảo quản

    public ProductDetail() {}

    public ProductDetail(int productDetailId, Product product, 
                        List<String> imageGallery, String specifications,
                        String sizeGuide, String careInstructions) {
        this.productDetailId = productDetailId;
        this.product = product;
        this.imageGallery = imageGallery;
        this.specifications = specifications;
        this.sizeGuide = sizeGuide;
        this.careInstructions = careInstructions;
    }

    // Getter/Setter
    public int getProductDetailId() { return productDetailId; }
    public void setProductDetailId(int productDetailId) { this.productDetailId = productDetailId; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public List<String> getImageGallery() { return imageGallery; }
    public void setImageGallery(List<String> imageGallery) { this.imageGallery = imageGallery; }

    public String getSpecifications() { return specifications; }
    public void setSpecifications(String specifications) { this.specifications = specifications; }

    public String getSizeGuide() { return sizeGuide; }
    public void setSizeGuide(String sizeGuide) { this.sizeGuide = sizeGuide; }

    public String getCareInstructions() { return careInstructions; }
    public void setCareInstructions(String careInstructions) { this.careInstructions = careInstructions; }
}