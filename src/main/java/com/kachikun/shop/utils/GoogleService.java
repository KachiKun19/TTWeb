package com.kachikun.shop.utils;

import com.google.gson.Gson;
import com.kachikun.shop.model.GoogleUser;
import okhttp3.*;

import java.io.IOException;

public class GoogleService {
    private static final Gson gson = new Gson();

    public static String getAccessToken(String code, String redirectUri) throws IOException {
        OkHttpClient client = new OkHttpClient();

        RequestBody formBody = new FormBody.Builder()
                .add("code", code)
                .add("client_id", GoogleConstants.GOOGLE_CLIENT_ID)
                .add("client_secret", GoogleConstants.GOOGLE_CLIENT_SECRET)
                .add("redirect_uri", redirectUri)
                .add("grant_type", "authorization_code")
                .build();


        Request request = new Request.Builder()
                .url(GoogleConstants.GOOGLE_LINK_GET_TOKEN)
                .post(formBody)
                .build();

        try (Response response = client.newCall(request).execute()) {
            String jsonResult = response.body().string();

            TokenResponse tokenResponse = gson.fromJson(jsonResult, TokenResponse.class);
            return tokenResponse.access_token;
        }
    }

    public static GoogleUser getUserInfo(String accessToken) throws IOException {
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(GoogleConstants.GOOGLE_LINK_GET_USER_INFO)
                .addHeader("Authorization", "Bearer " + accessToken)
                .build();

        try (Response response = client.newCall(request).execute()) {
            String jsonResult = response.body().string();

            return gson.fromJson(jsonResult, GoogleUser.class);
        }
    }

    private static class TokenResponse {
        String access_token;
    }
}