package com.system.filter;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import java.io.IOException;

@WebFilter(urlPatterns = "/*", initParams = {
        @WebInitParam(name = "encoding", value = "UTF8")
})
public class EncodingFilter implements Filter {

    private static final Logger LOGGER = Logger.getLogger(EncodingFilter.class);

    private String encoding;

    @Override
    public void init(FilterConfig filterConfig) {
        encoding = filterConfig.getInitParameter("encoding");
        LOGGER.info("The encoding filter has started and will set the encoding to: " + encoding);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding(encoding);
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        LOGGER.info("Encoding filter destroyed...");
    }

}
