package cn.dreampie.common.utils;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

/**
 * Created by wangrenhui on 14-4-21.
 */
public class TimeUtils {

    private static TimeUtils timeUtils = new TimeUtils();

    private TimeUtils() {
    }

    public static TimeUtils me() {
        return timeUtils;
    }

    /**
     * 字符串转换为时间格式
     *
     * @param dateStr
     * @return
     */
    public DateTime toDateTime(String dateStr) {
        DateTimeFormatter df = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
        DateTime date = df.parseDateTime(dateStr);
        return date;
    }

    public DateTime toDateTime(String dateStr, String format) {
        if (ValidateUtils.me().isNullOrEmpty(format)) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        DateTimeFormatter df = DateTimeFormat.forPattern(format);
        DateTime date = df.parseDateTime(dateStr);
        return date;
    }

    /**
     * 时间转换为字符串
     *
     * @param date
     * @return
     */
    public String toString(DateTime date) {
        DateTimeFormatter df = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
        String dateStr = date.toString(df);
        return dateStr;
    }

    public String toString(DateTime date, String format) {
        if (ValidateUtils.me().isNullOrEmpty(format)) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        DateTimeFormatter df = DateTimeFormat.forPattern(format);
        String dateStr = date.toString(df);
        return dateStr;
    }
}
