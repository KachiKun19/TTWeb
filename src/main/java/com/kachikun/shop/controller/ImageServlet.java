package com.kachikun.shop.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        String filename = pathInfo.substring(1); // strip leading "/"

        String uploadDir = System.getenv("UPLOAD_DIR");
        if (uploadDir != null && !uploadDir.trim().isEmpty()) {
            File file = new File(uploadDir, filename);
            if (file.exists() && file.isFile()) {
                serveFile(resp, file);
                return;
            }
        }

        // Fallback: ảnh tĩnh đóng gói trong WAR (logo, ảnh mặc định, v.v.)
        InputStream is = getServletContext().getResourceAsStream("/images/" + filename);
        if (is == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        String mimeType = getServletContext().getMimeType(filename);
        if (mimeType != null) resp.setContentType(mimeType);
        try (is) {
            is.transferTo(resp.getOutputStream());
        }
    }

    private void serveFile(HttpServletResponse resp, File file) throws IOException {
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType != null) resp.setContentType(mimeType);
        resp.setContentLengthLong(file.length());
        Files.copy(file.toPath(), resp.getOutputStream());
    }
}
