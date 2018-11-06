<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="com.google.inject.Key" %>
<%@ page import="com.google.inject.TypeLiteral" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="net.socialgamer.cah.CahModule.AllowBlankCards" %>
<%@ page import="net.socialgamer.cah.RequestWrapper" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.data.GameOptions" %>
<%
// Ensure a session exists for the user.
@SuppressWarnings("unused")
HttpSession hSession = request.getSession(true);
RequestWrapper wrapper = new RequestWrapper(request);
ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
boolean allowBlankCards = injector.getInstance(Key.get(new TypeLiteral<Boolean>(){}, AllowBlankCards.class));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="description" content="A Cards Against Humanity clone. Open sourced and available on GitHub.">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cards Against Originality</title>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.json.js"></script>
<script type="text/javascript" src="js/QTransform.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.titlealert.js"></script>
<script type="text/javascript" src="js/cah.js"></script>
<script type="text/javascript" src="js/cah.config.js"></script>
<script type="text/javascript" src="js/cah.constants.js"></script>
<script type="text/javascript" src="js/cah.log.js"></script>
<script type="text/javascript" src="js/cah.gamelist.js"></script>
<script type="text/javascript" src="js/cah.card.js"></script>
<script type="text/javascript" src="js/cah.cardset.js"></script>
<script type="text/javascript" src="js/cah.game.js"></script>
<script type="text/javascript" src="js/cah.preferences.js"></script>
<script type="text/javascript" src="js/cah.longpoll.js"></script>
<script type="text/javascript" src="js/cah.longpoll.handlers.js"></script>
<script type="text/javascript" src="js/cah.ajax.js"></script>
<script type="text/javascript" src="js/cah.ajax.builder.js"></script>
<script type="text/javascript" src="js/cah.ajax.handlers.js"></script>
<script type="text/javascript" src="js/cah.app.js"></script>
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
<link rel="stylesheet" type="text/css" href="jquery-ui.min.css" media="screen" />
<link href="https://fonts.googleapis.com/css?family=Slabo+27px|Source+Sans+Pro" rel="stylesheet">
<style>
</style>
</head>
<body id="gamebody">
<div id="welcome">
  <p tabindex="0" id="title">
    Cards Against Originality
  </p>
  <p id="subtitle">A Cards Against Humanity clone.</p>
  <div id="nickbox">
    <label for="nickname" id="nicklabel">Nickname:</label>
    <input type="text" id="nickname" value="" maxlength="25" role="textbox"
        aria-label="Enter your nickname." data-lpignore="true" autofocus />
    <input type="button" id="nicknameconfirm" value="Set" />
  </div>
  <span id="nickbox_error" class="error"></span>
  <span id="note"></span>
  <p id="footer">
    Cards Against Originality is a Cards Against Humanity clone, which is available at
    <a href="http://www.cardsagainsthumanity.com/">cardsagainsthumanity.com</a>, where you can buy it
    or download and print it out yourself. It is based off of <a href="https://github.com/ajanata/PretendYoureXyzzy">Pretend You're Xyzzy</a>
    and is distributed under a
    <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons - Attribution -
    Noncommercial - Share Alike license</a>. You may download the source code to this version from
    <a href="https://github.com/Benji-Collins/CardsAgainstOriginality">GitHub</a>. For full license
    information, including information about included libraries, see the
    <a href="license.html">full license information</a>.
  </p>
  <script>
    if (window.innerHeight <= 800)
    {
      document.getElementById("note").innerHTML = "Your screen resolution is kinda small. Try zooming out to 80% (Ctrl -).";
    }
    else
    {
      document.getElementById("note").innerHTML = "Original af.";
    }
</script>
</div>

<div id="canvas" class="hide">
  <div id="menubar">
    <div id="menubar_left">
      <input type="button" id="create_game" class="hide" value="Create Game" />

      <input type="button" id="leave_game" class="hide" value="Leave Game" />
      <input type="button" id="start_game" class="hide" value="Start Game" />
      <input type="button" id="stop_game" class="hide" value="Stop Game" />
    </div>
    <div id="menubar_right">
      <input type="button" id="logout" value="Log out" />
    </div>
  </div>
  <div id="main">
    <div id="game_list" class="hide">
    </div>
    <div id="main_holder">
    </div>
  </div>
