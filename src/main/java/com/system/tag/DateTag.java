package com.system.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Date tag class for support formatted date output on the page
 */
public class DateTag extends TagSupport {

    private static final long serialVersionUID = 1L;

    @Override
    public int doStartTag() throws JspException {
        JspWriter writer = pageContext.getOut();
        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss dd.MM.yyyy");

        try {
            writer.write(dateFormat.format(date));
        } catch (IOException e) {
            throw new JspException(e.getMessage());
        }

        return SKIP_BODY;
    }

}
