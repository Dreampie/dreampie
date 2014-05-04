package cn.dreampie.function.common;

import cn.dreampie.common.kit.sqlinxml.SqlKit;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-4-16.
 */
@TableBind(tableName = "com_state")
public class State extends Model<State> {
    public static State dao = new State();

    public List<State> findBy(String where, Object... paras) {
        List<State> result = (List<State>) dao.find(SqlKit.sql("state.findBy") + " " + where, paras);
        return result;
    }

    public State findByFirst(String where, Object... paras) {
        State result = (State) dao.findFirst(SqlKit.sql("state.findBy") + " " + where, paras);
        return result;
    }
}
