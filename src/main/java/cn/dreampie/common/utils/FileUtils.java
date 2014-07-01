package cn.dreampie.common.utils;

import java.io.File;

public class FileUtils {

    private static FileUtils fileUtils = new FileUtils();

    private FileUtils() {
    }

    public static FileUtils me() {
        return fileUtils;
    }

    /**
     * @param file 文件对象
     * @create_time 2012-8-15 下午7:21:17
     * @create_user wangrenhui
     * @whattodo 删除文件
     * @modify_time like:date1/date2
     * @modify_user like:user1/user2
     * @modify_content like:content1/content2
     */
    public boolean delete(File file) {
        boolean result = true;
        if (file != null) {
            if (file.exists()) {
                if (file.isDirectory()) {
                    for (File f : file.listFiles()) {
                        result = result && delete(f);
                    }
                }
                result = result && file.delete();
                file = null;
            }
        }
        return result;
    }

    /**
     * 删除指定文件名的文件或文件夹
     *
     * @param file
     * @param filename
     * @return
     */
    public boolean delete(File file, String filename) {
        boolean result = true;
        if (file != null) {
            if (file.exists()) {
                if (file.isDirectory()) {
                    if (file.getName().equals(filename)) {
                        for (File f : file.listFiles()) {
                            result = result && delete(f);
                        }
                        result = result && file.delete();
                    } else {
                        for (File f : file.listFiles()) {
                            result = result && delete(f, filename);
                        }
                    }
                } else if (file.getName().equals(filename)) {
                    result = result && file.delete();
                    file = null;
                }
            }
        }
        return result;
    }

    /**
     * 删除文件
     *
     * @param path
     * @return
     */
    public boolean delete(String path) {
        if (!ValidateUtils.me().isNullOrEmpty(path)) {
            File file = new File(path);
            return delete(file);
        }
        return false;
    }

    /**
     * 删除指定名称的文件
     */
    public boolean delete(String path, String filename) {
        if (!ValidateUtils.me().isNullOrEmpty(path)) {
            File file = new File(path);
            return delete(file, filename);
        }
        return false;
    }

    /**
     * @param file 文件目录
     * @create_time 2012-8-27 下午3:42:15
     * @create_user wangrenhui
     * @whattodo 判断该目录下是否有文件
     * @modify_time like:date1/date2
     * @modify_user like:user1/user2
     * @modify_content like:content1/content2
     */
    public boolean exist(File file) {
        if (file != null) {
            if (file.isDirectory()) {
                return true;
            } else
                return file.exists();
        }
        return false;
    }

    /**
     * 存在子文件或子目录
     *
     * @param file
     * @return
     */
    public boolean existChild(File file) {
        if (file.isDirectory()) {
            for (File f : file.listFiles()) {
                if (f.isDirectory() || f.exists()) {
                    return true;
                }
            }
        }
        return false;
    }


    /**
     * 判断文件是否存在
     *
     * @param path
     * @return
     */

    public boolean exist(String path) {
        if (!ValidateUtils.me().isNullOrEmpty(path)) {
            File file = new File(path);
            if (file.isDirectory()) {
                return true;
            } else
                return exist(file);
        }
        return false;
    }

    public static void main(String[] args) {
        System.out.println(FileUtils.me().delete("D:\\workspace\\idea\\dreampie", ".git"));
    }
}
