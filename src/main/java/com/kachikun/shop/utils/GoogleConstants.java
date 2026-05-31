package com.kachikun.shop.utils;

public class GoogleConstants {
    public static final String GOOGLE_CLIENT_ID = AppConfig.get("GOOGLE_CLIENT_ID");
    public static final String GOOGLE_CLIENT_SECRET = AppConfig.get("GOOGLE_CLIENT_SECRET");
    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v2/userinfo";
}
