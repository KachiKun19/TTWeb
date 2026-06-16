package com.kachikun.shop.payment;

public class VNPayConfig {

    public static final String TMN_CODE    = "5FWM0TRT";
    public static final String HASH_SECRET = "M4ZPU44X710F0GKA8ZWVYSU7X7WHAWMQ";

    public static final String PAY_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    public static final String RETURN_URL = "https://kachikunshop.azurewebsites.net/vnpay/return";
    public static final String IPN_URL    = "https://kachikunshop.azurewebsites.net/vnpay/ipn";

    public static final String VERSION    = "2.1.0";
    public static final String COMMAND    = "pay";
    public static final String CURR_CODE  = "VND";
    public static final String LOCALE     = "vn";
    public static final String ORDER_TYPE = "other";
}
