<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="docImp.aspx.cs" Inherits="Sinistros.docImp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

        <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="/Content/Site.css" rel="stylesheet" type="text/css" />

    <link href="css/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="Scripts/kissy-min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>

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

            try {
                document.getElementById("txtIdSinistro").value = parent.parent.document.getElementById('FormView1_TextBox1').value;
            }
            catch (err) {
                document.getElementById("txtIdSinistro").value = 47156;
            }


            $('#btSalvar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $('#btCancelar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $('#FileUploadControl').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $("#FileUploadControl").change(function () {
                readURL(this);
            });

            $('#btCancelar').click(function () {
                parent.parent.document.getElementById("overlay").style.display = "none";
                parent.parent.document.getElementById("docUpload").style.display = "none";
                if (document.getElementById("btCancelar").value == "Fechar") {
                    parent.parent.CarregarGridArquivos();
                };
            })

        });


        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

</head>
<body style="height:auto; width:auto; background-color:#ffffff">
    <form id="form1" runat="server">

        <asp:HiddenField runat="server" ID="txtIdSinistro" />

        <table width="100%">
            <tr>
                <td width="1100px">
                    <asp:FileUpload ID="FileUploadControl" runat="server" Width="60%" style="padding:0" />
                    Descrição: <asp:TextBox runat="server" ID="txtDescricao" Width="200px" />
                    <asp:Button runat="server" ID="btSalvar" Text="Salvar" OnClick="btDocUpload_Click" Height="25px" />
                    <asp:Button runat="server" ID="btCancelar" Text="Cancelar"  Height="25px"/>
                </td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label runat="server" ID="lbStatus" Text="Status: Selecione o arquivo" />
                    <br />
                    <img id="blah" runat="server" src="#" alt="imagem" />
                </td>
            </tr>
        </table>
    </form>

</body>
</html>
