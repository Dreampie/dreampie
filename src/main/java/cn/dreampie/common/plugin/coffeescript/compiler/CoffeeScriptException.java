package cn.dreampie.common.plugin.coffeescript.compiler;

public class CoffeeScriptException extends RuntimeException {
    public CoffeeScriptException(String message) {
        super(message);
    }

    public CoffeeScriptException(String message, Throwable cause) {
        super(message, cause);
    }

    public CoffeeScriptException(Throwable cause) {
        super(cause);
    }
}
