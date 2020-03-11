using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ygxgsc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string qm = Request["mas"].Trim();
        Class1 myc = new Class1();
        myc.noquery(qm);
        Response.Write(qm);
        Response.End();
    }
}