<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Properties" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="net.socialgamer.cah.data.ConnectedUsers" %>
<%@ page import="net.socialgamer.cah.data.GameManager" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%
ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);

ConnectedUsers users = injector.getInstance(ConnectedUsers.class);
GameManager games = injector.getInstance(GameManager.class);
Properties props = injector.getInstance(Properties.class);

out.clear();
out.println("USERS " + users.getUsers().size());
out.println("GAMES " + games.getGameList().size());
out.println("MAX_USERS " + props.get("pyx.server.max_users"));
out.println("MAX_GAMES " + props.get("pyx.server.max_games"));
out.println("GLOBAL_CHAT_ENABLED " + props.get("pyx.server.global_chat_enabled"));
out.println("GAME_CHAT_ENABLED " + props.get("pyx.server.game_chat_enabled"));
out.println("BLANK_CARDS_ENABLED " + props.get("pyx.server.allow_blank_cards"));
out.println("METRICS_GAME_ENABLED " + props.get("pyx.metrics.game.enabled"));
out.println("METRICS_ROUND_ENABLED " + props.get("pyx.metrics.round.enabled"));
out.println("METRICS_SESSION_ENABLED " + props.get("pyx.metrics.session.enabled"));
out.println("METRICS_USER_ENABLED " + props.get("pyx.metrics.user.enabled"));
%>
