package cn.dreampie.common.plugin.lesscss.compiler;

import org.lesscss.LessSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

/**
 * Createdby wangrenhui on 2014/7/11.
 */
public class LessCssList extends AbstractLessCss {

    private Logger logger = LoggerFactory.getLogger(getClass());

    public void execute() {
        if (logger.isDebugEnabled()) {
            logger.debug("sourceDirectory = " + sourceDirectory);
            logger.debug("includes = " + Arrays.toString(includes));
            logger.debug("excludes = " + Arrays.toString(excludes));
        }

        String[] files = getIncludedFiles();

        if (files == null || files.length < 1) {
            logger.info("No LESS sources found");
        } else {
            logger.info("The following LESS sources have been resolved:");

            for (String file : files) {
                File lessFile = new File(sourceDirectory, file);
                try {
                    LessSource lessSource = new LessSource(lessFile);
                    listLessSource(lessSource, file, 0, false);
                } catch (FileNotFoundException e) {
                    throw new LessCssException("Error while loading LESS source: " + lessFile.getAbsolutePath(), e);
                } catch (IOException e) {
                    throw new LessCssException("Error while loading LESS source: " + lessFile.getAbsolutePath(), e);
                }
            }
        }
    }

    private void listLessSource(LessSource lessSource, String path, int level, boolean last) {
        String prefix = "";
        if (level > 0) {
            for (int i = 1; i <= level; i++) {
                if (i == level && last) {
                    prefix = prefix + "`-- ";
                } else if (i == level) {
                    prefix = prefix + "|-- ";
                } else {
                    prefix = prefix + "|   ";
                }
            }
        }

        logger.info(prefix + path);

        Iterator<Map.Entry<String, LessSource>> it = lessSource.getImports().entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, LessSource> entry = it.next();
            listLessSource(entry.getValue(), entry.getKey(), level + 1, !it.hasNext());
        }
    }
}
