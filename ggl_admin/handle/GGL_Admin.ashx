<%@ WebHandler Language="C#" Class="GGL_Admin" %>

using System;
using System.Web;
using System.IO;

public class GGL_Admin : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        

        string uuid = getArg("uuid", "", context);
        //if (uuid=="")
        //{
        //    context.Response.Write("uuid can not be null");
        //    return;
            
        //}

        string action = getArg("action", "", context);
        string imgType = getArg("imgtype", "", context);

        string p_uuid = getArg("p_uuid", "", context);
 
        switch(action){
            case "addimg": addImg(uuid,imgType, context); break;
            case "del": del(p_uuid, uuid); break;
            case "addnew": addNewProject(p_uuid, context); break;
        }
 
    }

    public void addNewProject(string p_uuid, HttpContext context)
    {
        if (!Directory.Exists("D:/ggl"))
        {
            Directory.CreateDirectory("D:/ggl");

        }
        if (!Directory.Exists("D:/ggl/" + p_uuid))
        {
            Directory.CreateDirectory("D:/ggl/" + p_uuid);
        }
        File.WriteAllText("D:/ggl/" + p_uuid + "/p_name.txt", context.Request.Form["projectName"]);
        File.WriteAllText("D:/ggl/" + p_uuid + "/jshop_url.txt", context.Request.Form["jshopUrl"]);
        File.WriteAllText("D:/ggl/" + p_uuid + "/shop_uuid.txt", context.Request.Form["shopUUID"]);
 
    }

    public void addImg(string p_uuid,string imgType, HttpContext context)
    {
        if(!Directory.Exists("D:/ggl")){
            Directory.CreateDirectory("D:/ggl");
           
        }
        if (!Directory.Exists("D:/ggl/" + p_uuid))
        {
            Directory.CreateDirectory("D:/ggl/" + p_uuid);
        }
        
        HttpPostedFile file=context.Request.Files[0];
        string path = "D:/ggl/" + p_uuid + "/" + imgType + ".jpg";
        file.SaveAs(path);
        context.Response.Write(path);
    
    }


    public void del(string p_uuid,string uuid)
    {
        string img = "D:/ggl/" + p_uuid + "/prize_" + uuid + ".jpg";
        string percent = "D:/ggl/" + p_uuid + "/percent_" + uuid + ".txt";
        string url = "D:/ggl/" + p_uuid + "/url_" + uuid + ".txt";

        if (File.Exists(img))
        {
            File.Delete(img);
        }
        if (File.Exists(percent))
        {
            File.Delete(percent);
        }
        if (File.Exists(url))
        {
            File.Delete(url);
        }
    
    }
    
    private string getArg(string key, string val, HttpContext context)
    {
        if (context.Request.Params[key] != null)
        {
            return context.Request.Params[key];
        }
        return val;

    }

    public void createHTML(string p_uuid) { 
        
    
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}