<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="com.google.inject.Key" %>
<%@ page import="com.google.inject.TypeLiteral" %>
<%@ page import="net.socialgamer.cah.CahModule.Admins" %>
<%@ page import="net.socialgamer.cah.HibernateUtil" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.db.PyxBlackCard" %>
<%@ page import="net.socialgamer.cah.db.PyxWhiteCard" %>
<%@ page import="net.socialgamer.cah.RequestWrapper" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="java.util.Set" %>
<%
RequestWrapper wrapper = new RequestWrapper(request);
ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
Set<String> admins = injector.getInstance(Key.get(new TypeLiteral<Set<String>>(){}, Admins.class));
if (!admins.contains(wrapper.getRemoteAddr())) {
  response.sendError(403, "Access is restricted to known hosts");
  return;
}

final String watermark = request.getParameter("watermark") != null ? request.getParameter("watermark") : "";

String error = "";
String status = "";
String field = "";
final String color = request.getParameter("color");
if (color != null) {
  if ("black".equals(color)) {
    final String text = request.getParameter("text");
    final String pick_s = request.getParameter("pick");
    final String draw_s = request.getParameter("draw");
    
    if (text == null || "".equals(text) || pick_s == null || "".equals(pick_s) || draw_s == null ||
        "".equals(draw_s)) {
      error = "You didn't specify something.";
    } else {
      int pick = 0;
      int draw = 0;
      try {
        pick = Integer.parseInt(pick_s);
        draw = Integer.parseInt(draw_s);
      } catch (NumberFormatException e) {
        error = "Something isn't a number.";
      }
      if (0 == pick) {
        error += " Pick can't be 0.";
      } else {
        final Session s = HibernateUtil.instance.sessionFactory.openSession();
        final Transaction transaction = s.beginTransaction();
        transaction.begin();
        final PyxBlackCard card = new PyxBlackCard();
        card.setText(text);
        card.setPick(pick);
        card.setDraw(draw);
        card.setWatermark(watermark);
        s.save(card);
        transaction.commit();
        s.close();
        status = "Saved '" + text + "'.";
        field = "black";
      }
    }
  } else if ("white".equals(color)) {
    final String text = request.getParameter("text");
    
    if (text == null || "".equals(text)) {
      error = "You didn't specify something.";
    } else {
      final Session s = HibernateUtil.instance.sessionFactory.openSession();
      final Transaction transaction = s.beginTransaction();
      transaction.begin();
      final PyxWhiteCard card = new PyxWhiteCard();
      card.setText(text);
      card.setWatermark(watermark);
      s.save(card);
      transaction.commit();
      s.close();
      status = "Saved '" + text + "'.";
      field = "white";
    }
  }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PYX - Add Cards</title>
</head>
<body>
<span style="color:red"><%= error %></span>
<span style="color:blue"><%= status %></span>
<p>Convention is to use four underscores for the blanks on black cards.</p>
<h1 id="black">Black Card</h1>
<form method="post" action="addcard.jsp">
<input type="hidden" name="color" value="black" />
<label for="black_text">Card Text</label><input type="text" id="black_text" name="text" size="150" />
<br/>
<label for="pick">Pick</label><input type="text" id="pick" name="pick" size="3" value="1" />
<br/>
<label for="draw">Draw</label><input type="text" id="draw" name="draw" size="3" value="0" />
<br/>
<label for="watermark_b">Watermark</label>
<input type="text" id="watermark_b" name="watermark" size="3" maxlength="5" value="<%= watermark %>" />
<br/>
<input type="submit" value="Add card" />
</form>
<h1 id="white">White Card</h1>
<form method="post" action="addcard.jsp">
<input type="hidden" name="color" value="white" />
<label for="white_text">Card Text</label><input type="text" id="white_text" name="text" size="150" />
<br/>
<label for="watermark_w">Watermark</label>
<input type="text" id="watermark_w" name="watermark" size="3" maxlength="5" value="<%= watermark %>" />
<br/>
<input type="submit" value="Add card" />
</form>
<script type="text/javascript">
var field = '<%= field %>';
if ('' != field) {
  document.getElementById(field + '_text').focus();
}
</script>
</body>
</html>