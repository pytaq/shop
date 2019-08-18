package com.hxzy.service.impl;

import com.hxzy.entity.DbColumn;
import com.hxzy.mapper.DataBaseMapper;
import com.hxzy.service.DataBaseService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DataBaseServiceImpl implements DataBaseService {

    @Autowired
    private DataBaseMapper dataBaseMapper;

    @Override
    public List<String> findAllTableNames(String dbName) {
        return this.dataBaseMapper.findAllTableNames(dbName);
    }

    @Override
    public String findTableDesc(String dbName, String tableName) {
        List<DbColumn> arrColumns=this.dataBaseMapper.findTableDesc(dbName,tableName);

        //策略算法
        if(arrColumns.size()==0){
            return "";
        }
        return createHtmlTable(tableName,arrColumns);
    }
        private String createHtmlTable(String tableName,List<DbColumn> columns){

        StringBuffer str=new StringBuffer();
        str.append("<div class=\"panel-heading\">");
            str.append("             <h3 class=\"panel-title\" id=\"tableName\">"+tableName+"</h3>");
            str.append("            </div>");
            str.append("       <div class=\"panel-body\" id=\"tableDesc\">");
            str.append("           <table id=\"tb\" class=\"table table-bordered\">");
            str.append("         <thead>");
            str.append("            <tr>");
            str.append("                <th>序号</th>");
            str.append("                <th>名</th>");
            str.append("                <th>类型</th>");
            str.append("                <th>允许为空</th>");
            str.append("                <th>主键</th>");
            str.append("                <th>注释</th>");
            str.append("           </tr>");
            str.append("           </thead>");

            int i=1;
            for (DbColumn  db : columns) {
                str.append("              <tr >");
                str.append("                <th scope=\"row\">"+(i++)+"</th>");
                str.append("                 <td>"+db.getColumnName()+"</td>");
                str.append("                 <td>"+db.getColumnType()+"</td>");

                String nullStrChecked="<input type=\"checkbox\"  checked >";
                if(db.getIsNullable().equals("NO")){
                    str.append("                 <td></td>");
                }else{
                    //允许为空
                    str.append("                 <td>").append(nullStrChecked).append("</td>");
                }
               //是否是主键
               boolean isPrim= StringUtils.isNotBlank(db.getColumnKey()) && db.getColumnKey().equals("PRI");
                if(isPrim){
                    str.append("                 <td>主键</td>");
                }else{
                    str.append("                 <td></td>");
                }
                //注解
                str.append("                  <td>"+db.getColumnComment()+"</td>");

                str.append("             </tr>");
            }

            str.append("       </table>");
            str.append("   </div>");

        return str.toString();
    }
}
