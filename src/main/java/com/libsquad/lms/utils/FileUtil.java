package com.libsquad.lms.utils;

import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class FileUtil {
    private static final String UPLOAD_DIR = "uploads";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final String[] ALLOWED_MIME_TYPES = {
            "image/jpeg", "image/png", "image/gif"
    };

    public static String saveUploadedFile(Part filePart) throws IOException {
        validateFile(filePart);
        String fileName = generateUniqueFileName(filePart);
        Path uploadPath = Paths.get(getUploadDirectory());

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, uploadPath.resolve(fileName),
                    StandardCopyOption.REPLACE_EXISTING);
        }
        return fileName;
    }



    private static void validateFile(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            throw new IllegalArgumentException("No file uploaded");
        }

        if (filePart.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException("File size exceeds 5MB limit");
        }

        String contentType = filePart.getContentType();
        boolean validType = false;
        for (String mime : ALLOWED_MIME_TYPES) {
            if (mime.equalsIgnoreCase(contentType)) {
                validType = true;
                break;
            }
        }

        if (!validType) {
            throw new IllegalArgumentException(
                    "Invalid file type. Only JPG, PNG, and GIF allowed");
        }
    }

    private static String generateUniqueFileName(Part filePart) {
        String originalName = Paths.get(filePart.getSubmittedFileName())
                .getFileName().toString();
        return UUID.randomUUID().toString() + "_" + originalName;
    }

    public static String getUploadDirectory() {
        // Now using the UPLOAD_DIR constant
        return System.getProperty("user.home") + "/" + UPLOAD_DIR;
    }
}