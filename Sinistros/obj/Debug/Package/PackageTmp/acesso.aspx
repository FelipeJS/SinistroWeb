<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="acesso.aspx.cs" Inherits="Sinistros.acesso" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!--head>
  <meta charset="utf-8">
  <title>Administração de Usuários do Sistema</title>

  <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
  <script>
      $(function () {
          $("#accordion").accordion();
      });
  </script>
</head>
<body-->

<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />

    <title>..:: SinistroWeb ::..</title>


    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />

  <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>

  <script type="text/javascript">
      $(function () {
          $("#accordion").accordion();
      });
  </script>

  <style type="text/css">
      
        body {
	        font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
	        font-size: 62.5%;
        }      
  </style>

    
    <script type="text/javascript">

        $(document).ready(function () {
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

        });

    </script>

  <script>
      $(function () {
          $("#accordion").accordion();
      });
  </script>


</head>
<body>
    <div id="container">
        <div class="topo" id="topo" >    
            <!--p-->
            <br />
            &nbsp;&nbsp;&nbsp;<img src="css/images/logo_qbe.jpg" />
            <!--/p-->
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
  <h3>Usuários</h3>
  <div>

    <div style="height:400px">

   <asp:GridView ID="UsuarioGridView" runat="server" AutoGenerateColumns="False"
    DataKeyNames="id_usuario" BackColor="White" BorderColor="Black" 
          BorderStyle="Solid" BorderWidth="1px" CellPadding="2" GridLines="Both" 
          onrowediting="UsuarioGridView_RowEditing"
          onrowcancelingedit="UsuarioGridView_RowCancelingEdit" 
          onrowupdating="UsuarioGridView_RowUpdating" 
          >
       
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
  <h3>Perfís de Acesso</h3>
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
    
</body>
</html>
