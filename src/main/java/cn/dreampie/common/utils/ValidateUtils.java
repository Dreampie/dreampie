package cn.dreampie.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ValidateUtils {

  private static ValidateUtils validateUtils = new ValidateUtils();

  public static ValidateUtils me() {
    return validateUtils;
  }

  private ValidateUtils() {
  }

  /**
   * 邮箱验证工具
   *
   * @param email
   * @return
   */
  public boolean isEmail(String email) {
    String check = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";

    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);

    if (pattern.matcher(email).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 手机号码验证
   *
   * @param phone
   * @return
   */
  public boolean isMobile(String phone) {
    String check = "^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\\d{8})$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);

    if (pattern.matcher(phone).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 座机验证
   *
   * @param tel
   * @return
   */
  public boolean isTel(String tel) {
    String check = "^\\d{3,4}-?\\d{7,9}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);

    if (pattern.matcher(tel).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 电话号码 包括移动电话和座机
   *
   * @param phone
   * @return
   */
  public boolean isPhone(String phone) {
    String telcheck = "^\\d{3,4}-?\\d{7,9}$";
    String mobilecheck = "^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\\d{8})$";
    Pattern telpattern = Pattern
        .compile(telcheck, Pattern.CASE_INSENSITIVE);
    Pattern mobilepattern = Pattern.compile(mobilecheck,
        Pattern.CASE_INSENSITIVE);
    if (telpattern.matcher(phone).find()
        || mobilepattern.matcher(phone).find()) {
      return true;
    } else
      return false;
  }

  /**
   * @param general 输入内容限制为英文字母 、数字和下划线
   * @return
   */
  public boolean isGeneral(String general) {
    String check = "^\\w+$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);

    if (pattern.matcher(general).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isGeneral(String general, int min, int max) {
    String check = "^\\w{" + min + "," + max + "}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);

    if (pattern.matcher(general).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 判断是否是生日
   *
   * @param birthDay
   * @return
   */
  public boolean isBirthDay(String birthDay) {
    String check = "(\\d{4})(/|-|\\.)(\\d{1,2})(/|-|\\.)(\\d{1,2})$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    Matcher matcher = pattern.matcher(birthDay);
    if (matcher.find()) {
      int year = Integer.parseInt(birthDay.substring(0, 4));
      int month = Integer.parseInt(birthDay.substring(5, 7));
      int day = Integer.parseInt(birthDay.substring(8, 10));

      if (month < 1 || month > 12)
        return false;

      if (day < 1 || day > 31)
        return false;

      if ((month == 4 || month == 6 || month == 9 || month == 11)
          && day == 31)
        return false;

      if (month == 2) {
        boolean isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        if (day > 29 || (day == 29 && !isleap))
          return false;
      }
      return true;
    } else {
      return false;
    }
  }

  /**
   * 身份证
   *
   * @param identityCard
   * @return
   */
  public boolean isIdentityCard(String identityCard) {
    String check = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(identityCard).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 邮政编码
   *
   * @param zipCode
   * @return
   */
  public boolean isZipCode(String zipCode) {
    String check = "^[0-9]{6}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(zipCode).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 货币
   *
   * @param money
   * @return
   */
  public boolean isMoney(String money) {
    String check = "^(\\d+(?:\\.\\d{1,2})?)$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(money).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 大于0的数字
   *
   * @param number
   * @return
   */
  public boolean isNumber(String number) {
    String check = "^(\\+|\\-)?\\d+$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(number).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isNumber(String number, int min, int max) {
    String check = "^(\\+|\\-)?\\d{" + min + "," + max + "}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(number).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 正整数
   *
   * @param number
   * @return
   */
  public boolean isPositiveNumber(String number) {
    String check = "^\\d+$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(number).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isPositiveNumber(String number, int min, int max) {
    String check = "^\\d{" + min + "," + max + "}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(number).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 中文
   *
   * @param chinese
   * @return
   */
  public boolean isChinese(String chinese) {
    String check = "^[\\u2E80-\\u9FFF]+$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(chinese).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isChinese(String chinese, int min, int max) {
    String check = "^[\\u2E80-\\u9FFF]{" + min + "," + max + "}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(chinese).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 中文字、英文字母、数字和下划线
   *
   * @param String
   * @return
   */
  public boolean isString(String String) {
    String check = "^[\\u0391-\\uFFE5\\w]+$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(String).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isString(String String, int min, int max) {
    String check = "^[\\u0391-\\uFFE5\\w]{" + min + "," + max + "}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(String).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 礼品卡前缀
   *
   * @return
   */
  public boolean isCardPrefix(String card) {
    String check = "^[A-Za-z]\\w{0,3}\\d{0,4}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(card).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 礼品卡格式
   *
   * @param card
   * @return
   */
  public boolean isCard(String card) {
    String check = "^[A-Za-z]\\w{3}\\d{4}$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(card).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isUsername(String value) {
    return isGeneral(value, 5, 18);
  }

  public boolean isPassword(String value) {
    return isGeneral(value, 5, 18);
  }

  /**
   * 匹配是否是链接
   *
   * @param url
   * @return
   */
  public boolean isUrl(String url) {
//
//    // 子域名
//    final String SUB_DOMAIN = "(?i:[a-z0-9]|[a-z0-9][-a-z0-9]*[a-z0-9])";
//
//    // 顶级域名
//    final String TOP_DOMAINS = "(?x-i:com\\b        \n"
//        + "     |edu\\b        \n" + "     |biz\\b        \n"
//        + "     |in(?:t|fo)\\b \n" + "     |mil\\b        \n"
//        + "     |net\\b        \n" + "     |org\\b        \n"
//        + "     |[a-z][a-z]\\b \n" + // 国家代码
//        ")                   \n";
//    // 主机名
//    final String HOSTNAME = "(?:" + SUB_DOMAIN + "\\.)+" + TOP_DOMAINS;
//
//    // URL 地址中不允许包括的字符，以及其他的条件
//    final String NOT_IN = ";:\"'<>()\\[\\]{}\\s\\x7F-\\xFF";
//    final String NOT_END = "!.,?";
//    final String ANYWHERE = "[^" + NOT_IN + NOT_END + "]";
//    final String EMBEDDED = "[" + NOT_END + "]";
//    final String URL_PATH = "/" + ANYWHERE + "*(" + EMBEDDED + "+"
//        + ANYWHERE + "+)*";
//
//    // 端口号 0～65535
//    final String PORT = "(?:                          \n"
//        + "  [0-5]?[0-9]{1,4}           \n"
//        + "  |                          \n"
//        + "  6(?:                       \n"
//        + "     [0-4][0-9]{3}           \n"
//        + "     |                       \n"
//        + "     5(?:                    \n"
//        + "        [0-4][0-9]{2}        \n"
//        + "        |                    \n"
//        + "        5(?:                 \n"
//        + "           [0-2][0-9]        \n"
//        + "           |                 \n"
//        + "           3[0-5]            \n"
//        + "         )                   \n"
//        + "      )                      \n"
//        + "   )                         \n" + ")";
//
//    // URL 表达式
//    final String URL = "(?x:                                                \n"
//        + "  \\b                                               \n"
//        + "  (?:                                               \n"
//        + "    (?: ftp | http s? ): // [-\\w]+(\\.\\w[-\\w]*)+ \n"
//        + "   |                                                \n"
//        + "    "
//        + HOSTNAME
//        + "                                \n"
//        + "  )                                                 \n"
//        + "  (?: : "
//        + PORT
//        + " )?                             \n"
//        + "  (?: "
//        + URL_PATH
//        + ")?                            \n"
//        + ")";
    String check = "^((https?|ftp):\\/\\/)?(((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:)*@)?(((\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5]))|((([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.?)(:\\d*)?)(\\/((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)+(\\/(([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)*)*)?)?(\\?((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)|[\\uE000-\\uF8FF]|\\/|\\?)*)?(\\#((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)|\\/|\\?)*)?$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    if (pattern.matcher(url).find()) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 判断
   *
   * @param date
   * @return
   */
  public boolean isDateTime(String date) {
    String check = "^(\\d{4})(/|-|\\.|年)(\\d{1,2})(/|-|\\.|月)(\\d{1,2})(日)?(\\s+\\d{1,2}(:|时)\\d{1,2}(:|分)?(\\d{1,2}(秒)?)?)?$";// check = "^(\\d{4})(/|-|\\.)(\\d{1,2})(/|-|\\.)(\\d{1,2})$";

    Pattern pattern = Pattern.compile(check);
    if (pattern.matcher(date).find()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isNullOrEmpty(Object value) {
    if (value instanceof Collection) {
      if (value == null || ((Collection) value).isEmpty()) {
        return true;
      }
    } else if (value instanceof String) {
      if (value == null || "".equals(value.toString().trim())) {
        return true;
      }
    } else {
      if (value == null)
        return true;
    }
    return false;
  }

  public boolean isLength(String value, int min, int max) {
    int length = isNullOrEmpty(value) ? 0 : value.length();
    if (length >= min && length <= max) return true;
    else return false;
  }

  public boolean compareDate(String date1, String date2) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try {
      Date d1 = sdf.parse(date1);
      Date d2 = sdf.parse(date2);
      return d1.compareTo(d2) > 0;
    } catch (ParseException e) {
      return false;
    }
  }

  public static void main(String[] args) {
    String email = "sss@gmail.com";
    String phone = "18611351122";
    String general = "aa";

    // System.out.println(ValidateUtils.me().isEmail(email) + "--"
    // + ValidateUtils.me().isPhone(phone) + "--"
    // + ValidateUtils.me().isGeneral(general) + "--"
    // + isBirthDay("1990.02.29")+"--"+isCard("va234567"));
    // System.out.println(isNumber("000001"));
    // System.out.println(isCard("sz000016"));

    // 测试代码
    String[] strs = {"http://www.13.com", "https://www.asdf.com.cn/asdf",
        "www.23.com", "http://www.123.com/tsf",
        "http://www.abc.com/ab:2525/a.asp",
        "http://www.123.com:2563/tsf/a.html?a=2&&b=abc",
        "http://www.aa.com/servlet",
        "http://ee.com/abcSerlvet?a=8&&b=asdf",
        "ftp://192.168.0.2:8080", "http://ww.ss.com/////", "http://ww.gg.cn/"};
    for (int i = 0; i < strs.length; i++) {
      System.out.printf("%s --> %s%n", strs[i], ValidateUtils.me().isUrl(strs[i]));
    }
    System.out.println("--------------------------------");
//    System.out.println(isDateTime("2013年11月26日 11时10分11秒"));

    String check = "^((https?|ftp):\\/\\/)?(((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:)*@)?(((\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5]))|((([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.?)(:\\d*)?)(\\/((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)+(\\/(([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)*)*)?)?(\\?((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)|[\\uE000-\\uF8FF]|\\/|\\?)*)?(\\#((([a-z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(%[\\da-f]{2})|[!\\$&'\\(\\)\\*\\+,;=]|:|@)|\\/|\\?)*)?$";
    Pattern pattern = Pattern.compile(check, Pattern.CASE_INSENSITIVE);
    for (int i = 0; i < strs.length; i++) {
      System.out.printf("%s --> %s%n", strs[i], pattern.matcher(strs[i]).find());
    }
//    if (pattern.matcher("/channel/save").find()) {
//      System.out.print("true");
//    } else {
//      System.out.print("false");
//    }
  }
}
