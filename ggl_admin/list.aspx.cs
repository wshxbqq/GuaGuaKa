using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class guaguale_ggl_admin_list : System.Web.UI.Page
{
    public struct ggl_data {
        public string p_name;
        public string p_uuid;
        public string p_time;
   
    }
    public List<ggl_data> list_gd = new List<ggl_data>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
        {
            Response.Redirect("login.aspx");
        }

        if (!Directory.Exists("D:/ggl/"))
        {
            Directory.CreateDirectory("D:/ggl/");
        }
        DirectoryInfo di = new DirectoryInfo("D:/ggl/");
        DirectoryInfo[] ds = di.GetDirectories("*",SearchOption.TopDirectoryOnly);
        foreach (DirectoryInfo d in ds)
        {
            if(d.GetFiles("p_name.txt").Length>0){
                 ggl_data gd = new ggl_data();
                gd.p_uuid = d.Name;
                gd.p_name = File.ReadAllText(d.GetFiles("p_name.txt")[0].FullName);
                gd.p_time = d.GetFiles("p_name.txt")[0].CreationTime.ToString();

                list_gd.Add(gd);
            }
           
        }

        list_gd.Sort(Compare);

    }

    public int Compare(ggl_data x, ggl_data y)
    {
        if (Convert.ToDateTime(x.p_time) > Convert.ToDateTime(y.p_time))
        {
            return 1;
        }
        return 0;
    }
}