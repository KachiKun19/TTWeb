package com.kachikun.shop.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.math.BigInteger;

public class MD5 {
    public static String encrypt(String input) {
        try {
            // Gọi thuật toán MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            // Chuyển chuỗi đầu vào thành mảng byte và băm
            byte[] messageDigest = md.digest(input.getBytes());
            
            // Chuyển mảng byte thành dạng Số lớn (Signum)
            BigInteger no = new BigInteger(1, messageDigest);
            
            // Chuyển thành chuỗi Hex (hệ 16)
            String hashtext = no.toString(16);
            
            // Thêm các số 0 ở đầu nếu thiếu (cho đủ 32 ký tự chuẩn MD5)
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    
    // Test thử xem nó chạy không
    public static void main(String[] args) {
        System.out.println("Mật khẩu '123456' mã hóa thành: " + encrypt("123456"));
    }
}