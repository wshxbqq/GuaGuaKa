<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="guaguale_ggl_admin_list" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <link href="../css/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <script src="../js/lib/jquery.js"></script>
    <script src="../js/lib/jquery.cookie.js"></script>
    <script src="../js/lib/mustache.js"></script>
    <script src="../js/lib/require.js"></script>
    <script src="../js/lib/underscore-min.js"></script>
    <link href="../css/admin_list.css" rel="stylesheet" />

</head>
<body runat="server">
    <div class="container">
         <h3 class="muted">刮刮乐-抽奖生成</h3>
        <button id="add" type="button" class="btn btn-large btn-success add_new">添加新活动</button>
        <table class="table table-striped">
              <thead>
                <tr>
                  <th>#</th>
                  <th>项目名称</th>
                  <th>UUID</th>
                  <th>创建时间</th>
                </tr>
              </thead>
              <tbody>
                 <%  for (int i = 0; i < list_gd.Count;i++ )
                     { %>
                      <tr>
                      <td><%=i.ToString() %></td>
                      <td><a href="modifly.aspx?p_uuid=<%=list_gd[i].p_uuid %>"><%=list_gd[i].p_name %></a></td>
                      <td><%=list_gd[i].p_uuid %></td>
                      <td><%=list_gd[i].p_time %></td>
                    </tr>

                  <%} %>
              </tbody>
            </table>
    </div>
    <script>

        $("#add").click(function () {
            location.href = "index.aspx";
        });
    </script>
</body>
</html>
