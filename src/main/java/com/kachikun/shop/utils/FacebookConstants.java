package com.kachikun.shop.utils;

public class FacebookConstants {
    public static final String FACEBOOK_APP_ID = AppConfig.get("FACEBOOK_APP_ID");
    public static final String FACEBOOK_APP_SECRET = AppConfig.get("FACEBOOK_APP_SECRET");
    public static final String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/v19.0/oauth/access_token";
    public static final String FACEBOOK_LINK_GET_USER_INFO = "https://graph.facebook.com/me?fields=id,name,email,picture";
}
