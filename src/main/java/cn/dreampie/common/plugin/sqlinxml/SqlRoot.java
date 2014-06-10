package cn.dreampie.common.plugin.sqlinxml;

import com.google.common.collect.Lists;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created by wangrenhui on 14-1-5.
 */
@XmlRootElement
public class SqlRoot {

    @XmlElement(name = "sqlGroup")
    List<SqlGroup> sqlGroups = Lists.newArrayList();

    void addSqlRoot(SqlGroup sqlGroup) {
        sqlGroups.add(sqlGroup);
    }
}
