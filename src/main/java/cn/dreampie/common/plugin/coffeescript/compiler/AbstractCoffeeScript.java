package cn.dreampie.common.plugin.coffeescript.compiler;

import org.codehaus.plexus.util.Scanner;
import org.sonatype.plexus.build.incremental.BuildContext;

import java.io.File;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class AbstractCoffeeScript {

    /** @component */
    protected BuildContext buildContext;

    /**
     * The source directory containing the LESS sources.
     *
     * @parameter expression="${lesscss.sourceDirectory}" default-value="${project.basedir}/src/main/less"
     * @required
     */
    protected File sourceDirectory;

    /**
     * List of files to include. Specified as fileset patterns which are relative to the source directory. Default value is: { "**\/*.less" }
     *
     * @parameter
     */
    protected String[] includes = new String[] { "**/*.coffee" };

    /**
     * List of files to exclude. Specified as fileset patterns which are relative to the source directory.
     *
     * @parameter
     */
    protected String[] excludes = new String[] {};

    /**
     * Scans for the LESS sources that should be compiled.
     *
     * @return The list of LESS sources.
     */
    protected String[] getIncludedFiles() {
        Scanner scanner = buildContext.newScanner(sourceDirectory, true);
        scanner.setIncludes(includes);
        scanner.setExcludes(excludes);
        scanner.scan();
        return scanner.getIncludedFiles();
    }

    /**
     * Whether to skip plugin execution.
     * This makes the build more controllable from profiles.
     *
     * @parameter expression="${lesscss.skip}" default-value="false"
     */
    protected boolean skip;
}
