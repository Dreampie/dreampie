package cn.dreampie.function.common;

import cn.dreampie.common.web.model.Model;
import com.jfinal.ext.plugin.tablebind.TableBind;

/**
 * Created by wangrenhui on 14-4-16.
 */
@TableBind(tableName = "com_state")
public class State extends Model<State> {
    public static State dao=new State();

}
