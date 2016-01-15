<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="acesso.aspx.cs" Inherits="Sinistros.acesso" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <title>..:: SinistroWeb ::..</title>

    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="/Content/kendo/2013.3.1119/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="/Content/kendo/2013.3.1119/kendo.default.min.css" rel="stylesheet" type="text/css" />
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
    <script src="js/accounting.min.js" type="text/javascript"></script>

    <script src="/Scripts/FileUpload/tmpl.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/canvas-to-blob.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/load-image.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ip.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ui.js" type="text/javascript" charset="ISO88591"></script>
    <script src="/Scripts/FileUpload/main.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/locale.js" type="text/javascript"></script>
    <script src="Scripts/kendo/2013.3.1119/kendo.web.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            $("#accordion").accordion();
        });
    </script>
    <script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);
    </script>

    <style type="text/css">
        body {
	       font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
	       font-size: 62.5%;
        }      
    </style>
   
    <script type="text/javascript">
        $(document).ready(function () {
            datepickerBR('#txtDataCadastro');
            $('#txtHonorarios').maskMoney({ precision: 2 });
            $('#txtDespesas').maskMoney({ precision: 2 });
            $('#txtIndenizacao').maskMoney({ precision: 2 });

            $('#btnSairSistema').button({
                icons: {
                    primary: "ui-icon-key"
                },
                text: true
            })
            .click(function () {

                $.ajax({
                    type: "get",
                    contentType: "application/json",
                    url: "login",
                    data: "{}",
                    dataType: 'json',
                    success: function (result) {
                        //add data
                        $(location).attr('href', "login.aspx");
                    }
                });
            });

            $('#btnPesquisarUsuario').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                
            });
        
            $('#btnGravarUsuario').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "post",
                    url: "usuario?nomeLogin=" + document.getElementById('txtLogin').value + '$' +
                                              document.getElementById('selectPerfil').value + '$' +
                                              document.getElementById('txtNome').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');
                    }
                });
            });
            
            $('#btnGravarEmail').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "post",
                    url: "usuario?emailMatricula=" + document.getElementById('txtEmail').value + '$' +
                                                    document.getElementById('txtEmail').value + '$' +
                                                    document.getElementById('txtMatricula').value + '$' +
                                                    document.getElementById('txtSenha').value + '$' +
                                                    document.getElementById('selectReinicia').value + '$' +
                                                    document.getElementById('selectVigente').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');
                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.DS_EMAIL, item.DS_MATRICULA, item.DS_SENHA, item.FL_VIGENTE, item.FL_REINICIA_SENHA, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexUsuarios").flexAddData(pessoas);
                    }
                });
            });

            $('#btnGravarTelefone').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "get",
                    url: "usuario?foneRamal=" + document.getElementById('txtFoneRamal').value + '$' +
                                              document.getElementById('txtFoneRamal').value + '$' +
                                              document.getElementById('txtDataCadastro').value + '$' +
                                              document.getElementById('txtTipoUsuario').value + '$' +
                                              document.getElementById('txtNivel').value + '$' +
                                              document.getElementById('txtStatus').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');
                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.DS_FONE_RAMAL, item.DT_CADASTRO, item.TP_USUARIO, item.VL_NIVEL, item.CD_STATUS, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexUsuarios").flexAddData(pessoas);
                    }
                });
            });

            $('#btnGravarValores').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "get",
                    url: "usuario?valores=" + document.getElementById('txtIdUsuario').value + '$' +
                                              document.getElementById('txtUsuarioPai').value + '$' +
                                              document.getElementById('txtIndenizacao').value + '$' +
                                              document.getElementById('txtHonorarios').value + '$' +
                                              document.getElementById('txtDespesas').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');
                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.ID_USUARIO_PAI, item.VL_TOPE_INDENIZACAO, item.VL_TOPE_HONORARIOS, item.VL_TOPE_HONORARIOS, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexUsuarios").flexAddData(pessoas);
                    }
                });
            });

            $('#btnAdicionarEmail').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

            });

            $('#btnAdicionarRamal').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

            });

            $('#btnAdicionarIndenizacao').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

            });

            $('#btnLimparUsuario, #btnFecharUsuario').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                Usuario.style.display = 'none';
            });

            $('#btnCadastroUsuario').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                Usuario.style.display = 'block';

                $("#flexUsuarios").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'ID', name: 'ID_USUARIO', width: 41, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Login', name: 'CD_LOGIN', width: 75, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Perfil Usuário', name: 'DS_PERFIL', width: 180, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Nome', name: 'DS_USUARIO', width: 300, sortable: true, align: 'left', process: abrirPessoa }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

                $("#flexDocumentos").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'Email', name: 'DS_EMAIL', width: 200, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Matrícula', name: 'DS_MATRICULA', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Vigente', name: 'FL_VIGENTE', width: 60, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

                $("#flexEnderecos").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'Fone/Ramal', name: 'DS_FONE_RAMAL', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Data de Cadastro', name: 'DT_CADASTRO', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Tipo', name: 'TP_USUARIO', width: 50, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Nível', name: 'VL_NIVEL', width: 50, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Status', name: 'CD_STATUS', width: 50, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

                $("#flexContas").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'Id Usuário Pai', name: 'ID_USUARIO_PAI', width: 70, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Indenização', name: 'VL_TOPE_INDENIZACAO', width: 120, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Despesas', name: 'VL_TOPE_DESPESAS', width: 120, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Honorários', name: 'VL_TOPE_HONORARIOS', width: 120, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });
            });

            
            function formatResults(Beneficiario) {
                var rows = Array();

                for (i = 0; i < Beneficiario.length; i++) {
                    var item = Beneficiario[i];
                    rows.push({ cell: [item.ID_BENEFICIARIO, item.DS_PESSOA, item.TP_PARENTESCO, item.VL_PARTICIPACAO, ''] });
                }
                return { total: Beneficiario.length, page: 1, rows: rows }
            }

            function abrirBeneficiario() {
            }

            function abrirPessoa(celDiv, id) {
                if (celDiv.outerHTML.toLowerCase().indexOf('width: 41px') > 0) {
                    nId = celDiv.innerHTML;
                }
                celDiv.dataFld = nId;
                $(celDiv).dblclick(function () {

                    document.getElementById('txtIdPessoa').value = this.dataFld;

                    $.ajax({
                        type: "get",
                        url: "pessoa/" + this.dataFld,
                        success: function (result) {
                            $("#flexUsuarios").flexAddData([]);
                            document.getElementById('txtNomePessoa').value = result[0].DS_PESSOA;
                        }
                    });

                    $.ajax({
                        type: "get",
                        url: "pessoa?doctos=" + this.dataFld,
                        success: function (result) {

                            var rows = Array();

                            for (i = 0; i < result.length; i++) {
                                var item = result[i];
                                rows.push({ cell: [item.DS_EMAIL, item.DS_MATRICULA, ''] });
                            }
                            pessoas = { total: result.length, page: 1, rows: rows }

                            $("#flexDocumentos").flexAddData(pessoas);

                        }
                    });

                    $.ajax({
                        type: "get",
                        url: "pessoa?enderecos=" + this.dataFld,
                        success: function (result) {
                            var rows = Array();

                            for (i = 0; i < result.length; i++) {
                                var item = result[i];
                                rows.push({ cell: [item.DS_FONE_RAMAL, item.DT_CADASTRO, item.TP_USUARIO, item.VL_NIVEL, item.CD_STATUS, ''] });
                            }
                            pessoas = { total: result.length, page: 1, rows: rows }

                            $("#flexEnderecos").flexAddData(pessoas);

                        }
                    });

                    $.ajax({
                        type: "get",
                        url: "pessoa?contas=" + this.dataFld,
                        success: function (result) {
                            var rows = Array();

                            for (i = 0; i < result.length; i++) {
                                var item = result[i];
                                rows.push({ cell: [item.TP_CONTA, item.NRO_CONTA, item.DV_CONTA, item.DS_BANCO, item.CD_AGENCIA, item.DV_AGENCIA, item.FL_CONTA_PRINCIPAL, ''] });
                            }
                            pessoas = { total: result.length, page: 1, rows: rows }

                            $("#flexContas").flexAddData(pessoas);

                        }
                    });
                });
            }

            function retira_acentos(palavra) {
                com_acento = 'áàãâäéèêëíìîïóòõôöúùûüçÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÖÔÚÙÛÜÇ';
                sem_acento = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
                nova = '';
                for (i = 0; i < palavra.length; i++) {
                    if (com_acento.search(palavra.substr(i, 1)) >= 0) {
                        nova += sem_acento.substr(com_acento.search(palavra.substr(i, 1)), 1);
                    } else {
                        nova += palavra.substr(i, 1);
                    }
                } return nova;
            }

            //function atualizarGridUsuarios(idUsuario) {
            //    $.ajax({
            //        type: "get",
            //        url: "usuario?idUsuario=" + idUsuario,
            //        error: function (xhr, status, error) {
            //            var err = eval("(" + xhr.responseText + ")");
            //            alert(err.ExceptionMessage);
            //        },
            //        success: function (result) {
            //            alert('Atualizei.');
            //            var rows = Array();

            //            for (i = 0; i < result.length; i++) {
            //                var item = result[i];
            //                rows.push({ cell: [item.ID_USUARIO, item.DS_PERFIL, item.CD_LOGIN, item.DS_USUARIO, ''] });
            //            }
            //            usuarios = { total: result.length, page: 1, rows: rows }

            //            $("#flexUsuarios").flexAddData(usuarios);
            //        }
            //    });
            //}
        });
    </script>
