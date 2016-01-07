using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class guaguale_ggl_admin_modifly : System.Web.UI.Page
{
    public string p_uuid="";
    public string p_name="";
    public string jshop_url="";
    public string shop_uuid = "";

    public string bgimg = "";
    public string maskimg = "";
    public string loseimg = "";


    public struct prize_data
    {
        public string percent;
        public string url;
        public string img;
        public string uuid ;
        public string p_time;
    }
    public List<prize_data> list_gd = new List<prize_data>();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login"] == null)
        {
            Response.Redirect("login.aspx");
        }


        p_uuid = Request.QueryString["p_uuid"];
        DirectoryInfo di = new DirectoryInfo("D:/ggl/" + p_uuid);
        p_name = File.ReadAllText("D:/ggl/" + p_uuid + "/p_name.txt");
        if (File.Exists("D:/ggl/" + p_uuid + "/jshop_url.txt"))
        {
            jshop_url = File.ReadAllText("D:/ggl/" + p_uuid + "/jshop_url.txt");
        }




        shop_uuid = File.ReadAllText("D:/ggl/" + p_uuid + "/shop_uuid.txt");



        if (File.Exists("D:/ggl/" + p_uuid + "/bgimg.jpg"))
        {
            bgimg = "handle/GGL_ShowImg.ashx?path=D:/ggl/" + p_uuid + "/bgimg.jpg";
        }
        else {
            bgimg = "../ggl/img/bigbg.jpg";
        }

        if (File.Exists("D:/ggl/" + p_uuid + "/lose.jpg"))
        {
            loseimg = "handle/GGL_ShowImg.ashx?path=D:/ggl/" + p_uuid + "/lose.jpg";
        }
        else {
            loseimg = "../ggl/img/lose.jpg";
        }

        if (File.Exists("D:/ggl/" + p_uuid + "/mask.jpg"))
        {
            maskimg = "handle/GGL_ShowImg.ashx?path=D:/ggl/" + p_uuid + "/mask.jpg";
        }
        else {
            maskimg = "../ggl/img/mask.jpg";
        }
        


        DirectoryInfo di1 = new DirectoryInfo("D:/ggl/" + p_uuid);
        FileInfo[] fs = di1.GetFiles("percent_*.txt", SearchOption.TopDirectoryOnly);
        foreach (FileInfo fi in fs)
        {
            string uuid = fi.Name.Split('.')[0].Split('_')[1];
            prize_data pd=new prize_data();
            pd.img = "";
            if (File.Exists("D:/ggl/" + p_uuid + "/prize_" + uuid + ".jpg"))
            {
                pd.img = "D:/ggl/" + p_uuid + "/prize_" + uuid + ".jpg";
            }
            pd.percent = File.ReadAllText("D:/ggl/" + p_uuid + "/percent_" + uuid + ".txt");
            pd.url = File.ReadAllText("D:/ggl/" + p_uuid + "/url_" + uuid + ".txt");
            pd.uuid = uuid;

            pd.p_time = fi.LastWriteTime.ToString();

            list_gd.Add(pd);
        }
        list_gd.Sort(Compare);
        





    }

    public int Compare(prize_data x, prize_data y)
    {
        if (Convert.ToDateTime(x.p_time) > Convert.ToDateTime(y.p_time))
        {
            return 0;
        }
        return 1;
    }
}