</div>
<div id="bottom" class="hide">
  <div id="info_area">
  </div>
  <div id="tabs">
    <ul>
      <li><a href="#tab-preferences" class="tab-button">User Preferences</a></li>
      <li><a href="#tab-gamelist-filters" class="tab-button">Game List Filters</a></li>
      <li><a href="#tab-global" class="tab-button" id="button-global">Global Chat</a></li>
    </ul>
    <div id="tab-preferences">
      <input type="button" value="Save" onclick="cah.Preferences.save();" />
      <input type="button" value="Revert" onclick="cah.Preferences.load();" />
      <label for="hide_connect_quit">
        <dfn
          title="Even with this unselected, you might not see these events if the server is configured to not send them.">
            Hide connect and quit events:
        </dfn>
      </label>
      <input type="checkbox" id="hide_connect_quit" />
      <br />
      <label for="ignore_list">Chat ignore list, one name per line:</label>
      <br/>
      <textarea id="ignore_list" style="width: 200px; height: 150px"></textarea>
      <br/>
      <label for="no_persistent_id">
        <dfn title="Even with this selected, your card plays for a single session will be tracked.">
          Opt-out of card play tracking between sessions:
        </dfn>
      </label>
      <input type="checkbox" id="no_persistent_id" />
    </div>
    <div id="tab-gamelist-filters">
      You will have to click Refresh Games after saving any changes here.
      <div style="text-align: right; width:100%">
        <input type="button" value="Save" onclick="cah.Preferences.save();" />
        <input type="button" value="Revert" onclick="cah.Preferences.load();" />
      </div>
      <fieldset>
        <legend>Card set filters</legend>
        <div class="cardset_filter_list">
          <span title="Any game which uses at least one of these card sets will not be shown in the game list.">
            Do not show any games with these card sets:
          </span>
          <select id="cardsets_banned" multiple="multiple"></select>
          <div class="buttons">
            <input type="button" id="banned_remove" value="Remove --&gt;"
              onclick="cah.Preferences.transferCardSets('banned', 'neutral')" />
          </div>
        </div>
        <div class="cardset_filter_list">
          <span>Do not require or ban these card sets:</span>
          <select id="cardsets_neutral" multiple="multiple"></select>
          <div class="buttons">
            <input type="button" id="banned_add" value="&lt;-- Ban"
                onclick="cah.Preferences.transferCardSets('neutral', 'banned')" />
            <input type="button" id="required_add" value="Require --&gt;"
                onclick="cah.Preferences.transferCardSets('neutral', 'required')" />
          </div>
        </div>
        <div class="cardset_filter_list">
          <span title="Any game that does not use all of these card sets will not be shown in the game list.">
            Only show games with these card sets:
          </span>
          <select id="cardsets_required" multiple="multiple"></select>
          <div class="buttons">
            <input type="button" id="required_remove" value="&lt;-- Remove"
                onclick="cah.Preferences.transferCardSets('required', 'neutral')" />
          </div>
        </div>
      </fieldset>
    </div>
    <div id="tab-global">
      <div class="log"></div>
      <div id="chatwrapper">
        <input type="text" class="chat" maxlength="200" aria-label="Type here to chat."
            data-lpignore="true" />
          </div>
        <input type="button" class="chat_submit" value="Send" />
    </div>
  </div>
</div>

<!-- Template for game lobbies in the game list. -->
<div class="hide">
	<div id="gamelist_lobby_template" class="gamelist_lobby" tabindex="0">
	<div class="gamelist_lobby_left">
	  <h3 class="gamelist_hostname">
			<span class="gamelist_lobby_host">host</span>'s Game
			<span class="gamelist_lobby_status">status</span>
		</h3>
		<div>
		<strong>Players:</strong>
		<span class="gamelist_lobby_players">host, player1, player2</span>
		</div>
		<div>
		<strong>Spectators:</strong>
		<span class="gamelist_lobby_spectators">spectator1</span>
		</div>
		<div><strong>Goal:</strong> <span class="gamelist_lobby_goal"></span></div>
		<div>
		<strong>Cards:</strong> <span class="gamelist_lobby_cardset"></span>
		</div>
		<div class="hide">Game <span class="gamelist_lobby_id">###</span></div>
	  </div>
	  <div class="gamelist_lobby_right">
	    <input type="button" class="gamelist_lobby_join" value="Join" />
	    <input type="button" class="gamelist_lobby_spectate" value="Spectate" />
	  </div>
	</div>
</div>

