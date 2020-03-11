using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class kehuxg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string condi = Request["mas"].Trim();
        string s = new Class1().kehuxg(condi);
        Response.End();
    }
}