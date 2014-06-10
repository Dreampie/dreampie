package cn.dreampie.common.plugin.patchca;

import cn.dreampie.common.plugin.patchca.background.BackgroundFactory;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * Created by wangrenhui on 13-12-31.
 */
class SimpleBackgroundFactory implements BackgroundFactory {
  private Random random = new Random();

  public void fillBackground(BufferedImage image) {
    Graphics2D graphics = (Graphics2D) image.getGraphics();

    // 验证码图片的宽高
    int imgWidth = image.getWidth();
    int imgHeight = image.getHeight();

    // 填充为白色背景
    graphics.setColor(Color.WHITE);
    graphics.fillRect(0, 0, imgWidth, imgHeight);

    // 画100个噪点(颜色及位置随机)
    for (int i = 0; i < 50; i++) {
      // 随机颜色
      // int rInt = random.nextInt(255);
      // int gInt = random.nextInt(255);
      // int bInt = random.nextInt(255);

      graphics.setColor(new Color(102, 102, 102));

      // 随机位置
      int xInt = random.nextInt(imgWidth - 3);
      int yInt = random.nextInt(imgHeight - 2);

      // 随机旋转角度
      int sAngleInt = random.nextInt(360);
      int eAngleInt = random.nextInt(360);

      // 随机大小
      int wInt = random.nextInt(6);
      int hInt = random.nextInt(6);

      graphics.fillArc(xInt, yInt, wInt, hInt, sAngleInt, eAngleInt);

      // 画5条干扰线
      // if (i % 20 == 0) {
      // int xInt2 = random.nextInt(imgWidth);
      // int yInt2 = random.nextInt(imgHeight);
      // graphics.drawLine(xInt, yInt, xInt2, yInt2);
      // }
    }
    graphics.setRenderingHints(new RenderingHints(
        RenderingHints.KEY_ANTIALIASING,
        RenderingHints.VALUE_ANTIALIAS_ON));
    int cp = 4 + random.nextInt(3);
    int[] xPoints = new int[cp];
    int[] yPoints = new int[cp];
    imgWidth -= 10;
    for (int i = 0; i < cp; i++) {
      xPoints[i] = (int) ((int) 5 + (i * imgWidth) / (cp - 1));
      yPoints[i] = (int) (imgHeight * (random.nextDouble() * 0.5 + 0.2));
    }
    int subsections = 6;
    int[] xPointsSpline = new int[(cp - 1) * subsections];
    int[] yPointsSpline = new int[(cp - 1) * subsections];
    for (int i = 0; i < cp - 1; i++) {
      double x0 = i > 0 ? xPoints[i - 1] : 2 * xPoints[i]
          - xPoints[i + 1];
      double x1 = xPoints[i];
      double x2 = xPoints[i + 1];
      double x3 = (i + 2 < cp) ? xPoints[i + 2] : 2 * xPoints[i + 1]
          - xPoints[i];
      double y0 = i > 0 ? yPoints[i - 1] : 2 * yPoints[i]
          - yPoints[i + 1];
      double y1 = yPoints[i];
      double y2 = yPoints[i + 1];
      double y3 = (i + 2 < cp) ? yPoints[i + 2] : 2 * yPoints[i + 1]
          - yPoints[i];
      for (int j = 0; j < subsections; j++) {
        xPointsSpline[i * subsections + j] = (int) catmullRomSpline(
            x0, x1, x2, x3, 1.0 / subsections * j);
        yPointsSpline[i * subsections + j] = (int) catmullRomSpline(
            y0, y1, y2, y3, 1.0 / subsections * j);
      }
    }
    for (int i = 0; i < xPointsSpline.length - 1; i++) {
      //graphics.setColor(colorFactory.getColor(i));
      graphics.setColor(new Color(102, 102, 102));
      graphics.setStroke(new BasicStroke(0.2f + 2 * random
          .nextFloat()));
      graphics.drawLine(xPointsSpline[i], yPointsSpline[i],
          xPointsSpline[i + 1], yPointsSpline[i + 1]);
    }

  }

  private double hermiteSpline(double x1, double a1, double x2,
                               double a2, double t) {
    double t2 = t * t;
    double t3 = t2 * t;
    double b = -a2 - 2.0 * a1 - 3.0 * x1 + 3.0 * x2;
    double a = a2 + a1 + 2.0 * x1 - 2.0 * x2;
    return a * t3 + b * t2 + a1 * t + x1;
  }

  private double catmullRomSpline(double x0, double x1, double x2,
                                  double x3, double t) {
    double a1 = (x2 - x0) / 2;
    double a2 = (x3 - x1) / 2;
    return hermiteSpline(x1, a1, x2, a2, t);
  }
}