package com.libsquad.lms.controller.student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet(name="BrowseBookServlet", urlPatterns="/student/browseBooks")
public class BrowseBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{
        try{
            request.getRequestDispatcher("/WEB-INF/views/student/browseBooks.jsp").forward(request, response);
    }catch (Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading BrowseBook page");
        }
    }
}