<!-- Template for face-up black cards. -->
<div class="hide">
	<div id="black_up_template" class="card blackcard">
	  <span class="card_text">The quick brown fox jumped over the lazy dog.</span>
	  <div class="logo">
	    <div class="logo_1 logo_element">
	    </div>
	    <div class="logo_2 logo_element">
	    </div>
	    <div class="logo_3 logo_element watermark_container">
        <br/>
        <span class="watermark"></span>
	    </div>
	    <div class="logo_text">Cards Againt Originality</div>
	  </div>
    <div class="card_metadata">
      <div class="draw hide">DRAW <div class="card_number"></div></div>
      <div class="pick hide">PICK <div class="card_number"></div></div>
    </div>
	</div>
</div>

<!-- Template for face-down black cards. -->
<div class="hide">
	<div id="black_down_template" class="card blackcard">
	</div>
</div>

<!-- Template for face-up white cards. -->
<div class="hide">
	<div id="white_up_template" class="card whitecard">
	  <span class="card_text" role="button" tabindex="0">The quick brown fox jumped over the lazy dog.</span>
	  <div class="logo">
	    <div class="logo_1 logo_element">
	    </div>
	    <div class="logo_2 logo_element">
	    </div>
	    <div class="logo_3 logo_element watermark_container">
        <br/>
        <span class="watermark"></span>
	    </div>
	    <div class="logo_text">Cards Against Originality</div>
	  </div>
	</div>
</div>

<!-- Template for face-down white cards. -->
<div class="hide">
	<div id="white_down_template" class="card whitecard">
	</div>
</div>

<!-- Template for game lobbies. We have a holder here for designing only. -->
<div style="width: 1000px; height: 506px; border: 1px solid black; position: relative;"
    class="hide">
  <div id="game_template" class="game">
    <div class="game_top">
      <label class="game_menu_bar checkbox"><input type="checkbox" class="game_animate_cards" checked="checked" /><span> Animate Cards</span></label>
      <div class="game_message" role="status">
        Waiting for server...
      </div>
    </div>
    <div style="width:100%; height:472px;">
      <div style="width:100%; height:100%;">
        <div class="game_left_side">
          <div class="game_black_card_wrapper">
            <span tabindex="0">
                <span class="game_black_card_round_indicator"></span>
            </span>
            <div class="game_black_card" tabindex="0">
            </div>
          </div>
          <input type="button" class="confirm_card" value="Play Card" />
        </div>
        <div class="game_options">
        </div>
        <div class="game_right_side hide">
          <div class="game_right_side_box game_white_card_wrapper">
            <div class="game_white_cards game_right_side_cards">
            </div>
          </div>
          <div class="game_right_side_box game_last_round hide">
            The previous round was won by <span class="game_last_round_winner"></span>.
            <div class="game_last_round_cards game_right_side_cards">
            </div>
          </div>
        </div>
      </div>
      <div class="game_hand">
        <div class="game_hand_filter hide">
          <span class="game_hand_filter_text"></span>
        </div>
        <div class="game_hand_cards">
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Template for scoreboard container. Holder for design. -->
<div style="height: 215px; border: 1px solid black;" class="hide">
	<div id="scoreboard_template" class="scoreboard">
    <div class="game_message" tabindex="0">Scoreboard</div>
	</div>
</div>

<!-- Template for scoreboard score card. Holder for design. -->
<div class="scoreboard hide" style="height: 215px;">
	<div id="scorecard_template" class="scorecard" tabindex="0">
	  <span class="scorecard_player">PlayerName</span>
	  <div class="clear"></div>
	  <span class="scorecard_points"><span class="scorecard_score">0</span> <span class="scorecard_point_title">Awesome Point<span class="scorecard_s">s</span></span></span>
	  <span class="scorecard_status">Status</span>
	</div>
</div>

<!-- Template for round card set binder. -->
<div class="hide">
	<div id="game_white_cards_binder_template" class="game_white_cards_binder hide">
	</div>
</div>

<!-- Previous round display. -->
<div class="hide">
  <div id="previous_round_template" class="previous_round">
    <input type="button" class="previous_round_close" value="Close" />
    Round winner: <span class="previous_round_winner"></span>
    <div class="previous_round_cards"></div>
  </div>
</div>

