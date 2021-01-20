package servlet;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import service.guest.RegisterGuestService;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageServlet extends HttpServlet {
    private static final String IMAGE_LOCATION="imageLocation";
    private static final Logger LOGGER = LogManager.getLogger(ImageServlet.class.getName());
    private static final int DEFAULT_BUFFER_SIZE = 10240; // 10KB.
    private String filePath;

    public void init() {
        this.filePath = getServletContext().getInitParameter(IMAGE_LOCATION);

    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String requestedFile = req.getPathInfo();
        if (requestedFile == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File file = new File(filePath, URLDecoder.decode(requestedFile, "UTF-8"));
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        String contentType = getServletContext().getMimeType(file.getName());

        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        resp.reset();
        resp.setBufferSize(DEFAULT_BUFFER_SIZE);
        resp.setContentType(contentType);
        resp.setHeader("Content-Length", String.valueOf(file.length()));
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

        BufferedInputStream input = null;
        BufferedOutputStream output = null;

        try {
            input = new BufferedInputStream(new FileInputStream(file), DEFAULT_BUFFER_SIZE);
            output = new BufferedOutputStream(resp.getOutputStream(), DEFAULT_BUFFER_SIZE);

            byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        } finally {
            close(output);
            close(input);
        }
    }

    private static void close(Closeable resource) {
        if (resource != null) {
            try {
                resource.close();
            } catch (IOException e) {
                LOGGER.error(e.getMessage(),e);
            }
        }
    }
}
