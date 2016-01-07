using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class guaguale_ggl_admin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if(TextBox1.Text=="jdggl" && TextBox2.Text=="jdggl123"){
            Session["login"] = "1";
            Response.Redirect("list.aspx");
        }
    }
}