package cn.dreampie.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import com.jfinal.kit.PathKit;
import com.jfinal.kit.StringKit;

/**
 * Created by wangrenhui on 14-4-10.
 */
public class PropertyUtils {
    private ConcurrentMap<String, Object> properties = new ConcurrentHashMap<String, Object>();

    private static PropertyUtils config = new PropertyUtils();

    private PropertyUtils() {
    }

    public static PropertyUtils me() {
        return config;
    }


    public void loadPropertyFile(String file) {
        Properties property = new Properties();
        if (StringKit.isBlank(file))
            throw new IllegalArgumentException("Parameter of file can not be blank");
        if (file.contains(".."))
            throw new IllegalArgumentException("Parameter of file can not contains \"..\"");

        InputStream inputStream = null;
        String fullFile;  // String fullFile = PathUtil.getWebRootPath() + file;
        //判断是否带有文件分隔符
        boolean startStuff = file.startsWith(File.separator);
        if (startStuff)
            fullFile = PathKit.getWebRootPath() + File.separator + "WEB-INF" + file;
        else
            fullFile = PathKit.getWebRootPath() + File.separator + "WEB-INF" + File.separator + file;
        File propFile = new File(fullFile);
        //判断文件是否存在WebInf
        if (!propFile.exists()) {
            if (startStuff)
                fullFile = PathKit.getRootClassPath() + file;
            else
                fullFile = PathKit.getRootClassPath() + File.separator + file;
            propFile = new File(fullFile);
            //判断文件是否存在class
            if (!propFile.exists()) {
                throw new IllegalArgumentException("Properties file not found: " + fullFile);
            }
        }
        try {
            inputStream = new FileInputStream(new File(fullFile));
            property.load(inputStream);
        } catch (Exception eOne) {
            try {
                ClassLoader loader = Thread.currentThread().getContextClassLoader();
                property.load(loader.getResourceAsStream(file));
            } catch (IOException eTwo) {
                throw new IllegalArgumentException("Properties file loading failed: " + eTwo.getMessage());
            }
        } finally {
            try {
                if (inputStream != null) inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (property != null) {
            for (Entry<Object, Object> entry : property.entrySet()) {
                this.properties.put(entry.getKey().toString(), entry.getValue());
            }
        }
    }

    public String getProperty(String key) {
        if (this.properties.containsKey(key)) {
            return properties.get(key).toString();
        }
        return null;
    }

    public String getProperty(String key, String defaultValue) {
        if (this.properties.containsKey(key)) {
            return properties.get(key).toString();
        }
        return defaultValue;
    }

    public Integer getPropertyToInt(String key) {
        Integer resultInt = null;
        String resultStr = this.getProperty(key);
        if (resultStr != null)
            resultInt = Integer.parseInt(resultStr);
        return resultInt;
    }

    public Integer getPropertyToInt(String key, Integer defaultValue) {
        Integer result = getPropertyToInt(key);
        return result != null ? result : defaultValue;
    }

    public Boolean getPropertyToBoolean(String key) {
        String resultStr = this.getProperty(key);
        Boolean resultBool = null;
        if (resultStr != null) {
            if (resultStr.trim().equalsIgnoreCase("true"))
                resultBool = true;
            else if (resultStr.trim().equalsIgnoreCase("false"))
                resultBool = false;
        }
        return resultBool;
    }

    public Boolean getPropertyToBoolean(String key, boolean defaultValue) {
        Boolean result = getPropertyToBoolean(key);
        return result != null ? result : defaultValue;
    }
}