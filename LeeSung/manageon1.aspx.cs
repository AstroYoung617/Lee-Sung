using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class manageon1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sam = new Class1().managekehuck();
        Response.Write(sam);
        Response.End();
    }
}