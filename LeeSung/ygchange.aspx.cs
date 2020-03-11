using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class ygchange : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string condi = Request["key"].Trim();
        Class1 myc = new Class1();
        string sa = myc.ygchange(condi);
            Response.Write(sa);
            Response.End();
        
    }
}