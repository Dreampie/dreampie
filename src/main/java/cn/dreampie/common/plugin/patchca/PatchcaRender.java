package cn.dreampie.common.plugin.patchca;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.plugin.patchca.color.ColorFactory;
import cn.dreampie.common.plugin.patchca.filter.ConfigurableFilterFactory;
import cn.dreampie.common.plugin.patchca.filter.library.WobbleImageOp;
import cn.dreampie.common.plugin.patchca.font.RandomFontFactory;
import cn.dreampie.common.plugin.patchca.service.Captcha;
import cn.dreampie.common.plugin.patchca.service.ConfigurableCaptchaService;
import cn.dreampie.common.plugin.patchca.text.renderer.BestFitTextRenderer;
import cn.dreampie.common.plugin.patchca.text.renderer.TextRenderer;
import cn.dreampie.common.plugin.patchca.word.RandomWordFactory;
import cn.dreampie.common.utils.security.EncriptionUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.jfinal.render.Render;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by wangrenhui on 13-12-31.
 */
public class PatchcaRender extends Render {
    private static final String CODE_CHAR = "0123456789";
    private static final int MIN_NUM = 4;
    private static final int MAX_NUM = 4;
    private static final int FONT_MIN_SIZE = 20;
    private static final int FONT_MAX_SIZE = 20;
    private static final double X_AMPLITUDE = 1.6;
    private static final double Y_AMPLITUDE = 0.8;
    private static final int TOP_MARGIN = 1;
    private static final int BOTTOM_MARGIN = 1;
    private static final int WIDTH = 118;
    private static final int HEIGHT = 41;

    private static boolean use_code = true;

    private ConfigurableCaptchaService configurableCaptchaService = null;
    private ColorFactory colorFactory = null;
    private RandomFontFactory fontFactory = null;
    private RandomWordFactory wordFactory = null;
    private TextRenderer textRenderer = null;

    public PatchcaRender() {
        this(MIN_NUM, MAX_NUM, WIDTH, HEIGHT);
    }

    public PatchcaRender(int num) {
        this(num, num, WIDTH, HEIGHT);
    }

    public PatchcaRender(int minnum, int maxnum, int width, int height) {
        if (minnum <= 0) {
            minnum = MIN_NUM;
        }
        if (maxnum <= 0) {
            maxnum = MAX_NUM;
        }
        if (width <= 0) {
            width = WIDTH;
        }
        if (height <= 0) {
            height = HEIGHT;
        }
        configurableCaptchaService = new ConfigurableCaptchaService();

        // 颜色创建工厂,使用一定范围内的随机色
        //colorFactory = new RandomColorFactory();
        colorFactory = new ColorFactory() {

            public Color getColor(int index) {
                return new Color(0, 0, 0);//new Color(118,102,102);
            }
        };

        configurableCaptchaService.setColorFactory(colorFactory);

        // 随机字体生成器
        fontFactory = new RandomFontFactory();
        fontFactory.setMaxSize(FONT_MAX_SIZE);
        fontFactory.setMinSize(FONT_MIN_SIZE);
        configurableCaptchaService.setFontFactory(fontFactory);

        // 随机字符生成器,去除掉容易混淆的字母和数字,如o和0等
        wordFactory = new RandomWordFactory();
        wordFactory.setCharacters(CODE_CHAR);
        wordFactory.setMaxLength(maxnum);
        wordFactory.setMinLength(minnum);
        configurableCaptchaService.setWordFactory(wordFactory);

        // 自定义验证码图片背景
        SimpleBackgroundFactory backgroundFactory = new SimpleBackgroundFactory();
        configurableCaptchaService.setBackgroundFactory(backgroundFactory);

        // 图片滤镜设置
        ConfigurableFilterFactory filterFactory = new ConfigurableFilterFactory();

        java.util.List<BufferedImageOp> filters = new ArrayList<BufferedImageOp>();
        WobbleImageOp wobbleImageOp = new WobbleImageOp();
        wobbleImageOp.setEdgeMode(BufferedImage.TYPE_INT_ARGB);
        wobbleImageOp.setxAmplitude(X_AMPLITUDE);
        wobbleImageOp.setyAmplitude(Y_AMPLITUDE);
        filters.add(wobbleImageOp);
        filterFactory.setFilters(filters);

        configurableCaptchaService.setFilterFactory(filterFactory);

        // 文字渲染器设置
        textRenderer = new BestFitTextRenderer();
        textRenderer.setBottomMargin(BOTTOM_MARGIN);
        textRenderer.setTopMargin(TOP_MARGIN);
        configurableCaptchaService.setTextRenderer(textRenderer);

        // 验证码图片的大小
        configurableCaptchaService.setWidth(width);
        configurableCaptchaService.setHeight(height);
    }

    /**
     * 输出
     */
    public void render() {
        ServletOutputStream outputStream = null;

        // 得到验证码对象,有验证码图片和验证码字符串
        Captcha captcha = configurableCaptchaService.getCaptcha();
        // 取得验证码字符串放入Session
        String captchaCode = captcha.getChallenge();

        //System.out.println(validationCode);
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute(AppConstants.CAPTCHA_NAME, EncriptionUtils.encrypt(captchaCode));
//    CookieUtils.addCookie(request, response, AppConstants.CAPTCHA_NAME, EncriptionUtils.encrypt(captchaCode), -1);
        // 取得验证码图片并输出
        BufferedImage bufferedImage = captcha.getImage();

        try {
            outputStream = response.getOutputStream();
            ImageIO.write(bufferedImage, "png", outputStream);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (outputStream != null)
                try {
                    outputStream.flush();
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }

    }

    /**
     * 验证码验证
     *
     * @param controller
     * @param inputCode
     * @return
     */
    public static boolean validate(Controller controller, String inputCode) {
        if (StrKit.isBlank(inputCode))
            return false;
        try {
            if (use_code) {
                inputCode = inputCode.toUpperCase();
                inputCode = EncriptionUtils.encrypt(inputCode);
                return inputCode.equals(controller.getCookie(AppConstants.CAPTCHA_NAME));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
