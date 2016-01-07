<%@ WebHandler Language="C#" Class="GGL_List" %>

using System;
using System.Web;

public class GGL_List : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");

        int pageIdx = Convert.ToInt32(getArg("page", "1", context));
        int pageSize = 20;
        
    }
    
    private string getArg(string key,string val,HttpContext context){
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