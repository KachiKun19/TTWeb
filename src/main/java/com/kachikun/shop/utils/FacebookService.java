package com.kachikun.shop.utils;

import com.google.gson.Gson;
import com.kachikun.shop.model.FacebookUser;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;


import java.io.IOException;

public class FacebookService {
    private static final Gson gson = new Gson();

    public static String getAccessToken(String code, String redirectUri) throws IOException {
        OkHttpClient client = new OkHttpClient();

        HttpUrl url = HttpUrl.parse(FacebookConstants.FACEBOOK_LINK_GET_TOKEN).newBuilder().addQueryParameter("client_id", FacebookConstants.FACEBOOK_APP_ID).addQueryParameter("client_secret", FacebookConstants.FACEBOOK_APP_SECRET).addQueryParameter("redirect_uri", redirectUri).addQueryParameter("code", code).build();

        Request request = new Request.Builder().url(url).get().build();

        try (Response response = client.newCall(request).execute()) {
            String json = response.body().string();
            TokenResponse token = gson.fromJson(json, TokenResponse.class);
            return token.access_token;
        }
    }

    public static FacebookUser getUserInfo(String accessToken) throws IOException {
        OkHttpClient client = new OkHttpClient();

        HttpUrl url = HttpUrl.parse(FacebookConstants.FACEBOOK_LINK_GET_USER_INFO).newBuilder().addQueryParameter("access_token", accessToken).build();

        Request request = new Request.Builder().url(url).get().build();

        try (Response response = client.newCall(request).execute()) {
            String json = response.body().string();
            return gson.fromJson(json, FacebookUser.class);
        }
    }

    private static class TokenResponse {
        String access_token;
    }
}