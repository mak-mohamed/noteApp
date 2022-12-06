class ConstApi {
  static const String baseurl = "http://makali.byethost15.com/mynoteapp/";

//! auth api //////////////////////
  static const String constcreateaccount = "${baseurl}auth/createaccount.php";
  // static const String constcreateaccount = "http://aass.byethost16.com/noteapp/test.php";
  static const String constlogin = "${baseurl}auth/login.php";
  static const String constcheckemailexiest =
      "${baseurl}auth/checkemailexiest.php";
  static const String constresetpassword = "${baseurl}auth/resetpassword.php";
//! note api /////////////////////
  static const String constaddnote = "${baseurl}note/addnote.php";
  static const String constupdatenote = "${baseurl}note/updatenote.php";
  static const String constdeletenote = "${baseurl}note/deletenote.php";
  static const String constviewnotes = "${baseurl}note/viewnotes.php";
  static const String constNewNote = "${baseurl}note/newstnote.php";
  static const String constimageroute = "${baseurl}upload/";
}
