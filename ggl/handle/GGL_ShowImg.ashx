<%@ WebHandler Language="C#" Class="GGL_ShowImg" %>

using System;
using System.Web;

public class GGL_ShowImg : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string filePath = getArg("path", "", context);
        filePath = "D:/ggl/" + filePath;
        context.Response.ContentType = "image/jpeg";
        System.Drawing.Image img = System.Drawing.Bitmap.FromFile(filePath);
        
        img.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
        img.Dispose();
        
    }
    
    private string getArg(string key, string val, HttpContext context)
    {
        if (context.Request.Params[key] != null)
        {
            return context.Request.Params[key];
        }
        return val;

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}