</head>
<body>
    <div id="container">
        <div class="topo" id="topo" >
            <br />
            &nbsp;&nbsp;&nbsp;<img src="css/images/logo_qbe.jpg" />
        </div>  

        <div id="container_body">

             <div id="title" style="text-align:center">
                <h3 style="text-align:center">Administração de Usuários do Sistema</h3>
             </div>

            <div id="divSairSistema" style="float:right;visibility:hidden">
                <button type="button" id="btnSairSistema" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false"><span class="ui-button-icon-primary ui-icon ui-icon-power"></span><span class="ui-button-text">Sair</span></button>
            </div>

    <form id="form1" runat="server">
        <div id="accordion" style="padding-left:50px; padding-bottom:50px; padding-top:30px; padding-right:50px" >
            <h3 style="text-align:center;">Usuários</h3>
            
            <div>
                <button type="button" id="btnCadastroUsuario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cadastrar Novo Usuário</button>

                <div style="height:400px">
                <asp:GridView ID="UsuarioGridView" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="id_usuario" BackColor="White" BorderColor="Black" 
                            BorderStyle="Solid" BorderWidth="1px" CellPadding="2" GridLines="Both" 
                            onrowediting="UsuarioGridView_RowEditing"
                            onrowcancelingedit="UsuarioGridView_RowCancelingEdit" 
                            onrowupdating="UsuarioGridView_RowUpdating">
       
                <AlternatingRowStyle BackColor="#DCDCDC" />
       
                <Columns>

                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>    <%#Eval("id_usuario") + "  ."%>    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nome">
                    <ItemTemplate>    <%#Eval("ds_usuario") %>    </ItemTemplate>
                </asp:TemplateField>    

                <asp:TemplateField HeaderText="Perfil">
                    <ItemTemplate>    <%#Eval("ds_perfil") %>    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="cboPerfil" runat="server" Text='<%#Eval("ds_perfil") %>'>
                            <asp:ListItem value="Analista Sinistros" >Analista Sinistros</asp:ListItem>    
                            <asp:ListItem value="Juridico" >Juridico</asp:ListItem>    
                            <asp:ListItem value="Juridico Assistente" >Juridico Assistente</asp:ListItem>    
                            <asp:ListItem value="Admin" >Admin</asp:ListItem>    
                            <asp:ListItem value="Admin - Sistemas" >Admin - Sistemas</asp:ListItem>    
                            <asp:ListItem value="Gerente Sinistros" >Gerente Sinistros</asp:ListItem>    
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

               <asp:TemplateField HeaderText="Topo Indenização" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>    <%#Eval("vl_tope_indenizacao", "{0:c}")%>    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtIndenizacao" Width="70" runat="server" Text='<%#Eval("vl_tope_indenizacao") %>'></asp:TextBox>
                    </EditItemTemplate>
               </asp:TemplateField>

               <asp:TemplateField HeaderText="Topo Despesas" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>    <%#Eval("vl_tope_despesas", "{0:c}")%>    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtemail2" Width="70" runat="server" Text='<%#Eval("vl_tope_despesas") %>'></asp:TextBox>
                    </EditItemTemplate>
               </asp:TemplateField>

               <asp:TemplateField HeaderText="Topo Honorários" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>    <%#Eval("vl_tope_honorarios", "{0:c}")%>    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtemail3" Width="70" runat="server" Text='<%#Eval("vl_tope_honorarios") %>'></asp:TextBox>
                    </EditItemTemplate>
               </asp:TemplateField>

               <asp:TemplateField HeaderText="Vigente">
                    <ItemTemplate>    <%#Eval("bl_vigente") %>    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkVigente" runat="server" ></asp:CheckBox>
                    </EditItemTemplate>
               </asp:TemplateField>

               <asp:TemplateField HeaderText="Tipo Login">
                    <ItemTemplate>    <%#Eval("fl_login") %>    </ItemTemplate>
               </asp:TemplateField>

               <asp:CommandField ShowEditButton="true" ButtonType="Image" EditText="Editar" 
                                EditImageUrl="Content/images/editar.png" 
                                UpdateImageUrl="Content/images/confirmar.png"
                                CancelImageUrl="Content/images/icone-excluir.gif" HeaderText="Editar" />
                
                </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle Height="30px" BackColor="#DDEEF9" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="Black" Font-Bold="false" />
            </asp:GridView>
        </div>
    </div>
  
  <h3 style="text-align:center;">Perfís de Acesso</h3>
  <div>
    <table border="1px" cellpadding="0" cellspacing="0" style="margin-left:auto; margin-right:auto;">
    <thead><tr class="ui-state-default_gray"><th width="130px" align="center">Perfil</th>
                                             <!--<th width="120px" align="center">Gerar OP</th>
                                             <th width="120px" align="center">Autorizar OP</th>
                                             <th width="120px" align="center">Admistrar Usuários</th>
                                             <th width="120px" align="center">Pagnet</th>
                                             <th width="120px" align="center">Novo Sinistro</th>
                                             <th width="120px" align="center">Ajustar/Reabrir Reserva</th>
                                             --><th width="120px" align="center">Valor Fixo Abertura de Sinistros</th>
           </tr></thead>
    <tbody>
        <tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Analista Sinistros</span></div></td>
            <!--<td><div class="cell" style="padding-left:50px"><input runat="server" id="chk1" type="checkbox" name="1" value="1" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input runat="server" id="chk2" type="checkbox" name="1" value="2"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="1" value="3"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="1" value="4"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="1" value="5" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="1" value="6" checked="checked"/></div></td>
            --><td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="R$ 700,00" readonly="readonly"></div></td></tr>
        <tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Controladoria</span></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="R$ 700,00" readonly="readonly"></div></td></tr>
        <tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Jurídico</span></div></td>
            <!--<td><div class="cell" style="padding-left:50px"><input type="checkbox" name="2" value="1" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="2" value="2"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="2" value="3"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="2" value="4"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="2" value="5"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="2" value="6" checked="checked"/></div></td>
            --><td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="R$ 1000,00" readonly="readonly"></div></td></tr>
        <tr><td><div class="cell w130"><span style="font-size:11px; font-style:normal; font-weight:100;">Jurídico Assistente</span></div></td>
            <!--<td><div class="cell" style="padding-left:50px"><input type="checkbox" name="3" value="1"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="3" value="2"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="3" value="3"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="3" value="4"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="3" value="5"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="3" value="6"/ checked="checked"></div></td>
            --><td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="R$ 700,00" readonly="readonly"></div></td></tr>
        <!--<tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Admin</span></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="4" value="1" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="4" value="2" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="4" value="3" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="4" value="4" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="4" value="5" checked="checked"/></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="4" value="6"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="" readonly="readonly"></div></td></tr>-->
        <!--<tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Admin Sistemas</span></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="5" value="1"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="5" value="2"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="5" value="3"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="5" value="4"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="5" value="5"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="5" value="6"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="" readonly="readonly"></div></td></tr>-->
        <tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Gerente Sinistros</span></div></td>
            <!--<td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="1"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="2"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="3"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="4"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="5"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="6"/ checked="checked"></div></td>
            --><td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="R$ 1000,00" readonly="readonly"></div></td></tr>
        <tr><td><div class="cell w100"><span style="font-size:11px; font-style:normal; font-weight:100;">Abertura de Sinistro - CONECTA</span></div></td>
            <!--<td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="1"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="2"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="3"/ ></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="4"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="5"/ checked="checked"></div></td>
            <td><div class="cell" style="padding-left:50px"><input type="checkbox" name="6" value="6"/ checked="checked"></div></td>
            --><td><div class="cell" style="padding-left:50px"><input type="text" name="6" style="text-align:right" value="R$ 300,00" readonly="readonly"></div></td></tr>
        </tbody>
    </table>      
    <br />
    <!--<div id="div1" style="float:right">
        <button type="button" id="btnCancelar" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false"><span class="ui-button-icon-primary ui-icon ui-icon-power"></span><span class="ui-button-text">Cancelar</span></button>
        <button type="button" id="btnSalvar" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false"><span class="ui-button-icon-primary ui-icon ui-icon-power"></span><span class="ui-button-text">Salvar</span></button>
    </div>-->
    </div>
   </div>
  </form> 
 </div>
