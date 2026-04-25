package com.kachikun.shop.service;

import jakarta.servlet.http.HttpSession;

import java.util.Random;

public class OtpService {

    private static final long EXPIRE_MS = 5 * 60 * 1000L; // 5 phút

    // Tao ma OTP, luu vao session
    public static String generateAndSave(HttpSession session, String prefix) {
        String otp = String.format("%06d", new Random().nextInt(999999));
        session.setAttribute(prefix + "Otp", otp);
        session.setAttribute(prefix + "OtpSentAt", System.currentTimeMillis());
        return otp;
    }

    public static boolean send(String toEmail, String subject, String otp) {
        String body = "Mã OTP của bạn là: " + otp + ". Hiệu lực 5 phút.";
        return EmailService.sendEmail(toEmail, subject, body);
    }

    // Check OTP het han chua
    public static boolean isExpired(HttpSession session, String prefix) {
        Long sentAt = (Long) session.getAttribute(prefix + "OtpSentAt");
        return sentAt == null || System.currentTimeMillis() - sentAt > EXPIRE_MS;
    }

    public static boolean verify(HttpSession session, String prefix, String inputOtp) {
        String stored = (String) session.getAttribute(prefix + "Otp");
        return stored != null && stored.equals(inputOtp);
    }

    public static Long getSentAt(HttpSession session, String prefix) {
        return (Long) session.getAttribute(prefix + "OtpSentAt");
    }

    // xoa OTP
    public static void clear(HttpSession session, String prefix) {
        session.removeAttribute(prefix + "Otp");
        session.removeAttribute(prefix + "OtpSentAt");
    }
}