using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class manageon2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string so = new Class1().manageglyck();
        Response.Write(so);
        Response.End();
    }
}