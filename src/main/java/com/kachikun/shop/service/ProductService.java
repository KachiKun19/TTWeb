package com.kachikun.shop.service;

import com.kachikun.shop.model.Product;

import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.dao.ProductDAO;

public class ProductService {
	private ProductDAO productDAO = new ProductDAO();
	
	public List<Product> getAllProducts() {
		return productDAO.getAllProducts();
	}
	public Product getproductById(int id) {
		List<Product> list = new ArrayList<>();
		for(Product p : list) {
			if(p.getId() == id) {
				return p;
			}
		}
		return null;
	}
}