</div>
    
    <div id="Usuario" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1003; height: 550px; width: 965px; top: 95px; left: 198px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Cadastro de Usuários </div>
            <div id="Div2" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 600px;" scrolltop="0" scrollleft="0">
                
                
                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Login </label>
                    <input id="txtLogin" onkeyup="this.value=retira_acentos(this.value);" style="width: 70px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit">Perfil de Acesso</label>
                    <select id="selectPerfil">
                        <%--<option value="0">Admin</option>
                        <option value="1">Admin - Sistemas</option>--%>
                        <option value="2">Análista Sinistros</option>
                        <option value="3">Jurídico</option>
                        <option value="4">Jurídico Assistente</option>
                        <option value="23">Gerente Sinistros</option>
                        <option value="43">Controladoria</option>
                        <%--<option value="63">Consulta</option>
                        <option value="64">Abertura de Sinistro</option>--%>
                        <option value="65">Abertura de Sinistro - CONECTA</option>
                    </select>
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit">Nome</label>
                    <input id="txtNome" onkeyup="this.value=retira_acentos(this.value);" style="width: 240px;" type="text" />
                </div>

                <div class="button-bar-inline">
                    <button type="button" id="btnPesquisarUsuario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary">Pesquisar</button>
                    <button type="button" id="btnLimparUsuario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary">Limpar</button>
                    <button type="button" id="btnGravarUsuario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary">Gravar</button>
                    <button type="button" id="btnFecharUsuario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary">Fechar</button>
                </div>

                <div class="clear"></div>

                <%--<div id="usuariosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexUsuarios"> </table></div>--%>
                <hr/>

                <div class="clear"></div>
                
                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Email </label>
                    <input id="txtEmail" onkeyup="this.value=retira_acentos(this.value);" style="width: 200px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Matricula </label>
                    <input id="txtMatricula" onkeyup="this.value=retira_acentos(this.value);" style="width: 120px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Senha </label>
                    <input id="txtSenha" style="width: 70px; height:17.5px; margin-top:2px;" type="password" />
                </div>

                <div class="cell-wizard">
                   <label for="Itens_DsObjSeguradoEdit">Reiniciar Senha</label>
                   <select id="selectReiniciaSenha">
                       <option value="1">Sim</option>
                       <option value="0">Não</option>
                   </select>
                </div>

                <div class="cell-wizard">
                   <label for="Itens_DsObjSeguradoEdit">Vigente</label>
                   <select id="selectVigente">
                       <option value="1">Sim</option>
                       <option value="0">Não</option>
                   </select>
            </div>
                <div class="button-bar-inline">
                    <button type="button" id="btnAdicionarEmail" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary">Adicionar</button>
                </div>

            <div class="clear"></div>
            <div id="documentosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexDocumentos"> </table></div>

            <div class="clear"></div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Fone/Ramal </label>
                    <input id="txtRamal" style="width: 100px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Data de Cadastro </label>
                    <input id="txtDataCadastro" value='<%# Eval("DT_CADASTRO") %>' style="width: 100px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                   <label for="Itens_DsObjSeguradoEdit">Tipo</label>
                   <select id="selectTipoUsuario">
                       <option value=""></option>
                       <option value="D">D</option>
                       <option value="T">T</option>
                       <option value="C">C</option>
                       <option value="T">F</option>
                       <option value="T">L</option>
                   </select>
                </div>

                <div class="cell-wizard">
                   <label for="Itens_DsObjSeguradoEdit">Nível</label>
                   <select id="selectNivel">
                       <option value=""></option>
                       <option value="0">0</option>
                       <option value="1">1</option>
                       <option value="2">2</option>
                       <option value="3">3</option>
                       <option value="4">4</option>
                   </select>
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit">Status</label>
                    <select id="selectStatus">
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="E">E</option>
                    </select>
                </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarRamal" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>

            <div class="clear"></div>
            <div id="enderecosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexEnderecos"> </table></div>
            
                <div class="clear"></div>
                
                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> ID Usuário Pai </label>
                    <input id="txtIdUsuarioPai" style="width: 60px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Valor Indenização </label>
                    <input id="txtIndenizacao" style="width: 100px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Valor Despesas </label>
                    <input id="txtDespesas" style="width: 100px; height:17.5px; margin-top:2px;" type="text" />
                </div>

                <div class="cell-wizard">
                    <label for="Itens_DsObjSeguradoEdit"> Valor Honorarios </label>
                    <input id="txtHonorarios" style="width: 100px; height:17.5px; margin-top:2px;" type="text" />
                </div>

            

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarIndenizacao" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary">Adicionar</button>
            </div>

            <div class="clear"></div>
            <div id="contasGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexContas"> </table></div>
            </div>
            </div>
</body>
</html>
