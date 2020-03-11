using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class kehuchange : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string condi = Request["key"].Trim();
        Class1 myc1 = new Class1();

        DataTable t = myc1.gettable("select count(*)  from 客户表 where " + condi);
        if (t.Rows[0][0].ToString() == "0")
        {
            Response.Write("查无此人！");
            Response.End();
        }
        else
        {
            Class1 myc = new Class1();
            string sa = myc.kehuchange(condi);
            Response.Write(sa);
            Response.End();
        }
    }
}