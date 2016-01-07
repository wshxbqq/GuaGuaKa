using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class guaguale_ggl_ggl : System.Web.UI.Page
{

 
    public string lose_img = "";
    public string bigimg = "";
    public string maskimg = "";
    public string isWin = "false";
    public string winUrl=   "";
    public string shopUUID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       
        
        string p_uuid = Request.QueryString["p_uuid"];
        DirectoryInfo di = new DirectoryInfo("D:/ggl/" + p_uuid);

        FileInfo fi = new FileInfo("D:/ggl/" + p_uuid + "/shop_uuid.txt");
        string uuid = fi.Name.Split('.')[0].Split('_')[1];
        shopUUID = File.ReadAllText(fi.FullName);

        if (File.Exists("D:/ggl/" + p_uuid + "/bgimg.jpg"))
        {
            bigimg = "/" + p_uuid + "/bgimg.jpg";
        }

        if (File.Exists("D:/ggl/" + p_uuid + "/mask.jpg"))
        {
            maskimg = "/" + p_uuid + "/mask.jpg";
        }
        if (File.Exists("D:/ggl/" + p_uuid + "/lose.jpg"))
        {
            lose_img = "/" + p_uuid + "/lose.jpg";
        }

 

        
    }

  
}