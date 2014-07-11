package cn.dreampie.common.web.resource;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public interface Resource {

    /**
     * Tests if resource exists.
     *
     * @return true if resource exists.
     */
    boolean exists();

    /**
     * Returns the time that the FILE source was last modified.
     *
     * @return A <code>long</code> value representing the time the resource was last modified, measured in milliseconds
     * since the epoch (00:00:00 GMT, January 1, 1970).
     */
    long lastModified();

    /**
     * Returns resource input stream.
     *
     * @throws java.io.IOException
     */
    InputStream getInputStream() throws IOException;

    /**
     * Creates relative resource for current resource.
     *
     * @param relativeResourcePath String relative resource path
     * @return Resource relative resource
     */
    Resource createRelative(String relativeResourcePath) throws IOException;

    /**
     * Returns a unique name for this resource. (ie file name for files)
     *
     * @return the name of the resource
     */
    String getName();
}
