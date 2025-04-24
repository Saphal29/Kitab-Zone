package com.libsquad.lms.controller.student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="FineServlet", urlPatterns="/student/fines")
public class FineServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{
        try{
            request.getRequestDispatcher("/WEB-INF/views/student/fines.jsp").forward(request, response);
    }catch (Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading fines page");
        }
    }
}
