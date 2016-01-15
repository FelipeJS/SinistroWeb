<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="avisar_sinistro.aspx.cs" Inherits="Sinistros.avisar_sinistro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        
        .SumoSelect > .CaptionCont > span
        {
            padding-top: 5px; 
            padding-left: 2px; 
        }
        
        .SumoSelect > .CaptionCont
        {
/*            height: 23px;
            width:410px;*/
            padding-top: 0px;
            padding-bottom: 0px;
            padding-right: 0px;
            padding-left: 0px;
        }

        .SumoSelect > .optWrapper.open
        {
            top: 25px; 
            font-family: monospace; 
            font-size: small; 
            max-height: 300px;
            /*width: 625px;  font-style: oblique; */ 
        }

        .SumoSelect > .optWrapper > .options > li label
        {
            font-family: monospace; 
            font-size: small; 
            font-weight:normal;
        }
        
        .style1
        {
            width: 142px;
        }
        .style2
        {
            width: 430px;
        } 
        .style3
        {
            width: 115px;
        }
        .style4
        {
            width: 143px;
        }
        .style5
        {
            width: 151px;
        }
        .style6
        {
            width: 144px;
        }
        .style7
        {
            width: 138px;
        }
        #Text7
        {
            width: 176px;
        }
        #Text9
        {
            width: 180px;
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

    <script src="Scripts/sumoselect/jquery.sumoselect.min.js" type="text/javascript"></script>
    <link href="Scripts/sumoselect/sumoselect.css" rel="stylesheet" type="text/css" />
 
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

        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script>

    <script type="text/javascript">
        var model = { "coberturas": [] };
        $(document).ready(function () {

            $('.ddSeguroSeleciona').SumoSelect({ okCancelInMulti: true });

            $(".optWrapper label").each(function (i) {
                $(this).html(this.value);
            });

            $('#wizard').s;

            datepickerBR('#TextBoxDtOcorre');
            datepickerBR('#TextBoxDtAviso');

            $('#btFechar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $('#btnScan').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            $('#btnCarregar').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            $('#btnIniciar').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnSelecionarSeguro').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnSalvar').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnSalvar2').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnCancelar2').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnCancelar3').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnPreAviso').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#btnAlterar').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })

            $('#btnSalvar').click(function () {

                //                if(document.getElementById('TextBoxDtAviso').value < document.getElementById('TextBoxDtOcorre').value)


            })

            $('#btnCancelar').click(function () {
                //$('#wizard').select;
            })
            $('#btnCancelar').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            $('#TextBoxValor').maskMoney({ precision: 2 });


            $('.buttonFinish').click(function () {
                //finalizarApolice();
            });

            $('#wizard').smartWizard({
                //                selected: model.Passo > 0 ? model.Passo - 1 : model.Passo,
                selected: document.getElementById('Model').value,
                transitionEffect: 'none',
                enableAllSteps: true,
                labelNext: 'Próximo',
                labelPrevious: 'Anterior',
                labelFinish: 'Finalizar',
                labelback: 'Voltar',
                showReturnButton: true,
                returnPage: '/',
                enableFinishButton: false,
                onLeaveStep: leaveAStepCallback,
                onShowStep: showStepCallback
            });

            $(window).load(function () {
                $('#wizard').show();
                $('.stepContainer').height($('#step-1').outerHeight());

                if (model.Passo > 0) {
                    $('.stepContainer').height($($('#step' + model.Passo).attr("href")).outerHeight());
                }

                //ENABLE/DISABLE
                //                if (model.Apolice.NrApolice != null) {
                //                    TravarCampos();
                //                }

            });

            $("#flex1").flexigrid({
                //                url: 'sinistro',
                //                method: 'GET',
                dataType: 'json',
                colModel: [
                        { display: 'ID', name: 'ID_DOCUMENTO', width: 41, sortable: true, align: 'left' },
                        { display: 'Nome do Documento', name: 'DS_DOCUMENTO', width: 300, sortable: true, align: 'left' },
                        { display: 'Tipo', name: 'DS_TIPO', width: 50, sortable: true, align: 'left' },
                        { display: 'Visualizar', name: 'DS_LINK', width: 100, sortable: true, align: 'left' },
                        { display: '', name: 'botao', width: 03, sortable: false, align: 'center', textButton: 'Abrir', ColumnButton: 'Abrir', FunctionButton: 'ExcluirApolice', Icon: 'ui-icon-gear' }
                ],
                onError: function (jqXHR, textStatus, errorThrown) {
                    alert("flexigrid failed " + errorThrown + jqXHR + textStatus);
                },
                usepager: true,
                title: "",
                useRp: true,
                rp: 10,
                showTableToggleBtn: false,
                resizable: false,
                width: 820,
                height: 480,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

        });

        function FecharImg() {
            overlay.style.display = 'none';
            docView.style.display = 'none';
        }

        function showStepCallback(obj) {
            var stepNum = obj.attr('rel');
            switch (stepNum) {

                //Finalizar  
                case "2":
                    //consistirApolice();

                    return true;

                default:
                    return true;
            }
        }

        function Pesquisar() {
            document.getElementById('frmImagem').contentWindow.location.reload();
            overlay.style.display = 'block';
            docUpload.style.display = 'block';
        }

        function abrirImagem(id) {
            document.getElementById("imgDoc").src = "docExp.ashx?IdArquivo=" + id;
            overlay.style.display = 'block';
            docView.style.display = 'block';

        }

        function CarregarGridArquivos() {

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?arquivos=" + document.getElementById('FormView1_TextBox1').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });
        }

        function formatResults(arquivos) {
            var rows = Array();

            var str = "<div  style='text-align:right'>";

            for (i = 0; i < arquivos.length; i++) {
                var item = arquivos[i];
                rows.push({ cell: [i + 1, item.DS_DESCRICAO, item.DS_TIPO, '<a href=# onclick="abrirImagem(' + item.ID_ARQUIVO + ');">Abrir</a>', ''] });
            }
            return { total: arquivos.length, page: 1, rows: rows }
        }

        function leaveAStepCallback(obj) {
            var stepNum = obj.attr('rel');
            switch (stepNum) {

                //Endosso Zero     
                case "2":
                    //                   if (isCompleteEndossoStep(model)) {
                    //                       persistEndosso(model);
                    return true;
                    //                   } else {
                    //                       return false;
                    //                   }

                default:
                    return true;
            }


        }

        function ExibirCampos(model) {
            if (model.NrProposta != null) {
                $('#step2').show();
                $('.buttonPrevious').show();
                $('.buttonNext').show();
                $('.buttonFinish').show();
                IncializarFormularios(model);
            }
            else {
                $('#step2').hide();
                $('.buttonPrevious').hide();
                $('.buttonNext').hide();
                $('.buttonFinish').hide();
            }
        }


    </script>

</head>
<body>
    <form id="form1" runat="server">

    <asp:HiddenField runat="server" ID="txtUsuario" />
    <asp:HiddenField runat="server" ID="txtPerfil" />
    <asp:HiddenField runat="server" ID="txtIdSinistro" />

        <div id="container">

        <div id="container_body">

         <div id="title">
            <h3>
                
    Aviso de Sinistro

            </h3>
         </div>


<div id="wizard" class="swMain" >
    <input type="hidden" id="Model" runat="server" />
    <ul class="anchor">
  	    <li><a href="#step-1" id="step1">
        <label class="stepNumber">1</label>
        <span class="stepDesc">
            Sinistro<br />
            <small>Aviso</small>
        </span>
	    </a>
        </li>

  	    <li><a href="#step-2" id="step2">
        <label class="stepNumber">2</label>
        <span class="stepDesc">
            Confirmação<br />
            <small>ID/Número SUSEP</small>
        </span>
	    </a>
        </li>

  	    <li><a href="#step-3" id="step3">
        <label class="stepNumber">3</label>
        <span class="stepDesc">
            Documentos<br />
            <small>Documentos</small>
        </span>
	    </a>
        </li>

    </ul>


    <div id="step-1">	    

        <div id="divSinistro" style="height:600px">

    <table style="width:100%;">
        <tr>
            <td class="style4">
                Tipo Sinistro</td>
            <td class="style5" style="width:141px">
                Data da Ocorrência</td>
            <td class="style6">
                CPF / Bilhete</td>
            <td class="style7">
                Apólice</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
                <asp:DropDownList ID="ddTpSinistro" runat="server" Enabled="false" >
                    <asp:ListItem Value="1">ADMINISTRATIVO</asp:ListItem>
                    <asp:ListItem Value="2">JURIDICO</asp:ListItem>
                    <asp:ListItem Value="0">SISE</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="style5" style="width:141px">
                <asp:TextBox ID="TextBoxDtOcorre" runat="server"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:TextBox ID="TextBoxCPF" runat="server"></asp:TextBox>
            <td class="style7">
                <asp:TextBox ID="TextBoxAPO" runat="server"></asp:TextBox>
            <td>
                <asp:Button ID="btnIniciar" runat="server" onclick="Button1_Click" 
                    Text="    Iniciar    " />
                <asp:Button ID="btnCancelar3" runat="server" onclick="btnCancelar_Click" Visible="false" 
                    Text="Cancelar" />
                <asp:Button ID="btnPreAviso" runat="server" onclick="btnPreAviso_Click" 
                    Text="Abrir Pré-Aviso" />
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;</td>
            <td class="style5" style="width:141px">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

    <asp:Panel ID="pnSeguro" runat="server" Visible="false">
     <table style="width:100%">
        <tr>
            <!--td class="style1">
                Seguro</td-->
            <td class="style2">
                <asp:ListBox ID="ddSeguroSeleciona" SelectionMode="Multiple" runat="server" DataSourceID="dsSeguroSeleciona" onchange="$( '#btnSelecionarSeguro' ).click();"
                    DataTextField="SEGURO" DataValueField="ROWNUM" Enabled="true"  style="height: 25px;width:725px;padding-top: 0px;padding-bottom: 0px;padding-right: 0px;padding-left: 0px;" multiple="multiple" class="ddSeguroSeleciona"  >
                </asp:ListBox>
                </td>
            <td class="style3">&nbsp;<asp:Button ID="btnSelecionarSeguro" runat="server" onclick="btnSelecionarSeguro_Click" 
                    Text="Selecionar" style="display:none" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMsgSeguro" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>

     </table>
    </asp:Panel>

    <asp:Panel ID="Panel3" runat="server" Visible="false">
     <table style="width:100%">
        <tr>
            <td class="style1">
                Seguro</td>
        </tr>
     </table>
    </asp:Panel>

    <asp:Panel ID="Panel1" runat="server" Visible="false">
 
     <table style="width:100%">
        <tr>
            <td class="style1">
                ---</td>
        </tr>
        <tr>
            <td class="style1">
                Segurado</td>
            <td class="style2">
                <asp:DropDownList ID="ddSegurado" runat="server" DataSourceID="SEGURADO" 
                    DataTextField="DS_CLIENTE" DataValueField="DS_CLIENTE" Enabled="false"  Width="100%" >
                </asp:DropDownList>
                </td>
            <td class="style3">
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Estipulante</td>
            <td class="style2">
               <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SEGURADO" 
                    DataTextField="ESTIPULANTE" DataValueField="ESTIPULANTE" Enabled="false"  Width="100%" >
                </asp:DropDownList>

                </td>
            <td class="style3">
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Nome do Reclamante</td>
            <td class="style2">
                <asp:TextBox ID="TextBoxNmReclamante" runat="server" Width="99%" ></asp:TextBox>
                 </td>
         </tr>
        <tr>
           <td class="style3">
                Tipo Reclamante</td>
            <td>
                <asp:DropDownList ID="ddReclamante" runat="server" DataSourceID="parentesco" 
                    DataTextField="DS_PARENTESCO" DataValueField="ID_TP_PARENTESCO" Width="100%">
                </asp:DropDownList>
                <asp:SqlDataSource ID="parentesco" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select * from SYS_TPPARENTESCO
order by id_tp_parentesco"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1">
                CPF do Reclamante</td>
            <td class="style2">
                <asp:TextBox ID="TextBoxCPFReclamante" runat="server" Text='<%# Eval("CPF") %>' Width="99%" ></asp:TextBox>
                </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Descrição</td>
            <td class="style2">
                <asp:TextBox ID="TextBoxDesc" runat="server"  Width="99%" TextMode="MultiLine" Height="80" Text="Aguardando documentação ser encaminhada a seguradora." ></asp:TextBox>
                </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr style="display:none">
            <td class="style1">
                Seguro</td>
            <td class="style2">
                <asp:TextBox ID="TextBoxSeguro" runat="server"></asp:TextBox> 
                <asp:Label ID="lblSeguro" runat="server" Text="Label" ForeColor="Red" Visible="false">Inserir novo seguro e segurado na base do SIMASS</asp:Label>
            </td>
            <td class="style3">
                
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Cobertura</td>
            <td class="style2">
                <asp:DropDownList ID="ddCobertura" runat="server" DataSourceID="cobertura" 
                    DataTextField="DS_COBER" DataValueField="CD_COBER" Width="100%">
                </asp:DropDownList>
                <asp:SqlDataSource ID="cobertura" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
                    SelectCommand="select -1 cd_cober, ' ' ds_cober from dual 
                                   union 
                                   select cd_cober, ds_cober from TB_CAD_COBSU"></asp:SqlDataSource>
            </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Causa</td>
            <td class="style2">
                <asp:DropDownList ID="ddCausa" runat="server" DataSourceID="causa" 
                    DataTextField="DS_CAUSA" DataValueField="ID_CAUSA" Width="100%">
                </asp:DropDownList>
                <asp:SqlDataSource ID="causa" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
                    SelectCommand="SELECT -1 ID_CAUSA, ' ' DS_CAUSA FROM DUAL
                                   UNION
                                   SELECT ID_CAUSA, DS_CAUSA FROM STO_TPCAUSA ORDER BY DS_CAUSA"></asp:SqlDataSource>
            </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                ---</td>
            <td class="style2">
                <asp:DropDownList ID="ddEndosso" runat="server" Width="100%" DataSourceID="ENDOSSO" DataTextField="ENDOSSO" DataValueField="ID_ENDOSSO" Visible="false">
                </asp:DropDownList>
                <asp:SqlDataSource ID="ENDOSSO" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
                    SelectCommand="SELECT E.ID_ENDOSSO, 'Num: ' || to_char(E.NR_ENDOS_OFIC, '000000') || ' Vig: ' || TO_CHAR(E.DT_INI_VIG, 'DD/MM/YYYY') || ' A ' || TO_CHAR(E.DT_FIM_VIG, 'DD/MM/YYYY') ENDOSSO 
FROM TB_EMI_ENDOS E, TB_EMI_APOLI A
WHERE E.ID_APOLICE = A.ID_APOLICE
AND A.NR_APOLI_OFIC = :APO 
AND TO_DATE(:OCO, 'DD/MM/YYYY') BETWEEN E.DT_INI_VIG AND E.DT_FIM_VIG
">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBoxDtOcorre" Name="OCO" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="TextBoxAPO" Name="APO" PropertyName="Text" 
                Type="Int64" />
         </SelectParameters>

</asp:SqlDataSource>
            </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Valor da Indenização</td>
            <td class="style2">
                <asp:TextBox ID="TextBoxValor" runat="server" Text="300" Enabled="false" ></asp:TextBox>
                &nbsp; Data Aviso :<asp:TextBox ID="TextBoxDtAviso" runat="server" ></asp:TextBox>
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar" onclick="btnSalvar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" onclick="btnCancelar_Click" />
            </td>
            <td class="style3">
            </td>
            <td>
             </td>
        </tr>
    </table>
 
    </asp:Panel>

    <asp:SqlDataSource ID="SMA_SINISTRO" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        OnInserting="On_Inserting"
        UpdateCommand="    update sto_seq_susep ss
       set ss.nm_sequencia = ss.nm_sequencia + 1
     where ss.cd_sucursal = (select cd_sucursal from tb_emi_apoli a where a.nr_apoli_ofic = :APO or (ID_APOLICE = :APO AND NR_APOLI_OFIC IS NULL) )
       and ss.cd_ramo = (select cd_ramo_emis from tb_emi_apoli a where a.nr_apoli_ofic = :APO or (ID_APOLICE = :APO AND NR_APOLI_OFIC IS NULL) )
       and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy')
"
        SelectCommand="SELECT S.*, TO_CHAR(ID_SINISTRO) ID_SINISTRO_S FROM SMA_SINISTRO S WHERE ID_SEGURO = :idSeguro and dt_ocorrencia = TO_DATE(:dtOcorrencia, 'DD/MM/YYYY') order by id_sinistro desc"
        InsertCommand="INSERT INTO sma_sinistro 
(
id_sinistro,
nr_sinistro_aon, 
nr_sinistro, 
fl_status, cd_cia, id_segurado, 
vl_qtde_paga, fl_status_legado, vl_saldo_devedor, fl_documentos_recebidos, fl_catastrofe, dt_cadastro, dt_modificacao, dt_ult_consulta,
tp_sinistro, dt_ocorrencia, dt_aviso, nm_reclamante, cpf_reclamante, id_seguro, tp_reclamante, cd_cober, id_causa, id_endosso, id_usuario, id_apolice) 
VALUES 
(
(select max(id_sinistro) + 1 from sma_sinistro where id_sinistro &lt; 900000),              
0, 
    (select lpad(to_char(pol.cd_sucursal), 2, '0') ||
                       lpad(to_char(pol.cd_ramo_emis), 2, '0') ||
                       lpad(to_char(nvl(ss.nm_sequencia, 0) + 1), 6, '0') ||
                       to_char(sysdate, 'yyyy') SinistroSUSEP
      from tb_emi_apoli pol
     inner join sto_seq_susep ss
        on ss.cd_sucursal = pol.cd_sucursal
       and ss.cd_ramo = pol.cd_ramo_emis
       and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy')
     where pol.nr_apoli_ofic = :APO)
,       
'A',     4, (select id_segurado from sma_seguro where id_seguro = :idSeguro), 
0,                        0,                  0,                       0,             0,     sysdate,        sysdate,         sysdate,
nvl(:tpSinistro,1), TO_DATE(:dtOcorrencia, 'DD/MM/YYYY'), TO_DATE(:dtAviso, 'DD/MM/YYYY'), :nmReclamante, :cpfReclamante, :idSeguro, :tpReclamante, decode(:cdCober, -1, null, :cdCober), decode(:idCausa, -1, null, :idCausa), 
(select max(e.id_endosso) from tb_emi_endos e, tb_emi_endit t, tb_emi_apoli a 
  where a.nr_apoli_ofic = :APO and t.id_endosso = e.id_endosso and e.id_apolice = a.id_apolice
    and to_date(:dtOcorrencia, 'dd/mm/yyyy') between e.dt_ini_vig and e.dt_fim_vig
    and t.cd_tipo_motivo_endos = 220 ), 
:idUsuario,
(select id_apolice from tb_emi_apoli where nr_apoli_ofic = :APO)
)">
          <insertparameters>
            <asp:formparameter name="tpSinistro" formfield="ddTpSinistro" />
            <asp:formparameter name="dtOcorrencia" formfield="TextBoxDtOcorre" />
            <asp:formparameter name="dtAviso" formfield="TextBoxDtAviso" />
            <asp:formparameter name="nmReclamante" formfield="TextBoxNmReclamante" />
            <asp:formparameter name="cpfReclamante" formfield="TextBoxCPFReclamante" />
            <asp:formparameter name="tpReclamante" formfield="ddReclamante" />
            <asp:formparameter name="cdCober" formfield="ddCobertura" />
            <asp:formparameter name="idCausa" formfield="ddCausa" />
            <asp:formparameter name="APO" formfield="TextBoxAPO" />
            <asp:formparameter name="idSeguro" formfield="TextBoxSeguro" />
            <asp:formparameter name="idUsuario" formfield="txtUsuario" />
            
          </insertparameters>

          <UpdateParameters>
            <asp:formparameter name="APO" formfield="TextBoxAPO" />
          
          </UpdateParameters>

    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SEGURADO" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        InsertCommand="insert into sma_segurado s
(s.id_segurado, s.cd_estipulante, s.cd_cliente_aon, s.cd_cliente_etp, s.cpf, s.ds_cliente, s.id_pessoa)
SELECT seq_sma_segurado.nextval, a.cd_estipulante, substr('75611376800',1,8), '75611376800', '75611376800', S.DS_PESSOA, s.id_pessoa     
FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante      
FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e     
WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and e.cd_estipulante = sp.cd_estipulante     ) a,     
CRP_PESSOA S, CRP_DOCTO D     
WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa ;
insert into sma_seguro ss
(ss.id_seguro, ss.nr_seguro, ss.id_segurado, ss.id_produto)
SELECT seq_sma_seguro.nextval, 1, seq_sma_segurado.currval, a.id_produto     
FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante      
FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e     
WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and e.cd_estipulante = sp.cd_estipulante     ) a,     
CRP_PESSOA S, CRP_DOCTO D     
WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa "

        SelectCommand="
select a.id_apolice, to_char(a.nr_apoli_ofic), p.ds_pessoa DS_CLIENTE, to_char(a.nr_idtfc_neg) SEGURO, est.ds_estipulante ESTIPULANTE, NULL ID_SEGURO
            from tb_emi_apoli a, tb_emi_endos e, crp_pessoa p, crp_docto d, sma_estipulante est
            where a.id_apolice = e.id_apolice
            and e.id_pessoa = p.id_pessoa
            and d.id_pessoa = p.id_pessoa
            and est.cd_estipulante = a.cd_estipulante
            and (a.nr_idtfc_neg = :CPF             or d.nr_docto = :CPF)
            
union
select a.id_apolice, to_char(a.nr_apoli_ofic), s.ds_cliente,
       s.cd_cliente_etp || ' - ' || seg.nr_seguro || ' - ' || p.ds_produto,
       est.ds_estipulante ESTIPULANTE, seg.id_seguro
            from sma_segurado s
            inner join sma_seguro seg on s.id_segurado = seg.id_segurado
            inner join sma_estipulante est on s.cd_estipulante = est.cd_estipulante
            inner join tb_cad_prodt p on p.id_produto = seg.id_produto
            inner join tb_emi_apoli a on a.id_prod_unif = p.id_prod_unif
            and s.cpf =  :CPF
            
union
select null, 'SEM APÓLICE', s.ds_cliente,
       s.cd_cliente_etp || ' - ' || seg.nr_seguro || ' - ' || prod.ds_produto,
       est.ds_estipulante ESTIPULANTE, seg.id_seguro
            from sma_segurado s
            inner join sma_seguro seg on s.id_segurado = seg.id_segurado
            inner join sma_estipulante est on s.cd_estipulante = est.cd_estipulante
            inner join sma_produto prod on prod.id_produto = seg.id_produto
            where seg.id_produto not in (select p.id_produto from tb_emi_apoli a, tb_cad_prodt p where p.id_prod_unif = a.id_prod_unif and p.id_produto = seg.id_produto)
            and s.cpf =  :CPF
">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxCPF" Name="CPF" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="TextBoxAPO" Name="APO" PropertyName="Text" 
                Type="Int64" />
         </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSeguroSeleciona" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        SelectCommand="select x.*, rownum from (
select a.id_apolice, to_char(a.nr_apoli_ofic) nr_apoli_ofic, p.ds_pessoa DS_CLIENTE, 
       '<strong>SEGURO:</strong> ' || a.nr_idtfc_neg || ' - ' || null || ' - ' || p.ds_produto 
                   || '<br /><strong>APÓLICE:</strong> ' || a.nr_apoli_ofic || ' | <strong>VIGÊNCIA:</strong> ' || to_char(e.dt_ini_vig, 'dd/mm/yyyy') || ' a ' || to_char(e.dt_fim_vig, 'dd/mm/yyyy') 
                   || ' | <strong>SINISTRO:</strong> ' || fnConcatenarSinistroApolice(a.id_apolice) SEGURO,
       est.ds_estipulante ESTIPULANTE, (select max(id_seguro) from sma_sinistro s where s.id_apolice = a.id_apolice)  ID_SEGURO, E.ID_ENDOSSO, D.NR_DOCTO CPF
            from tb_emi_apoli a, tb_emi_endos e, crp_pessoa p, crp_docto d, sma_estipulante est, tb_cad_prodt p
            where a.id_apolice = e.id_apolice
            and e.id_pessoa = p.id_pessoa
            and a.cd_status = 'A'
            and d.id_pessoa = p.id_pessoa
            and d.tp_docto in ('CPF', 'CNPJ')
            and p.id_prod_unif = a.id_prod_unif
            and est.cd_estipulante = a.cd_estipulante
            and to_date(':dtOcorrencia', 'dd/mm/yyyy') between e.dt_ini_vig and e.dt_fim_vig
            and (a.nr_idtfc_neg = ':CPF'             or d.nr_docto = ':CPF')
            
union
select a.id_apolice, to_char(a.nr_apoli_ofic), s.ds_cliente,
       '<strong>SEGURO:</strong> ' || s.cd_cliente_etp || ' - ' || seg.nr_seguro || ' - ' || p.ds_produto 
                   || '<br /><strong>APÓLICE:</strong> ' || a.nr_apoli_ofic || ' | <strong>VIGÊNCIA:</strong> ' 
                   || to_char(seg.dt_adesao, 'dd/mm/yyyy') || ' a ' 
                   || to_char(add_months(seg.dt_adesao, case when seg.qt_prestacao = 0 then 1 else nvl(seg.qt_prestacao,1) end), 'dd/mm/yyyy') 
                   || ' | <strong>SINISTRO:</strong> ' || fnConcatenarSinistro(seg.id_seguro) SEGURO,
       est.ds_estipulante ESTIPULANTE, seg.id_seguro, E.ID_ENDOSSO, S.CPF
            from sma_segurado s
            inner join sma_seguro seg on s.id_segurado = seg.id_segurado
            inner join sma_estipulante est on s.cd_estipulante = est.cd_estipulante
            inner join tb_cad_prodt p on p.id_produto = seg.id_produto
            inner join tb_emi_apoli a on a.id_prod_unif = p.id_prod_unif
            inner join tb_emi_endos e on e.id_endosso = (select max(e.id_endosso) from tb_emi_endos e, tb_emi_endit t 
                                                          where e.id_apolice = a.id_apolice and t.id_endosso = e.id_endosso
                                                            and to_date(':dtOcorrencia', 'dd/mm/yyyy') between e.dt_ini_vig and e.dt_fim_vig
                                                            and t.cd_tipo_motivo_endos = 220 /* fatura */)
            where s.cpf =  ':CPF'
              and to_date(':dtOcorrencia', 'dd/mm/yyyy') between seg.dt_adesao and add_months(seg.dt_adesao, case when seg.qt_prestacao = 0 then 1 else nvl(seg.qt_prestacao,1) end)
            
--union
--select null, 'SEM APÓLICE', s.ds_cliente,
--       'SEM APÓLICE' || ' - ' || s.cd_cliente_etp || ' - ' || seg.nr_seguro || ' - ' || prod.ds_produto,
--       est.ds_estipulante ESTIPULANTE, seg.id_seguro
--            from sma_segurado s
--            inner join sma_seguro seg on s.id_segurado = seg.id_segurado
--            inner join sma_estipulante est on s.cd_estipulante = est.cd_estipulante
--            inner join sma_produto prod on prod.id_produto = seg.id_produto
--            where seg.id_produto not in (select p.id_produto from tb_emi_apoli a, tb_cad_prodt p where p.id_prod_unif = a.id_prod_unif and p.id_produto = seg.id_produto)
--            and s.cpf =  ':CPF'
) x
">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="RESERVA" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        InsertCommand="INSERT INTO STO_RESERVA
(VL_RESERVA, FL_EVENTO, DT_CADASTRO, TP_OPERACAO, TP_MOEDA, TP_VALOR, TP_SINISTRO, 
ID_SINISTRO)
VALUES 
(replace(:vlReserva,',','.'), 'A', sysdate, 1, 0, 1, :tpSinistro, 
(select max(id_sinistro) from sma_sinistro where id_sinistro < 900000))
 ">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxValor" Name="vlReserva" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="ddTpSinistro" Name="tpSinistro" PropertyName="Text" 
                Type="String" />
         </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="STATUS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        InsertCommand="INSERT INTO STO_STATUS
(ID_SINISTRO, TP_STATUS, DT_CRIACAO, ID_USUARIO)
VALUES
((select max(id_sinistro) from sma_sinistro where id_sinistro < 900000), 40, sysdate, :idUsuario)
">
        <insertparameters>
        <asp:formparameter name="idUsuario" formfield="txtUsuario" />
        </insertparameters>

    </asp:SqlDataSource>

        </div>

    </div>

    <div id="step-2">	    

        <div id="confirmacao">

        <asp:Panel ID="Panel2" runat="server" Visible="False">

        <asp:Label ID="lblMsg" runat="server" Font-Size="Medium" >Sinistro cadastrado com sucesso.</asp:Label>
        <br />
        <asp:Label ID="lblErro" runat="server" Font-Size="Medium"  ForeColor="Red">Ocorreu um erro na inclusao. Verifique.</asp:Label>>
        <br />
        <asp:Label ID="lblMsgErro" runat="server" Font-Size="Medium"  ForeColor="Red"></asp:Label>>

        <asp:GridView ID="GridView3" Runat="server" DataSourceID="SMA_SINISTRO" AutoGenerateColumns="False" Font-Size="Medium">
            <Columns>
                <asp:BoundField HeaderText="ID Sinistro Gerado" DataField="ID_SINISTRO"></asp:BoundField>
                <asp:BoundField HeaderText="Numero Susep Gerado" DataField="NR_SINISTRO"></asp:BoundField>
            </Columns>
        </asp:GridView>

            <asp:Label ID="lblSinistro" runat="server" ></asp:Label>
            <br />
     </asp:Panel>

        </div>

    </div>

    <div id="step-3">	    

        <div id="Div2">

            <div id="ScanWrapper">

                <div id="divScanner" class="divinput">
                    <ul class="PCollapse">
                        <li>
                            <label for="source">Selecionar o Equipamento:</label>
                            <select size="1" id="source" style="xposition:relative;width: 220px;" onchange="source_onchange()">
                                <option value = ""></option>    
                            </select>
                            <input id="btnScan" disabled="disabled" type="button" value="Scan" onclick ="acquireImage();"/>
                            <strong> ou </strong> 
                            <input id="btnCarregar" type="button" value="Carregar Imagem do Arquivo" onclick="return Pesquisar()" />
                            <asp:Button ID="btnSalvar2" runat="server" Text="Salvar" onclick="btnSalvar_Click" />
                            <asp:Button ID="btnCancelar2" runat="server" Text="Cancelar" onclick="btnCancelar_Click" />
                        </li>  
   
                    </ul>

                </div>


                <div id="imagensGrid" style="padding-left:6px"><table id="flex1"> </table>
                </div>


        </div>


        </div>

    </div>

        </div>

    </div>

        </div>


    <div id="docUpload" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 1106px; top: 0px; left: 300px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Importar Documento </div>
        <div id="editAjusteManual" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100%;" scrolltop="0" scrollleft="0">
<iframe id="frmImagem" src="docImp.aspx" height="100%" width="100%" frameborder="0"></iframe>        
    </div>
    </div>

    <div id="docView" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 1106px; top: 0px; left: 300px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Visualizar Documento </div>
        <div id="Div3" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100%;" scrolltop="0" scrollleft="0">
            <table style="border-style:none; width=100%;" >
                <tr><td style="width:95%"></td><td><input type="button" id="btFechar" value="Fechar" onclick="FecharImg();" /></td></tr>
                <tr><td colspan="2">
                    <img id="imgDoc" src="" alt="" /></td>   
                </tr>
            </table>  
        </div>
    </div>

    <div id="overlay" class="ui-widget-overlay" style="width: 1583px; height: 100%; z-index: 1001; display: none;"></div>

    </form>

</body>
</html>
