package com.kachikun.shop.utils;

public class GHNConfig {

    public static final String TOKEN = fetchConfig("GHN_TOKEN", "");
    public static final String SHOP_ID = fetchConfig("GHN_SHOP_ID", "");

    public static final String BASE_URL = fetchConfig("GHN_BASE_URL", "https://online-gateway.ghn.vn/shiip/public-api");

    private static String fetchConfig(String key, String defaultValue) {
        String value = System.getenv(key);

        if (value == null || value.trim().isEmpty()) {
            value = System.getProperty(key);
        }

        return (value != null && !value.trim().isEmpty()) ? value.trim() : defaultValue;
    }
}