<!-- Template for game options. -->
<div class="hide">
  <div class="game_options" id="game_options_template">
    <span class="options_host_only">Only the game host can change options.</span>
    <fieldset>
      <legend>Game options:</legend>
      <label id="score_limit_template_label" for="score_limit_template">Score limit:</label>
      <select id="score_limit_template" class="score_limit">
        <%
          for (int i = GameOptions.MIN_SCORE_LIMIT; i <= GameOptions.MAX_SCORE_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_SCORE_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
      <br/>
      <label id="player_limit_template_label" for="player_limit_template">Player limit:</label>
      <select id="player_limit_template" class="player_limit"
          aria-label="Player limit. Having more than 10 players may cause issues both for screen readers and traditional browsers.">
        <%
          for (int i = GameOptions.MIN_PLAYER_LIMIT; i <= GameOptions.MAX_PLAYER_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_PLAYER_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
      Having more than 10 players may get cramped, especially on smaller screens!
      <br/>
      <label id="spectator_limit_template_label" for="spectator_limit_template">Spectator limit:</label>
      <select id="spectator_limit_template" class="spectator_limit"
          aria-label="Spectator limit.">
        <%
          for (int i = GameOptions.MIN_SPECTATOR_LIMIT; i <= GameOptions.MAX_SPECTATOR_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_SPECTATOR_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
      Spectators can watch and chat, but not actually play.
      <br/>
      <label id="timer_multiplier_template_label" for="timer_multiplier_template"
          title="Players will be skipped if they have not played within a reasonable amount of time. This is the multiplier to apply to the default timeouts, or Unlimited to disable timeouts.">
          Idle timer multiplier:
      </label>
      <select id="timer_multiplier_template" class="timer_multiplier"
          title="Players will be skipped if they have not played within a reasonable amount of time. This is the multiplier to apply to the default timeouts, or Unlimited to disable timeouts."
          aria-label="Players will be skipped if they have not played within a reasonable amount of time. This is the multiplier to apply to the default timeouts, or Unlimited to disable timeouts.">
      	<option value="0.25x">0.25x</option>
      	<option value="0.5x">0.5x</option>
      	<option value="0.75x">0.75x</option>
      	<option selected="selected" value="1x">1x</option>
      	<option value="1.25x">1.25x</option>
      	<option value="1.5x">1.5x</option>
      	<option value="1.75x">1.75x</option>
      	<option value="2x">2x</option>
      	<option value="2.5x">2.5x</option>
      	<option value="3x">3x</option>
      	<option value="4x">4x</option>
      	<option value="5x">5x</option>
      	<option value="10x">10x</option>
      	<option value="Unlimited">Unlimited</option>
      </select>
      <br/>
      <fieldset class="card_sets">
        <legend>Card Sets</legend>
        <span class="base_card_sets"></span>
        <span class="extra_card_sets"></span>
        <legend>Type /add ##### to add a CardCast deck. Suggested decks include:
          <br>
          <a href="https://www.cardcastgame.com/browse/deck/MMUSJ">MMUSJ - Cards Against The World</a>
          <br>
          <a href="https://www.cardcastgame.com/browse/deck/PCK9T">PCK9T - Cactus Cancer</a>
          <br>
          <a href="https://www.cardcastgame.com/browse/deck/RPH29">RPH29 - CAO Pack (WIP)</a>
        </legend>
      </fieldset>
      <% if (allowBlankCards) { %>
        <br/>
        <label id="blanks_limit_label" title="Blank cards allow a player to type in their own answer.">
          Also include <select id="blanks_limit_template" class="blanks_limit">
          <%
            for (int i = GameOptions.MIN_BLANK_CARD_LIMIT; i <= GameOptions.MAX_BLANK_CARD_LIMIT; i++) {
          %>
            <option <%= i == GameOptions.DEFAULT_BLANK_CARD_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
          <% } %>
          </select> blank white cards.
        </label>
      <% } %>
      <br/>
      <label id="game_password_template_label" for="game_password_template">Game password:</label>
      <input type="text" id="game_password_template" class="game_password"
          aria-label="Game password. You must tab outside of the box to apply the password."/>
      <input type="password" id="game_fake_password_template" class="game_fake_password hide" />
      You must click outside the box to apply the password.
      <input type="checkbox" id="game_hide_password_template" class="game_hide_password" />
      <label id="game_hide_password_template_label" for="game_hide_password_template"
          aria-label="Hide password from your screen."
          title="Hides the password from your screen, so people watching your stream can't see it.">
        Hide password.
      </label>
    </fieldset>
  </div>
</div>
<div style="position:absolute; left:-99999px" role="alert" id="aria-notifications"></div>
</body>
</html>