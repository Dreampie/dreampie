package cn.dreampie.common.render;

import com.jfinal.render.Render;
import com.jfinal.render.RenderException;
import com.jfinal.render.RenderFactory;
import cn.dreampie.common.utils.ValidateUtils;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by wangrenhui on 14-4-28.
 */
public class JsonErrorRender extends Render {

  private static final long serialVersionUID = -7175292712918557096L;
  protected static final String contentType = "application/json" + getEncoding();

  protected static final String json404 = "404 Not Found";
  protected static final String json500 = "500 Internal Server Error";

  protected static final String json401 = "401 Unauthorized";
  protected static final String json403 = "403 Forbidden";

  protected int errorCode;

  public JsonErrorRender(int errorCode, String view) {
    this.errorCode = errorCode;
    this.view = view;
  }

  public void render() {
    response.setStatus(getErrorCode());  // HttpServletResponse.SC_XXX_XXX

    // render with json
    String errorJson = null;
    Object error = request.getAttribute("errorJson");
    if (ValidateUtils.me().isNullOrEmpty(error)) {
      errorJson = getErrorJson();
    } else {
      errorJson = error.toString();
    }

    // render with html content
    PrintWriter writer = null;
    try {
      response.setContentType(contentType);
      writer = response.getWriter();
      writer.write(errorJson);
      writer.flush();
    } catch (IOException e) {
      throw new RenderException(e);
    } finally {
      if (writer != null)
        writer.close();
    }
  }

  public String getErrorJson() {
    int errorCode = getErrorCode();
    if (errorCode == 404)
      return json404;
    if (errorCode == 500)
      return json500;
    if (errorCode == 401)
      return json401;
    if (errorCode == 403)
      return json403;
    return errorCode + " Error";
  }

  public int getErrorCode() {
    return errorCode;
  }
}
