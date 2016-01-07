using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class guaguale_ggl_admin_index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string uuid = Request.QueryString["uuid"];
        if(Session["login"]==null){
            Response.Redirect("login.aspx");
        }

    }
}