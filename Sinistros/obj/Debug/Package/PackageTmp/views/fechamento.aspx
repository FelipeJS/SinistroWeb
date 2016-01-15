<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fechamento.aspx.cs" Inherits="Sinistros.views.Fechamento" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />

    <title>..:: SinistroWeb ::..</title>

    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    
    <!--[if IE 7]>
        <style type='text/css'>
            #textTop h2 {
                            display: block;
                            margin: 23px auto;
                        }
        </style>    
   <![endif]-->

    <script src="/Scripts/jquery/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-ui-1.9.1.custom.js" type="text/javascript"></script> 
    <script src="/Scripts/jquery/jquery-blockUI.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.notice.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-manager-error.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-timerpicker.js" type="text/javascript"></script>       
    <script src="/Scripts/commons.js" type="text/javascript"></script>

    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />

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
    
    <!--script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script-->
    
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnGerarXML').button({
                icons: {
                    primary: "ui-icon-gear"
                },
                text: true
            }).click(function () {
                GerarXML();
            });

            rangeDatepickerBR('#DtInicio', '#DtFim');
        });

        function GerarXML() {

            var isValid = true;

            if ($('#DtInicio').val() == '') {
                isValid = false;
                $('#DtInicio').mgrerror();
            }

            if ($('#DtFim').val() == '') {
                isValid = false;
                $('#DtFim').mgrerror();
            }

            if (isValid) {

                var dtInicio = $('#DtInicio').val();
                var dtFim = $('#DtFim').val();

                var formJson = { 'dtInicio': dtInicio,
                    'dtFim': dtFim
                };
            }
            else {
                growlError(MENSAGEM_REQUERIDO);
            }
        }

    </script>

</head>
<body>
    <div id="container">
        <!--div class="topo" id="topo" >     
            <p>&nbsp;&nbsp;&nbsp;<img src="../css/images/logo_qbe.jpg" /></p>
        </div-->  


        <div id="container_body">
         <div id="title">
            <h3>
                

            </h3>
         </div>

<div class="frame w450" style="margin-left:auto; margin-right:auto;">
    <h4>Período para emissão do XML</h4>

    <form id="form1" runat="server">
    <div>

<div class="frame" id="frmCadastroRO">
    <div class="cell">
        <label>Data Inicial</label>
        <input class="w70" id="DtInicio" name="DtInicio" type="text" value="" runat="server" />
    </div>
    <div class="cell">
        <label>Data Final</label>
        <input class="w70" id="DtFim" name="DtFim" type="text" value="" runat="server"/>
    </div>
    <div class="button-bar-inline">
        <asp:CheckBox ID="chkCongelarXML" runat="server" />
    </div>
    <div class="button-bar-inline">
        Congelar XML
    </div>
    <div class="clear"></div>
    <div class="cell">
        <asp:Button id="btnGerarXML" runat="server" Text="Gerar XML"  OnClick="btnGerarXML_Click" />
    </div>
    <div class="clear"></div>
</div>
    <div class="clear"></div>
    
    </div>
    </form>

</div>


        </div>
    </div>
    
</body>
</html>