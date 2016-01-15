﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aviso.aspx.cs" Inherits="Sinistros.aviso" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
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

/*        var gWebTwain2;
        var _dwtParam2 = {
            'productKey': '', /* please input your product key here. How to Generate Product Key>> */
//            'containerID': 'dwtcontrolContainer2', /* the container's id. */
//            'isTrial': 'true', /* true for a trial license. */
//            'version': '9,2', /* The version of Dynamic Web TWAIN. */
//            'resourcesPath': 'Resources', /* The relative path of MSI, CAB and PKG. */
//            'width': 440,
//            'height': 600
//        };


        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script>

    <script type="text/javascript">
        var model = { "coberturas": [] };
        $(document).ready(function () {

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

            $('#btnJudicialNao').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $('#btnJudicialSim').button({
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
            $('#btnAlterar').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
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
                rows.push({ cell: [i+1, item.DS_DESCRICAO, item.DS_TIPO, '<a href=# onclick="abrirImagem('+item.ID_ARQUIVO+');">Abrir</a>', ''] });
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

        <div id="divSinistro">

    <table style="width:100%;">
        <tr>
            <td class="style4">
                Tipo Sinistro</td>
            <td class="style5">
                Data da Ocorrência</td>
            <td class="style6">
                CPF</td>
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
            <td class="style5">
                <asp:TextBox ID="TextBoxDtOcorre" runat="server"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:TextBox ID="TextBoxCPF" runat="server"></asp:TextBox>
            <td class="style7">
                <asp:TextBox ID="TextBoxAPO" runat="server"></asp:TextBox>
            <td>
                <asp:Button ID="btnIniciar" runat="server" onclick="Button1_Click" 
                    Text="Iniciar" />
            </td>
        </tr>
        <script>
            $(document).ready(function () {
                $('#btnIniciar').hide();
                $('#TextBoxCPF').blur(function () {
                    if (document.getElementById('TextBoxCPF').value != "") {
                        $.ajax({
                            type: "get",
                            contentType: "application/json",
                            url: "pessoa/" + document.getElementById('TextBoxCPF').value,
                            data: "{}",
                            dataType: 'json',
                            success: function (result) {
                                if (result.length == 0) {
                                    alert("CPF Não encontrado.");
                                    $('#btnIniciar').hide();
                                } else {
                                    $('#btnIniciar').show();
                                }
                            }
                        });
                    } else {
                        alert("Preencha o CPF");
                        $('#btnIniciar').hide();
                        return;
                    }
                });
            });
        </script>
        <tr>
            <td class="style4">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

    <asp:Label ID="lblCosseguroAceito" runat="server" Text="Label" ForeColor="Red" Visible="false">Esta é uma apólice de COSSEGURO ACEITO.</asp:Label>

    <asp:Panel ID="Panel1" runat="server" Visible="false">
 
     <table style="width:100%">
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
                Número do Sinistro</td>
            <td class="style2">
                        <asp:TextBox ID="TextBoxNrSinistro" runat="server" ReadOnly="true" Width="98%" ></asp:TextBox>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Nome do Reclamante</td>
            <td class="style2">
                <asp:TextBox ID="TextBoxNmReclamante" runat="server" Width="98%" ></asp:TextBox>
                </td>
            <td class="style3">
&nbsp;&nbsp; Tipo Reclamante</td>
            <td>
                <asp:DropDownList ID="ddReclamante" runat="server" DataSourceID="parentesco" 
                    DataTextField="DS_PARENTESCO" DataValueField="ID_TP_PARENTESCO">
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
                <asp:TextBox ID="TextBoxCPFReclamante" runat="server" Text='<%# Eval("CPF") %>' Width="98%" ></asp:TextBox>
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
                <asp:TextBox ID="TextBoxDesc" runat="server"  Width="98%" TextMode="MultiLine" Height="80" ></asp:TextBox>
                </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Seguro</td>
            <td class="style2">
                <asp:DropDownList ID="ddSeguro" runat="server" Width="100%" DataSourceID="SEGURADO" DataTextField="SEGURO" DataValueField="ID_SEGURO" >
                </asp:DropDownList>
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
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select * from TB_CAD_COBSU"></asp:SqlDataSource>
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
                    SelectCommand="SELECT * FROM &quot;STO_TPCAUSA&quot; ORDER BY DS_CAUSA"></asp:SqlDataSource>
            </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                Endosso</td>
            <td class="style2">
                <asp:DropDownList ID="ddEndosso" runat="server" Width="100%" DataSourceID="ENDOSSO" DataTextField="ENDOSSO" DataValueField="ID_ENDOSSO">
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
                <asp:TextBox ID="TextBoxValor" runat="server" ></asp:TextBox>&nbsp; Data Aviso :<asp:TextBox 
                    ID="TextBoxDtAviso" runat="server" ></asp:TextBox>
            </td>
            <td class="style3">
                &nbsp;&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                <!--Histórico Reserva--></td>
            <td class="style2">
                <table id="tabela1" style="border-style: solid; border-width: thin; width:100%; display: none" >
                    <tr>
                        <td>
                            Data</td>
                        <td>
                            Valor</td>
                        <td>
                            Evento</td>
                    </tr>
                    <tr>
                        <td>
                            01/08/2013 09h56</td>
                        <td>
                            500,00</td>
                        <td>
                            A</td>
                    </tr>
                    <tr>
                        <td>
                            01/08/2013 10h05</td>
                        <td>
                            476,50</td>
                        <td>
                            J</td>
                    </tr>
                </table>
            </td>
            <td class="style3">
                <asp:Button ID="btnSalvar" runat="server" Text="Salvar" onclick="Button2_Click" />
            </td>
            <td>
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
                    onclick="btnCancelar_Click" />
            </td>
        </tr>
    </table>
 
    </asp:Panel>

    <asp:SqlDataSource ID="SMA_SINISTRO" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
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
nvl(:tpSinistro,1), TO_DATE(:dtOcorrencia, 'DD/MM/YYYY'), TO_DATE(:dtAviso, 'DD/MM/YYYY'), :nmReclamante, :cpfReclamante, :idSeguro, :tpReclamante, :cdCober, :idCausa, :idEndosso, :idUsuario,
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
            <asp:formparameter name="idEndosso" formfield="ddEndosso" />
            <asp:formparameter name="APO" formfield="TextBoxAPO" />
            <asp:formparameter name="idSeguro" formfield="ddSeguro" />
            <asp:formparameter name="idUsuario" formfield="txtUsuario" />
            
          </insertparameters>

          <SelectParameters>
            <asp:formparameter name="dtOcorrencia" formfield="TextBoxDtOcorre" />
            <asp:formparameter name="idSeguro" formfield="ddSeguro" />
            
          </SelectParameters>
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

        SelectCommand="SELECT S.DS_CLIENTE, S.CPF, P.ID_PRODUTO, SS.NR_SEGURO, SS.ID_SEGURO, P.DS_PRODUTO, to_char(SS.NR_SEGURO, '0000') || ' - ' || a.DS_PRODUTO SEGURO, 
a.cd_estipulante, a.ds_estipulante, a.cd_estipulante || ' - ' || a.ds_estipulante ESTIPULANTE
FROM (
SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante 
FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e
WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.id_produto = sp.id_produto and e.cd_estipulante = sp.cd_estipulante
) a,
SMA_SEGURADO S, SMA_SEGURO SS, SMA_PRODUTO P 
WHERE 
S.CPF =  :CPF
and S.ID_SEGURADO = Ss.ID_SEGURADO 
AND SS.ID_PRODUTO = (
SELECT sp.id_produto 
FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp  
WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.id_produto = sp.id_produto
) 
">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxCPF" Name="CPF" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="TextBoxAPO" Name="APO" PropertyName="Text" 
                Type="Int64" />
         </InsertParameters>
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

        <asp:Label ID="lblMsg" runat="server" >Sinistro cadastrado com sucesso.</asp:Label>
        <br />
        <asp:Label ID="lblErro" runat="server" Font-Size="Medium" ForeColor="Red">Ocorreu um erro na inclusao. Verifique.</asp:Label>
        <br />
        <br />
        <asp:Label ID="lblMsgErro" runat="server"  ForeColor="Red"></asp:Label>

        <asp:FormView ID="FormView1" runat="server" DataSourceID="SMA_SINISTRO" DefaultMode="Edit">
            <EditItemTemplate>
                <a>ID Sinistro Gravado</a>
                <br />
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("ID_SINISTRO") %>' ReadOnly="true"></asp:TextBox>
                <br />
                <a>Numero Susep Gerado</a>
                <br />
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NR_SINISTRO") %>' ></asp:TextBox>
                <asp:Button ID="btnAlterar" runat="server"  
                    Text="Alterar" onclick="Button3_Click" />
            </EditItemTemplate>
        </asp:FormView>
            <asp:Label ID="lblSinistro" runat="server" ></asp:Label>
            <br />
        </asp:Panel>

        <asp:Panel ID="pnlJudicial" runat="server" Visible="False">
            <asp:Label ID="Label1" Font-Size="Medium" runat="server"  ForeColor="Red">Deseja abrir o sinistro como Judicial?</asp:Label>
            <br />
            <br />
            <asp:Button ID="btnJudicialSim" runat="server"  
                Text="SIM" onclick="btnJudicialSim_Click" />
            <asp:Button ID="btnJudicialNao" runat="server"  
                Text="NÃO" onclick="btnCancelar_Click" />
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
                            <asp:Button ID="btnSalvar2" runat="server" Text="Salvar" onclick="Button2_Click" />
                            <asp:Button ID="btnCancelar2" runat="server" Text="Cancelar" onclick="btnCancelar_Click" />
                        </li>  
   
                    </ul>

                </div>


                <div id="imagensGrid" style="padding-left:6px"><table id="flex1"> </table>
                </div>


                <!--div id="tblLoadImage" style="visibility:hidden;height:80px">
                    <ul>
                        <li><b>You can:</b><a href="javascript: void(0)" style="text-decoration:none; padding-left:200px" class="ClosetblLoadImage">X</a></li>
                    </ul>
                    <div id="notformac1" style="background-color:#f0f0f0; padding:5px;">
                        <ul>
                            <li><img alt="arrow" src="Images/arrow.gif" width="9" height="12"/><b>Install a Virtual Scanner:</b></li>
                            <li style="text-align:center;"><a id="samplesource32bit" href="http://www.dynamsoft.com/demo/DWT/Sources/twainds.win32.installer.2.1.3.msi">32-bit Sample Source</a>
                                <a id="samplesource64bit" style="display:none;" href="http://www.dynamsoft.com/demo/DWT/Sources/twainds.win64.installer.2.1.3.msi">64-bit Sample Source</a>
                                from <a href="http://www.twain.org">TWG</a></li>
                        </ul>
                    </div>
                </div-->

        </div>


            <!--div id="DWTcontainer" style="background-color:#ffffff; height:810px; border:0;">

                <div id="dwtcontrolContainer" style="height:600px;"></div>
                <div id="DWTNonInstallContainerID" style="width:580px"></div>
                <div id="DWTemessageContainer" style="margin-left:25px;width:580px"></div>

            </div-->

            <!--iframe class="menu" src="teste2.htm" frameborder=0 width="100%" height="100%"></iframe-->

        </div>

    </div>

        </div>

    </div>

        <!--div id="dwtcontrolContainer2" style="height:800px;"></div>
        <input type="button" value="Scan" onclick="Simple_AcquireImage();" /--> 

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
            <table style="border-style:none; width:100%;" >
                <tr><td style="width:99%"></td><td align="right"><input type="button" id="btFechar" value="Fechar" onclick="FecharImg();" /></td></tr>
                <tr><td colspan="2" align="center">
                    <img id="imgDoc" src="" alt="" /></td>   
                </tr>
            </table>  
        </div>
    </div>

    <div id="overlay" class="ui-widget-overlay" style="width: 1583px; height: 100%; z-index: 1001; display: none;"></div>

    </form>

</body>
</html>
