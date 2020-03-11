using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Class1 的摘要说明
/// </summary>
public class Class1
{
    public Class1()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    //此处定义连接串，以后所有程序可以共用，如果参数发生变化，只需要修改这里即可
    public string constr = "server=Localhost;database=Hotel;User ID=sa;pwd=sa;Trusted_Connection=no";

    public DataTable gettable(string sql)
    {

        SqlConnection cn = new SqlConnection(constr);
        cn.Open();
        DataSet ds = new DataSet();

        SqlDataAdapter myad = new SqlDataAdapter(sql, cn);
        myad.Fill(ds, "t1");
        cn.Close();
        return ds.Tables["t1"];
    }
    public void filltable(DataTable t, Table t0)
    {
        TableRow tr0 = new TableRow();
        for (int j = 0; j < t.Columns.Count; j++)
        {
            TableCell td0 = new TableCell(); td0.Text = t.Columns[j].Caption.ToString();
            tr0.Cells.Add(td0);
        }
        t0.Rows.Add(tr0);
        for (int k = 0; k < t.Rows.Count; k++)
        {
            TableRow tr = new TableRow();
            for (int a = 0; a < t.Columns.Count; a++)
            {
                TableCell td = new TableCell();
                td.Text = t.Rows[k][a].ToString();
                tr.Cells.Add(td);//把生成的单元格td加到行tr的单元格集合中

            }
            t0.Rows.Add(tr);
        }
    }
    public void filldrop(DataTable t, string colname, DropDownList L1)
    {
        L1.DataSource = t;
        L1.DataTextField = colname;
        L1.DataBind();
    }
    public void noquery(string sql)
    {
        SqlConnection cn = new SqlConnection(constr);
        cn.Open();
        SqlCommand cmd = new SqlCommand(sql, cn);
        cmd.ExecuteNonQuery();
        cn.Close();
        cmd.Clone();
    }
    public string ajaxreturn(string condition)//查看余房
    {
        string sql = "select 房号,是否入住,入住人数 from 入住数据表 where 是否入住 ="+condition;
        DataTable t = gettable(sql);
        //凑成文本返回
        string res = "房号,是否入住,入住人数";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string ajaxaddrzsj(string srm)//添加数据
    {
        string sql = "insert into 入住数据表(房号,日期,入住人姓名,入住人数,是否入住)values(" + srm + ")";
        Class1 na = new Class1();
        na.noquery(sql);
        return sql;
    }
    public string ajaxupper(string spm)
    {

        string sql = "update 入住数据表 set " + spm;
        Class1 ns = new Class1();
        ns.noquery(sql);
        return sql;
    }
    public string ajaxreturn2(string sqm)
    {
        string sql = "select * from 入住数据表 where " + sqm;
        DataTable t = gettable(sql);
        //凑成文本返回
        string res = "房号,日期,入住人姓名,入住人数,是否入住";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string kehuchange(string condi)
    {
        string sql = "select * from 客户表 where " + condi;
        DataTable t = gettable(sql);
        //凑成文本返回
        string res = "姓名,密码,性别,联系方式,身份证号码";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }

    public string kehuxg(string spm)
    {
        string sql = "update 客户表 set " + spm;
        Class1 ns = new Class1();
        ns.noquery(sql);
        return sql;
    }

    public string managekehuck()
    {
        string sql = "select * from 客户表";
        DataTable t = gettable(sql);
        string res = "姓名,密码,性别,联系方式,身份证号码";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string manageygck()
    {
        string sql = "select * from 员工表";
        DataTable t = gettable(sql);
        string res = "工号,部门号,密码,姓名,性别,身份证号码,联系方式,相片,家庭住址";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string manageglyck()//管理员信息查看
    {
        string sql = "select * from 管理员表";
        DataTable t = gettable(sql);
        string res = "工号,密码,姓名,性别,出生日期,身份证号码,联系方式,相片,家庭住址";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string ygchange(string spm)//员工查询
    {
        DataTable t = gettable(spm);
        string res = "工号,部门号,密码,姓名,性别,身份证号码,联系方式,家庭住址";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string glychange(string sql)//管理员查询
    {
        DataTable t = gettable(sql);
        string res = "工号,密码,姓名,性别,出生日期,身份证号码,联系方式,家庭住址";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            res = res + "|";
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
        }
        return res;
    }
    public string lookthrough(string sql)
    {
        DataTable t = gettable(sql);
        string res = "";
        for (int i = 0; i < t.Rows.Count; i++)
        {
            
            for (int j = 0; j < t.Columns.Count; j++)
            {
                res = res + t.Rows[i][j].ToString().Trim() + ",";
            }
            res = res + "|";
        }
        return res;
    }
}