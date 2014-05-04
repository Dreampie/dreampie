package cn.dreampie.common.config;

/**
 * Created by wangrenhui on 14-1-2.
 */
public enum ReTurnType {
  PAGE(0), JSON(1);
  private final int value;

  private ReTurnType(int value) {
    this.value = value;
  }

  public int value() {
    return this.value;
  }
}
