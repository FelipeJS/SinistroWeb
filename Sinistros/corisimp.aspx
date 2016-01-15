<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="corisimp.aspx.cs" Inherits="Sinistros.corisimp" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head2" runat="server">
    <title>Importar Arquivo Coris - Open Cases</title>

    <style type="text/css">
        .gvCSVData
        {
            font-family: Verdana;
            font-size: 10pt;
            font-weight: normal;
            color: black;
        }
    </style>

    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="/Content/Site.css" rel="stylesheet" type="text/css" />


    <script src="/Scripts/jquery/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.wizard.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-percent.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-blockUI.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.notice.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.qtip.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-ui-1.9.1.custom.js" type="text/javascript"></script> 
    <script src="/Scripts/jquery/jquery-timerpicker.js" type="text/javascript"></script>       
    <script src="/Scripts/jquery/jquery.form.json.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-manager-error.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.decimalMask.js" type="text/javascript"></script>
    <script src="/Scripts/grid.js" type="text/javascript"></script>
    <script src="/Scripts/json2.js" type="text/javascript"></script>
    <script src="/Scripts/menu.js" type="text/javascript"></script>
    <script src="/Scripts/commons.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.maskedinput-1.2.2.js" type="text/javascript"></script>
    

    <script src="/Scripts/FileUpload/tmpl.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/canvas-to-blob.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/load-image.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ip.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ui.js" type="text/javascript" charset="ISO88591"></script>
    <script src="/Scripts/FileUpload/main.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/locale.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $('#FileUploadControl').file({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })

            $('#btCSVUpload').submit({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <div id="container">
        <div id="container_body">

         <div id="title">
            <h3>
            Importar Arquivo Coris - Open Cases
            
            </h3>
         </div>

        <table>
            <tr>
                <td>
                    <asp:FileUpload ID="FileUploadControl" runat="server" />
                    <asp:Button runat="server" ID="btCSVUpload" Text="Importar Arquivo"
        OnClick="btCSVUpload_Click" />
        <br />
        <br />
        <br />
                    <asp:Label runat="server" ID="lbStatus" ForeColor=Red
Text="Status: Selecione o arquivo" />
                                <asp:Button runat="server" ID="btProcessar" Text="Processar Arquivo"
        OnClick="btProcessar_Click" Visible="false" />
        <br />
        <br />
        <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvCSVData" CssClass="gvCSVData" runat="server"
AutoGenerateColumns="True" HeaderStyle-BackColor="#61A6F8"
  HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White">
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>

        </table>
    </div>
    </div>
    </form>
</body>
</html>