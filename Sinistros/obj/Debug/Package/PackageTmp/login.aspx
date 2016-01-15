<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Sinistros.login" %>

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
    <script src="/Scripts/commons.js" type="text/javascript"></script>
    
    <!--script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script-->
    
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnEntrar').button({
                icons: {
                    primary: "ui-icon-key"
                },
                text: true
            }).click(function () {
//                ValidarUsuario();
            });
        });

        function ValidarUsuario() {
            var isValid = true;

            if ($('#Descricao').val() == '') {
                isValid = false;
                $('#Descricao').mgrerror();
            }

            if ($('#Senha').val() == '') {
                isValid = false;
                $('#Senha').mgrerror();
            }

            if (isValid) {
                var formJson = { Descricao: $('#Descricao').val(),
                    Senha: $('#Senha').val()
                };

                $.ajax({
                    url: "/Login?usuario=" + $('#Descricao').val() + '$' + $('#Senha').val(),
                    type: "get",
                    global: false,
                    dataType: "json",
                    data: JSON.stringify(formJson),
                    contentType: "application/json; charset=utf-8;",
                    async: false,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        //                        alert(err.ExceptionMessage);

                        trataMensagemRetorno(err.ExceptionMessage);
                        $('#Senha').val('');

                        isValid = false;

                        growlError(err.ExceptionMessage);

                    },
                    success: function (data) {
                        if (data.Tipo != '0') {
                            $(location).attr('href', '/');
                        }
                        else {
                            trataMensagemRetorno(data);
                            $('#Senha').val('');
                        }
                    }
                });
            }
            else {
                growlError(MENSAGEM_REQUERIDO);

            }

            return isValid;
        }

    </script>

</head>
<body>
    <div id="container">
        <div class="topo" id="topo" >    
            <p>&nbsp;&nbsp;&nbsp;<img src="css/images/logo_qbe.jpg" /></p>
        </div>  

<div id="infoTop" class="left" align="right" style="float:right"><p style="color:Black">Versão: 2.9.0</p></div>

        <div id="container_body">
         <div id="title">
            <h3>
                

            </h3>
         </div>

    <form id="Login" method="post" runat="server" onsubmit="return ValidarUsuario();">

        <asp:HiddenField ID="contaTentativa" runat="server" />

<div class="frame w250" style="margin-left:auto; margin-right:auto;">
    <h4>Dados Usuário</h4>
    <div class="cell">
        <label for="Descricao">Usuário</label>
        <input class="w200" id="Descricao" name="Descricao" type="text" value="" runat="server" />
    </div>
    <div class="clear"></div>
    <div class="cell">
        <label for="Senha">Senha</label>
        <input class="w200" id="Senha" name="Senha" type="password" value="" runat="server" />
    </div>
    <div class="clear"></div>
    <div class="cell">
        <asp:Button ID="btnEntrar" Runat="server" Text="Entrar" OnClick="Login_Click"></asp:Button>
        <!--button type="button" id="btnEntrar">
            <span>Entrar</span>
        </button-->
    </div>
    <div class="clear"></div>
</div>

    </form>	

        </div>
    </div>
    
</body>
</html>