<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sinistro.aspx.cs" Inherits="Sinistros.Sinistro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="/Content/kendo/2013.3.1119/kendo.common.min.css"
        rel="stylesheet" type="text/css" />
    <link href="/Content/kendo/2013.3.1119/kendo.default.min.css"
        rel="stylesheet" type="text/css" />
    <link href="/Content/Site.css" rel="stylesheet" type="text/css" />

    <!--[if IE 7]> 
        <style type='text/css'>
            #textTop h2 {
                            display: block;
                            margin: 23px auto;
                        }
        </style>    
   <![endif]-->


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
        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script>

    <script type="text/javascript">

        function cboRitoChange() {

            $("#txtProcesso").mask("9999999-99.9999.9.99.9999");
            if (document.getElementById('cboRito').value == 1) $("#txtProcesso").unmask("9999999-99.9999.9.99.9999");
            if (document.getElementById('cboRito').value == 5) $("#txtProcesso").unmask("9999999-99.9999.9.99.9999");

        }


        /* Dom Ready */
        window.onDomReady = function dgDomReady(fn) {
            if (document.addEventListener)	//W3C
                document.addEventListener("DOMContentLoaded", fn, false);
            else //IE
                document.onreadystatechange = function () { dgReadyState(fn); }
        }

        function dgReadyState(fn) { //dom is ready for interaction (IE)
            if (document.readyState == "interactive") fn();
        }

        /* Objeto */
        dgCidadesEstados = function (cidade, estado, init) {
            this.set(cidade, estado);
            if (init) this.start();
        }

        dgCidadesEstados.prototype = {
            estado: document.createElement('select'),
            cidade: document.createElement('select'),
            set: function (estado, cidade) {
                this.estado = estado;
                this.estado.dgCidadesEstados = this
                this.cidade = cidade;
                this.estado.onchange = function () { this.dgCidadesEstados.run() };
            },
            run: function () {
                var sel = this.estado.options.selectedIndex;
                var itens = this.cidades[sel];
                var itens_total = itens.length;
                var opts = this.cidade;
                while (opts.childNodes.length)
                    opts.removeChild(opts.firstChild);
                this.addOption(opts, '', 'Selecione uma cidade');
                for (var i = 0; i < itens_total; i++)
                    this.addOption(opts, itens[i], itens[i]);
            },
            start: function () {
                var estado = this.estado
                while (estado.childNodes.length)
                    estado.removeChild(estado.firstChild);
                for (var i = 0; i < this.estados.length; i++)
                    this.addOption(estado, this.estados[i][0], this.estados[i][1]);
            },
            addOption: function (elm, val, text) {
                var opt = document.createElement('option');
                opt.appendChild(document.createTextNode(text));
                opt.value = val;
                elm.appendChild(opt);
            },
            estados: [
    ['', 'Selecione um estado'], ['AC', 'Acre'], ['AL', 'Alagoas'], ['AM', 'Amazonas'], ['AP', 'Amapá'], ['BA', 'Bahia'],
    ['CE', 'Ceará'], ['DF', 'Distrito Federal'], ['ES', 'Espírito Santo'], ['GO', 'Goiás'], ['MA', 'Maranhão'], ['MG', 'Minas Gerais'],
    ['MS', 'Mato Grosso do Sul'], ['MT', 'Mato Grosso'], ['PA', 'Pará'], ['PB', 'Paraíba'], ['PE', 'Pernambuco'], ['PI', 'Piauí'],
    ['PR', 'Paraná'], ['RJ', 'Rio de Janeiro'], ['RN', 'Rio Grande do Norte'], ['RO', 'Rondônia'], ['RR', 'Roraima'], ['RS', 'Rio Grande do Sul'],
    ['SC', 'Santa Catarina'], ['SE', 'Sergipe'], ['SP', 'São Paulo'], ['TO', 'Tocantins']
  ],
            cidades: [[
    ], ['Acrelândia', 'Assis Brasil', 'Brasiléia', 'Bujari', 'Capixaba', 'Cruzeiro do Sul', 'Epitaciolândia', 'Feijó', 'Jordão', 'Mâncio Lima', 'Manoel Urbano', 'Marechal Thaumaturgo', 'Plácido de Castro', 'Porto Acre', 'Porto Walter', 'Rio Branco', 'Rodrigues Alves', 'Santa Rosa do Purus', 'Sena Madureira', 'Senador Guiomard', 'Tarauacá', 'Xapuri',
    ], ['Água Branca', 'Anadia', 'Arapiraca', 'Atalaia', 'Barra de Santo Antônio', 'Barra de São Miguel', 'Batalha', 'Belém', 'Belo Monte', 'Boca da Mata', 'Branquinha', 'Cacimbinhas', 'Cajueiro', 'Campestre', 'Campo Alegre', 'Campo Grande', 'Canapi', 'Capela', 'Carneiros', 'Chã Preta', 'Coité do Nóia', 'Colônia Leopoldina', 'Coqueiro Seco', 'Coruripe', 'Craíbas', 'Delmiro Gouveia', 'Dois Riachos', 'Estrela de Alagoas', 'Feira Grande', 'Feliz Deserto', 'Flexeiras', 'Girau do Ponciano', 'Ibateguara', 'Igaci', 'Igreja Nova', 'Inhapi', 'Jacaré dos Homens', 'Jacuípe', 'Japaratinga', 'Jaramataia', 'Jequiá da Praia', 'Joaquim Gomes', 'Jundiá', 'Junqueiro', 'Lagoa da Canoa', 'Limoeiro de Anadia', 'Maceió', 'Major Isidoro', 'Mar Vermelho', 'Maragogi', 'Maravilha', 'Marechal Deodoro', 'Maribondo', 'Mata Grande', 'Matriz de Camaragibe', 'Messias', 'Minador do Negrão', 'Monteirópolis', 'Murici', 'Novo Lino', 'Olho d\'Água das Flores', 'Olho d\'Água do Casado', 'Olho d\'Água Grande', 'Olivença', 'Ouro Branco', 'Palestina', 'Palmeira dos Índios', 'Pão de Açúcar', 'Pariconha', 'Paripueira', 'Passo de Camaragibe', 'Paulo Jacinto', 'Penedo', 'Piaçabuçu', 'Pilar', 'Pindoba', 'Piranhas', 'Poço das Trincheiras', 'Porto Calvo', 'Porto de Pedras', 'Porto Real do Colégio', 'Quebrangulo', 'Rio Largo', 'Roteiro', 'Santa Luzia do Norte', 'Santana do Ipanema', 'Santana do Mundaú', 'São Brás', 'São José da Laje', 'São José da Tapera', 'São Luís do Quitunde', 'São Miguel dos Campos', 'São Miguel dos Milagres', 'São Sebastião', 'Satuba', 'Senador Rui Palmeira', 'Tanque d\'Arca', 'Taquarana', 'Teotônio Vilela', 'Traipu', 'União dos Palmares', 'Viçosa',
    ], ['Alvarães', 'Amaturá', 'Anamã', 'Anori', 'Apuí', 'Atalaia do Norte', 'Autazes', 'Barcelos', 'Barreirinha', 'Benjamin Constant', 'Beruri', 'Boa Vista do Ramos', 'Boca do Acre', 'Borba', 'Caapiranga', 'Canutama', 'Carauari', 'Careiro', 'Careiro da Várzea', 'Coari', 'Codajás', 'Eirunepé', 'Envira', 'Fonte Boa', 'Guajará', 'Humaitá', 'Ipixuna', 'Iranduba', 'Itacoatiara', 'Itamarati', 'Itapiranga', 'Japurá', 'Juruá', 'Jutaí', 'Lábrea', 'Manacapuru', 'Manaquiri', 'Manaus', 'Manicoré', 'Maraã', 'Maués', 'Nhamundá', 'Nova Olinda do Norte', 'Novo Airão', 'Novo Aripuanã', 'Parintins', 'Pauini', 'Presidente Figueiredo', 'Rio Preto da Eva', 'Santa Isabel do Rio Negro', 'Santo Antônio do Içá', 'São Gabriel da Cachoeira', 'São Paulo de Olivença', 'São Sebastião do Uatumã', 'Silves', 'Tabatinga', 'Tapauá', 'Tefé', 'Tonantins', 'Uarini', 'Urucará', 'Urucurituba',
    ], ['Amapá', 'Calçoene', 'Cutias', 'Ferreira Gomes', 'Itaubal', 'Laranjal do Jari', 'Macapá', 'Mazagão', 'Oiapoque', 'Pedra Branca do Amapari', 'Porto Grande', 'Pracuúba', 'Santana', 'Serra do Navio', 'Tartarugalzinho', 'Vitória do Jari',
    ], ['Abaíra', 'Abaré', 'Acajutiba', 'Adustina', 'Água Fria', 'Aiquara', 'Alagoinhas', 'Alcobaça', 'Almadina', 'Amargosa', 'Amélia Rodrigues', 'América Dourada', 'Anagé', 'Andaraí', 'Andorinha', 'Angical', 'Anguera', 'Antas', 'Antônio Cardoso', 'Antônio Gonçalves', 'Aporá', 'Apuarema', 'Araças', 'Aracatu', 'Araci', 'Aramari', 'Arataca', 'Aratuípe', 'Aurelino Leal', 'Baianópolis', 'Baixa Grande', 'Banzaê', 'Barra', 'Barra da Estiva', 'Barra do Choça', 'Barra do Mendes', 'Barra do Rocha', 'Barreiras', 'Barro Alto', 'Barrocas', 'Barro Preto', 'Belmonte', 'Belo Campo', 'Biritinga', 'Boa Nova', 'Boa Vista do Tupim', 'Bom Jesus da Lapa', 'Bom Jesus da Serra', 'Boninal', 'Bonito', 'Boquira', 'Botuporã', 'Brejões', 'Brejolândia', 'Brotas de Macaúbas', 'Brumado', 'Buerarema', 'Buritirama', 'Caatiba', 'Cabaceiras do Paraguaçu', 'Cachoeira', 'Caculé', 'Caém', 'Caetanos', 'Caetité', 'Cafarnaum', 'Cairu', 'Caldeirão Grande', 'Camacan', 'Camaçari', 'Camamu', 'Campo Alegre de Lourdes', 'Campo Formoso', 'Canápolis', 'Canarana', 'Canavieiras', 'Candeal', 'Candeias', 'Candiba', 'Cândido Sales', 'Cansanção', 'Canudos', 'Capela do Alto Alegre', 'Capim Grosso', 'Caraíbas', 'Caravelas', 'Cardeal da Silva', 'Carinhanha', 'Casa Nova', 'Castro Alves', 'Catolândia', 'Catu', 'Caturama', 'Central', 'Chorrochó', 'Cícero Dantas', 'Cipó', 'Coaraci', 'Cocos', 'Conceição da Feira', 'Conceição do Almeida', 'Conceição do Coité', 'Conceição do Jacuípe', 'Conde', 'Condeúba', 'Contendas do Sincorá', 'Coração de Maria', 'Cordeiros', 'Coribe', 'Coronel João Sá', 'Correntina', 'Cotegipe', 'Cravolândia', 'Crisópolis', 'Cristópolis', 'Cruz das Almas', 'Curaçá', 'Dário Meira', 'Dias d\'Ávila', 'Dom Basílio', 'Dom Macedo Costa', 'Elísio Medrado', 'Encruzilhada', 'Entre Rios', 'Érico Cardoso', 'Esplanada', 'Euclides da Cunha', 'Eunápolis', 'Fátima', 'Feira da Mata', 'Feira de Santana', 'Filadélfia', 'Firmino Alves', 'Floresta Azul', 'Formosa do Rio Preto', 'Gandu', 'Gavião', 'Gentio do Ouro', 'Glória', 'Gongogi', 'Governador Mangabeira', 'Guajeru', 'Guanambi', 'Guaratinga', 'Heliópolis', 'Iaçu', 'Ibiassucê', 'Ibicaraí', 'Ibicoara', 'Ibicuí', 'Ibipeba', 'Ibipitanga', 'Ibiquera', 'Ibirapitanga', 'Ibirapuã', 'Ibirataia', 'Ibitiara', 'Ibititá', 'Ibotirama', 'Ichu', 'Igaporã', 'Igrapiúna', 'Iguaí', 'Ilhéus', 'Inhambupe', 'Ipecaetá', 'Ipiaú', 'Ipirá', 'Ipupiara', 'Irajuba', 'Iramaia', 'Iraquara', 'Irará', 'Irecê', 'Itabela', 'Itaberaba', 'Itabuna', 'Itacaré', 'Itaeté', 'Itagi', 'Itagibá', 'Itagimirim', 'Itaguaçu da Bahia', 'Itaju do Colônia', 'Itajuípe', 'Itamaraju', 'Itamari', 'Itambé', 'Itanagra', 'Itanhém', 'Itaparica', 'Itapé', 'Itapebi', 'Itapetinga', 'Itapicuru', 'Itapitanga', 'Itaquara', 'Itarantim', 'Itatim', 'Itiruçu', 'Itiúba', 'Itororó', 'Ituaçu', 'Ituberá', 'Iuiú', 'Jaborandi', 'Jacaraci', 'Jacobina', 'Jaguaquara', 'Jaguarari', 'Jaguaripe', 'Jandaíra', 'Jequié', 'Jeremoabo', 'Jiquiriçá', 'Jitaúna', 'João Dourado', 'Juazeiro', 'Jucuruçu', 'Jussara', 'Jussari', 'Jussiape', 'Lafaiete Coutinho', 'Lagoa Real', 'Laje', 'Lajedão', 'Lajedinho', 'Lajedo do Tabocal', 'Lamarão', 'Lapão', 'Lauro de Freitas', 'Lençóis', 'Licínio de Almeida', 'Livramento de Nossa Senhora', 'Luís Eduardo Magalhães', 'Macajuba', 'Macarani', 'Macaúbas', 'Macururé', 'Madre de Deus', 'Maetinga', 'Maiquinique', 'Mairi', 'Malhada', 'Malhada de Pedras', 'Manoel Vitorino', 'Mansidão', 'Maracás', 'Maragogipe', 'Maraú', 'Marcionílio Souza', 'Mascote', 'Mata de São João', 'Matina', 'Medeiros Neto', 'Miguel Calmon', 'Milagres', 'Mirangaba', 'Mirante', 'Monte Santo', 'Morpará', 'Morro do Chapéu', 'Mortugaba', 'Mucugê', 'Mucuri', 'Mulungu do Morro', 'Mundo Novo', 'Muniz Ferreira', 'Muquém de São Francisco', 'Muritiba', 'Mutuípe', 'Nazaré', 'Nilo Peçanha', 'Nordestina', 'Nova Canaã', 'Nova Fátima', 'Nova Ibiá', 'Nova Itarana', 'Nova Redenção', 'Nova Soure', 'Nova Viçosa', 'Novo Horizonte', 'Novo Triunfo', 'Olindina', 'Oliveira dos Brejinhos', 'Ouriçangas', 'Ourolândia', 'Palmas de Monte Alto', 'Palmeiras', 'Paramirim', 'Paratinga', 'Paripiranga', 'Pau Brasil', 'Paulo Afonso', 'Pé de Serra', 'Pedrão', 'Pedro Alexandre', 'Piatã', 'Pilão Arcado', 'Pindaí', 'Pindobaçu', 'Pintadas', 'Piraí do Norte', 'Piripá', 'Piritiba', 'Planaltino', 'Planalto', 'Poções', 'Pojuca', 'Ponto Novo', 'Porto Seguro', 'Potiraguá', 'Prado', 'Presidente Dutra', 'Presidente Jânio Quadros', 'Presidente Tancredo Neves', 'Queimadas', 'Quijingue', 'Quixabeira', 'Rafael Jambeiro', 'Remanso', 'Retirolândia', 'Riachão das Neves', 'Riachão do Jacuípe', 'Riacho de Santana', 'Ribeira do Amparo', 'Ribeira do Pombal', 'Ribeirão do Largo', 'Rio de Contas', 'Rio do Antônio', 'Rio do Pires', 'Rio Real', 'Rodelas', 'Ruy Barbosa', 'Salinas da Margarida', 'Salvador', 'Santa Bárbara', 'Santa Brígida', 'Santa Cruz Cabrália', 'Santa Cruz da Vitória', 'Santa Inês', 'Santa Luzia', 'Santa Maria da Vitória', 'Santa Rita de Cássia', 'Santa Teresinha', 'Santaluz', 'Santana', 'Santanópolis', 'Santo Amaro', 'Santo Antônio de Jesus', 'Santo Estêvão', 'São Desidério', 'São Domingos', 'São Felipe', 'São Félix', 'São Félix do Coribe', 'São Francisco do Conde', 'São Gabriel', 'São Gonçalo dos Campos', 'São José da Vitória', 'São José do Jacuípe', 'São Miguel das Matas', 'São Sebastião do Passé', 'Sapeaçu', 'Sátiro Dias', 'Saubara', 'Saúde', 'Seabra', 'Sebastião Laranjeiras', 'Senhor do Bonfim', 'Sento Sé', 'Serra do Ramalho', 'Serra Dourada', 'Serra Preta', 'Serrinha', 'Serrolândia', 'Simões Filho', 'Sítio do Mato', 'Sítio do Quinto', 'Sobradinho', 'Souto Soares', 'Tabocas do Brejo Velho', 'Tanhaçu', 'Tanque Novo', 'Tanquinho', 'Taperoá', 'Tapiramutá', 'Teixeira de Freitas', 'Teodoro Sampaio', 'Teofilândia', 'Teolândia', 'Terra Nova', 'Tremedal', 'Tucano', 'Uauá', 'Ubaíra', 'Ubaitaba', 'Ubatã', 'Uibaí', 'Umburanas', 'Una', 'Urandi', 'Uruçuca', 'Utinga', 'Valença', 'Valente', 'Várzea da Roça', 'Várzea do Poço', 'Várzea Nova', 'Varzedo', 'Vera Cruz', 'Vereda', 'Vitória da Conquista', 'Wagner', 'Wanderley', 'Wenceslau Guimarães', 'Xique-Xique',
    ], ['Abaiara', 'Acarapé', 'Acaraú', 'Acopiara', 'Aiuaba', 'Alcântaras', 'Altaneira', 'Alto Santo', 'Amontada', 'Antonina do Norte', 'Apuiarés', 'Aquiraz', 'Aracati', 'Aracoiaba', 'Ararendá', 'Araripe', 'Aratuba', 'Arneiroz', 'Assaré', 'Aurora', 'Baixio', 'Banabuiú', 'Barbalha', 'Barreira', 'Barro', 'Barroquinha', 'Baturité', 'Beberibe', 'Bela Cruz', 'Boa Viagem', 'Brejo Santo', 'Camocim', 'Campos Sales', 'Canindé', 'Capistrano', 'Caridade', 'Cariré', 'Caririaçu', 'Cariús', 'Carnaubal', 'Cascavel', 'Catarina', 'Catunda', 'Caucaia', 'Cedro', 'Chaval', 'Choró', 'Chorozinho', 'Coreaú', 'Crateús', 'Crato', 'Croatá', 'Cruz', 'Deputado Irapuan Pinheiro', 'Ererê', 'Eusébio', 'Farias Brito', 'Forquilha', 'Fortaleza', 'Fortim', 'Frecheirinha', 'General Sampaio', 'Graça', 'Granja', 'Granjeiro', 'Groaíras', 'Guaiúba', 'Guaraciaba do Norte', 'Guaramiranga', 'Hidrolândia', 'Horizonte', 'Ibaretama', 'Ibiapina', 'Ibicuitinga', 'Icapuí', 'Icó', 'Iguatu', 'Independência', 'Ipaporanga', 'Ipaumirim', 'Ipu', 'Ipueiras', 'Iracema', 'Irauçuba', 'Itaiçaba', 'Itaitinga', 'Itapagé', 'Itapipoca', 'Itapiúna', 'Itarema', 'Itatira', 'Jaguaretama', 'Jaguaribara', 'Jaguaribe', 'Jaguaruana', 'Jardim', 'Jati', 'Jijoca de Jericoaroara', 'Juazeiro do Norte', 'Jucás', 'Lavras da Mangabeira', 'Limoeiro do Norte', 'Madalena', 'Maracanaú', 'Maranguape', 'Marco', 'Martinópole', 'Massapê', 'Mauriti', 'Meruoca', 'Milagres', 'Milhã', 'Miraíma', 'Missão Velha', 'Mombaça', 'Monsenhor Tabosa', 'Morada Nova', 'Moraújo', 'Morrinhos', 'Mucambo', 'Mulungu', 'Nova Olinda', 'Nova Russas', 'Novo Oriente', 'Ocara', 'Orós', 'Pacajus', 'Pacatuba', 'Pacoti', 'Pacujá', 'Palhano', 'Palmácia', 'Paracuru', 'Paraipaba', 'Parambu', 'Paramoti', 'Pedra Branca', 'Penaforte', 'Pentecoste', 'Pereiro', 'Pindoretama', 'Piquet Carneiro', 'Pires Ferreira', 'Poranga', 'Porteiras', 'Potengi', 'Potiretama', 'Quiterianópolis', 'Quixadá', 'Quixelô', 'Quixeramobim', 'Quixeré', 'Redenção', 'Reriutaba', 'Russas', 'Saboeiro', 'Salitre', 'Santa Quitéria', 'Santana do Acaraú', 'Santana do Cariri', 'São Benedito', 'São Gonçalo do Amarante', 'São João do Jaguaribe', 'São Luís do Curu', 'Senador Pompeu', 'Senador Sá', 'Sobral', 'Solonópole', 'Tabuleiro do Norte', 'Tamboril', 'Tarrafas', 'Tauá', 'Tejuçuoca', 'Tianguá', 'Trairi', 'Tururu', 'Ubajara', 'Umari', 'Umirim', 'Uruburetama', 'Uruoca', 'Varjota', 'Várzea Alegre', 'Viçosa do Ceará',
    ], ['Brasília',
    ], ['Afonso Cláudio', 'Água Doce do Norte', 'Águia Branca', 'Alegre', 'Alfredo Chaves', 'Alto Rio Novo', 'Anchieta', 'Apiacá', 'Aracruz', 'Atilio Vivacqua', 'Baixo Guandu', 'Barra de São Francisco', 'Boa Esperança', 'Bom Jesus do Norte', 'Brejetuba', 'Cachoeiro de Itapemirim', 'Cariacica', 'Castelo', 'Colatina', 'Conceição da Barra', 'Conceição do Castelo', 'Divino de São Lourenço', 'Domingos Martins', 'Dores do Rio Preto', 'Ecoporanga', 'Fundão', 'Governador Lindenberg', 'Guaçuí', 'Guarapari', 'Ibatiba', 'Ibiraçu', 'Ibitirama', 'Iconha', 'Irupi', 'Itaguaçu', 'Itapemirim', 'Itarana', 'Iúna', 'Jaguaré', 'Jerônimo Monteiro', 'João Neiva', 'Laranja da Terra', 'Linhares', 'Mantenópolis', 'Marataizes', 'Marechal Floriano', 'Marilândia', 'Mimoso do Sul', 'Montanha', 'Mucurici', 'Muniz Freire', 'Muqui', 'Nova Venécia', 'Pancas', 'Pedro Canário', 'Pinheiros', 'Piúma', 'Ponto Belo', 'Presidente Kennedy', 'Rio Bananal', 'Rio Novo do Sul', 'Santa Leopoldina', 'Santa Maria de Jetibá', 'Santa Teresa', 'São Domingos do Norte', 'São Gabriel da Palha', 'São José do Calçado', 'São Mateus', 'São Roque do Canaã', 'Serra', 'Sooretama', 'Vargem Alta', 'Venda Nova do Imigrante', 'Viana', 'Vila Pavão', 'Vila Valério', 'Vila Velha', 'Vitória',
    ], ['Abadia de Goiás', 'Abadiânia', 'Acreúna', 'Adelândia', 'Água Fria de Goiás', 'Água Limpa', 'Águas Lindas de Goiás', 'Alexânia', 'Aloândia', 'Alto Horizonte', 'Alto Paraíso de Goiás', 'Alvorada do Norte', 'Amaralina', 'Americano do Brasil', 'Amorinópolis', 'Anápolis', 'Anhanguera', 'Anicuns', 'Aparecida de Goiânia', 'Aparecida do Rio Doce', 'Aporé', 'Araçu', 'Aragarças', 'Aragoiânia', 'Araguapaz', 'Arenópolis', 'Aruanã', 'Aurilândia', 'Avelinópolis', 'Baliza', 'Barro Alto', 'Bela Vista de Goiás', 'Bom Jardim de Goiás', 'Bom Jesus de Goiás', 'Bonfinópolis', 'Bonópolis', 'Brazabrantes', 'Britânia', 'Buriti Alegre', 'Buriti de Goiás', 'Buritinópolis', 'Cabeceiras', 'Cachoeira Alta', 'Cachoeira de Goiás', 'Cachoeira Dourada', 'Caçu', 'Caiapônia', 'Caldas Novas', 'Caldazinha', 'Campestre de Goiás', 'Campinaçu', 'Campinorte', 'Campo Alegre de Goiás', 'Campos Limpo de Goiás', 'Campos Belos', 'Campos Verdes', 'Carmo do Rio Verde', 'Castelândia', 'Catalão', 'Caturaí', 'Cavalcante', 'Ceres', 'Cezarina', 'Chapadão do Céu', 'Cidade Ocidental', 'Cocalzinho de Goiás', 'Colinas do Sul', 'Córrego do Ouro', 'Corumbá de Goiás', 'Corumbaíba', 'Cristalina', 'Cristianópolis', 'Crixás', 'Cromínia', 'Cumari', 'Damianópolis', 'Damolândia', 'Davinópolis', 'Diorama', 'Divinópolis de Goiás', 'Doverlândia', 'Edealina', 'Edéia', 'Estrela do Norte', 'Faina', 'Fazenda Nova', 'Firminópolis', 'Flores de Goiás', 'Formosa', 'Formoso', 'Gameleira de Goiás', 'Goianápolis', 'Goiandira', 'Goianésia', 'Goiânia', 'Goianira', 'Goiás', 'Goiatuba', 'Gouvelândia', 'Guapó', 'Guaraíta', 'Guarani de Goiás', 'Guarinos', 'Heitoraí', 'Hidrolândia', 'Hidrolina', 'Iaciara', 'Inaciolândia', 'Indiara', 'Inhumas', 'Ipameri', 'Ipiranga de Goiás', 'Iporá', 'Israelândia', 'Itaberaí', 'Itaguari', 'Itaguaru', 'Itajá', 'Itapaci', 'Itapirapuã', 'Itapuranga', 'Itarumã', 'Itauçu', 'Itumbiara', 'Ivolândia', 'Jandaia', 'Jaraguá', 'Jataí', 'Jaupaci', 'Jesúpolis', 'Joviânia', 'Jussara', 'Lagoa Santa', 'Leopoldo de Bulhões', 'Luziânia', 'Mairipotaba', 'Mambaí', 'Mara Rosa', 'Marzagão', 'Matrinchã', 'Maurilândia', 'Mimoso de Goiás', 'Minaçu', 'Mineiros', 'Moiporá', 'Monte Alegre de Goiás', 'Montes Claros de Goiás', 'Montividiu', 'Montividiu do Norte', 'Morrinhos', 'Morro Agudo de Goiás', 'Mossâmedes', 'Mozarlândia', 'Mundo Novo', 'Mutunópolis', 'Nazário', 'Nerópolis', 'Niquelândia', 'Nova América', 'Nova Aurora', 'Nova Crixás', 'Nova Glória', 'Nova Iguaçu de Goiás', 'Nova Roma', 'Nova Veneza', 'Novo Brasil', 'Novo Gama', 'Novo Planalto', 'Orizona', 'Ouro Verde de Goiás', 'Ouvidor', 'Padre Bernardo', 'Palestina de Goiás', 'Palmeiras de Goiás', 'Palmelo', 'Palminópolis', 'Panamá', 'Paranaiguara', 'Paraúna', 'Perolândia', 'Petrolina de Goiás', 'Pilar de Goiás', 'Piracanjuba', 'Piranhas', 'Pirenópolis', 'Pires do Rio', 'Planaltina', 'Pontalina', 'Porangatu', 'Porteirão', 'Portelândia', 'Posse', 'Professor Jamil', 'Quirinópolis', 'Rialma', 'Rianápolis', 'Rio Quente', 'Rio Verde', 'Rubiataba', 'Sanclerlândia', 'Santa Bárbara de Goiás', 'Santa Cruz de Goiás', 'Santa Fé de Goiás', 'Santa Helena de Goiás', 'Santa Isabel', 'Santa Rita do Araguaia', 'Santa Rita do Novo Destino', 'Santa Rosa de Goiás', 'Santa Tereza de Goiás', 'Santa Terezinha de Goiás', 'Santo Antônio da Barra', 'Santo Antônio de Goiás', 'Santo Antônio do Descoberto', 'São Domingos', 'São Francisco de Goiás', 'São João d\'Aliança', 'São João da Paraúna', 'São Luís de Montes Belos', 'São Luíz do Norte', 'São Miguel do Araguaia', 'São Miguel do Passa Quatro', 'São Patrício', 'São Simão', 'Senador Canedo', 'Serranópolis', 'Silvânia', 'Simolândia', 'Sítio d\'Abadia', 'Taquaral de Goiás', 'Teresina de Goiás', 'Terezópolis de Goiás', 'Três Ranchos', 'Trindade', 'Trombas', 'Turvânia', 'Turvelândia', 'Uirapuru', 'Uruaçu', 'Uruana', 'Urutaí', 'Valparaíso de Goiás', 'Varjão', 'Vianópolis', 'Vicentinópolis', 'Vila Boa', 'Vila Propício',
    ], ['Açailândia', 'Afonso Cunha', 'Água Doce do Maranhão', 'Alcântara', 'Aldeias Altas', 'Altamira do Maranhão', 'Alto Alegre do Maranhão', 'Alto Alegre do Pindaré', 'Alto Parnaíba', 'Amapá do Maranhão', 'Amarante do Maranhão', 'Anajatuba', 'Anapurus', 'Apicum-Açu', 'Araguanã', 'Araioses', 'Arame', 'Arari', 'Axixá', 'Bacabal', 'Bacabeira', 'Bacuri', 'Bacurituba', 'Balsas', 'Barão de Grajaú', 'Barra do Corda', 'Barreirinhas', 'Bela Vista do Maranhão', 'Belágua', 'Benedito Leite', 'Bequimão', 'Bernardo do Mearim', 'Boa Vista do Gurupi', 'Bom Jardim', 'Bom Jesus das Selvas', 'Bom Lugar', 'Brejo', 'Brejo de Areia', 'Buriti', 'Buriti Bravo', 'Buriticupu', 'Buritirana', 'Cachoeira Grande', 'Cajapió', 'Cajari', 'Campestre do Maranhão', 'Cândido Mendes', 'Cantanhede', 'Capinzal do Norte', 'Carolina', 'Carutapera', 'Caxias', 'Cedral', 'Central do Maranhão', 'Centro do Guilherme', 'Centro Novo do Maranhão', 'Chapadinha', 'Cidelândia', 'Codó', 'Coelho Neto', 'Colinas', 'Conceição do Lago-Açu', 'Coroatá', 'Cururupu', 'Davinópolis', 'Dom Pedro', 'Duque Bacelar', 'Esperantinópolis', 'Estreito', 'Feira Nova do Maranhão', 'Fernando Falcão', 'Formosa da Serra Negra', 'Fortaleza dos Nogueiras', 'Fortuna', 'Godofredo Viana', 'Gonçalves Dias', 'Governador Archer', 'Governador Edison Lobão', 'Governador Eugênio Barros', 'Governador Luiz Rocha', 'Governador Newton Bello', 'Governador Nunes Freire', 'Graça Aranha', 'Grajaú', 'Guimarães', 'Humberto de Campos', 'Icatu', 'Igarapé do Meio', 'Igarapé Grande', 'Imperatriz', 'Itaipava do Grajaú', 'Itapecuru Mirim', 'Itinga do Maranhão', 'Jatobá', 'Jenipapo dos Vieiras', 'João Lisboa', 'Joselândia', 'Junco do Maranhão', 'Lago da Pedra', 'Lago do Junco', 'Lago dos Rodrigues', 'Lago Verde', 'Lagoa do Mato', 'Lagoa Grande do Maranhão', 'Lajeado Novo', 'Lima Campos', 'Loreto', 'Luís Domingues', 'Magalhães de Almeida', 'Maracaçumé', 'Marajá do Sena', 'Maranhãozinho', 'Mata Roma', 'Matinha', 'Matões', 'Matões do Norte', 'Milagres do Maranhão', 'Mirador', 'Miranda do Norte', 'Mirinzal', 'Monção', 'Montes Altos', 'Morros', 'Nina Rodrigues', 'Nova Colinas', 'Nova Iorque', 'Nova Olinda do Maranhão', 'Olho d\'Água das Cunhãs', 'Olinda Nova do Maranhão', 'Paço do Lumiar', 'Palmeirândia', 'Paraibano', 'Parnarama', 'Passagem Franca', 'Pastos Bons', 'Paulino Neves', 'Paulo Ramos', 'Pedreiras', 'Pedro do Rosário', 'Penalva', 'Peri Mirim', 'Peritoró', 'Pindaré Mirim', 'Pinheiro', 'Pio XII', 'Pirapemas', 'Poção de Pedras', 'Porto Franco', 'Porto Rico do Maranhão', 'Presidente Dutra', 'Presidente Juscelino', 'Presidente Médici', 'Presidente Sarney', 'Presidente Vargas', 'Primeira Cruz', 'Raposa', 'Riachão', 'Ribamar Fiquene', 'Rosário', 'Sambaíba', 'Santa Filomena do Maranhão', 'Santa Helena', 'Santa Inês', 'Santa Luzia', 'Santa Luzia do Paruá', 'Santa Quitéria do Maranhão', 'Santa Rita', 'Santana do Maranhão', 'Santo Amaro do Maranhão', 'Santo Antônio dos Lopes', 'São Benedito do Rio Preto', 'São Bento', 'São Bernardo', 'São Domingos do Azeitão', 'São Domingos do Maranhão', 'São Félix de Balsas', 'São Francisco do Brejão', 'São Francisco do Maranhão', 'São João Batista', 'São João do Carú', 'São João do Paraíso', 'São João do Soter', 'São João dos Patos', 'São José de Ribamar', 'São José dos Basílios', 'São Luís', 'São Luís Gonzaga do Maranhão', 'São Mateus do Maranhão', 'São Pedro da Água Branca', 'São Pedro dos Crentes', 'São Raimundo das Mangabeiras', 'São Raimundo do Doca Bezerra', 'São Roberto', 'São Vicente Ferrer', 'Satubinha', 'Senador Alexandre Costa', 'Senador La Rocque', 'Serrano do Maranhão', 'Sítio Novo', 'Sucupira do Norte', 'Sucupira do Riachão', 'Tasso Fragoso', 'Timbiras', 'Timon', 'Trizidela do Vale', 'Tufilândia', 'Tuntum', 'Turiaçu', 'Turilândia', 'Tutóia', 'Urbano Santos', 'Vargem Grande', 'Viana', 'Vila Nova dos Martírios', 'Vitória do Mearim', 'Vitorino Freire', 'Zé Doca',
    ], ['Abadia dos Dourados', 'Abaeté', 'Abre Campo', 'Acaiaca', 'Açucena', 'Água Boa', 'Água Comprida', 'Aguanil', 'Águas Formosas', 'Águas Vermelhas', 'Aimorés', 'Aiuruoca', 'Alagoa', 'Albertina', 'Além Paraíba', 'Alfenas', 'Alfredo Vasconcelos', 'Almenara', 'Alpercata', 'Alpinópolis', 'Alterosa', 'Alto Caparaó', 'Alto Jequitibá', 'Alto Rio Doce', 'Alvarenga', 'Alvinópolis', 'Alvorada de Minas', 'Amparo do Serra', 'Andradas', 'Andrelândia', 'Angelândia', 'Antônio Carlos', 'Antônio Dias', 'Antônio Prado de Minas', 'Araçaí', 'Aracitaba', 'Araçuaí', 'Araguari', 'Arantina', 'Araponga', 'Araporã', 'Arapuá', 'Araújos', 'Araxá', 'Arceburgo', 'Arcos', 'Areado', 'Argirita', 'Aricanduva', 'Arinos', 'Astolfo Dutra', 'Ataléia', 'Augusto de Lima', 'Baependi', 'Baldim', 'Bambuí', 'Bandeira', 'Bandeira do Sul', 'Barão de Cocais', 'Barão de Monte Alto', 'Barbacena', 'Barra Longa', 'Barroso', 'Bela Vista de Minas', 'Belmiro Braga', 'Belo Horizonte', 'Belo Oriente', 'Belo Vale', 'Berilo', 'Berizal', 'Bertópolis', 'Betim', 'Bias Fortes', 'Bicas', 'Biquinhas', 'Boa Esperança', 'Bocaina de Minas', 'Bocaiúva', 'Bom Despacho', 'Bom Jardim de Minas', 'Bom Jesus da Penha', 'Bom Jesus do Amparo', 'Bom Jesus do Galho', 'Bom Repouso', 'Bom Sucesso', 'Bonfim', 'Bonfinópolis de Minas', 'Bonito de Minas', 'Borda da Mata', 'Botelhos', 'Botumirim', 'Brás Pires', 'Brasilândia de Minas', 'Brasília de Minas', 'Brasópolis', 'Braúnas', 'Brumadinho', 'Bueno Brandão', 'Buenópolis', 'Bugre', 'Buritis', 'Buritizeiro', 'Cabeceira Grande', 'Cabo Verde', 'Cachoeira da Prata', 'Cachoeira de Minas', 'Cachoeira de Pajeú', 'Cachoeira Dourada', 'Caetanópolis', 'Caeté', 'Caiana', 'Cajuri', 'Caldas', 'Camacho', 'Camanducaia', 'Cambuí', 'Cambuquira', 'Campanário', 'Campanha', 'Campestre', 'Campina Verde', 'Campo Azul', 'Campo Belo', 'Campo do Meio', 'Campo Florido', 'Campos Altos', 'Campos Gerais', 'Cana Verde', 'Canaã', 'Canápolis', 'Candeias', 'Cantagalo', 'Caparaó', 'Capela Nova', 'Capelinha', 'Capetinga', 'Capim Branco', 'Capinópolis', 'Capitão Andrade', 'Capitão Enéas', 'Capitólio', 'Caputira', 'Caraí', 'Caranaíba', 'Carandaí', 'Carangola', 'Caratinga', 'Carbonita', 'Careaçu', 'Carlos Chagas', 'Carmésia', 'Carmo da Cachoeira', 'Carmo da Mata', 'Carmo de Minas', 'Carmo do Cajuru', 'Carmo do Paranaíba', 'Carmo do Rio Claro', 'Carmópolis de Minas', 'Carneirinho', 'Carrancas', 'Carvalhópolis', 'Carvalhos', 'Casa Grande', 'Cascalho Rico', 'Cássia', 'Cataguases', 'Catas Altas', 'Catas Altas da Noruega', 'Catuji', 'Catuti', 'Caxambu', 'Cedro do Abaeté', 'Central de Minas', 'Centralina', 'Chácara', 'Chalé', 'Chapada do Norte', 'Chapada Gaúcha', 'Chiador', 'Cipotânea', 'Claraval', 'Claro dos Poções', 'Cláudio', 'Coimbra', 'Coluna', 'Comendador Gomes', 'Comercinho', 'Conceição da Aparecida', 'Conceição da Barra de Minas', 'Conceição das Alagoas', 'Conceição das Pedras', 'Conceição de Ipanema', 'Conceição do Mato Dentro', 'Conceição do Pará', 'Conceição do Rio Verde', 'Conceição dos Ouros', 'Cônego Marinho', 'Confins', 'Congonhal', 'Congonhas', 'Congonhas do Norte', 'Conquista', 'Conselheiro Lafaiete', 'Conselheiro Pena', 'Consolação', 'Contagem', 'Coqueiral', 'Coração de Jesus', 'Cordisburgo', 'Cordislândia', 'Corinto', 'Coroaci', 'Coromandel', 'Coronel Fabriciano', 'Coronel Murta', 'Coronel Pacheco', 'Coronel Xavier Chaves', 'Córrego Danta', 'Córrego do Bom Jesus', 'Córrego Fundo', 'Córrego Novo', 'Couto de Magalhães de Minas', 'Crisólita', 'Cristais', 'Cristália', 'Cristiano Otoni', 'Cristina', 'Crucilândia', 'Cruzeiro da Fortaleza', 'Cruzília', 'Cuparaque', 'Curral de Dentro', 'Curvelo', 'Datas', 'Delfim Moreira', 'Delfinópolis', 'Delta', 'Descoberto', 'Desterro de Entre Rios', 'Desterro do Melo', 'Diamantina', 'Diogo de Vasconcelos', 'Dionísio', 'Divinésia', 'Divino', 'Divino das Laranjeiras', 'Divinolândia de Minas', 'Divinópolis', 'Divisa Alegre', 'Divisa Nova', 'Divisópolis', 'Dom Bosco', 'Dom Cavati', 'Dom Joaquim', 'Dom Silvério', 'Dom Viçoso', 'Dona Euzébia', 'Dores de Campos', 'Dores de Guanhães', 'Dores do Indaiá', 'Dores do Turvo', 'Doresópolis', 'Douradoquara', 'Durandé', 'Elói Mendes', 'Engenheiro Caldas', 'Engenheiro Navarro', 'Entre Folhas', 'Entre Rios de Minas', 'Ervália', 'Esmeraldas', 'Espera Feliz', 'Espinosa', 'Espírito Santo do Dourado', 'Estiva', 'Estrela Dalva', 'Estrela do Indaiá', 'Estrela do Sul', 'Eugenópolis', 'Ewbank da Câmara', 'Extrema', 'Fama', 'Faria Lemos', 'Felício dos Santos', 'Felisburgo', 'Felixlândia', 'Fernandes Tourinho', 'Ferros', 'Fervedouro', 'Florestal', 'Formiga', 'Formoso', 'Fortaleza de Minas', 'Fortuna de Minas', 'Francisco Badaró', 'Francisco Dumont', 'Francisco Sá', 'Franciscópolis', 'Frei Gaspar', 'Frei Inocêncio', 'Frei Lagonegro', 'Fronteira', 'Fronteira dos Vales', 'Fruta de Leite', 'Frutal', 'Funilândia', 'Galiléia', 'Gameleiras', 'Glaucilândia', 'Goiabeira', 'Goianá', 'Gonçalves', 'Gonzaga', 'Gouveia', 'Governador Valadares', 'Grão Mogol', 'Grupiara', 'Guanhães', 'Guapé', 'Guaraciaba', 'Guaraciama', 'Guaranésia', 'Guarani', 'Guarará', 'Guarda-Mor', 'Guaxupé', 'Guidoval', 'Guimarânia', 'Guiricema', 'Gurinhatã', 'Heliodora', 'Iapu', 'Ibertioga', 'Ibiá', 'Ibiaí', 'Ibiracatu', 'Ibiraci', 'Ibirité', 'Ibitiúra de Minas', 'Ibituruna', 'Icaraí de Minas', 'Igarapé', 'Igaratinga', 'Iguatama', 'Ijaci', 'Ilicínea', 'Imbé de Minas', 'Inconfidentes', 'Indaiabira', 'Indianópolis', 'Ingaí', 'Inhapim', 'Inhaúma', 'Inimutaba', 'Ipaba', 'Ipanema', 'Ipatinga', 'Ipiaçu', 'Ipuiúna', 'Iraí de Minas', 'Itabira', 'Itabirinha de Mantena', 'Itabirito', 'Itacambira', 'Itacarambi', 'Itaguara', 'Itaipé', 'Itajubá', 'Itamarandiba', 'Itamarati de Minas', 'Itambacuri', 'Itambé do Mato Dentro', 'Itamogi', 'Itamonte', 'Itanhandu', 'Itanhomi', 'Itaobim', 'Itapagipe', 'Itapecerica', 'Itapeva', 'Itatiaiuçu', 'Itaú de Minas', 'Itaúna', 'Itaverava', 'Itinga', 'Itueta', 'Ituiutaba', 'Itumirim', 'Iturama', 'Itutinga', 'Jaboticatubas', 'Jacinto', 'Jacuí', 'Jacutinga', 'Jaguaraçu', 'Jaíba', 'Jampruca', 'Janaúba', 'Januária', 'Japaraíba', 'Japonvar', 'Jeceaba', 'Jenipapo de Minas', 'Jequeri', 'Jequitaí', 'Jequitibá', 'Jequitinhonha', 'Jesuânia', 'Joaíma', 'Joanésia', 'João Monlevade', 'João Pinheiro', 'Joaquim Felício', 'Jordânia', 'José Gonçalves de Minas', 'José Raydan', 'Josenópolis', 'Juatuba', 'Juiz de Fora', 'Juramento', 'Juruaia', 'Juvenília', 'Ladainha', 'Lagamar', 'Lagoa da Prata', 'Lagoa dos Patos', 'Lagoa Dourada', 'Lagoa Formosa', 'Lagoa Grande', 'Lagoa Santa', 'Lajinha', 'Lambari', 'Lamim', 'Laranjal', 'Lassance', 'Lavras', 'Leandro Ferreira', 'Leme do Prado', 'Leopoldina', 'Liberdade', 'Lima Duarte', 'Limeira do Oeste', 'Lontra', 'Luisburgo', 'Luislândia', 'Luminárias', 'Luz', 'Machacalis', 'Machado', 'Madre de Deus de Minas', 'Malacacheta', 'Mamonas', 'Manga', 'Manhuaçu', 'Manhumirim', 'Mantena', 'Mar de Espanha', 'Maravilhas', 'Maria da Fé', 'Mariana', 'Marilac', 'Mário Campos', 'Maripá de Minas', 'Marliéria', 'Marmelópolis', 'Martinho Campos', 'Martins Soares', 'Mata Verde', 'Materlândia', 'Mateus Leme', 'Mathias Lobato', 'Matias Barbosa', 'Matias Cardoso', 'Matipó', 'Mato Verde', 'Matozinhos', 'Matutina', 'Medeiros', 'Medina', 'Mendes Pimentel', 'Mercês', 'Mesquita', 'Minas Novas', 'Minduri', 'Mirabela', 'Miradouro', 'Miraí', 'Miravânia', 'Moeda', 'Moema', 'Monjolos', 'Monsenhor Paulo', 'Montalvânia', 'Monte Alegre de Minas', 'Monte Azul', 'Monte Belo', 'Monte Carmelo', 'Monte Formoso', 'Monte Santo de Minas', 'Monte Sião', 'Montes Claros', 'Montezuma', 'Morada Nova de Minas', 'Morro da Garça', 'Morro do Pilar', 'Munhoz', 'Muriaé', 'Mutum', 'Muzambinho', 'Nacip Raydan', 'Nanuque', 'Naque', 'Natalândia', 'Natércia', 'Nazareno', 'Nepomuceno', 'Ninheira', 'Nova Belém', 'Nova Era', 'Nova Lima', 'Nova Módica', 'Nova Ponte', 'Nova Porteirinha', 'Nova Resende', 'Nova Serrana', 'Nova União', 'Novo Cruzeiro', 'Novo Oriente de Minas', 'Novorizonte', 'Olaria', 'Olhos-d\'Água', 'Olímpio Noronha', 'Oliveira', 'Oliveira Fortes', 'Onça de Pitangui', 'Oratórios', 'Orizânia', 'Ouro Branco', 'Ouro Fino', 'Ouro Preto', 'Ouro Verde de Minas', 'Padre Carvalho', 'Padre Paraíso', 'Pai Pedro', 'Paineiras', 'Pains', 'Paiva', 'Palma', 'Palmópolis', 'Papagaios', 'Pará de Minas', 'Paracatu', 'Paraguaçu', 'Paraisópolis', 'Paraopeba', 'Passa Quatro', 'Passa Tempo', 'Passa-Vinte', 'Passabém', 'Passos', 'Patis', 'Patos de Minas', 'Patrocínio', 'Patrocínio do Muriaé', 'Paula Cândido', 'Paulistas', 'Pavão', 'Peçanha', 'Pedra Azul', 'Pedra Bonita', 'Pedra do Anta', 'Pedra do Indaiá', 'Pedra Dourada', 'Pedralva', 'Pedras de Maria da Cruz', 'Pedrinópolis', 'Pedro Leopoldo', 'Pedro Teixeira', 'Pequeri', 'Pequi', 'Perdigão', 'Perdizes', 'Perdões', 'Periquito', 'Pescador', 'Piau', 'Piedade de Caratinga', 'Piedade de Ponte Nova', 'Piedade do Rio Grande', 'Piedade dos Gerais', 'Pimenta', 'Pingo-d\'Água', 'Pintópolis', 'Piracema', 'Pirajuba', 'Piranga', 'Piranguçu', 'Piranguinho', 'Pirapetinga', 'Pirapora', 'Piraúba', 'Pitangui', 'Piumhi', 'Planura', 'Poço Fundo', 'Poços de Caldas', 'Pocrane', 'Pompéu', 'Ponte Nova', 'Ponto Chique', 'Ponto dos Volantes', 'Porteirinha', 'Porto Firme', 'Poté', 'Pouso Alegre', 'Pouso Alto', 'Prados', 'Prata', 'Pratápolis', 'Pratinha', 'Presidente Bernardes', 'Presidente Juscelino', 'Presidente Kubitschek', 'Presidente Olegário', 'Prudente de Morais', 'Quartel Geral', 'Queluzito', 'Raposos', 'Raul Soares', 'Recreio', 'Reduto', 'Resende Costa', 'Resplendor', 'Ressaquinha', 'Riachinho', 'Riacho dos Machados', 'Ribeirão das Neves', 'Ribeirão Vermelho', 'Rio Acima', 'Rio Casca', 'Rio do Prado', 'Rio Doce', 'Rio Espera', 'Rio Manso', 'Rio Novo', 'Rio Paranaíba', 'Rio Pardo de Minas', 'Rio Piracicaba', 'Rio Pomba', 'Rio Preto', 'Rio Vermelho', 'Ritápolis', 'Rochedo de Minas', 'Rodeiro', 'Romaria', 'Rosário da Limeira', 'Rubelita', 'Rubim', 'Sabará', 'Sabinópolis', 'Sacramento', 'Salinas', 'Salto da Divisa', 'Santa Bárbara', 'Santa Bárbara do Leste', 'Santa Bárbara do Monte Verde', 'Santa Bárbara do Tugúrio', 'Santa Cruz de Minas', 'Santa Cruz de Salinas', 'Santa Cruz do Escalvado', 'Santa Efigênia de Minas', 'Santa Fé de Minas', 'Santa Helena de Minas', 'Santa Juliana', 'Santa Luzia', 'Santa Margarida', 'Santa Maria de Itabira', 'Santa Maria do Salto', 'Santa Maria do Suaçuí', 'Santa Rita de Caldas', 'Santa Rita de Ibitipoca', 'Santa Rita de Jacutinga', 'Santa Rita de Minas', 'Santa Rita do Itueto', 'Santa Rita do Sapucaí', 'Santa Rosa da Serra', 'Santa Vitória', 'Santana da Vargem', 'Santana de Cataguases', 'Santana de Pirapama', 'Santana do Deserto', 'Santana do Garambéu', 'Santana do Jacaré', 'Santana do Manhuaçu', 'Santana do Paraíso', 'Santana do Riacho', 'Santana dos Montes', 'Santo Antônio do Amparo', 'Santo Antônio do Aventureiro', 'Santo Antônio do Grama', 'Santo Antônio do Itambé', 'Santo Antônio do Jacinto', 'Santo Antônio do Monte', 'Santo Antônio do Retiro', 'Santo Antônio do Rio Abaixo', 'Santo Hipólito', 'Santos Dumont', 'São Bento Abade', 'São Brás do Suaçuí', 'São Domingos das Dores', 'São Domingos do Prata', 'São Félix de Minas', 'São Francisco', 'São Francisco de Paula', 'São Francisco de Sales', 'São Francisco do Glória', 'São Geraldo', 'São Geraldo da Piedade', 'São Geraldo do Baixio', 'São Gonçalo do Abaeté', 'São Gonçalo do Pará', 'São Gonçalo do Rio Abaixo', 'São Gonçalo do Rio Preto', 'São Gonçalo do Sapucaí', 'São Gotardo', 'São João Batista do Glória', 'São João da Lagoa', 'São João da Mata', 'São João da Ponte', 'São João das Missões', 'São João del Rei', 'São João do Manhuaçu', 'São João do Manteninha', 'São João do Oriente', 'São João do Pacuí', 'São João do Paraíso', 'São João Evangelista', 'São João Nepomuceno', 'São Joaquim de Bicas', 'São José da Barra', 'São José da Lapa', 'São José da Safira', 'São José da Varginha', 'São José do Alegre', 'São José do Divino', 'São José do Goiabal', 'São José do Jacuri', 'São José do Mantimento', 'São Lourenço', 'São Miguel do Anta', 'São Pedro da União', 'São Pedro do Suaçuí', 'São Pedro dos Ferros', 'São Romão', 'São Roque de Minas', 'São Sebastião da Bela Vista', 'São Sebastião da Vargem Alegre', 'São Sebastião do Anta', 'São Sebastião do Maranhão', 'São Sebastião do Oeste', 'São Sebastião do Paraíso', 'São Sebastião do Rio Preto', 'São Sebastião do Rio Verde', 'São Thomé das Letras', 'São Tiago', 'São Tomás de Aquino', 'São Vicente de Minas', 'Sapucaí-Mirim', 'Sardoá', 'Sarzedo', 'Sem-Peixe', 'Senador Amaral', 'Senador Cortes', 'Senador Firmino', 'Senador José Bento', 'Senador Modestino Gonçalves', 'Senhora de Oliveira', 'Senhora do Porto', 'Senhora dos Remédios', 'Sericita', 'Seritinga', 'Serra Azul de Minas', 'Serra da Saudade', 'Serra do Salitre', 'Serra dos Aimorés', 'Serrania', 'Serranópolis de Minas', 'Serranos', 'Serro', 'Sete Lagoas', 'Setubinha', 'Silveirânia', 'Silvianópolis', 'Simão Pereira', 'Simonésia', 'Sobrália', 'Soledade de Minas', 'Tabuleiro', 'Taiobeiras', 'Taparuba', 'Tapira', 'Tapiraí', 'Taquaraçu de Minas', 'Tarumirim', 'Teixeiras', 'Teófilo Otoni', 'Timóteo', 'Tiradentes', 'Tiros', 'Tocantins', 'Tocos do Moji', 'Toledo', 'Tombos', 'Três Corações', 'Três Marias', 'Três Pontas', 'Tumiritinga', 'Tupaciguara', 'Turmalina', 'Turvolândia', 'Ubá', 'Ubaí', 'Ubaporanga', 'Uberaba', 'Uberlândia', 'Umburatiba', 'Unaí', 'União de Minas', 'Uruana de Minas', 'Urucânia', 'Urucuia', 'Vargem Alegre', 'Vargem Bonita', 'Vargem Grande do Rio Pardo', 'Varginha', 'Varjão de Minas', 'Várzea da Palma', 'Varzelândia', 'Vazante', 'Verdelândia', 'Veredinha', 'Veríssimo', 'Vermelho Novo', 'Vespasiano', 'Viçosa', 'Vieiras', 'Virgem da Lapa', 'Virgínia', 'Virginópolis', 'Virgolândia', 'Visconde do Rio Branco', 'Volta Grande', 'Wenceslau Braz',
    ], ['Água Clara', 'Alcinópolis', 'Amambaí', 'Anastácio', 'Anaurilândia', 'Angélica', 'Antônio João', 'Aparecida do Taboado', 'Aquidauana', 'Aral Moreira', 'Bandeirantes', 'Bataguassu', 'Bataiporã', 'Bela Vista', 'Bodoquena', 'Bonito', 'Brasilândia', 'Caarapó', 'Camapuã', 'Campo Grande', 'Caracol', 'Cassilândia', 'Chapadão do Sul', 'Corguinho', 'Coronel Sapucaia', 'Corumbá', 'Costa Rica', 'Coxim', 'Deodápolis', 'Dois Irmãos do Buriti', 'Douradina', 'Dourados', 'Eldorado', 'Fátima do Sul', 'Glória de Dourados', 'Guia Lopes da Laguna', 'Iguatemi', 'Inocência', 'Itaporã', 'Itaquiraí', 'Ivinhema', 'Japorã', 'Jaraguari', 'Jardim', 'Jateí', 'Juti', 'Ladário', 'Laguna Carapã', 'Maracaju', 'Miranda', 'Mundo Novo', 'Naviraí', 'Nioaque', 'Nova Alvorada do Sul', 'Nova Andradina', 'Novo Horizonte do Sul', 'Paranaíba', 'Paranhos', 'Pedro Gomes', 'Ponta Porã', 'Porto Murtinho', 'Ribas do Rio Pardo', 'Rio Brilhante', 'Rio Negro', 'Rio Verde de Mato Grosso', 'Rochedo', 'Santa Rita do Pardo', 'São Gabriel do Oeste', 'Selvíria', 'Sete Quedas', 'Sidrolândia', 'Sonora', 'Tacuru', 'Taquarussu', 'Terenos', 'Três Lagoas', 'Vicentina',
    ], ['Acorizal', 'Água Boa', 'Alta Floresta', 'Alto Araguaia', 'Alto Boa Vista', 'Alto Garças', 'Alto Paraguai', 'Alto Taquari', 'Apiacás', 'Araguaiana', 'Araguainha', 'Araputanga', 'Arenápolis', 'Aripuanã', 'Barão de Melgaço', 'Barra do Bugres', 'Barra do Garças', 'Bom Jesus do Araguaia', 'Brasnorte', 'Cáceres', 'Campinápolis', 'Campo Novo do Parecis', 'Campo Verde', 'Campos de Júlio', 'Canabrava do Norte', 'Canarana', 'Carlinda', 'Castanheira', 'Chapada dos Guimarães', 'Cláudia', 'Cocalinho', 'Colíder', 'Colniza', 'Comodoro', 'Confresa', 'Conquista d\'Oeste', 'Cotriguaçu', 'Curvelândia', 'Cuiabá', 'Denise', 'Diamantino', 'Dom Aquino', 'Feliz Natal', 'Figueirópolis d\'Oeste', 'Gaúcha do Norte', 'General Carneiro', 'Glória d\'Oeste', 'Guarantã do Norte', 'Guiratinga', 'Indiavaí', 'Itaúba', 'Itiquira', 'Jaciara', 'Jangada', 'Jauru', 'Juara', 'Juína', 'Juruena', 'Juscimeira', 'Lambari d\'Oeste', 'Lucas do Rio Verde', 'Luciára', 'Marcelândia', 'Matupá', 'Mirassol d\'Oeste', 'Nobres', 'Nortelândia', 'Nossa Senhora do Livramento', 'Nova Bandeirantes', 'Nova Brasilândia', 'Nova Canãa do Norte', 'Nova Guarita', 'Nova Lacerda', 'Nova Marilândia', 'Nova Maringá', 'Nova Monte Verde', 'Nova Mutum', 'Nova Nazaré', 'Nova Olímpia', 'Nova Santa Helena', 'Nova Ubiratã', 'Nova Xavantina', 'Novo Horizonte do Norte', 'Novo Mundo', 'Novo Santo Antônio', 'Novo São Joaquim', 'Paranaíta', 'Paranatinga', 'Pedra Preta', 'Peixoto de Azevedo', 'Planalto da Serra', 'Poconé', 'Pontal do Araguaia', 'Ponte Branca', 'Pontes e Lacerda', 'Porto Alegre do Norte', 'Porto dos Gaúchos', 'Porto Esperidião', 'Porto Estrela', 'Poxoréo', 'Primavera do Leste', 'Querência', 'Reserva do Cabaçal', 'Ribeirão Cascalheira', 'Ribeirãozinho', 'Rio Branco', 'Rondolândia', 'Rondonópolis', 'Rosário Oeste', 'Salto do Céu', 'Santa Carmem', 'Santa Cruz do Xingu', 'Santa Rita do Trivelato', 'Santa Terezinha', 'Santo Afonso', 'Santo Antônio do Leste', 'Santo Antônio do Leverger', 'São Félix do Araguaia', 'São José do Povo', 'São José do Rio Claro', 'São José do Xingu', 'São José dos Quatro Marcos', 'São Pedro da Cipa', 'Sapezal', 'Serra Nova Dourada', 'Sinop', 'Sorriso', 'Tabaporã', 'Tangará da Serra', 'Tapurah', 'Terra Nova do Norte', 'Tesouro', 'Torixoréu', 'União do Sul', 'Vale de São Domingos', 'Várzea Grande', 'Vera', 'Vila Bela da Santíssima Trindade', 'Vila Rica',
    ], ['Abaetetuba', 'Abel Figueiredo', 'Acará', 'Afuá', 'Água Azul do Norte', 'Alenquer', 'Almeirim', 'Altamira', 'Anajás', 'Ananindeua', 'Anapu', 'Augusto Corrêa', 'Aurora do Pará', 'Aveiro', 'Bagre', 'Baião', 'Bannach', 'Barcarena', 'Belém', 'Belterra', 'Benevides', 'Bom Jesus do Tocantins', 'Bonito', 'Bragança', 'Brasil Novo', 'Brejo Grande do Araguaia', 'Breu Branco', 'Breves', 'Bujaru', 'Cachoeira do Arari', 'Cachoeira do Piriá', 'Cametá', 'Canaã dos Carajás', 'Capanema', 'Capitão Poço', 'Castanhal', 'Chaves', 'Colares', 'Conceição do Araguaia', 'Concórdia do Pará', 'Cumaru do Norte', 'Curionópolis', 'Curralinho', 'Curuá', 'Curuçá', 'Dom Eliseu', 'Eldorado dos Carajás', 'Faro', 'Floresta do Araguaia', 'Garrafão do Norte', 'Goianésia do Pará', 'Gurupá', 'Igarapé-Açu', 'Igarapé-Miri', 'Inhangapi', 'Ipixuna do Pará', 'Irituia', 'Itaituba', 'Itupiranga', 'Jacareacanga', 'Jacundá', 'Juruti', 'Limoeiro do Ajuru', 'Mãe do Rio', 'Magalhães Barata', 'Marabá', 'Maracanã', 'Marapanim', 'Marituba', 'Medicilândia', 'Melgaço', 'Mocajuba', 'Moju', 'Monte Alegre', 'Muaná', 'Nova Esperança do Piriá', 'Nova Ipixuna', 'Nova Timboteua', 'Novo Progresso', 'Novo Repartimento', 'Óbidos', 'Oeiras do Pará', 'Oriximiná', 'Ourém', 'Ourilândia do Norte', 'Pacajá', 'Palestina do Pará', 'Paragominas', 'Parauapebas', 'Pau d\'Arco', 'Peixe-Boi', 'Piçarra', 'Placas', 'Ponta de Pedras', 'Portel', 'Porto de Moz', 'Prainha', 'Primavera', 'Quatipuru', 'Redenção', 'Rio Maria', 'Rondon do Pará', 'Rurópolis', 'Salinópolis', 'Salvaterra', 'Santa Bárbara do Pará', 'Santa Cruz do Arari', 'Santa Isabel do Pará', 'Santa Luzia do Pará', 'Santa Maria das Barreiras', 'Santa Maria do Pará', 'Santana do Araguaia', 'Santarém', 'Santarém Novo', 'Santo Antônio do Tauá', 'São Caetano de Odivela', 'São Domingos do Araguaia', 'São Domingos do Capim', 'São Félix do Xingu', 'São Francisco do Pará', 'São Geraldo do Araguaia', 'São João da Ponta', 'São João de Pirabas', 'São João do Araguaia', 'São Miguel do Guamá', 'São Sebastião da Boa Vista', 'Sapucaia', 'Senador José Porfírio', 'Soure', 'Tailândia', 'Terra Alta', 'Terra Santa', 'Tomé-Açu', 'Tracuateua', 'Trairão', 'Tucumã', 'Tucuruí', 'Ulianópolis', 'Uruará', 'Vigia', 'Viseu', 'Vitória do Xingu', 'Xinguara',
    ], ['Água Branca', 'Aguiar', 'Alagoa Grande', 'Alagoa Nova', 'Alagoinha', 'Alcantil', 'Algodão de Jandaíra', 'Alhandra', 'Amparo', 'Aparecida', 'Araçagi', 'Arara', 'Araruna', 'Areia', 'Areia de Baraúnas', 'Areial', 'Aroeiras', 'Assunção', 'Baía da Traição', 'Bananeiras', 'Baraúna', 'Barra de Santa Rosa', 'Barra de Santana', 'Barra de São Miguel', 'Bayeux', 'Belém', 'Belém do Brejo do Cruz', 'Bernardino Batista', 'Boa Ventura', 'Boa Vista', 'Bom Jesus', 'Bom Sucesso', 'Bonito de Santa Fé', 'Boqueirão', 'Borborema', 'Brejo do Cruz', 'Brejo dos Santos', 'Caaporã', 'Cabaceiras', 'Cabedelo', 'Cachoeira dos Índios', 'Cacimba de Areia', 'Cacimba de Dentro', 'Cacimbas', 'Caiçara', 'Cajazeiras', 'Cajazeirinhas', 'Caldas Brandão', 'Camalaú', 'Campina Grande', 'Campo de Santana', 'Capim', 'Caraúbas', 'Carrapateira', 'Casserengue', 'Catingueira', 'Catolé do Rocha', 'Caturité', 'Conceição', 'Condado', 'Conde', 'Congo', 'Coremas', 'Coxixola', 'Cruz do Espírito Santo', 'Cubati', 'Cuité', 'Cuité de Mamanguape', 'Cuitegi', 'Curral de Cima', 'Curral Velho', 'Damião', 'Desterro', 'Diamante', 'Dona Inês', 'Duas Estradas', 'Emas', 'Esperança', 'Fagundes', 'Frei Martinho', 'Gado Bravo', 'Guarabira', 'Gurinhém', 'Gurjão', 'Ibiara', 'Igaracy', 'Imaculada', 'Ingá', 'Itabaiana', 'Itaporanga', 'Itapororoca', 'Itatuba', 'Jacaraú', 'Jericó', 'João Pessoa', 'Juarez Távora', 'Juazeirinho', 'Junco do Seridó', 'Juripiranga', 'Juru', 'Lagoa', 'Lagoa de Dentro', 'Lagoa Seca', 'Lastro', 'Livramento', 'Logradouro', 'Lucena', 'Mãe d\'Água', 'Malta', 'Mamanguape', 'Manaíra', 'Marcação', 'Mari', 'Marizópolis', 'Massaranduba', 'Mataraca', 'Matinhas', 'Mato Grosso', 'Maturéia', 'Mogeiro', 'Montadas', 'Monte Horebe', 'Monteiro', 'Mulungu', 'Natuba', 'Nazarezinho', 'Nova Floresta', 'Nova Olinda', 'Nova Palmeira', 'Olho d\'Água', 'Olivedos', 'Ouro Velho', 'Parari', 'Passagem', 'Patos', 'Paulista', 'Pedra Branca', 'Pedra Lavrada', 'Pedras de Fogo', 'Pedro Régis', 'Piancó', 'Picuí', 'Pilar', 'Pilões', 'Pilõezinhos', 'Pirpirituba', 'Pitimbu', 'Pocinhos', 'Poço Dantas', 'Poço de José de Moura', 'Pombal', 'Prata', 'Princesa Isabel', 'Puxinanã', 'Queimadas', 'Quixabá', 'Remígio', 'Riachão', 'Riachão do Bacamarte', 'Riachão do Poço', 'Riacho de Santo Antônio', 'Riacho dos Cavalos', 'Rio Tinto', 'Salgadinho', 'Salgado de São Félix', 'Santa Cecília', 'Santa Cruz', 'Santa Helena', 'Santa Inês', 'Santa Luzia', 'Santa Rita', 'Santa Teresinha', 'Santana de Mangueira', 'Santana dos Garrotes', 'Santarém', 'Santo André', 'São Bentinho', 'São Bento', 'São Domingos de Pombal', 'São Domingos do Cariri', 'São Francisco', 'São João do Cariri', 'São João do Rio do Peixe', 'São João do Tigre', 'São José da Lagoa Tapada', 'São José de Caiana', 'São José de Espinharas', 'São José de Piranhas', 'São José de Princesa', 'São José do Bonfim', 'São José do Brejo do Cruz', 'São José do Sabugi', 'São José dos Cordeiros', 'São José dos Ramos', 'São Mamede', 'São Miguel de Taipu', 'São Sebastião de Lagoa de Roça', 'São Sebastião do Umbuzeiro', 'Sapé', 'Seridó', 'Serra Branca', 'Serra da Raiz', 'Serra Grande', 'Serra Redonda', 'Serraria', 'Sertãozinho', 'Sobrado', 'Solânea', 'Soledade', 'Sossêgo', 'Sousa', 'Sumé', 'Taperoá', 'Tavares', 'Teixeira', 'Tenório', 'Triunfo', 'Uiraúna', 'Umbuzeiro', 'Várzea', 'Vieirópolis', 'Vista Serrana', 'Zabelê',
    ], ['Abreu e Lima', 'Afogados da Ingazeira', 'Afrânio', 'Agrestina', 'Água Preta', 'Águas Belas', 'Alagoinha', 'Aliança', 'Altinho', 'Amaraji', 'Angelim', 'Araçoiaba', 'Araripina', 'Arcoverde', 'Barra de Guabiraba', 'Barreiros', 'Belém de Maria', 'Belém de São Francisco', 'Belo Jardim', 'Betânia', 'Bezerros', 'Bodocó', 'Bom Conselho', 'Bom Jardim', 'Bonito', 'Brejão', 'Brejinho', 'Brejo da Madre de Deus', 'Buenos Aires', 'Buíque', 'Cabo de Santo Agostinho', 'Cabrobó', 'Cachoeirinha', 'Caetés', 'Calçado', 'Calumbi', 'Camaragibe', 'Camocim de São Félix', 'Camutanga', 'Canhotinho', 'Capoeiras', 'Carnaíba', 'Carnaubeira da Penha', 'Carpina', 'Caruaru', 'Casinhas', 'Catende', 'Cedro', 'Chã de Alegria', 'Chã Grande', 'Condado', 'Correntes', 'Cortês', 'Cumaru', 'Cupira', 'Custódia', 'Dormentes', 'Escada', 'Exu', 'Feira Nova', 'Fernando de Noronha', 'Ferreiros', 'Flores', 'Floresta', 'Frei Miguelinho', 'Gameleira', 'Garanhuns', 'Glória do Goitá', 'Goiana', 'Granito', 'Gravatá', 'Iati', 'Ibimirim', 'Ibirajuba', 'Igarassu', 'Iguaraci', 'Inajá', 'Ingazeira', 'Ipojuca', 'Ipubi', 'Itacuruba', 'Itaíba', 'Itamaracá', 'Itambé', 'Itapetim', 'Itapissuma', 'Itaquitinga', 'Jaboatão dos Guararapes', 'Jaqueira', 'Jataúba', 'Jatobá', 'João Alfredo', 'Joaquim Nabuco', 'Jucati', 'Jupi', 'Jurema', 'Lagoa do Carro', 'Lagoa do Itaenga', 'Lagoa do Ouro', 'Lagoa dos Gatos', 'Lagoa Grande', 'Lajedo', 'Limoeiro', 'Macaparana', 'Machados', 'Manari', 'Maraial', 'Mirandiba', 'Moreilândia', 'Moreno', 'Nazaré da Mata', 'Olinda', 'Orobó', 'Orocó', 'Ouricuri', 'Palmares', 'Palmeirina', 'Panelas', 'Paranatama', 'Parnamirim', 'Passira', 'Paudalho', 'Paulista', 'Pedra', 'Pesqueira', 'Petrolândia', 'Petrolina', 'Poção', 'Pombos', 'Primavera', 'Quipapá', 'Quixaba', 'Recife', 'Riacho das Almas', 'Ribeirão', 'Rio Formoso', 'Sairé', 'Salgadinho', 'Salgueiro', 'Saloá', 'Sanharó', 'Santa Cruz', 'Santa Cruz da Baixa Verde', 'Santa Cruz do Capibaribe', 'Santa Filomena', 'Santa Maria da Boa Vista', 'Santa Maria do Cambucá', 'Santa Terezinha', 'São Benedito do Sul', 'São Bento do Una', 'São Caitano', 'São João', 'São Joaquim do Monte', 'São José da Coroa Grande', 'São José do Belmonte', 'São José do Egito', 'São Lourenço da Mata', 'São Vicente Ferrer', 'Serra Talhada', 'Serrita', 'Sertânia', 'Sirinhaém', 'Solidão', 'Surubim', 'Tabira', 'Tacaimbó', 'Tacaratu', 'Tamandaré', 'Taquaritinga do Norte', 'Terezinha', 'Terra Nova', 'Timbaúba', 'Toritama', 'Tracunhaém', 'Trindade', 'Triunfo', 'Tupanatinga', 'Tuparetama', 'Venturosa', 'Verdejante', 'Vertente do Lério', 'Vertentes', 'Vicência', 'Vitória de Santo Antão', 'Xexéu',
    ], ['Acauã', 'Agricolândia', 'Água Branca', 'Alagoinha do Piauí', 'Alegrete do Piauí', 'Alto Longá', 'Altos', 'Alvorada do Gurguéia', 'Amarante', 'Angical do Piauí', 'Anísio de Abreu', 'Antônio Almeida', 'Aroazes', 'Arraial', 'Assunção do Piauí', 'Avelino Lopes', 'Baixa Grande do Ribeiro', 'Barra d\'Alcântara', 'Barras', 'Barreiras do Piauí', 'Barro Duro', 'Batalha', 'Bela Vista do Piauí', 'Belém do Piauí', 'Beneditinos', 'Bertolínia', 'Betânia do Piauí', 'Boa Hora', 'Bocaina', 'Bom Jesus', 'Bom Princípio do Piauí', 'Bonfim do Piauí', 'Boqueirão do Piauí', 'Brasileira', 'Brejo do Piauí', 'Buriti dos Lopes', 'Buriti dos Montes', 'Cabeceiras do Piauí', 'Cajazeiras do Piauí', 'Cajueiro da Praia', 'Caldeirão Grande do Piauí', 'Campinas do Piauí', 'Campo Alegre do Fidalgo', 'Campo Grande do Piauí', 'Campo Largo do Piauí', 'Campo Maior', 'Canavieira', 'Canto do Buriti', 'Capitão de Campos', 'Capitão Gervásio Oliveira', 'Caracol', 'Caraúbas do Piauí', 'Caridade do Piauí', 'Castelo do Piauí', 'Caxingó', 'Cocal', 'Cocal de Telha', 'Cocal dos Alves', 'Coivaras', 'Colônia do Gurguéia', 'Colônia do Piauí', 'Conceição do Canindé', 'Coronel José Dias', 'Corrente', 'Cristalândia do Piauí', 'Cristino Castro', 'Curimatá', 'Currais', 'Curral Novo do Piauí', 'Curralinhos', 'Demerval Lobão', 'Dirceu Arcoverde', 'Dom Expedito Lopes', 'Dom Inocêncio', 'Domingos Mourão', 'Elesbão Veloso', 'Eliseu Martins', 'Esperantina', 'Fartura do Piauí', 'Flores do Piauí', 'Floresta do Piauí', 'Floriano', 'Francinópolis', 'Francisco Ayres', 'Francisco Macedo', 'Francisco Santos', 'Fronteiras', 'Geminiano', 'Gilbués', 'Guadalupe', 'Guaribas', 'Hugo Napoleão', 'Ilha Grande', 'Inhuma', 'Ipiranga do Piauí', 'Isaías Coelho', 'Itainópolis', 'Itaueira', 'Jacobina do Piauí', 'Jaicós', 'Jardim do Mulato', 'Jatobá do Piauí', 'Jerumenha', 'João Costa', 'Joaquim Pires', 'Joca Marques', 'José de Freitas', 'Juazeiro do Piauí', 'Júlio Borges', 'Jurema', 'Lagoa Alegre', 'Lagoa de São Francisco', 'Lagoa do Barro do Piauí', 'Lagoa do Piauí', 'Lagoa do Sítio', 'Lagoinha do Piauí', 'Landri Sales', 'Luís Correia', 'Luzilândia', 'Madeiro', 'Manoel Emídio', 'Marcolândia', 'Marcos Parente', 'Massapê do Piauí', 'Matias Olímpio', 'Miguel Alves', 'Miguel Leão', 'Milton Brandão', 'Monsenhor Gil', 'Monsenhor Hipólito', 'Monte Alegre do Piauí', 'Morro Cabeça no Tempo', 'Morro do Chapéu do Piauí', 'Murici dos Portelas', 'Nazaré do Piauí', 'Nossa Senhora de Nazaré', 'Nossa Senhora dos Remédios', 'Nova Santa Rita', 'Novo Oriente do Piauí', 'Novo Santo Antônio', 'Oeiras', 'Olho d\'Água do Piauí', 'Padre Marcos', 'Paes Landim', 'Pajeú do Piauí', 'Palmeira do Piauí', 'Palmeirais', 'Paquetá', 'Parnaguá', 'Parnaíba', 'Passagem Franca do Piauí', 'Patos do Piauí', 'Pau d\'Arco do Piauí', 'Paulistana', 'Pavussu', 'Pedro II', 'Pedro Laurentino', 'Picos', 'Pimenteiras', 'Pio IX', 'Piracuruca', 'Piripiri', 'Porto', 'Porto Alegre do Piauí', 'Prata do Piauí', 'Queimada Nova', 'Redenção do Gurguéia', 'Regeneração', 'Riacho Frio', 'Ribeira do Piauí', 'Ribeiro Gonçalves', 'Rio Grande do Piauí', 'Santa Cruz do Piauí', 'Santa Cruz dos Milagres', 'Santa Filomena', 'Santa Luz', 'Santa Rosa do Piauí', 'Santana do Piauí', 'Santo Antônio de Lisboa', 'Santo Antônio dos Milagres', 'Santo Inácio do Piauí', 'São Braz do Piauí', 'São Félix do Piauí', 'São Francisco de Assis do Piauí', 'São Francisco do Piauí', 'São Gonçalo do Gurguéia', 'São Gonçalo do Piauí', 'São João da Canabrava', 'São João da Fronteira', 'São João da Serra', 'São João da Varjota', 'São João do Arraial', 'São João do Piauí', 'São José do Divino', 'São José do Peixe', 'São José do Piauí', 'São Julião', 'São Lourenço do Piauí', 'São Luis do Piauí', 'São Miguel da Baixa Grande', 'São Miguel do Fidalgo', 'São Miguel do Tapuio', 'São Pedro do Piauí', 'São Raimundo Nonato', 'Sebastião Barros', 'Sebastião Leal', 'Sigefredo Pacheco', 'Simões', 'Simplício Mendes', 'Socorro do Piauí', 'Sussuapara', 'Tamboril do Piauí', 'Tanque do Piauí', 'Teresina', 'União', 'Uruçuí', 'Valença do Piauí', 'Várzea Branca', 'Várzea Grande', 'Vera Mendes', 'Vila Nova do Piauí', 'Wall Ferraz',
    ], ['Abatiá', 'Adrianópolis', 'Agudos do Sul', 'Almirante Tamandaré', 'Altamira do Paraná', 'Alto Paraná', 'Alto Piquiri', 'Altônia', 'Alvorada do Sul', 'Amaporã', 'Ampére', 'Anahy', 'Andirá', 'Ângulo', 'Antonina', 'Antônio Olinto', 'Apucarana', 'Arapongas', 'Arapoti', 'Arapuã', 'Araruna', 'Araucária', 'Ariranha do Ivaí', 'Assaí', 'Assis Chateaubriand', 'Astorga', 'Atalaia', 'Balsa Nova', 'Bandeirantes', 'Barbosa Ferraz', 'Barra do Jacaré', 'Barracão', 'Bela Vista da Caroba', 'Bela Vista do Paraíso', 'Bituruna', 'Boa Esperança', 'Boa Esperança do Iguaçu', 'Boa Ventura de São Roque', 'Boa Vista da Aparecida', 'Bocaiúva do Sul', 'Bom Jesus do Sul', 'Bom Sucesso', 'Bom Sucesso do Sul', 'Borrazópolis', 'Braganey', 'Brasilândia do Sul', 'Cafeara', 'Cafelândia', 'Cafezal do Sul', 'Califórnia', 'Cambará', 'Cambé', 'Cambira', 'Campina da Lagoa', 'Campina do Simão', 'Campina Grande do Sul', 'Campo Bonito', 'Campo do Tenente', 'Campo Largo', 'Campo Magro', 'Campo Mourão', 'Cândido de Abreu', 'Candói', 'Cantagalo', 'Capanema', 'Capitão Leônidas Marques', 'Carambeí', 'Carlópolis', 'Cascavel', 'Castro', 'Catanduvas', 'Centenário do Sul', 'Cerro Azul', 'Céu Azul', 'Chopinzinho', 'Cianorte', 'Cidade Gaúcha', 'Clevelândia', 'Colombo', 'Colorado', 'Congonhinhas', 'Conselheiro Mairinck', 'Contenda', 'Corbélia', 'Cornélio Procópio', 'Coronel Domingos Soares', 'Coronel Vivida', 'Corumbataí do Sul', 'Cruz Machado', 'Cruzeiro do Iguaçu', 'Cruzeiro do Oeste', 'Cruzeiro do Sul', 'Cruzmaltina', 'Curitiba', 'Curiúva', 'Diamante d\'Oeste', 'Diamante do Norte', 'Diamante do Sul', 'Dois Vizinhos', 'Douradina', 'Doutor Camargo', 'Doutor Ulysses', 'Enéas Marques', 'Engenheiro Beltrão', 'Entre Rios do Oeste', 'Esperança Nova', 'Espigão Alto do Iguaçu', 'Farol', 'Faxinal', 'Fazenda Rio Grande', 'Fênix', 'Fernandes Pinheiro', 'Figueira', 'Flor da Serra do Sul', 'Floraí', 'Floresta', 'Florestópolis', 'Flórida', 'Formosa do Oeste', 'Foz do Iguaçu', 'Foz do Jordão', 'Francisco Alves', 'Francisco Beltrão', 'General Carneiro', 'Godoy Moreira', 'Goioerê', 'Goioxim', 'Grandes Rios', 'Guaíra', 'Guairaçá', 'Guamiranga', 'Guapirama', 'Guaporema', 'Guaraci', 'Guaraniaçu', 'Guarapuava', 'Guaraqueçaba', 'Guaratuba', 'Honório Serpa', 'Ibaiti', 'Ibema', 'Ibiporã', 'Icaraíma', 'Iguaraçu', 'Iguatu', 'Imbaú', 'Imbituva', 'Inácio Martins', 'Inajá', 'Indianópolis', 'Ipiranga', 'Iporã', 'Iracema do Oeste', 'Irati', 'Iretama', 'Itaguajé', 'Itaipulândia', 'Itambaracá', 'Itambé', 'Itapejara d\'Oeste', 'Itaperuçu', 'Itaúna do Sul', 'Ivaí', 'Ivaiporã', 'Ivaté', 'Ivatuba', 'Jaboti', 'Jacarezinho', 'Jaguapitã', 'Jaguariaíva', 'Jandaia do Sul', 'Janiópolis', 'Japira', 'Japurá', 'Jardim Alegre', 'Jardim Olinda', 'Jataizinho', 'Jesuítas', 'Joaquim Távora', 'Jundiaí do Sul', 'Juranda', 'Jussara', 'Kaloré', 'Lapa', 'Laranjal', 'Laranjeiras do Sul', 'Leópolis', 'Lidianópolis', 'Lindoeste', 'Loanda', 'Lobato', 'Londrina', 'Luiziana', 'Lunardelli', 'Lupionópolis', 'Mallet', 'Mamborê', 'Mandaguaçu', 'Mandaguari', 'Mandirituba', 'Manfrinópolis', 'Mangueirinha', 'Manoel Ribas', 'Marechal Cândido Rondon', 'Maria Helena', 'Marialva', 'Marilândia do Sul', 'Marilena', 'Mariluz', 'Maringá', 'Mariópolis', 'Maripá', 'Marmeleiro', 'Marquinho', 'Marumbi', 'Matelândia', 'Matinhos', 'Mato Rico', 'Mauá da Serra', 'Medianeira', 'Mercedes', 'Mirador', 'Miraselva', 'Missal', 'Moreira Sales', 'Morretes', 'Munhoz de Melo', 'Nossa Senhora das Graças', 'Nova Aliança do Ivaí', 'Nova América da Colina', 'Nova Aurora', 'Nova Cantu', 'Nova Esperança', 'Nova Esperança do Sudoeste', 'Nova Fátima', 'Nova Laranjeiras', 'Nova Londrina', 'Nova Olímpia', 'Nova Prata do Iguaçu', 'Nova Santa Bárbara', 'Nova Santa Rosa', 'Nova Tebas', 'Novo Itacolomi', 'Ortigueira', 'Ourizona', 'Ouro Verde do Oeste', 'Paiçandu', 'Palmas', 'Palmeira', 'Palmital', 'Palotina', 'Paraíso do Norte', 'Paranacity', 'Paranaguá', 'Paranapoema', 'Paranavaí', 'Pato Bragado', 'Pato Branco', 'Paula Freitas', 'Paulo Frontin', 'Peabiru', 'Perobal', 'Pérola', 'Pérola d\'Oeste', 'Piên', 'Pinhais', 'Pinhal de São Bento', 'Pinhalão', 'Pinhão', 'Piraí do Sul', 'Piraquara', 'Pitanga', 'Pitangueiras', 'Planaltina do Paraná', 'Planalto', 'Ponta Grossa', 'Pontal do Paraná', 'Porecatu', 'Porto Amazonas', 'Porto Barreiro', 'Porto Rico', 'Porto Vitória', 'Prado Ferreira', 'Pranchita', 'Presidente Castelo Branco', 'Primeiro de Maio', 'Prudentópolis', 'Quarto Centenário', 'Quatiguá', 'Quatro Barras', 'Quatro Pontes', 'Quedas do Iguaçu', 'Querência do Norte', 'Quinta do Sol', 'Quitandinha', 'Ramilândia', 'Rancho Alegre', 'Rancho Alegre d\'Oeste', 'Realeza', 'Rebouças', 'Renascença', 'Reserva', 'Reserva do Iguaçu', 'Ribeirão Claro', 'Ribeirão do Pinhal', 'Rio Azul', 'Rio Bom', 'Rio Bonito do Iguaçu', 'Rio Branco do Ivaí', 'Rio Branco do Sul', 'Rio Negro', 'Rolândia', 'Roncador', 'Rondon', 'Rosário do Ivaí', 'Sabáudia', 'Salgado Filho', 'Salto do Itararé', 'Salto do Lontra', 'Santa Amélia', 'Santa Cecília do Pavão', 'Santa Cruz Monte Castelo', 'Santa Fé', 'Santa Helena', 'Santa Inês', 'Santa Isabel do Ivaí', 'Santa Izabel do Oeste', 'Santa Lúcia', 'Santa Maria do Oeste', 'Santa Mariana', 'Santa Mônica', 'Santa Tereza do Oeste', 'Santa Terezinha de Itaipu', 'Santana do Itararé', 'Santo Antônio da Platina', 'Santo Antônio do Caiuá', 'Santo Antônio do Paraíso', 'Santo Antônio do Sudoeste', 'Santo Inácio', 'São Carlos do Ivaí', 'São Jerônimo da Serra', 'São João', 'São João do Caiuá', 'São João do Ivaí', 'São João do Triunfo', 'São Jorge d\'Oeste', 'São Jorge do Ivaí', 'São Jorge do Patrocínio', 'São José da Boa Vista', 'São José das Palmeiras', 'São José dos Pinhais', 'São Manoel do Paraná', 'São Mateus do Sul', 'São Miguel do Iguaçu', 'São Pedro do Iguaçu', 'São Pedro do Ivaí', 'São Pedro do Paraná', 'São Sebastião da Amoreira', 'São Tomé', 'Sapopema', 'Sarandi', 'Saudade do Iguaçu', 'Sengés', 'Serranópolis do Iguaçu', 'Sertaneja', 'Sertanópolis', 'Siqueira Campos', 'Sulina', 'Tamarana', 'Tamboara', 'Tapejara', 'Tapira', 'Teixeira Soares', 'Telêmaco Borba', 'Terra Boa', 'Terra Rica', 'Terra Roxa', 'Tibagi', 'Tijucas do Sul', 'Toledo', 'Tomazina', 'Três Barras do Paraná', 'Tunas do Paraná', 'Tuneiras do Oeste', 'Tupãssi', 'Turvo', 'Ubiratã', 'Umuarama', 'União da Vitória', 'Uniflor', 'Uraí', 'Ventania', 'Vera Cruz do Oeste', 'Verê', 'Vila Alta', 'Virmond', 'Vitorino', 'Wenceslau Braz', 'Xambrê',
    ], ['Angra dos Reis', 'Aperibé', 'Araruama', 'Areal', 'Armação de Búzios', 'Arraial do Cabo', 'Barra do Piraí', 'Barra Mansa', 'Belford Roxo', 'Bom Jardim', 'Bom Jesus do Itabapoana', 'Cabo Frio', 'Cachoeiras de Macacu', 'Cambuci', 'Campos dos Goytacazes', 'Cantagalo', 'Carapebus', 'Cardoso Moreira', 'Carmo', 'Casimiro de Abreu', 'Comendador Levy Gasparian', 'Conceição de Macabu', 'Cordeiro', 'Duas Barras', 'Duque de Caxias', 'Engenheiro Paulo de Frontin', 'Guapimirim', 'Iguaba Grande', 'Itaboraí', 'Itaguaí', 'Italva', 'Itaocara', 'Itaperuna', 'Itatiaia', 'Japeri', 'Laje do Muriaé', 'Macaé', 'Macuco', 'Magé', 'Mangaratiba', 'Maricá', 'Mendes', 'Mesquita', 'Miguel Pereira', 'Miracema', 'Natividade', 'Nilópolis', 'Niterói', 'Nova Friburgo', 'Nova Iguaçu', 'Paracambi', 'Paraíba do Sul', 'Parati', 'Paty do Alferes', 'Petrópolis', 'Pinheiral', 'Piraí', 'Porciúncula', 'Porto Real', 'Quatis', 'Queimados', 'Quissamã', 'Resende', 'Rio Bonito', 'Rio Claro', 'Rio das Flores', 'Rio das Ostras', 'Rio de Janeiro', 'Santa Maria Madalena', 'Santo Antônio de Pádua', 'São Fidélis', 'São Francisco de Itabapoana', 'São Gonçalo', 'São João da Barra', 'São João de Meriti', 'São José de Ubá', 'São José do Vale do Rio Preto', 'São Pedro da Aldeia', 'São Sebastião do Alto', 'Sapucaia', 'Saquarema', 'Seropédica', 'Silva Jardim', 'Sumidouro', 'Tanguá', 'Teresópolis', 'Trajano de Morais', 'Três Rios', 'Valença', 'Varre-Sai', 'Vassouras', 'Volta Redonda',
    ], ['Acari', 'Açu', 'Afonso Bezerra', 'Água Nova', 'Alexandria', 'Almino Afonso', 'Alto do Rodrigues', 'Angicos', 'Antônio Martins', 'Apodi', 'Areia Branca', 'Arês', 'Augusto Severo', 'Baía Formosa', 'Baraúna', 'Barcelona', 'Bento Fernandes', 'Bodó', 'Bom Jesus', 'Brejinho', 'Caiçara do Norte', 'Caiçara do Rio do Vento', 'Caicó', 'Campo Redondo', 'Canguaretama', 'Caraúbas', 'Carnaúba dos Dantas', 'Carnaubais', 'Ceará-Mirim', 'Cerro Corá', 'Coronel Ezequiel', 'Coronel João Pessoa', 'Cruzeta', 'Currais Novos', 'Doutor Severiano', 'Encanto', 'Equador', 'Espírito Santo', 'Extremoz', 'Felipe Guerra', 'Fernando Pedroza', 'Florânia', 'Francisco Dantas', 'Frutuoso Gomes', 'Galinhos', 'Goianinha', 'Governador Dix-Sept Rosado', 'Grossos', 'Guamaré', 'Ielmo Marinho', 'Ipanguaçu', 'Ipueira', 'Itajá', 'Itaú', 'Jaçanã', 'Jandaíra', 'Janduís', 'Januário Cicco', 'Japi', 'Jardim de Angicos', 'Jardim de Piranhas', 'Jardim do Seridó', 'João Câmara', 'João Dias', 'José da Penha', 'Jucurutu', 'Jundiá', 'Lagoa d\'Anta', 'Lagoa de Pedras', 'Lagoa de Velhos', 'Lagoa Nova', 'Lagoa Salgada', 'Lajes', 'Lajes Pintadas', 'Lucrécia', 'Luís Gomes', 'Macaíba', 'Macau', 'Major Sales', 'Marcelino Vieira', 'Martins', 'Maxaranguape', 'Messias Targino', 'Montanhas', 'Monte Alegre', 'Monte das Gameleiras', 'Mossoró', 'Natal', 'Nísia Floresta', 'Nova Cruz', 'Olho-d\'Água do Borges', 'Ouro Branco', 'Paraná', 'Paraú', 'Parazinho', 'Parelhas', 'Parnamirim', 'Passa e Fica', 'Passagem', 'Patu', 'Pau dos Ferros', 'Pedra Grande', 'Pedra Preta', 'Pedro Avelino', 'Pedro Velho', 'Pendências', 'Pilões', 'Poço Branco', 'Portalegre', 'Porto do Mangue', 'Presidente Juscelino', 'Pureza', 'Rafael Fernandes', 'Rafael Godeiro', 'Riacho da Cruz', 'Riacho de Santana', 'Riachuelo', 'Rio do Fogo', 'Rodolfo Fernandes', 'Ruy Barbosa', 'Santa Cruz', 'Santa Maria', 'Santana do Matos', 'Santana do Seridó', 'Santo Antônio', 'São Bento do Norte', 'São Bento do Trairí', 'São Fernando', 'São Francisco do Oeste', 'São Gonçalo do Amarante', 'São João do Sabugi', 'São José de Mipibu', 'São José do Campestre', 'São José do Seridó', 'São Miguel', 'São Miguel de Touros', 'São Paulo do Potengi', 'São Pedro', 'São Rafael', 'São Tomé', 'São Vicente', 'Senador Elói de Souza', 'Senador Georgino Avelino', 'Serra de São Bento', 'Serra do Mel', 'Serra Negra do Norte', 'Serrinha', 'Serrinha dos Pintos', 'Severiano Melo', 'Sítio Novo', 'Taboleiro Grande', 'Taipu', 'Tangará', 'Tenente Ananias', 'Tenente Laurentino Cruz', 'Tibau', 'Tibau do Sul', 'Timbaúba dos Batistas', 'Touros', 'Triunfo Potiguar', 'Umarizal', 'Upanema', 'Várzea', 'Venha-Ver', 'Vera Cruz', 'Viçosa', 'Vila Flor',
    ], ['Alta Floresta d\'Oeste', 'Alto Alegre do Parecis', 'Alto Paraíso', 'Alvorada d\'Oeste', 'Ariquemes', 'Buritis', 'Cabixi', 'Cacaulândia', 'Cacoal', 'Campo Novo de Rondônia', 'Candeias do Jamari', 'Castanheiras', 'Cerejeiras', 'Chupinguaia', 'Colorado do Oeste', 'Corumbiara', 'Costa Marques', 'Cujubim', 'Espigão d\'Oeste', 'Governador Jorge Teixeira', 'Guajará-Mirim', 'Itapuã do Oeste', 'Jaru', 'Ji-Paraná', 'Machadinho d\'Oeste', 'Ministro Andreazza', 'Mirante da Serra', 'Monte Negro', 'Nova Brasilândia d\'Oeste', 'Nova Mamoré', 'Nova União', 'Novo Horizonte do Oeste', 'Ouro Preto do Oeste', 'Parecis', 'Pimenta Bueno', 'Pimenteiras do Oeste', 'Porto Velho', 'Presidente Médici', 'Primavera de Rondônia', 'Rio Crespo', 'Rolim de Moura', 'Santa Luzia d\'Oeste', 'São Felipe d\'Oeste', 'São Francisco do Guaporé', 'São Miguel do Guaporé', 'Seringueiras', 'Teixeirópolis', 'Theobroma', 'Urupá', 'Vale do Anari', 'Vale do Paraíso', 'Vilhena',
    ], ['Alto Alegre', 'Amajari', 'Boa Vista', 'Bonfim', 'Cantá', 'Caracaraí', 'Caroebe', 'Iracema', 'Mucajaí', 'Normandia', 'Pacaraima', 'Rorainópolis', 'São João da Baliza', 'São Luiz', 'Uiramutã',
    ], ['Aceguá', 'Água Santa', 'Agudo', 'Ajuricaba', 'Alecrim', 'Alegrete', 'Alegria', 'Almirante Tamandaré do Sul', 'Alpestre', 'Alto Alegre', 'Alto Feliz', 'Alvorada', 'Amaral Ferrador', 'Ametista do Sul', 'André da Rocha', 'Anta Gorda', 'Antônio Prado', 'Arambaré', 'Araricá', 'Aratiba', 'Arroio do Meio', 'Arroio do Padre', 'Arroio do Sal', 'Arroio do Tigre', 'Arroio dos Ratos', 'Arroio Grande', 'Arvorezinha', 'Augusto Pestana', 'Áurea', 'Bagé', 'Balneário Pinhal', 'Barão', 'Barão de Cotegipe', 'Barão do Triunfo', 'Barra do Guarita', 'Barra do Quaraí', 'Barra do Ribeiro', 'Barra do Rio Azul', 'Barra Funda', 'Barracão', 'Barros Cassal', 'Benjamin Constan do Sul', 'Bento Gonçalves', 'Boa Vista das Missões', 'Boa Vista do Buricá', 'Boa Vista do Cadeado', 'Boa Vista do Incra', 'Boa Vista do Sul', 'Bom Jesus', 'Bom Princípio', 'Bom Progresso', 'Bom Retiro do Sul', 'Boqueirão do Leão', 'Bossoroca', 'Bozano', 'Braga', 'Brochier', 'Butiá', 'Caçapava do Sul', 'Cacequi', 'Cachoeira do Sul', 'Cachoeirinha', 'Cacique Doble', 'Caibaté', 'Caiçara', 'Camaquã', 'Camargo', 'Cambará do Sul', 'Campestre da Serra', 'Campina das Missões', 'Campinas do Sul', 'Campo Bom', 'Campo Novo', 'Campos Borges', 'Candelária', 'Cândido Godói', 'Candiota', 'Canela', 'Canguçu', 'Canoas', 'Canudos do Vale', 'Capão Bonito do Sul', 'Capão da Canoa', 'Capão do Cipó', 'Capão do Leão', 'Capela de Santana', 'Capitão', 'Capivari do Sul', 'Caraá', 'Carazinho', 'Carlos Barbosa', 'Carlos Gomes', 'Casca', 'Caseiros', 'Catuípe', 'Caxias do Sul', 'Centenário', 'Cerrito', 'Cerro Branco', 'Cerro Grande', 'Cerro Grande do Sul', 'Cerro Largo', 'Chapada', 'Charqueadas', 'Charrua', 'Chiapeta', 'Chuí', 'Chuvisca', 'Cidreira', 'Ciríaco', 'Colinas', 'Colorado', 'Condor', 'Constantina', 'Coqueiro Baixo', 'Coqueiros do Sul', 'Coronel Barros', 'Coronel Bicaco', 'Coronel Pilar', 'Cotiporã', 'Coxilha', 'Crissiumal', 'Cristal', 'Cristal do Sul', 'Cruz Alta', 'Cruzaltense', 'Cruzeiro do Sul', 'David Canabarro', 'Derrubadas', 'Dezesseis de Novembro', 'Dilermando de Aguiar', 'Dois Irmãos', 'Dois Irmãos das Missões', 'Dois Lajeados', 'Dom Feliciano', 'Dom Pedrito', 'Dom Pedro de Alcântara', 'Dona Francisca', 'Doutor Maurício Cardoso', 'Doutor Ricardo', 'Eldorado do Sul', 'Encantado', 'Encruzilhada do Sul', 'Engenho Velho', 'Entre Rios do Sul', 'Entre-Ijuís', 'Erebango', 'Erechim', 'Ernestina', 'Erval Grande', 'Erval Seco', 'Esmeralda', 'Esperança do Sul', 'Espumoso', 'Estação', 'Estância Velha', 'Esteio', 'Estrela', 'Estrela Velha', 'Eugênio de Castro', 'Fagundes Varela', 'Farroupilha', 'Faxinal do Soturno', 'Faxinalzinho', 'Fazenda Vilanova', 'Feliz', 'Flores da Cunha', 'Floriano Peixoto', 'Fontoura Xavier', 'Formigueiro', 'Forquetinha', 'Fortaleza dos Valos', 'Frederico Westphalen', 'Garibaldi', 'Garruchos', 'Gaurama', 'General Câmara', 'Gentil', 'Getúlio Vargas', 'Giruá', 'Glorinha', 'Gramado', 'Gramado dos Loureiros', 'Gramado Xavier', 'Gravataí', 'Guabiju', 'Guaíba', 'Guaporé', 'Guarani das Missões', 'Harmonia', 'Herval', 'Herveiras', 'Horizontina', 'Hulha Negra', 'Humaitá', 'Ibarama', 'Ibiaçá', 'Ibiraiaras', 'Ibirapuitã', 'Ibirubá', 'Igrejinha', 'Ijuí', 'Ilópolis', 'Imbé', 'Imigrante', 'Independência', 'Inhacorá', 'Ipê', 'Ipiranga do Sul', 'Iraí', 'Itaara', 'Itacurubi', 'Itapuca', 'Itaqui', 'Itati', 'Itatiba do Sul', 'Ivorá', 'Ivoti', 'Jaboticaba', 'Jacuizinho', 'Jacutinga', 'Jaguarão', 'Jaguari', 'Jaquirana', 'Jari', 'Jóia', 'Júlio de Castilhos', 'Lagoa Bonita do Sul', 'Lagoa dos Três Cantos', 'Lagoa Vermelha', 'Lagoão', 'Lajeado', 'Lajeado do Bugre', 'Lavras do Sul', 'Liberato Salzano', 'Lindolfo Collor', 'Linha Nova', 'Maçambara', 'Machadinho', 'Mampituba', 'Manoel Viana', 'Maquiné', 'Maratá', 'Marau', 'Marcelino Ramos', 'Mariana Pimentel', 'Mariano Moro', 'Marques de Souza', 'Mata', 'Mato Castelhano', 'Mato Leitão', 'Mato Queimado', 'Maximiliano de Almeida', 'Minas do Leão', 'Miraguaí', 'Montauri', 'Monte Alegre dos Campos', 'Monte Belo do Sul', 'Montenegro', 'Mormaço', 'Morrinhos do Sul', 'Morro Redondo', 'Morro Reuter', 'Mostardas', 'Muçum', 'Muitos Capões', 'Muliterno', 'Não-Me-Toque', 'Nicolau Vergueiro', 'Nonoai', 'Nova Alvorada', 'Nova Araçá', 'Nova Bassano', 'Nova Boa Vista', 'Nova Bréscia', 'Nova Candelária', 'Nova Esperança do Sul', 'Nova Hartz', 'Nova Pádua', 'Nova Palma', 'Nova Petrópolis', 'Nova Prata', 'Nova Ramada', 'Nova Roma do Sul', 'Nova Santa Rita', 'Novo Barreiro', 'Novo Cabrais', 'Novo Hamburgo', 'Novo Machado', 'Novo Tiradentes', 'Novo Xingu', 'Osório', 'Paim Filho', 'Palmares do Sul', 'Palmeira das Missões', 'Palmitinho', 'Panambi', 'Pântano Grande', 'Paraí', 'Paraíso do Sul', 'Pareci Novo', 'Parobé', 'Passa Sete', 'Passo do Sobrado', 'Passo Fundo', 'Paulo Bento', 'Paverama', 'Pedras Altas', 'Pedro Osório', 'Pejuçara', 'Pelotas', 'Picada Café', 'Pinhal', 'Pinhal da Serra', 'Pinhal Grande', 'Pinheirinho do Vale', 'Pinheiro Machado', 'Pirapó', 'Piratini', 'Planalto', 'Poço das Antas', 'Pontão', 'Ponte Preta', 'Portão', 'Porto Alegre', 'Porto Lucena', 'Porto Mauá', 'Porto Vera Cruz', 'Porto Xavier', 'Pouso Novo', 'Presidente Lucena', 'Progresso', 'Protásio Alves', 'Putinga', 'Quaraí', 'Quatro Irmãos', 'Quevedos', 'Quinze de Novembro', 'Redentora', 'Relvado', 'Restinga Seca', 'Rio dos Índios', 'Rio Grande', 'Rio Pardo', 'Riozinho', 'Roca Sales', 'Rodeio Bonito', 'Rolador', 'Rolante', 'Ronda Alta', 'Rondinha', 'Roque Gonzales', 'Rosário do Sul', 'Sagrada Família', 'Saldanha Marinho', 'Salto do Jacuí', 'Salvador das Missões', 'Salvador do Sul', 'Sananduva', 'Santa Bárbara do Sul', 'Santa Cecília do Sul', 'Santa Clara do Sul', 'Santa Cruz do Sul', 'Santa Margarida do Sul', 'Santa Maria', 'Santa Maria do Herval', 'Santa Rosa', 'Santa Tereza', 'Santa Vitória do Palmar', 'Santana da Boa Vista', 'Santana do Livramento', 'Santiago', 'Santo Ângelo', 'Santo Antônio da Patrulha', 'Santo Antônio das Missões', 'Santo Antônio do Palma', 'Santo Antônio do Planalto', 'Santo Augusto', 'Santo Cristo', 'Santo Expedito do Sul', 'São Borja', 'São Domingos do Sul', 'São Francisco de Assis', 'São Francisco de Paula', 'São Gabriel', 'São Jerônimo', 'São João da Urtiga', 'São João do Polêsine', 'São Jorge', 'São José das Missões', 'São José do Herval', 'São José do Hortêncio', 'São José do Inhacorá', 'São José do Norte', 'São José do Ouro', 'São José do Sul', 'São José dos Ausentes', 'São Leopoldo', 'São Lourenço do Sul', 'São Luiz Gonzaga', 'São Marcos', 'São Martinho', 'São Martinho da Serra', 'São Miguel das Missões', 'São Nicolau', 'São Paulo das Missões', 'São Pedro da Serra', 'São Pedro das Missões', 'São Pedro do Butiá', 'São Pedro do Sul', 'São Sebastião do Caí', 'São Sepé', 'São Valentim', 'São Valentim do Sul', 'São Valério do Sul', 'São Vendelino', 'São Vicente do Sul', 'Sapiranga', 'Sapucaia do Sul', 'Sarandi', 'Seberi', 'Sede Nova', 'Segredo', 'Selbach', 'Senador Salgado Filho', 'Sentinela do Sul', 'Serafina Corrêa', 'Sério', 'Sertão', 'Sertão Santana', 'Sete de Setembro', 'Severiano de Almeida', 'Silveira Martins', 'Sinimbu', 'Sobradinho', 'Soledade', 'Tabaí', 'Tapejara', 'Tapera', 'Tapes', 'Taquara', 'Taquari', 'Taquaruçu do Sul', 'Tavares', 'Tenente Portela', 'Terra de Areia', 'Teutônia', 'Tio Hugo', 'Tiradentes do Sul', 'Toropi', 'Torres', 'Tramandaí', 'Travesseiro', 'Três Arroios', 'Três Cachoeiras', 'Três Coroas', 'Três de Maio', 'Três Forquilhas', 'Três Palmeiras', 'Três Passos', 'Trindade do Sul', 'Triunfo', 'Tucunduva', 'Tunas', 'Tupanci do Sul', 'Tupanciretã', 'Tupandi', 'Tuparendi', 'Turuçu', 'Ubiretama', 'União da Serra', 'Unistalda', 'Uruguaiana', 'Vacaria', 'Vale do Sol', 'Vale Real', 'Vale Verde', 'Vanini', 'Venâncio Aires', 'Vera Cruz', 'Veranópolis', 'Vespasiano Correa', 'Viadutos', 'Viamão', 'Vicente Dutra', 'Victor Graeff', 'Vila Flores', 'Vila Lângaro', 'Vila Maria', 'Vila Nova do Sul', 'Vista Alegre', 'Vista Alegre do Prata', 'Vista Gaúcha', 'Vitória das Missões', 'Westfália', 'Xangri-lá',
    ], ['Abdon Batista', 'Abelardo Luz', 'Agrolândia', 'Agronômica', 'Água Doce', 'Águas de Chapecó', 'Águas Frias', 'Águas Mornas', 'Alfredo Wagner', 'Alto Bela Vista', 'Anchieta', 'Angelina', 'Anita Garibaldi', 'Anitápolis', 'Antônio Carlos', 'Apiúna', 'Arabutã', 'Araquari', 'Araranguá', 'Armazém', 'Arroio Trinta', 'Arvoredo', 'Ascurra', 'Atalanta', 'Aurora', 'Balneário Arroio do Silva', 'Balneário Barra do Sul', 'Balneário Camboriú', 'Balneário Gaivota', 'Bandeirante', 'Barra Bonita', 'Barra Velha', 'Bela Vista do Toldo', 'Belmonte', 'Benedito Novo', 'Biguaçu', 'Blumenau', 'Bocaina do Sul', 'Bom Jardim da Serra', 'Bom Jesus', 'Bom Jesus do Oeste', 'Bom Retiro', 'Bombinhas', 'Botuverá', 'Braço do Norte', 'Braço do Trombudo', 'Brunópolis', 'Brusque', 'Caçador', 'Caibi', 'Calmon', 'Camboriú', 'Campo Alegre', 'Campo Belo do Sul', 'Campo Erê', 'Campos Novos', 'Canelinha', 'Canoinhas', 'Capão Alto', 'Capinzal', 'Capivari de Baixo', 'Catanduvas', 'Caxambu do Sul', 'Celso Ramos', 'Cerro Negro', 'Chapadão do Lageado', 'Chapecó', 'Cocal do Sul', 'Concórdia', 'Cordilheira Alta', 'Coronel Freitas', 'Coronel Martins', 'Correia Pinto', 'Corupá', 'Criciúma', 'Cunha Porã', 'Cunhataí', 'Curitibanos', 'Descanso', 'Dionísio Cerqueira', 'Dona Emma', 'Doutor Pedrinho', 'Entre Rios', 'Ermo', 'Erval Velho', 'Faxinal dos Guedes', 'Flor do Sertão', 'Florianópolis', 'Formosa do Sul', 'Forquilhinha', 'Fraiburgo', 'Frei Rogério', 'Galvão', 'Garopaba', 'Garuva', 'Gaspar', 'Governador Celso Ramos', 'Grão Pará', 'Gravatal', 'Guabiruba', 'Guaraciaba', 'Guaramirim', 'Guarujá do Sul', 'Guatambú', 'Herval d\'Oeste', 'Ibiam', 'Ibicaré', 'Ibirama', 'Içara', 'Ilhota', 'Imaruí', 'Imbituba', 'Imbuia', 'Indaial', 'Iomerê', 'Ipira', 'Iporã do Oeste', 'Ipuaçu', 'Ipumirim', 'Iraceminha', 'Irani', 'Irati', 'Irineópolis', 'Itá', 'Itaiópolis', 'Itajaí', 'Itapema', 'Itapiranga', 'Itapoá', 'Ituporanga', 'Jaborá', 'Jacinto Machado', 'Jaguaruna', 'Jaraguá do Sul', 'Jardinópolis', 'Joaçaba', 'Joinville', 'José Boiteux', 'Jupiá', 'Lacerdópolis', 'Lages', 'Laguna', 'Lajeado Grande', 'Laurentino', 'Lauro Muller', 'Lebon Régis', 'Leoberto Leal', 'Lindóia do Sul', 'Lontras', 'Luiz Alves', 'Luzerna', 'Macieira', 'Mafra', 'Major Gercino', 'Major Vieira', 'Maracajá', 'Maravilha', 'Marema', 'Massaranduba', 'Matos Costa', 'Meleiro', 'Mirim Doce', 'Modelo', 'Mondaí', 'Monte Carlo', 'Monte Castelo', 'Morro da Fumaça', 'Morro Grande', 'Navegantes', 'Nova Erechim', 'Nova Itaberaba', 'Nova Trento', 'Nova Veneza', 'Novo Horizonte', 'Orleans', 'Otacílio Costa', 'Ouro', 'Ouro Verde', 'Paial', 'Painel', 'Palhoça', 'Palma Sola', 'Palmeira', 'Palmitos', 'Papanduva', 'Paraíso', 'Passo de Torres', 'Passos Maia', 'Paulo Lopes', 'Pedras Grandes', 'Penha', 'Peritiba', 'Petrolândia', 'Piçarras', 'Pinhalzinho', 'Pinheiro Preto', 'Piratuba', 'Planalto Alegre', 'Pomerode', 'Ponte Alta', 'Ponte Alta do Norte', 'Ponte Serrada', 'Porto Belo', 'Porto União', 'Pouso Redondo', 'Praia Grande', 'Presidente Castelo Branco', 'Presidente Getúlio', 'Presidente Nereu', 'Princesa', 'Quilombo', 'Rancho Queimado', 'Rio das Antas', 'Rio do Campo', 'Rio do Oeste', 'Rio do Sul', 'Rio dos Cedros', 'Rio Fortuna', 'Rio Negrinho', 'Rio Rufino', 'Riqueza', 'Rodeio', 'Romelândia', 'Salete', 'Saltinho', 'Salto Veloso', 'Sangão', 'Santa Cecília', 'Santa Helena', 'Santa Rosa de Lima', 'Santa Rosa do Sul', 'Santa Terezinha', 'Santa Terezinha do Progresso', 'Santiago do Sul', 'Santo Amaro da Imperatriz', 'São Bento do Sul', 'São Bernardino', 'São Bonifácio', 'São Carlos', 'São Cristovão do Sul', 'São Domingos', 'São Francisco do Sul', 'São João Batista', 'São João do Itaperiú', 'São João do Oeste', 'São João do Sul', 'São Joaquim', 'São José', 'São José do Cedro', 'São José do Cerrito', 'São Lourenço do Oeste', 'São Ludgero', 'São Martinho', 'São Miguel da Boa Vista', 'São Miguel do Oeste', 'São Pedro de Alcântara', 'Saudades', 'Schroeder', 'Seara', 'Serra Alta', 'Siderópolis', 'Sombrio', 'Sul Brasil', 'Taió', 'Tangará', 'Tigrinhos', 'Tijucas', 'Timbé do Sul', 'Timbó', 'Timbó Grande', 'Três Barras', 'Treviso', 'Treze de Maio', 'Treze Tílias', 'Trombudo Central', 'Tubarão', 'Tunápolis', 'Turvo', 'União do Oeste', 'Urubici', 'Urupema', 'Urussanga', 'Vargeão', 'Vargem', 'Vargem Bonita', 'Vidal Ramos', 'Videira', 'Vitor Meireles', 'Witmarsum', 'Xanxerê', 'Xavantina', 'Xaxim', 'Zortéa',
    ], ['Amparo de São Francisco', 'Aquidabã', 'Aracaju', 'Arauá', 'Areia Branca', 'Barra dos Coqueiros', 'Boquim', 'Brejo Grande', 'Campo do Brito', 'Canhoba', 'Canindé de São Francisco', 'Capela', 'Carira', 'Carmópolis', 'Cedro de São João', 'Cristinápolis', 'Cumbe', 'Divina Pastora', 'Estância', 'Feira Nova', 'Frei Paulo', 'Gararu', 'General Maynard', 'Gracho Cardoso', 'Ilha das Flores', 'Indiaroba', 'Itabaiana', 'Itabaianinha', 'Itabi', 'Itaporanga d\'Ajuda', 'Japaratuba', 'Japoatã', 'Lagarto', 'Laranjeiras', 'Macambira', 'Malhada dos Bois', 'Malhador', 'Maruim', 'Moita Bonita', 'Monte Alegre de Sergipe', 'Muribeca', 'Neópolis', 'Nossa Senhora Aparecida', 'Nossa Senhora da Glória', 'Nossa Senhora das Dores', 'Nossa Senhora de Lourdes', 'Nossa Senhora do Socorro', 'Pacatuba', 'Pedra Mole', 'Pedrinhas', 'Pinhão', 'Pirambu', 'Poço Redondo', 'Poço Verde', 'Porto da Folha', 'Propriá', 'Riachão do Dantas', 'Riachuelo', 'Ribeirópolis', 'Rosário do Catete', 'Salgado', 'Santa Luzia do Itanhy', 'Santa Rosa de Lima', 'Santana do São Francisco', 'Santo Amaro das Brotas', 'São Cristóvão', 'São Domingos', 'São Francisco', 'São Miguel do Aleixo', 'Simão Dias', 'Siriri', 'Telha', 'Tobias Barreto', 'Tomar do Geru', 'Umbaúba',
    ], ['Adamantina', 'Adolfo', 'Aguaí', 'Águas da Prata', 'Águas de Lindóia', 'Águas de Santa Bárbara', 'Águas de São Pedro', 'Agudos', 'Alambari', 'Alfredo Marcondes', 'Altair', 'Altinópolis', 'Alto Alegre', 'Alumínio', 'Álvares Florence', 'Álvares Machado', 'Álvaro de Carvalho', 'Alvinlândia', 'Americana', 'Américo Brasiliense', 'Américo de Campos', 'Amparo', 'Analândia', 'Andradina', 'Angatuba', 'Anhembi', 'Anhumas', 'Aparecida', 'Aparecida d\'Oeste', 'Apiaí', 'Araçariguama', 'Araçatuba', 'Araçoiaba da Serra', 'Aramina', 'Arandu', 'Arapeí', 'Araraquara', 'Araras', 'Arco-Íris', 'Arealva', 'Areias', 'Areiópolis', 'Ariranha', 'Artur Nogueira', 'Arujá', 'Aspásia', 'Assis', 'Atibaia', 'Auriflama', 'Avaí', 'Avanhandava', 'Avaré', 'Bady Bassitt', 'Balbinos', 'Bálsamo', 'Bananal', 'Barão de Antonina', 'Barbosa', 'Bariri', 'Barra Bonita', 'Barra do Chapéu', 'Barra do Turvo', 'Barretos', 'Barrinha', 'Barueri', 'Bastos', 'Batatais', 'Bauru', 'Bebedouro', 'Bento de Abreu', 'Bernardino de Campos', 'Bertioga', 'Bilac', 'Birigui', 'Biritiba-Mirim', 'Boa Esperança do Sul', 'Bocaina', 'Bofete', 'Boituva', 'Bom Jesus dos Perdões', 'Bom Sucesso de Itararé', 'Borá', 'Boracéia', 'Borborema', 'Borebi', 'Botucatu', 'Bragança Paulista', 'Braúna', 'Brejo Alegre', 'Brodowski', 'Brotas', 'Buri', 'Buritama', 'Buritizal', 'Cabrália Paulista', 'Cabreúva', 'Caçapava', 'Cachoeira Paulista', 'Caconde', 'Cafelândia', 'Caiabu', 'Caieiras', 'Caiuá', 'Cajamar', 'Cajati', 'Cajobi', 'Cajuru', 'Campina do Monte Alegre', 'Campinas', 'Campo Limpo Paulista', 'Campos do Jordão', 'Campos Novos Paulista', 'Cananéia', 'Canas', 'Cândido Mota', 'Cândido Rodrigues', 'Canitar', 'Capão Bonito', 'Capela do Alto', 'Capivari', 'Caraguatatuba', 'Carapicuíba', 'Cardoso', 'Casa Branca', 'Cássia dos Coqueiros', 'Castilho', 'Catanduva', 'Catiguá', 'Cedral', 'Cerqueira César', 'Cerquilho', 'Cesário Lange', 'Charqueada', 'Chavantes', 'Clementina', 'Colina', 'Colômbia', 'Conchal', 'Conchas', 'Cordeirópolis', 'Coroados', 'Coronel Macedo', 'Corumbataí', 'Cosmópolis', 'Cosmorama', 'Cotia', 'Cravinhos', 'Cristais Paulista', 'Cruzália', 'Cruzeiro', 'Cubatão', 'Cunha', 'Descalvado', 'Diadema', 'Dirce Reis', 'Divinolândia', 'Dobrada', 'Dois Córregos', 'Dolcinópolis', 'Dourado', 'Dracena', 'Duartina', 'Dumont', 'Echaporã', 'Eldorado', 'Elias Fausto', 'Elisiário', 'Embaúba', 'Embu', 'Embu-Guaçu', 'Emilianópolis', 'Engenheiro Coelho', 'Espírito Santo do Pinhal', 'Espírito Santo do Turvo', 'Estiva Gerbi', 'Estrela d\'Oeste', 'Estrela do Norte', 'Euclides da Cunha Paulista', 'Fartura', 'Fernando Prestes', 'Fernandópolis', 'Fernão', 'Ferraz de Vasconcelos', 'Flora Rica', 'Floreal', 'Florínia', 'Flórida Paulista', 'Franca', 'Francisco Morato', 'Franco da Rocha', 'Gabriel Monteiro', 'Gália', 'Garça', 'Gastão Vidigal', 'Gavião Peixoto', 'General Salgado', 'Getulina', 'Glicério', 'Guaiçara', 'Guaimbê', 'Guaíra', 'Guapiaçu', 'Guapiara', 'Guará', 'Guaraçaí', 'Guaraci', 'Guarani d\'Oeste', 'Guarantã', 'Guararapes', 'Guararema', 'Guaratinguetá', 'Guareí', 'Guariba', 'Guarujá', 'Guarulhos', 'Guatapará', 'Guzolândia', 'Herculândia', 'Holambra', 'Hortolândia', 'Iacanga', 'Iacri', 'Iaras', 'Ibaté', 'Ibirá', 'Ibirarema', 'Ibitinga', 'Ibiúna', 'Icém', 'Iepê', 'Igaraçu do Tietê', 'Igarapava', 'Igaratá', 'Iguape', 'Ilha Comprida', 'Ilha Solteira', 'Ilhabela', 'Indaiatuba', 'Indiana', 'Indiaporã', 'Inúbia Paulista', 'Ipauçu', 'Iperó', 'Ipeúna', 'Ipiguá', 'Iporanga', 'Ipuã', 'Iracemápolis', 'Irapuã', 'Irapuru', 'Itaberá', 'Itaí', 'Itajobi', 'Itaju', 'Itanhaém', 'Itaóca', 'Itapecerica da Serra', 'Itapetininga', 'Itapeva', 'Itapevi', 'Itapira', 'Itapirapuã Paulista', 'Itápolis', 'Itaporanga', 'Itapuí', 'Itapura', 'Itaquaquecetuba', 'Itararé', 'Itariri', 'Itatiba', 'Itatinga', 'Itirapina', 'Itirapuã', 'Itobi', 'Itu', 'Itupeva', 'Ituverava', 'Jaborandi', 'Jaboticabal', 'Jacareí', 'Jaci', 'Jacupiranga', 'Jaguariúna', 'Jales', 'Jambeiro', 'Jandira', 'Jardinópolis', 'Jarinu', 'Jaú', 'Jeriquara', 'Joanópolis', 'João Ramalho', 'José Bonifácio', 'Júlio Mesquita', 'Jumirim', 'Jundiaí', 'Junqueirópolis', 'Juquiá', 'Juquitiba', 'Lagoinha', 'Laranjal Paulista', 'Lavínia', 'Lavrinhas', 'Leme', 'Lençóis Paulista', 'Limeira', 'Lindóia', 'Lins', 'Lorena', 'Lourdes', 'Louveira', 'Lucélia', 'Lucianópolis', 'Luís Antônio', 'Luiziânia', 'Lupércio', 'Lutécia', 'Macatuba', 'Macaubal', 'Macedônia', 'Magda', 'Mairinque', 'Mairiporã', 'Manduri', 'Marabá Paulista', 'Maracaí', 'Marapoama', 'Mariápolis', 'Marília', 'Marinópolis', 'Martinópolis', 'Matão', 'Mauá', 'Mendonça', 'Meridiano', 'Mesópolis', 'Miguelópolis', 'Mineiros do Tietê', 'Mira Estrela', 'Miracatu', 'Mirandópolis', 'Mirante do Paranapanema', 'Mirassol', 'Mirassolândia', 'Mococa', 'Mogi das Cruzes', 'Mogi-Guaçu', 'Mogi-Mirim', 'Mombuca', 'Monções', 'Mongaguá', 'Monte Alegre do Sul', 'Monte Alto', 'Monte Aprazível', 'Monte Azul Paulista', 'Monte Castelo', 'Monte Mor', 'Monteiro Lobato', 'Morro Agudo', 'Morungaba', 'Motuca', 'Murutinga do Sul', 'Nantes', 'Narandiba', 'Natividade da Serra', 'Nazaré Paulista', 'Neves Paulista', 'Nhandeara', 'Nipoã', 'Nova Aliança', 'Nova Campina', 'Nova Canaã Paulista', 'Nova Castilho', 'Nova Europa', 'Nova Granada', 'Nova Guataporanga', 'Nova Independência', 'Nova Luzitânia', 'Nova Odessa', 'Novais', 'Novo Horizonte', 'Nuporanga', 'Ocauçu', 'Óleo', 'Olímpia', 'Onda Verde', 'Oriente', 'Orindiúva', 'Orlândia', 'Osasco', 'Oscar Bressane', 'Osvaldo Cruz', 'Ourinhos', 'Ouro Verde', 'Ouroeste', 'Pacaembu', 'Palestina', 'Palmares Paulista', 'Palmeira d\'Oeste', 'Palmital', 'Panorama', 'Paraguaçu Paulista', 'Paraibuna', 'Paraíso', 'Paranapanema', 'Paranapuã', 'Parapuã', 'Pardinho', 'Pariquera-Açu', 'Parisi', 'Patrocínio Paulista', 'Paulicéia', 'Paulínia', 'Paulistânia', 'Paulo de Faria', 'Pederneiras', 'Pedra Bela', 'Pedranópolis', 'Pedregulho', 'Pedreira', 'Pedrinhas Paulista', 'Pedro de Toledo', 'Penápolis', 'Pereira Barreto', 'Pereiras', 'Peruíbe', 'Piacatu', 'Piedade', 'Pilar do Sul', 'Pindamonhangaba', 'Pindorama', 'Pinhalzinho', 'Piquerobi', 'Piquete', 'Piracaia', 'Piracicaba', 'Piraju', 'Pirajuí', 'Pirangi', 'Pirapora do Bom Jesus', 'Pirapozinho', 'Pirassununga', 'Piratininga', 'Pitangueiras', 'Planalto', 'Platina', 'Poá', 'Poloni', 'Pompéia', 'Pongaí', 'Pontal', 'Pontalinda', 'Pontes Gestal', 'Populina', 'Porangaba', 'Porto Feliz', 'Porto Ferreira', 'Potim', 'Potirendaba', 'Pracinha', 'Pradópolis', 'Praia Grande', 'Pratânia', 'Presidente Alves', 'Presidente Bernardes', 'Presidente Epitácio', 'Presidente Prudente', 'Presidente Venceslau', 'Promissão', 'Quadra', 'Quatá', 'Queiroz', 'Queluz', 'Quintana', 'Rafard', 'Rancharia', 'Redenção da Serra', 'Regente Feijó', 'Reginópolis', 'Registro', 'Restinga', 'Ribeira', 'Ribeirão Bonito', 'Ribeirão Branco', 'Ribeirão Corrente', 'Ribeirão do Sul', 'Ribeirão dos Índios', 'Ribeirão Grande', 'Ribeirão Pires', 'Ribeirão Preto', 'Rifaina', 'Rincão', 'Rinópolis', 'Rio Claro', 'Rio das Pedras', 'Rio Grande da Serra', 'Riolândia', 'Riversul', 'Rosana', 'Roseira', 'Rubiácea', 'Rubinéia', 'Sabino', 'Sagres', 'Sales', 'Sales Oliveira', 'Salesópolis', 'Salmourão', 'Saltinho', 'Salto', 'Salto de Pirapora', 'Salto Grande', 'Sandovalina', 'Santa Adélia', 'Santa Albertina', 'Santa Bárbara d\'Oeste', 'Santa Branca', 'Santa Clara d\'Oeste', 'Santa Cruz da Conceição', 'Santa Cruz da Esperança', 'Santa Cruz das Palmeiras', 'Santa Cruz do Rio Pardo', 'Santa Ernestina', 'Santa Fé do Sul', 'Santa Gertrudes', 'Santa Isabel', 'Santa Lúcia', 'Santa Maria da Serra', 'Santa Mercedes', 'Santa Rita d\'Oeste', 'Santa Rita do Passa Quatro', 'Santa Rosa de Viterbo', 'Santa Salete', 'Santana da Ponte Pensa', 'Santana de Parnaíba', 'Santo Anastácio', 'Santo André', 'Santo Antônio da Alegria', 'Santo Antônio de Posse', 'Santo Antônio do Aracanguá', 'Santo Antônio do Jardim', 'Santo Antônio do Pinhal', 'Santo Expedito', 'Santópolis do Aguapeí', 'Santos', 'São Bento do Sapucaí', 'São Bernardo do Campo', 'São Caetano do Sul', 'São Carlos', 'São Francisco', 'São João da Boa Vista', 'São João das Duas Pontes', 'São João de Iracema', 'São João do Pau d\'Alho', 'São Joaquim da Barra', 'São José da Bela Vista', 'São José do Barreiro', 'São José do Rio Pardo', 'São José do Rio Preto', 'São José dos Campos', 'São Lourenço da Serra', 'São Luís do Paraitinga', 'São Manuel', 'São Miguel Arcanjo', 'São Paulo', 'São Pedro', 'São Pedro do Turvo', 'São Roque', 'São Sebastião', 'São Sebastião da Grama', 'São Simão', 'São Vicente', 'Sarapuí', 'Sarutaiá', 'Sebastianópolis do Sul', 'Serra Azul', 'Serra Negra', 'Serrana', 'Sertãozinho', 'Sete Barras', 'Severínia', 'Silveiras', 'Socorro', 'Sorocaba', 'Sud Mennucci', 'Sumaré', 'Suzanápolis', 'Suzano', 'Tabapuã', 'Tabatinga', 'Taboão da Serra', 'Taciba', 'Taguaí', 'Taiaçu', 'Taiúva', 'Tambaú', 'Tanabi', 'Tapiraí', 'Tapiratiba', 'Taquaral', 'Taquaritinga', 'Taquarituba', 'Taquarivaí', 'Tarabai', 'Tarumã', 'Tatuí', 'Taubaté', 'Tejupá', 'Teodoro Sampaio', 'Terra Roxa', 'Tietê', 'Timburi', 'Torre de Pedra', 'Torrinha', 'Trabiju', 'Tremembé', 'Três Fronteiras', 'Tuiuti', 'Tupã', 'Tupi Paulista', 'Turiúba', 'Turmalina', 'Ubarana', 'Ubatuba', 'Ubirajara', 'Uchoa', 'União Paulista', 'Urânia', 'Uru', 'Urupês', 'Valentim Gentil', 'Valinhos', 'Valparaíso', 'Vargem', 'Vargem Grande do Sul', 'Vargem Grande Paulista', 'Várzea Paulista', 'Vera Cruz', 'Vinhedo', 'Viradouro', 'Vista Alegre do Alto', 'Vitória Brasil', 'Votorantim', 'Votuporanga', 'Zacarias',
    ], ['Abreulândia', 'Aguiarnópolis', 'Aliança do Tocantins', 'Almas', 'Alvorada', 'Ananás', 'Angico', 'Aparecida do Rio Negro', 'Aragominas', 'Araguacema', 'Araguaçu', 'Araguaína', 'Araguanã', 'Araguatins', 'Arapoema', 'Arraias', 'Augustinópolis', 'Aurora do Tocantins', 'Axixá do Tocantins', 'Babaçulândia', 'Bandeirantes do Tocantins', 'Barra do Ouro', 'Barrolândia', 'Bernardo Sayão', 'Bom Jesus do Tocantins', 'Brasilândia do Tocantins', 'Brejinho de Nazaré', 'Buriti do Tocantins', 'Cachoeirinha', 'Campos Lindos', 'Cariri do Tocantins', 'Carmolândia', 'Carrasco Bonito', 'Caseara', 'Centenário', 'Chapada da Natividade', 'Chapada de Areia', 'Colinas do Tocantins', 'Colméia', 'Combinado', 'Conceição do Tocantins', 'Couto de Magalhães', 'Cristalândia', 'Crixás do Tocantins', 'Darcinópolis', 'Dianópolis', 'Divinópolis do Tocantins', 'Dois Irmãos do Tocantins', 'Dueré', 'Esperantina', 'Fátima', 'Figueirópolis', 'Filadélfia', 'Formoso do Araguaia', 'Fortaleza do Tabocão', 'Goianorte', 'Goiatins', 'Guaraí', 'Gurupi', 'Ipueiras', 'Itacajá', 'Itaguatins', 'Itapiratins', 'Itaporã do Tocantins', 'Jaú do Tocantins', 'Juarina', 'Lagoa da Confusão', 'Lagoa do Tocantins', 'Lajeado', 'Lavandeira', 'Lizarda', 'Luzinópolis', 'Marianópolis do Tocantins', 'Mateiros', 'Maurilândia do Tocantins', 'Miracema do Tocantins', 'Miranorte', 'Monte do Carmo', 'Monte Santo do Tocantins', 'Muricilândia', 'Natividade', 'Nazaré', 'Nova Olinda', 'Nova Rosalândia', 'Novo Acordo', 'Novo Alegre', 'Novo Jardim', 'Oliveira de Fátima', 'Palmas', 'Palmeirante', 'Palmeiras do Tocantins', 'Palmeirópolis', 'Paraíso do Tocantins', 'Paranã', 'Pau d\'Arco', 'Pedro Afonso', 'Peixe', 'Pequizeiro', 'Pindorama do Tocantins', 'Piraquê', 'Pium', 'Ponte Alta do Bom Jesus', 'Ponte Alta do Tocantins', 'Porto Alegre do Tocantins', 'Porto Nacional', 'Praia Norte', 'Presidente Kennedy', 'Pugmil', 'Recursolândia', 'Riachinho', 'Rio da Conceição', 'Rio dos Bois', 'Rio Sono', 'Sampaio', 'Sandolândia', 'Santa Fé do Araguaia', 'Santa Maria do Tocantins', 'Santa Rita do Tocantins', 'Santa Rosa do Tocantins', 'Santa Tereza do Tocantins', 'Santa Terezinha Tocantins', 'São Bento do Tocantins', 'São Félix do Tocantins', 'São Miguel do Tocantins', 'São Salvador do Tocantins', 'São Sebastião do Tocantins', 'São Valério da Natividade', 'Silvanópolis', 'Sítio Novo do Tocantins', 'Sucupira', 'Taguatinga', 'Taipas do Tocantins', 'Talismã', 'Tocantínia', 'Tocantinópolis', 'Tupirama', 'Tupiratins', 'Wanderlândia', 'Xambioá'
    ]
  ]
        };

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

        function validarCNPJ(cnpj) {

            cnpj = cnpj.replace(/[^\d]+/g, '');

            if (cnpj == '') return false;

            if (cnpj.length != 14)
                return false;

            // Elimina CNPJs invalidos conhecidos
            if (cnpj == "00000000000000" ||
		cnpj == "11111111111111" ||
		cnpj == "22222222222222" ||
		cnpj == "33333333333333" ||
		cnpj == "44444444444444" ||
		cnpj == "55555555555555" ||
		cnpj == "66666666666666" ||
		cnpj == "77777777777777" ||
		cnpj == "88888888888888" ||
		cnpj == "99999999999999")
                return false;

            // Valida DVs
            tamanho = cnpj.length - 2
            numeros = cnpj.substring(0, tamanho);
            digitos = cnpj.substring(tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                return false;

            tamanho = tamanho + 1;
            numeros = cnpj.substring(0, tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                return false;

            return true;

        }

        function validarCPF(cpf) {
            cpf = cpf.replace(/[^\d]+/g, '');
            if (cpf == '') return false;
            // Elimina CPFs invalidos conhecidos    
            if (cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999") return false;

            // Valida 1o digito 
            add = 0;
            for (i = 0; i < 9; i++)
                add += parseInt(cpf.charAt(i)) * (10 - i);
            rev = 11 - (add % 11);
            if (rev == 10 || rev == 11) rev = 0;
            if (rev != parseInt(cpf.charAt(9))) return false;
            // Valida 2o digito 
            add = 0;
            for (i = 0; i < 10; i++) add += parseInt(cpf.charAt(i)) * (11 - i);
            rev = 11 - (add % 11);
            if (rev == 10 || rev == 11) rev = 0;
            if (rev != parseInt(cpf.charAt(10))) return false;
            return true;
        }

        var model = { "coberturas": [] };
        $(document).ready(function () {

            obj = new dgCidadesEstados(document.getElementById('comarcaUF'), document.getElementById('comarcaCidade'), true);

            try {
                strUF = document.getElementById("lblComarcaUF").innerHTML;
                $('.judicial option[value=' + strUF + ']').prop('selected', true);
                obj.run();
                strCidade = document.getElementById("lblComarcaCidade").innerHTML;
                $('.judicial option[value="' + strCidade + '"]').prop('selected', true);
            }
            catch (err) {
                alert(err.message);
            }

            if (document.getElementById('FormView1_lblTpSinistro').innerText == "JUDICIAL") {
                divDadosJudicial.style.display = 'block';
                document.getElementById('btnSalvarJudicial').style.display = 'block';
                document.getElementById('btnTransformarJudicial').style.display = 'none';
            }
            else {
                divDadosJudicial.style.display = 'none';
                document.getElementById('btnSalvarJudicial').style.display = 'none';
                document.getElementById('btnTransformarJudicial').style.display = 'block';
            }


            if (document.getElementById('txtPerfil').value == '-1') {
                document.getElementById('barraBotoes').style.display = 'none';
                document.getElementById('barraComentario').style.display = 'none';
                document.getElementById('barraJudicial').style.display = 'none';
            }

            document.getElementById('txtValorAjusteHon').disabled = false;
            document.getElementById('txtValorAjusteDes').disabled = false;
            document.getElementById('txtValorAjusteRes').disabled = false;
            document.getElementById('txtValorAjusteSal').disabled = false;

            $('#btnScan').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            $('#btnCarregar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            $('btFechar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $("#imagensGrid").flexigrid({
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
                height: 300,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

            CarregarGridArquivos();

            $('#btnTransformarJudicial').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'block';
                abrirJudicial.style.display = 'block';
            });

            $('#btnSalvarJudicial').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "sinistro?judicialDados=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                              document.getElementById('txtProcesso').value + '$' +
                                              document.getElementById('txtMotivoAcao').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                                              document.getElementById('txtReu').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                                              document.getElementById('txtObjeto').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                                              document.getElementById('cboAdvogadoResponsavel').value + '$' +
                                              document.getElementById('txtAdvogadoParteContraria').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                                              document.getElementById('txtDataCitacao').value + '$' +
                                              document.getElementById('txtDataCadastro').value + '$' +
                                              document.getElementById('txtDataDefesa').value + '$' +
                                              document.getElementById('txtValorDaCausa').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorDoRisco').value.replace(",", ".") + '$' +
                                              document.getElementById('cboProbabilidade').value + '$' +
                                              document.getElementById('cboFase').value + '$' +
                                              document.getElementById('cboMotivoEncerramento').value + '$' +
                                              document.getElementById('txtAutor').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                                              document.getElementById('comarcaUF').value + '$' +
                                              document.getElementById('comarcaCidade').value + '$' +
                                              document.getElementById('cboVara').value + '$' +
                                              document.getElementById('cboRito').value + '$' +
                                              document.getElementById('cboTipoAcao').value + '$' +
                                              document.getElementById('cboCausaRaiz').value.replace(/\$/g, '^').replace(/\@/g, '~'),
                    data: "{}",
                    dataType: 'json',
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Dados judiciais gravados com sucesso.');
                        location.reload();
                    }
                });

            });

            $('#txtVlPagto').maskMoney({ precision: 2 });
            $('#txtValorAjuste').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteHon').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteDes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteRes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteSal').maskMoney({ precision: 2, allowNegative: true });

            $('#txtReserva').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaHon').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDesp').maskMoney({ precision: 2, allowNegative: true });

            $('#txtReservaDisponivel').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelHon').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelDes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelRes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelSal').maskMoney({ precision: 2, allowNegative: true });
            $('#txtParticipacao').maskMoney({ precision: 2 });
            $('#txtValorLiquidacao').maskMoney({ precision: 2 });
            $('#txtIndenizacaoJudicial').maskMoney({ precision: 2 });
            $('#txtHonorarios').maskMoney({ precision: 2 });
            $('#txtDespesas').maskMoney({ precision: 2 });
            $('#txtRemoto').maskMoney({ precision: 2 });
            $('#txtPossivel').maskMoney({ precision: 2 });
            $('#txtProvavel').maskMoney({ precision: 2 });
            datepickerBR('#txtDtPagto');

            datepickerBR('#txtDataCitacao');
            datepickerBR('#txtDataCadastro');
            datepickerBR('#txtDataDefesa');
            $('#txtValorDaCausa').maskMoney({ precision: 2 });
            $('#txtValorDoRisco').maskMoney({ precision: 2 });

            $('.buttonFinish').click(function () {
                //finalizarApolice();
            });

            $('#wizard').smartWizard({
                selected: model.Passo > 0 ? model.Passo - 1 : model.Passo,
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
                onShowStep: showStepCallback,
                onFinish: finalizarApolice
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

            $('#btnComentario').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                var cbo = null;
                if (document.getElementById('cboComentarioEvento').value != -1) {
                    cbo = document.getElementById('cboComentarioEvento').value;
                }
                else if (document.getElementById('cboComentarioJudicial').value != '') {
                    cbo = document.getElementById('cboComentarioJudicial').value;
                    alert(cbo);
                }

                if (cbo == null) {
                    alert("É necessario informar o tipo do comentario");
                } else {
                    $.ajax({
                        type: "post",
                        contentType: "application/json",
                        url: "sinistro?comentario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                                  cbo + '$' +
                                                  document.getElementById('txtUsuario').value + '$' +
                                                  document.getElementById('txtComentarioEvento').value.replace(/\$/g, '^').replace(/\@/g, '~'),
                        data: "{}",
                        dataType: 'json',
                        error: function (xhr, status, error) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.ExceptionMessage);
                        },
                        success: function (result) {
                            alert('Comentário gravado com sucesso.');
                            location.reload();
                        }
                    });
                }

            });

            $('#btnCancelarOP').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'none';
                novaOP.style.display = 'none';
            });

            $('#btnLimparPessoa').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                Pessoa.style.display = 'none';
            });

            $('#btnGravarPessoa').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "get",
                    url: "pessoa?nometipo=" + document.getElementById('txtNomePessoa').value + '$' + document.getElementById('cboTipoPessoa').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');
                        document.getElementById('txtIdPessoa').value = result;
                    }
                });
            });

            $('#btnFecharPessoas').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                Pessoa.style.display = 'none';
            });

            $('#btnCancelarBeneficiario').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'none';
                beneficiarios.style.display = 'none';
            });

            $('#btnGravarOP').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                GravarOP();
            });

            $('#btnCadastroPessoa').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                //                beneficiarios.style.display = 'none';
                Pessoa.style.display = 'block';

                $("#flexPessoas").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'ID', name: 'ID_PESSOA', width: 41, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Tipo Pessoa', name: 'TP_PESSOA', width: 60, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Nome', name: 'DS_PESSOA', width: 300, sortable: true, align: 'left', process: abrirPessoa }
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
                        { display: 'Tipo Docto', name: 'TP_DOCTO', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Número', name: 'NR_DOCTO', width: 300, sortable: true, align: 'left', process: abrirBeneficiario }
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
                        { display: 'Endereço', name: 'DS_ENDERECO', width: 250, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Complemento', name: 'DS_COMPL', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Bairro', name: 'DS_BAIRRO', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Cidade', name: 'DS_CIDADE', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'UF', name: 'CD_UF', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'CEP', name: 'DS_CEP', width: 50, sortable: true, align: 'left', process: abrirBeneficiario }
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
                        { display: 'Tipo', name: 'TP_CONTA', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Número', name: 'NRO_CONTA', width: 60, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'DV', name: 'DV_CONTA', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Banco', name: 'DS_BANCO', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Agência', name: 'CD_AGENCIA', width: 60, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'DV', name: 'DV_AGENCIA', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Principal', name: 'FL_CONTA_PRINCIPAL', width: 40, sortable: true, align: 'left', process: abrirBeneficiario }
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

            $('#btnLimparBeneficiarios').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                if (!confirm("Deseja limpar a lista de beneficiários?")) return;
                $.ajax({
                    type: "post",
                    url: "sinistro?beneficiarios=" + +document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Lista de beneficiários excluída com sucesso.');
                    }
                });

                $.ajax({
                    type: "get",
                    contentType: "application/json",
                    url: "sinistro?beneficiario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    data: "{}",
                    dataType: 'json',
                    success: function (result) {
                        //add data
                        $("#flex1").flexAddData(formatResults(result));

                    }
                });

            });

            $('#btnEstipulante').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                chkEstipulanteClick();
            });

            $('#btnReabrirSinistro').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                ReabrirSinistro();
            });

            $('#btnFecharSinistro').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                FecharSinistro();
            });

            $('#btnAjusteManual').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                AjusteManual();
            });

            $('#btnNovaOP').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                NovaOP();
            });

            $('#btnCancelarAjuste').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                CancelarAjuste();
            });

            $('#btnSalvarAjuste').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                SalvarAjuste();
            });

            $('#btnGravarLiquidacao').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                document.getElementById('btnGravarLiq').disabled = false;
                GravarLiquidacao();
            });

            $('#btnGravarLiq').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                document.getElementById('btnGravarLiq').disabled = true;

                if ($('#chkBoleto').prop('checked')) {
                    var boleto = prompt("Por favor, use o leitor de código de barras para capturar o código do boleto para pagamento");
                    if (boleto != null) {
                        document.getElementById('txtCodigoBoleto').value = boleto;
                    }
                }

                SalvarLiquidacao();
            });

            $('#btnAdicionarBeneficiario').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                AdicionarBeneficiario();
            });

        });

        function AlterarCessao(id) {
            var r = prompt("Qual o novo percentual?");

            if (r == null) { return };
            if (isNaN(r)) {
                alert("Valor inválido!")
                return;
            }

            if (r < 0) {
                alert("Valor inválido!")
                return;
            }
            if (r > 100) {
                alert("Valor inválido!")
                return;
            }

            {
                $.ajax({
                    type: "post",
                    url: "sinistro?alterarCessao=" + id + '$' + r + '$' + document.getElementById('txtUsuario').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert("Novo percentual alterado com sucesso.");
                        location.reload();
                    }
                });
            }
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
                        $("#flexPessoas").flexAddData([]);
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
                            rows.push({ cell: [item.TP_DOCTO, item.NR_DOCTO, ''] });
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
                            rows.push({ cell: [item.DS_ENDERECO, item.DS_COMPL, item.DS_BAIRRO, item.DS_CIDADE, item.CD_UF, item.DS_CEP, ''] });
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

        function chkEstipulanteClick() {
            $.ajax({
                type: "get",
                url: "sinistro?idSinistroEstipulante=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                success: function (result) {


                    var pessoa = result[0];
                    document.getElementById('txtNome').value = pessoa.DS_PESSOA;
                    document.getElementById('txtCPF').value = pessoa.NR_DOCTO;
                    document.getElementById('txtIdPessoa').value = pessoa.ID_PESSOA;
                    document.getElementById('txtIdDocto').value = pessoa.ID_DOCTO;
                    document.getElementById('txtCPF').value = pessoa.NR_DOCTO;
                    document.getElementById('cboParentesco').value = 99;
                    document.getElementById('txtParticipacao').value = 100;


                    for (i = 0; i < result.length; i++) {
                        var conta = result[i];
                        var dropdown = document.getElementById("cboConta");
                        dropdown[dropdown.length] = new Option(conta.DS_BANCO + " - Agencia: " + conta.CD_AGENCIA + " Conta: " + conta.NRO_CONTA, conta.ID_CONTA);
                    }

                }
            });
        }

        function GravarOP() {
            $.ajax({
                type: "post",
                url: "sinistro?op=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                      document.getElementById('txtDtPagto2').value + '$' +
                                      document.getElementById('txtUsuario').value,
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.ExceptionMessage);
                },
                success: function (result) {
                    alert('OP gravada com sucesso.');
                    location.reload();
                }
            });
        }

        function NovaOP() {

            switch (document.getElementById('FormView1_lblStatus').innerText) {
                case "APROVAÇAO PAGAMENTO PENDENTE": { alert("Sinistro tem aprovaçao de pagamento pendente. Você não pode cadastrar a OP antes da aprovação."); return; };
            }

            overlay.style.display = 'block';
            novaOP.style.display = 'block';

            $.ajax({
                type: "get",
                url: "sinistro?liquidacao=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                success: function (result) {
                    var rows = Array();

                    if (result.length == 0) {
                        alert("Não existe liquidação pendente de pagamento. Use o botão 'Liquidação' para gerar uma liquidação. ");
                        overlay.style.display = 'none';
                        novaOP.style.display = 'none';
                        return;
                    }

                    var item = result[0];
                    document.getElementById('txtIdLiquidacao').value = item.ID_LIQUIDACAO;
                    document.getElementById('txtVlPagto').value = item.VL_TOTAL;
                    if (item.FL_PAGTO == "T")
                    { document.getElementById('txtFlPagto').value = "PAGTO TOTAL"; }
                    else
                    { document.getElementById('txtFlPagto').value = "PAGTO PARCIAL"; }
                    document.getElementById('txtDsBeneficiario').value = item.DS_BENEFICIARIO;
                }
            });

        }

        function FecharSinistro() {
            var x;
            var r = confirm("Deseja fechar o sinistro?");
            if (r == true) {
                $.ajax({
                    type: "post",
                    url: "sinistro?fechar=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Sinistro fechado com sucesso.');
                        location.reload();
                    }
                });
            }
        }

        function ReabrirSinistro() {
            var x;
            var r = confirm("Deseja reabrir o sinistro?");
            if (r == true) {
                $.ajax({
                    type: "post",
                    url: "sinistro?reabrir=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Sinistro reaberto com sucesso.');
                        location.reload();
                    }
                });
            }
        }

        function CancelarAjuste() {
            overlay.style.display = 'none';
            ajusteManual.style.display = 'none';
        }

        function SalvarAjuste() {
            $.ajax({
                type: "post",
                url: "sinistro?ajuste=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                              document.getElementById('txtValorAjuste').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteHon').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteDes').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteRes').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteSal').value.replace(",", "."),
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.ExceptionMessage);
                },
                success: function (result) {
                    alert('Ajuste gravado com sucesso.');
                    location.reload();
                }
            });
        }

        function AjusteManual() {
            overlay.style.display = 'block';
            ajusteManual.style.display = 'block';

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$1",
                success: function (result) {
                    document.getElementById('txtReservaDisponivel').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$2",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelHon').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$3",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelDes').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$5",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelRes').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$6",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelSal').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

        }

        function SalvarLiquidacao() {

            var geraBoleto;
            var retencaoImpostos;
            var bordero;
            var governo;


            if ($('#chkBoleto').prop('checked')) geraBoleto = "1"
            else geraBoleto = "0";

            if ($('#chkRetencaoImpostos').prop('checked')) retencaoImpostos = "1"
            else retencaoImpostos = "0";

            if ($('#chkBordero').prop('checked')) bordero = "1"
            else bordero = "0";

            if ($('#chkGoverno').prop('checked')) governo = "1"
            else governo = "0";

            var vlReserva;
            var tpValor;

            if (document.getElementById('cboTipoLiquidacao').value == 1) {
                vlReserva = document.getElementById('txtReserva').value.replace(",", ".");
                tpValor = 1;
            }
            if (document.getElementById('cboTipoLiquidacao').value == 2) {
                vlReserva = document.getElementById('txtReservaHon').value.replace(",", ".");
                tpValor = 2;
            }
            if (document.getElementById('cboTipoLiquidacao').value == 3) {
                vlReserva = document.getElementById('txtReservaDesp').value.replace(",", ".");
                tpValor = 3;
            }

            $.ajax({
                type: "post",
                contentType: "application/json",
                url: "sinistro?liquidacao=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                              document.getElementById('txtValorLiquidacao').value.replace(",", ".") + '$' +
                                              vlReserva + '$' +
                                              tpValor + '$' +
                                              document.getElementById('txtDtPagto').value + '$' +
                                              document.getElementById('txtUsuario').value + '$' +
                                              retencaoImpostos + '$' +
                                              geraBoleto + '$' +
                                              document.getElementById('txtCodigoBoleto').value + '$' +
                                              bordero + '$' +
                                              governo + '$' +
                                              document.getElementById('txtComentario').value.replace(/\$/g, '^').replace(/\@/g, '~'),
                data: "{}",
                dataType: 'json',
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.ExceptionMessage);
                },
                success: function (result) {
                    alert('Liquidação gravada com sucesso.');
                    location.reload();
                }
            });
        }

        function GravarLiquidacao() {
            //            sinistrosGrid.style.display = 'block';

            overlay.style.display = 'block';
            beneficiarios.style.display = 'block';

            switch (document.getElementById('FormView1_lblStatus').innerText) {
                case "APROVAÇAO PAGAMENTO PENDENTE": { alert("Sinistro tem aprovaçao pagamento pendente. Você não pode cadastrar uma nova liquidação."); document.getElementById('btnGravarLiq').disabled = true; };
                case "OP PENDENTE": { alert("Sinistro tem liquidação en progresso. Você não pode cadastrar uma nova liquidação ate final da anterior."); document.getElementById('btnGravarLiq').disabled = true; };
                case "OP EM PROGRESSO (PAGNET)": { alert("Sinistro tem liquidação en progresso. Você não pode cadastrar uma nova liquidação ate final da anterior."); document.getElementById('btnGravarLiq').disabled = true; };
            }

            $("#flex1").flexigrid({
                dataType: 'json',
                colModel: [
                        { display: 'ID', name: 'ID_BENEFICIARIO', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Nome', name: 'DS_PESSOA', width: 300, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Parentesco', name: 'TP_PARENTESCO', width: 70, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Participação', name: 'VL_PARTICIPACAO', width: 60, sortable: true, align: 'left', process: abrirBeneficiario }
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

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?beneficiario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });

            $.ajax({
                type: "get",
                //contentType: "application/json",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$1",
                //data: "{}",
                //dataType: 'json',
                success: function (result) {
                    document.getElementById('txtReserva').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                //contentType: "application/json",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$2",
                //data: "{}",
                //dataType: 'json',
                success: function (result) {
                    document.getElementById('txtReservaHon').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                //contentType: "application/json",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$3",
                //data: "{}",
                //dataType: 'json',
                success: function (result) {
                    document.getElementById('txtReservaDesp').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

        }

        function AdicionarBeneficiario() {
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?beneficiario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                                document.getElementById('txtParticipacao').value.replace(",", ".") + '$' +
                                                document.getElementById('cboParentesco').value + '$' +
                                                document.getElementById('txtIdPessoa').value + '$' +
                                                document.getElementById('txtIdDocto').value + '$' +
                                                document.getElementById('cboConta').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });

            document.getElementById('txtCPF').value = "";
            document.getElementById('txtNome').value = "";
            document.getElementById('txtIdPessoa').value = "";
            document.getElementById('txtIdDocto').value = "";
            document.getElementById('cboParentesco').value = "";
            document.getElementById('cboConta').options.length = 0;
            document.getElementById('txtParticipacao').value = "";
        }

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

        function pesquisarBeneficiario() {

            if (document.getElementById('txtCPF').value == "") { return; }

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "pessoa/" + document.getElementById('txtCPF').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {

                    if (result.length == 0) {
                        alert("Pessoa não encontrada.");
                        return;
                    }

                    var pessoa = result[0];
                    document.getElementById('txtNome').value = pessoa.DS_PESSOA;
                    document.getElementById('txtIdPessoa').value = pessoa.ID_PESSOA;
                    document.getElementById('txtIdDocto').value = pessoa.ID_DOCTO;

                    for (i = 0; i < result.length; i++) {
                        pessoa = result[i];
                        var dropdown = document.getElementById("cboConta");
                        dropdown[dropdown.length] = new Option(pessoa.DS_BANCO + " - Agencia: " + pessoa.CD_AGENCIA + " Conta: " + pessoa.NRO_CONTA, pessoa.ID_CONTA);
                    }

                }
            });
        }

        function finalizarApolice() {
        }

        function showStepCallback(obj) {
            var stepNum = obj.attr('rel');
            switch (stepNum) {

                //Finalizar       
                case "8":
                    //consistirApolice();
                    return true;

                default:
                    return true;
            }
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
                $('#step3').show();
                $('#step4').show();
                $('#step5').show();
                $('#step6').show();
                $('#step7').show();
                $('#step8').show();
                $('.buttonPrevious').show();
                $('.buttonNext').show();
                $('.buttonFinish').show();
                IncializarFormularios(model);
            }
            else {
                $('#step2').hide();
                $('#step3').hide();
                $('#step4').hide();
                $('#step5').hide();
                $('#step6').hide();
                $('#step7').hide();
                $('#step8').hide();
                $('.buttonPrevious').hide();
                $('.buttonNext').hide();
                $('.buttonFinish').hide();
            }
        }

        function FecharImg() {
            overlay.style.display = 'none';
            docView.style.display = 'none';
        }

        function Pesquisar() {
            document.getElementById('frmImagem').contentWindow.location.reload();
            overlay.style.display = 'block';
            docUpload.style.display = 'block';
        }

        function abrirImagem(id) {
            document.getElementById("imgDoc").src = "docExp.ashx?IdArquivo=" + id;

            $('btFechar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            overlay.style.display = 'block';
            docView.style.display = 'block';

        }

        function CarregarGridArquivos() {

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?arquivos=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#imagensGrid").flexAddData(formatResultsArq(result));

                }
            });
        }

        function formatResultsArq(arquivos) {
            var rows = Array();

            var str = "<div  style='text-align:right'>";

            for (i = 0; i < arquivos.length; i++) {
                var item = arquivos[i];
                rows.push({ cell: [i + 1, item.DS_DESCRICAO, item.DS_TIPO, '<a href=# onclick="abrirImagem(' + item.ID_ARQUIVO + ');">Abrir</a>', ''] });
            }
            return { total: arquivos.length, page: 1, rows: rows }
        }


    </script>

    <title></title>
</head>
<body>

    <style type="text/css">
        .swMain {
        width: 1150px;
        }

        .swMain .stepContainer div.content {
        width: 940px;
        }    
    </style>           

    <form id="form1" runat="server">

    <asp:HiddenField runat="server" ID="txtUsuario" />
    <asp:HiddenField runat="server" ID="txtPerfil" />
    <asp:HiddenField runat="server" ID="txtCodigoBoleto" />

    <div id="container" style="width:1200px">
        <div id="container_body" style="width:1200px">
         <div id="title">
            <h3>
                
    Sinistro

            </h3>
         </div>


<div id="wizard" class="swMain" >

    <input type="hidden" id="Model" />
    <ul class="anchor">
  	    <li><a href="#step-1" id="step1">
        <label class="stepNumber">1</label>
        <span class="stepDesc">
            Sinistro<br />
            <small>Dados do sinistro</small>
        </span>
	    </a>
        </li>

	    <li><a href="#step-2"  id="step2">
        <label class="stepNumber">2</label>
        <span class="stepDesc">
            Pessoas<br />
            <small>Dados Pessoas</small>
        </span>
	    </a>
	    </li>

	    <li><a href="#step-3"  id="step3">
        <label class="stepNumber">3</label>
        <span class="stepDesc">
            Documentos<br />
            <small>Dados Documentação</small>
        </span>
	    </a>
	    </li>

        <li><a href="#step-4"  id="step4">
        <label class="stepNumber">4</label>
        <span class="stepDesc">
            Reservas<br />
            <small>Reservas cadastradas</small>
        </span>
	    </a>
	    </li>

        <li><a href="#step-5"  id="step5">
        <label class="stepNumber">5</label>
        <span class="stepDesc">
            Judicial<br />
            <small>Dados Judiciais</small>
        </span>
	    </a>
	    </li>

        <li><a href="#step-6"  id="step6">
        <label class="stepNumber">6</label>
        <span class="stepDesc">
            Agenda<br />
            <small>Agenda de ações</small>
        </span>
	    </a>
	    </li>
        
        <li><a href="#step-7"  id="step7">
        <label class="stepNumber">7</label>
        <span class="stepDesc">
            Histórico<br />
            <small>Histórico do sinistro</small>
        </span>
	    </a>
	    </li>        

	    <li><a href="#step-8"  id="step8">
        <label class="stepNumber">8</label>
        <span class="stepDesc">
            Pagamentos<br />
            <small>Ordem de Pagamento</small>
        </span>
	    </a>
	    </li>

	    <li><a href="#step-9"  id="step9">
        <label class="stepNumber">9</label>
        <span class="stepDesc">
            Arrecadações<br />
            <small>Arrecadação de Fundos</small>
        </span>
	    </a>
	    </li>

    </ul>

    <div id="step-1">	    
        <div id="divSinistro">

    <asp:FormView ID="FormView1" runat="server" DataSourceID="dsSinistro">

        <ItemTemplate>

            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="lblIdSinistro" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label1" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label2" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label3" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label id="lblStatus" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label51" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="lblTpSinistro" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        <div class="clear"></div>

        <fieldset class="fieldset-wizard">
            <legend>Principal</legend>

            <div class="cell-wizard-margin" >
                <label>Estipulante</label>
            <asp:TextBox ID="TextBox5" runat="server" Width="380" ReadOnly="true"
                 Text='<%# Eval("ds_estipulante") %>' ></asp:TextBox>
            </div>

            <div class="cell-wizard-margin" >
                <label>Produto</label>
            <asp:TextBox ID="TextBox6" runat="server" class="w250 required" ReadOnly="true"
                 Text='<%# Eval("ds_produto") %>' ></asp:TextBox>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard-margin" >
                <label>Sucursal</label>
            <asp:TextBox ID="TextBox9" runat="server" class="w150 required" ReadOnly="true"
                 Text='<%# Eval("ds_sucursal") %>' ></asp:TextBox>
            </div>

            <div class="cell-wizard-margin" >
                <label>Grupo Ramo Susep</label>
            <asp:TextBox ID="TextBox10" runat="server" class="w200 required" ReadOnly="true"
                 Text='<%# Eval("ds_grupo_susep") %>' ></asp:TextBox>
            </div>

            <div class="cell-wizard-margin" >
                <label>Ramo Susep</label>
            <asp:TextBox ID="TextBox11" runat="server" class="w200 required" ReadOnly="true"
                 Text='<%# Eval("ds_ramo_susep") %>' ></asp:TextBox>
            </div>

    <!--fieldset class="cell-wizard-margin">
        <legend></legend-->

        <div class="cell-wizard-margin" >
            <label>Nº de Sinistro AON</label>
        <asp:TextBox ID="TextBox14" runat="server" class="w100 required"  ReadOnly="true"
                Text='<%# Eval("nr_sinistro_aon") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Data Ocorrência</label>
        <asp:TextBox ID="TextBox15" runat="server" class="w50 required"  ReadOnly="true"
                Text='<%# Eval("dt_ocorrencia") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Data Aviso</label>
        <asp:TextBox ID="TextBox16" runat="server" width="52" ReadOnly="true"
                Text='<%# Eval("dt_aviso") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Cobertura</label>
        <asp:TextBox ID="TextBox17" runat="server" class="w200 required"  ReadOnly="true"
                Text='<%# Eval("cd_cober") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Causa</label>
        <asp:TextBox ID="TextBox18" runat="server" class="w200 required"  ReadOnly="true"
                Text='<%# Eval("id_causa") %>' ></asp:TextBox>
        </div>
    <!--/fieldset-->
            <div class="clear"></div>

        <div class="clear"></div>

    </fieldset>

            <div class="clear"></div>

            <fieldset class="fieldset-wizard">
                <legend>Dados Apólice</legend>


                <div class="cell-wizard-margin" >
                <label>Nº Apolice Ofi.</label>
            <asp:TextBox ID="TextBox13" runat="server" class="w100 required"  ReadOnly="true"
                 Text='<%# Eval("nr_apoli_ofic") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Data Início</label>
            <asp:TextBox ID="TextBox19" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_ini_vig") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Data Término</label>
            <asp:TextBox ID="TextBox20" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_fim_vig") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Nº Endosso Ofi.</label>
            <asp:TextBox ID="TextBox22" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("nr_endos_ofic") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Início Vigência</label>
            <asp:TextBox ID="TextBox23" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_ini_vig_e") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Fim Vigência</label>
            <asp:TextBox ID="TextBox24" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_fim_vig_e") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Importância Segurada</label>
            <asp:TextBox ID="TextBox25" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("vl_impor_segda") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                    <label>Prêmio</label>
                    <asp:TextBox ID="TextBox26" runat="server" class="w50 required"  ReadOnly="true" Text='<%# Eval("vl_premio_tarifa") %>' ></asp:TextBox>
                </div>

                <div class="clear"></div>

            </fieldset>

            <div class="clear"></div>
            <!--fieldset class="fieldset-wizard">
                <legend></legend>

                <div class="cell-wizard-margin" >
                    <label>Regulador</label>
                <asp:TextBox ID="TextBox27" runat="server" class="w300 required"  ReadOnly="true"
                        Text='<%# Eval("ds_usuario") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Data Cadastro</label>
                <asp:TextBox ID="TextBox28" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("dt_aviso") %>' ></asp:TextBox>
                </div>
                <div class="clear"></div>
            </fieldset-->
            
        </ItemTemplate>

    </asp:FormView>


    <fieldset class="fieldset-wizard">
        <legend>Plano Cessão</legend>

        <asp:GridView ID="gvCessao" runat="server" DataSourceID="dsCessao" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
            <Columns>
                <asp:BoundField DataField="ds_tipo_pess" HeaderText="Tipo Participação" />
                <asp:BoundField DataField="ds_descricao" HeaderText="Tipo Operação"  />
                <asp:BoundField DataField="ds_parti" HeaderText="Seguradora" />
                <asp:BoundField DataField="pc_participacao" HeaderText="%"  />
                <asp:TemplateField HeaderText="">
                    <ItemTemplate >
                        <a id="popup" onclick='AlterarCessao(<%# Eval("id_cesion") %>);' > Alterar Percentual </a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsCessao" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select   tipo.ds_tipo_pess,
                                    oper.ds_descricao,
                                    par.ds_parti,
                                    ces.pc_participacao,
                                    ces.id_cesion
                                from   STO_CESION ces
                        inner join   TB_DOM_TPPES tipo on tipo.cd_tipo_pess = ces.tp_parti
                        inner join   CTB_TPOPERACAO oper on oper.id_operacao = ces.id_operacao
                    left outer join   TB_CAD_PTCCE par on par.cd_parti in (ces.id_cossegurador, ces.id_ressegurador) 
                            where   ces.id_sinistro = :idSinistro">
        </asp:SqlDataSource>
        <div class="clear"></div>
        <div class="clear"></div>
    </fieldset>


    <!--fieldset class="fieldset-wizard">
    <legend>Status de Autorização</legend>
    <div class="cell-wizard-margin">      
        <label></label>   
        <div class="clear"></div>
    </div>


<asp:GridView ID="GridView2" runat="server" DataSourceID="dsAutorizacao" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="autor" HeaderText="Tipo" />
                        <asp:BoundField DataField="status_autor" HeaderText="Status"  />
                        <asp:BoundField DataField="dt_criacao" HeaderText="Data" />
                        <asp:BoundField DataField="ds_usuario" HeaderText="Usuário"  />
                    </Columns>
            </asp:GridView>

        <asp:SqlDataSource ID="dsAutorizacao" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select case when tpst.fl_status_autorizacion_stro = '1' then 'ADMINISTRATIVA'
            when tpst.fl_status_autorizacion_Liq = '1' then 'LIQUIDAÇAO' end autor,
       case when st.tp_status in (k.STATUS_SINISTRO_ACEITO, k.STATUS_OP_PENDENTE) then 'APROVADO'
            when st.tp_status = k.STATUS_SINISTRO_REJEITADO then 'REJEITO'
            when st.tp_status = k.STATUS_FECHADO_SEM_INDENIZACAO then 'FECHADO_SEM_INDENIZAÇAO'
            when st.tp_status = k.STATUS_SINISTRO_PAGTO then 'PAGTO'
            else 'PENDENTE' end status_autor,
            to_char(st.dt_criacao,'dd/mm/yyyy') dt_criacao,
            u.ds_usuario
  from sto_status st 
 inner join sto_tpstatus tpst
    on tpst.id_tpstatus =  st.tp_status
  left outer join adm_usuario u 
    on u.id_usuario = st.id_usuario
 where st.id_status in (select max(st1.id_status)
                          from sto_status st1
                         inner join sto_tpstatus tpst1
                            on tpst1.id_tpstatus =  st1.tp_status
                         where st1.id_sinistro = :idSinistro
                      group by tpst1.fl_status_autorizacion_stro, 
                               tpst1.fl_status_autorizacion_liq)
 order by st.id_status
"></asp:SqlDataSource>

</fieldset-->

    <asp:SqlDataSource ID="dsSinistro" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select nvl(str.nr_sinistro,0) nr_sinistro,
       str.id_sinistro,
       nvl(ase.cpf, ( select max(d.nr_docto)
                              from crp_docto d
                             where p.id_pessoa = d.id_pessoa and d.tp_docto in ('CPF','CNPJ') )) cpf,
       nvl(nvl(ase.ds_cliente,( select p.ds_pessoa
                              from crp_pessoa p
                             where p.id_pessoa = ase.id_pessoa )), p.ds_pessoa) ds_cliente,
       nvl(est.ds_estipulante, ( select cp.ds_progr
                              from tb_cad_progr cp
                             where cp.cd_progr = apo.cd_progr )) ds_estipulante,
       (select suc.ds_sucursal from crs_sucursal suc where suc.cd_sucursal = apo.cd_sucursal) ds_sucursal,
       (select gra.ds_grupo_susep from tb_cad_grpsu gra where gra.cd_grupo_susep = apo.cd_grupo_emis) ds_grupo_susep,
       (select ram.ds_ramo_susep from tb_cad_rmosu ram where ram.cd_grupo_susep = apo.cd_grupo_emis and ram.cd_ramo_susep = apo.cd_ramo_emis) ds_ramo_susep,
       --nvl(pa_sinistros.fnEstadoSiniestro(str.id_sinistro),k.STATUS_PREAVISO) status,
       --tps.ds_status status,
       upper((select r.tpmoid from vreserva_status r where r.id_sinistro = str.id_sinistro and rownum = 1)) status,
       str.id_segurado,
       --str.tp_sinistro,
       tp.ds_tpsinistro tp_sinistro,
       ase.cd_cliente_etp,
       str.id_seguro,
       str.id_sinistro_ref,
       seg.vl_capital_segurado,
       (select pdt.ds_produto from tb_cad_prodt pdt where pdt.id_prod_unif = apo.id_prod_unif) ds_produto,
       est.cd_estipulante,
       to_char(str.dt_ocorrencia,'dd/mm/yy') dt_ocorrencia,
       to_char(str.dt_aviso,'dd/mm/yy') dt_aviso,
       str.nr_sinistro_aon,
       (select t.ds_cober from TB_CAD_COBSU t where t.cd_cober = str.cd_cober) cd_cober,
       (select t.ds_causa from STO_TPCAUSA t where t.id_causa = str.id_causa) id_causa,
       nvl(apo.nr_apoli_ofic, apo.nr_idtfc_neg) nr_apoli_ofic,
       to_char(apo.dt_ini_vig,'dd/mm/yy') dt_ini_vig,
       to_char(apo.dt_fim_vig,'dd/mm/yy') dt_fim_vig,
       en.nr_endos_ofic,
       to_char(en.dt_ini_vig,'dd/mm/yy') dt_ini_vig_e,
       to_char(en.dt_fim_vig,'dd/mm/yy') dt_fim_vig_e,
       en.vl_impor_segda,
       en.vl_premio_tarifa,
       u.id_usuario,
       u.ds_usuario,
       cpl.nr_rg,
       to_char(cpl.dt_nascto,'dd/mm/yy') dt_nascto,
       cpl.ds_endereco,
       cpl.ds_bairro,
       cpl.cd_uf,
       cpl.ds_cidade,

       j.nm_processo,
       j.tp_andamento,
       j.TP_MOTIVO_ACAO,
       j.DS_REU, 
       j.DS_OBJETO, 
       j.ID_ADVOGADO_RESPONSAVEL, 
       j.DS_ADVOGADO_PARTE_CONTRARIA, 
       to_char(j.DT_CADASTRO,'dd/mm/yyyy') DT_CADASTRO, 
       j.DT_DISTRIB_ACAO,
       j.VL_CAUSA, 
       j.VL_RISCO, 
       j.TP_RISCO, 
       j.TP_ANDAMENTO, 
       j.TP_ENCERRAMENTO,
       j.DS_AUTOR, 
       j.DS_COMARCA_UF, 
       j.DS_COMARCA_CIDADE, 
       j.DS_VARA, 
       j.TP_RITO, 
       j.DS_MOTIVO_ACAO, 
       j.TP_CAUSA_RAIZ,

       to_char(j.dt_citacao,'dd/mm/yyyy') dt_citacao,
       to_char(j.dt_distrib_acao,'dd/mm/yyyy') dt_distrib_acao,
       to_char(j.dt_defesa,'dd/mm/yyyy') dt_defesa,
       j.id_escritorio,
       j.vl_capital_segurado,
       j.ds_autor,

       (select e.ds_evento 
                    from sma_tarefa t, exc_evento e
                    where t.cd_evento = e.cd_evento
                    and t.id_sinistro = str.id_sinistro
                    and t.id_tarefa = (select max(t2.id_tarefa) from sma_tarefa t2 where t2.id_sinistro = str.id_sinistro)) ds_sub_status
                 
       
  from sma_sinistro str
 left outer join sma_segurado ase
    on ase.id_segurado = str.id_segurado
 left outer join sto_tpsinistro tp
    on tp.id_tpsinistro = str.tp_sinistro
 left outer join sma_seguro seg
    on seg.id_seguro = str.id_seguro
 left outer join sma_produto prd
    on prd.id_produto = seg.id_produto
 left outer join sma_estipulante est
    on est.cd_estipulante = prd.cd_estipulante
 left outer join tb_emi_apoli apo
    on apo.id_apolice = str.id_apolice
 left outer join tb_emi_endos en
    on str.id_endosso = en.id_endosso
 left outer join crp_pessoa p
    on en.id_pessoa = p.id_pessoa
 left outer join crp_docto d
    on en.id_pessoa = d.id_pessoa
 left outer join adm_usuario u
    on u.id_usuario = str.id_usuario
 left outer join sma_segurado_cpl cpl
    on ase.id_segurado_compl = cpl.id_segurado_compl
 left outer join sto_judicial j
    on j.id_sinistro = str.id_sinistro
 where str.id_sinistro = :idSinistro">
</asp:SqlDataSource>


        </div>
    </div>

    <div id="step-2">	    
        <div id="divPessoas">


    <asp:FormView ID="FormView5" runat="server" DataSourceID="dsSinistro" Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label1" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label2" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label3" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label4" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label5" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label51" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>


            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label6" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <asp:FormView ID="FormView2" runat="server" DataSourceID="dsSinistro">
        <ItemTemplate>

            <fieldset class="fieldset-wizard">

                <div class="cell-wizard-margin" >
                    <label>Código Cliente</label>
                <asp:TextBox ID="TextBox2" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("id_segurado") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Nome</label>
                <asp:TextBox ID="TextBox12" runat="server" class="w300 required"  ReadOnly="true"
                        Text='<%# Eval("ds_cliente") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>CPF</label>
                <asp:TextBox ID="TextBox21" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("cpf") %>' ></asp:TextBox>
                </div>
 
                <div class="cell-wizard-margin" >
                    <label>RG</label>
                <asp:TextBox ID="TextBox29" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("nr_rg") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Nascimento</label>
                <asp:TextBox ID="TextBox30" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("dt_nascto") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Endereco</label>
                <asp:TextBox ID="TextBox31" runat="server" class="w300 required"  ReadOnly="true"
                        Text='<%# Eval("ds_endereco") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Bairro</label>
                <asp:TextBox ID="TextBox32" runat="server" width="230" ReadOnly="true"
                        Text='<%# Eval("ds_bairro") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Cidade</label>
                <asp:TextBox ID="TextBox34" runat="server" width="430" ReadOnly="true"
                        Text='<%# Eval("ds_cidade") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>UF</label>
                <asp:TextBox ID="TextBox33" runat="server" class="w50 required"  ReadOnly="true"
                        Text='<%# Eval("cd_uf") %>' ></asp:TextBox>
                </div>

            </fieldset>
        </ItemTemplate>
    </asp:FormView>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
        <legend>Beneficiários</legend>


            <asp:GridView ID="GridView3" runat="server" DataSourceID="dsBeneficiarios" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="ds_pessoa" HeaderText="Nome" />
                        <asp:BoundField DataField="tp_parentesco" HeaderText="Parentesco"  />
                        <asp:BoundField DataField="vl_participacao" HeaderText="Participacao" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsBeneficiarios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select pes.ds_pessoa,
       nvl(sb.tp_parentesco,99) tp_parentesco,
       sb.vl_participacao,
       sb.id_beneficiario
  from sto_beneficiario sb
 inner join crp_pessoa pes
    on pes.id_pessoa = sb.id_pessoa
  left outer join sys_tppessoa tps
    on tps.cd_tp_pessoa = pes.tp_pessoa
  left outer join crp_conta cb
    on cb.id_conta = sb.id_conta
  left outer join crp_docto doc
    on doc.id_docto = sb.id_docto
 where sb.id_sinistro = :idSinistro
"></asp:SqlDataSource>

    </fieldset>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard" style="display:none">
    <legend>Beneficiários</legend>

            <asp:GridView ID="GridView4" runat="server" DataSourceID="dsSinistro" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_sinistro" HeaderText="Tipo" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Status"  />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Data" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Usuário"  />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard" style="display:none">
    <legend>Beneficiários</legend>

            <asp:GridView ID="GridView5" runat="server" DataSourceID="dsSinistro" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_sinistro" HeaderText="Tipo" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Status"  />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Data" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Usuário"  />
                    </Columns>
            </asp:GridView>

    </fieldset>

        <div class="clear"></div>

        </div>
    </div>

    <div id="step-3">	    
        <div id="divDocumentacao">

    <asp:FormView ID="FormView6" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label7" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label8" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label9" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label10" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label11" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label51" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label12" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

            <div id="ScanWrapper" style="padding-left:8px">

                <div style="float:left">
                <label for="source">Selecionar o Equipamento:</label>
                <select size="1" id="source" style="width: 220px;" onchange="source_onchange()">
                    <option value = ""></option>    
                </select>
                <input id="btnScan" disabled="disabled" type="button" value="Scan" onclick ="acquireImage();"/>
                <strong> ou </strong> 
                <input id="btnCarregar" type="button" value="Carregar Arquivo" onclick="return Pesquisar()" />
                </div>


                <div style="float:left">
            <label for="source">Documentos:</label>
            <select size="1" id="Select1" style="width: 220px;" onchange="source_onchange()">
                <option value=""></option>
                <option value="">Carta de Citação</option>
                <option value="">Petição Inicial</option>
                <option value="">Contestação</option>
                <option value="">Recurso</option>
                <option value="">Sentença</option>
                <option value="">Acórdão</option>
                <option value="">Email de Contratação</option>
                <option value="">Confirmação de Contratação</option>
                <option value="">Subsídios</option>
                <option value="">Cálculo de Condenação</option>
                <option value="">Outros</option>
            </select>
                </div>

                <div id="imagensGrid" ><table id="Table1"> </table>
                </div>

        </div>

    <div class="clear"></div>

    <!--fieldset class="fieldset-wizard">

        <asp:GridView ID="GridView6" runat="server" DataSourceID="dsDocumentos" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                <Columns>
                    <asp:BoundField DataField="ds_resumo" HeaderText="Documento" />
                    <asp:BoundField DataField="recebido" HeaderText="Recebido"  />
                    <asp:BoundField DataField="solicita" HeaderText="Solicitação" />
                    <asp:BoundField DataField="dt_solicitacao" HeaderText="Data Solicitação" />
                    <asp:BoundField DataField="dt_resposta" HeaderText="Data Resposta" />
                    <asp:BoundField DataField="nm_pedidos" HeaderText="Pedidos" />
                </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsDocumentos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_number(doc.cd_documento), 
    doc.ds_resumo,
    nvl(pen.fl_recebido, 0) recebido,
    nvl(pen.fl_solicita, 0) solicita,
    to_char(pen.dt_solicitacao,'dd/mm/yyyy') dt_solicitacao,
    to_char(pen.dt_resposta,'dd/mm/yyyy') dt_resposta,
    nvl(pen.nm_pedidos, 0) nm_pedidos,
    pen.id_pendencia,
    null
from sma_sinistro str
inner join sma_seguro seg
on seg.id_seguro = str.id_seguro
left outer join sma_campanha_docto cad
on seg.id_campanha = cad.id_campanha
left outer join sma_documento doc
on doc.cd_documento = cad.cd_documento
left outer join sma_pendencia pen
on pen.id_sinistro = str.id_sinistro
and pen.cd_documento = doc.cd_documento
where str.id_sinistro = :idSinistro
group by doc.cd_documento, 
        doc.ds_resumo,
        pen.fl_recebido,
        pen.fl_solicita,
        pen.dt_solicitacao,
        pen.dt_resposta,
        pen.nm_pedidos,
        pen.id_pendencia,
        pen.rowid
order by 1
"></asp:SqlDataSource>

        <div class="clear"></div>

        <asp:FormView ID="FormViewXX" runat="server" DataSourceID="dsMotivoRejeicao">
            <ItemTemplate>

                    <div class="cell-wizard-margin" >
                        <label>Data Recusado</label>
                    <asp:TextBox ID="TextBox2" runat="server" class="w100 required"  ReadOnly="true"
                            Text='<%# Eval("dt_recusado") %>' ></asp:TextBox>
                    </div>

                    <div class="cell-wizard-margin" >
                        <label>Motivo</label>
                    <asp:TextBox ID="TextBox12" runat="server" class="w600 required" Height="80" TextMode="MultiLine" Rows="5" ReadOnly="true"
                            Text='<%# Eval("ds_motivo_rejeicao") %>' ></asp:TextBox>
                    </div>

            </ItemTemplate>
        </asp:FormView>

        <asp:SqlDataSource ID="dsMotivoRejeicao" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select s.fl_status, 
    s.ds_motivo_rejeicao,
    s.fl_documentos_recebidos,
    to_char(st.dt_criacao,'dd/mm/yyyy') dt_recusado
from sma_sinistro s 
inner join sto_status st
on st.id_sinistro = s.id_sinistro
and st.tp_status = k.STATUS_SINISTRO_REJEITADO
where s.id_sinistro = :idSinistro
"></asp:SqlDataSource>

    </fieldset-->

    </div>
    </div>

    <div id="step-4">	    
        <div id="divReserva">

    <asp:FormView ID="FormView7" runat="server" DataSourceID="dsSinistro" Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label13" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label14" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label15" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label16" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label17" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label51" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label18" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <div class="clear"></div>

    <div class="button-bar-inline-right" id="barraBotoes">
        <button type="button" id="btnAjusteManual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Ajuste/Aviso</button>
        <button type="button" id="btnGravarLiquidacao" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Liquidação</button>
        <!--button type="button" id="btnNovaOP" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Nova OP</button-->
        <button type="button" id="btnFecharSinistro" class="ui-button ui-widget ui-state-default-red ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Encerrar Sinistro</button>
        <!--button type="button" id="btnReabrirSinistro" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Reabrir</button-->
    </div>

    <div class="clear"></div>


    <fieldset class="fieldset-wizard">
    <legend>Liquidações</legend>

            <asp:GridView ID="GridView10" runat="server" DataSourceID="dsLiquidacoes" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_liquidacao" HeaderText="Liquidação" />
                        <asp:BoundField DataField="id_op" HeaderText="OP" />
                        <asp:BoundField DataField="fl_status" HeaderText="Autorizado" />
                        <asp:BoundField DataField="vl_valor" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Valor" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsLiquidacoes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select t.id_liquidacao,
       nvl(t.tp_moeda,0) tp_moeda,
       nvl(vl_valor,0) + nvl(vl_valor_coss,0)+ nvl(vl_valor_ress,0) vl_valor,
       nvl(pa_sinistros.fnCadenaOP(t.id_liquidacao),'Pendente') id_op,
       case when t.fl_status = 'A' then 'SIM' else 'NÃO' end fl_status
  from sto_liquidacao t
 where t.id_sinistro = :idSinistro
   and t.fl_valido = '1' 
 order by t.id_liquidacao"></asp:SqlDataSource>

    </fieldset>

    <div class="clear"></div>


    <fieldset class="fieldset-wizard">
    <legend>Reserva disponível</legend>

            <asp:GridView ID="GridView8" runat="server" DataSourceID="dsReservaPendente" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="ds_descricao" HeaderText="Tipo" />
                        <asp:BoundField DataField="vl_total" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Valor"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                    </Columns>
            </asp:GridView>
    </fieldset>

    <div class="clear"></div>

    <asp:SqlDataSource ID="dsReservaPendente" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        SelectCommand="select t.ds_descricao, t.vl_total from ctb_vtotalreservaspendente 
                       t where t.id_sinistro = :idSinistro and t.vl_total <> 0">
    </asp:SqlDataSource>

    <fieldset class="fieldset-wizard">
    <legend>Movimento Reserva Indenização</legend>

            <asp:GridView ID="GridView9" runat="server" DataSourceID="dsReservaMovimento" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="data" DataFormatString="{0:f}" HeaderText="Data" />
                        <asp:BoundField DataField="TPMOID" HeaderText="Tipo Movimento"  />
                        <asp:BoundField DataField="vl_reserva" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Valor"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <asp:SqlDataSource ID="dsReservaMovimento" runat="server" ConnectionString="<%$ ConnectionStrings:DB1 %>" ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
                       SelectCommand="select tpmoid fl_evento, to_char(r.dt_cadastro, 'dd/MM/yyyy') data, r.* 
                                        from VRESERVA_STATUS r
                                       inner join ctb_tpvalor tpv on tpv.id_valor = r.tp_valor
                                       where r.id_sinistro = :idSinistro
                                       order by r.dt_cadastro, r.id_reserva asc">
    </asp:SqlDataSource>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
    <legend>Movimento Honorários/Despesas/Outros</legend>

            <asp:GridView ID="GridView60" runat="server" DataSourceID="dsReservaHonDesp" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="dt_cadastro" HeaderText="Data" />
                        <asp:BoundField DataField="ds_descricao" HeaderText="Tipo Reserva"  />
                        <asp:BoundField DataField="fl_evento" HeaderText="Tipo Evento" />
                        <asp:BoundField DataField="vl_reserva_somatorio" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Reserva Total"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <asp:SqlDataSource ID="dsReservaHonDesp" runat="server" ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select to_char(r.dt_cadastro,'dd/mm/yyyy') dt_cadastro,
       tpv.ds_descricao,
       case when r.fl_evento = 'A' then 'AVISO'
            when r.fl_evento = 'J' then 'AJUSTE' || (select ' - ' || t.ds_cm from sto_cm c, sto_tpcm t where c.tp_cm = t.tp_cm and c.id_cm = r.id_cm)
            when r.fl_evento = 'P' then 'PAGTO'
            when r.fl_evento = 'CM' then 'CORREÇAO MONETÁRIA' end fl_evento,
            nvl(r.vl_reserva,0) + nvl(r.vl_cosseguro,0) + nvl(r.vl_resseguro,0) vl_reserva_somatorio,
       r.id_op
  from sto_reserva r 
 inner join ctb_tpvalor tpv
    on tpv.id_valor = r.tp_valor
 where r.id_sinistro = :idSinistro and nvl(r.vl_reserva,0) + nvl(r.vl_cosseguro,0) + nvl(r.vl_resseguro,0) <> 0
   and r.tp_valor <> 1
 order by r.dt_cadastro">
    </asp:SqlDataSource>

    <div class="clear"></div>

        </div>
    </div>

    <div id="step-5">	    
        <div id="divJudicial">

    <asp:FormView ID="FormView8" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label19" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label20" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label21" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label22" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label23" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label51" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label24" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <div class="clear"></div>

    <div class="judicial" id="divDadosJudicial" >
        <!--style>
            /*@import "css/styleJudicial.css";
            @import "css/css1.css";
    .judicial label{font-family:Oswald;font-weight:normal;font-style:normal;font-size:12px;color:Teal;}
.judicial textarea,
.judicial input[type="texto"],
.judicial input[type="email"],
.judicial input[type="password"] {
	width:95%;
	padding:5px;
	border:1px solid #ccc;
    border-color: #000;
    XXfont-size:small;    
    font-family:Oswald;
    box-sizing: content-box;

    line-height: normal;
  font-size: 100%;
  margin: 0;
  vertical-align: baseline;
  -webkit-font-smoothing: antialiased;
  }
    .judicial select { 
	width:100%;
	padding:3px;
	border:1px solid #ccc;
    border-color: #000;
    height:36px;
    XXfont-size:small;
    font-family:Oswald;
  font-size: 100%;
  margin: 0;
  vertical-align: baseline;
  max-width: 100%;

-webkit-font-smoothing: antialiased;
}
	input:focus {
		outline:0;
		box-shadow:3px 3px 0 #000;
	}
    
    .judicial legend 
    {
        font-family:Oswald;
        font-size:12px;
        font-style:normal;
        font-weight:normal;
    }
            
        </style-->

                    <fieldset class="fieldset-wizard"  style="width: 250px; float:left">
                                <legend>PROCESSO</legend>

                <div>

                    <asp:FormView ID="FormView3" runat="server" DataSourceID="dsSinistro"  Width="100%">
                        <ItemTemplate>

                            <label for="source">Rito</label>
                            <select id="cboRito" class="novoSelect" onchange="cboRitoChange();" style="width:243px; height:21px; margin-top:0" >
                                <option value="1" <%# ProcessarItemCombo(Eval("TP_RITO"), 1) %> >Conciliação</option>
                                <option value="2" <%# ProcessarItemCombo(Eval("TP_RITO"), 2) %> >JEC</option>
                                <option value="3" <%# ProcessarItemCombo(Eval("TP_RITO"), 3) %> >Ordinário</option>
                                <option value="4" <%# ProcessarItemCombo(Eval("TP_RITO"), 4) %> >Sumário</option>
                                <option value="5" <%# ProcessarItemCombo(Eval("TP_RITO"), 5) %> >Vara Cível</option>
                            </select>
    <p></p>
                            <label>Nr Processo</label>
                            <input id="txtProcesso" type="texto" value='<%# Eval("nm_processo") %>' style="width:238px" /> 
    <p></p>
                            <label>Motivo da Ação</label>
                            <input id="txtMotivoAcao" type="texto" value='<%# Eval("DS_MOTIVO_ACAO") %>' style="width:238px" />

    <p></p>

                            <label>Réu </label>
                            <input id="txtReu" type="texto" value='<%# Eval("DS_REU") %>' style="width:238px" />
    <p></p>

                            <label>Objeto </label>
                            <input id="txtObjeto" type="texto" value='<%# Eval("DS_OBJETO") %>' style="width:238px" />
    <p></p>

                            <label for="source">Advogado Responsável</label>
                            <select class="novoSelect" id="cboAdvogadoResponsavel" style="width:243px; height:21px; margin-top:0" >
                                <option value="1" <%# ProcessarItemCombo(Eval("ID_ADVOGADO_RESPONSAVEL"), 1) %> >Luciano Henrique Tomczinski Novellini</option>
                                <option value="2" <%# ProcessarItemCombo(Eval("ID_ADVOGADO_RESPONSAVEL"), 2) %> >Rodrigo Alexandre Cerqueira Augusto</option>
                            </select>
    <p></p>

                            <label>Advogado da Parte Contrária </label>
                            <input id="txtAdvogadoParteContraria" type="texto" value='<%# Eval("DS_ADVOGADO_PARTE_CONTRARIA") %>' style="width:238px" />
                        </ItemTemplate>
                    </asp:FormView>
                
                </div>

                    </fieldset>

                    <fieldset class="fieldset-wizard"  style="width: 330px; float:left;">
                        <legend >ANDAMENTO</legend>
                        <div>

                    <asp:FormView ID="FormView4" runat="server" DataSourceID="dsSinistro"  Width="100%">
                        <ItemTemplate>

                            <table>
                                <tr>
                                    <td>
                                    <label>Data Citação</label>
                                    <input id="txtDataCitacao" type="texto"  value='<%# Eval("DT_CITACAO") %>' style="width:90px" />
                                    </td>
                                    <td>
                                    <label>Data de Cadastro</label>
                                    <input id="txtDataCadastro" type="texto" value='<%# Eval("DT_CADASTRO") %>' disabled style="width:90px" />
                                    </td>
                                    <td>
                                    <label>Data Defesa</label>
                                    <input id="txtDataDefesa" type="texto" value='<%# Eval("DT_DEFESA") %>' style="width:105px" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>
    <p></p>
                                        <label>Valor da Causa </label>
                                        <input id="txtValorDaCausa" type="texto"  value='<%# Eval("VL_CAUSA") %>' style="width:90px" />
                                    </td>
                                    <td>
    <p></p>
                                        <label>Valor do Risco </label>
                                        <input id="txtValorDoRisco" type="texto"  value='<%# Eval("VL_RISCO") %>'  style="width:90px">
                                    </td>
                                    <td>
    <p></p>
                                        <label>Probabilidade</label>
                                        <select id="cboProbabilidade" class="novoSelect" style="width:111px; height:21px; margin-top:0">
                                            <option value="1" <%# ProcessarItemCombo(Eval("TP_RISCO"), 1) %> >Remoto 10%</option>
                                            <option value="2" <%# ProcessarItemCombo(Eval("TP_RISCO"), 2) %> >Possivel 60%</option>
                                            <option value="3" <%# ProcessarItemCombo(Eval("TP_RISCO"), 3) %> >Provavel 110%</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>

    <p></p>
                                <label for="source">Fase</label>
                                <select id="cboFase" class="novoSelect" style="width:310px; height:21px; margin-top:0">
                                    <option value="1" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 1) %>" >Instrução</option>
                                    <option value="2" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 2) %> >Primeira Instância - Improcedente</option>
                                    <option value="3" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 3) %> >Primeira Instância - Procedente</option>
                                    <option value="4" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 4) %> >Primeira Instância - Sem Resolução do Mérito</option>
                                    <option value="5" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 5) %> >Segunda Instância - Improcedente</option>
                                    <option value="6" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 6) %> >Segunda Instância - Procedente</option>
                                    <option value="7" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 7) %> >Terceira Instância - Improcedente</option>
                                    <option value="8" <%# ProcessarItemCombo(Eval("TP_ANDAMENTO"), 8) %> >Terceira Instância - Procedente</option>
                                </select>
    <p></p>

                                <label >Motivo do Encerramento</label>
                                <select id="cboMotivoEncerramento" class="novoSelect" style="width:310px; height:21px; margin-top:0">
                                    <option value="1" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 1) %> >Improcedência Primeira Instância</option>
                                    <option value="2" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 2) %> >Encerrado sem Resolução do Mérito</option>
                                    <option value="3" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 3) %> >Improcedência Segunda Instância</option>
                                    <option value="4" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 4) %> >Procedência Segunda Instância</option>
                                    <option value="5" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 5) %> >Improcedência Terceira Instância</option>
                                    <option value="6" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 6) %> >Procedência Terceira Instância</option>
                                    <option value="7" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 7) %> >Pagamento de Condenação</option>
                                    <option value="8" <%# ProcessarItemCombo(Eval("TP_ENCERRAMENTO"), 8) %> >Pagamento de Acordo</option>
                                </select>
    <p></p>

                                <label>Autor</label>
                                <textarea id="txtAutor" cols="45" rows="10" style="height:108px; width:305px; margin-top:0" > <%# Eval("DS_AUTOR")%> </textarea> 

                        </ItemTemplate>
                    </asp:FormView>

                        </div>
                    </fieldset>

                    <fieldset class="fieldset-wizard"  style="width: 250px; float:left;">
                                <legend >OUTROS</legend>
                                <div>

                    <asp:FormView ID="FormView13" runat="server" DataSourceID="dsSinistro"  Width="100%">
                        <ItemTemplate>

                                    <label for="source">Comarca</label>
                                    <select id="comarcaUF" class="novoSelect" style="width:243px; height:21px; margin-top:0">
                                        <option value="">GO</option>
                                        <option value="">SP</option>
                                        <option value="">...</option>
                                    </select>
                                    <label id="lblComarcaUF" style="display:none;font-weight:bold;font-size:12px"><%# Eval("DS_COMARCA_UF")%></label> 
    <p></p>

                                    <label for="source">Cidade</label>
                                <select id="comarcaCidade" class="novoSelect" style="width:243px; height:21px; margin-top:0">
                                    <option value="">...</option>
                                </select>
                                    <label id="lblComarcaCidade" style="display:none;font-weight:bold;font-size:12px"><%# Eval("DS_COMARCA_CIDADE")%></label> 
    <p></p>

                                <label for="source">Vara</label>
                                <select id="cboVara" class="novoSelect" style="width:243px; height:21px; margin-top:0">
                                    <option value="0" <%# ProcessarItemCombo(Eval("DS_VARA"), 0) %> >Única</option>
                                    <option value="1" <%# ProcessarItemCombo(Eval("DS_VARA"), 1) %> >1</option>
                                    <option value="2" <%# ProcessarItemCombo(Eval("DS_VARA"), 2) %> >2</option>
                                    <option value="3" <%# ProcessarItemCombo(Eval("DS_VARA"), 3) %> >3</option>
                                    <option value="4" <%# ProcessarItemCombo(Eval("DS_VARA"), 4) %> >4</option>
                                    <option value="5" <%# ProcessarItemCombo(Eval("DS_VARA"), 5) %> >5</option>
                                    <option value="6" <%# ProcessarItemCombo(Eval("DS_VARA"), 6) %> >6</option>
                                    <option value="7" <%# ProcessarItemCombo(Eval("DS_VARA"), 7) %> >7</option>
                                    <option value="8" <%# ProcessarItemCombo(Eval("DS_VARA"), 8) %> >8</option>
                                    <option value="9" <%# ProcessarItemCombo(Eval("DS_VARA"), 9) %> >9</option>
                                    <option value="10" <%# ProcessarItemCombo(Eval("DS_VARA"), 10) %> >10</option>
                                    <option value="11" <%# ProcessarItemCombo(Eval("DS_VARA"), 11) %> >11</option>
                                    <option value="12" <%# ProcessarItemCombo(Eval("DS_VARA"), 12) %> >12</option>
                                    <option value="13" <%# ProcessarItemCombo(Eval("DS_VARA"), 13) %> >13</option>
                                    <option value="14" <%# ProcessarItemCombo(Eval("DS_VARA"), 14) %> >14</option>
                                    <option value="15" <%# ProcessarItemCombo(Eval("DS_VARA"), 15) %> >15</option>
                                    <option value="16" <%# ProcessarItemCombo(Eval("DS_VARA"), 16) %> >16</option>
                                    <option value="17" <%# ProcessarItemCombo(Eval("DS_VARA"), 17) %> >17</option>
                                    <option value="18" <%# ProcessarItemCombo(Eval("DS_VARA"), 18) %> >18</option>
                                    <option value="19" <%# ProcessarItemCombo(Eval("DS_VARA"), 19) %> >19</option>
                                    <option value="20" <%# ProcessarItemCombo(Eval("DS_VARA"), 20) %> >20</option>
                                    <option value="21" <%# ProcessarItemCombo(Eval("DS_VARA"), 21) %> >21</option>
                                    <option value="22" <%# ProcessarItemCombo(Eval("DS_VARA"), 22) %> >22</option>
                                    <option value="23" <%# ProcessarItemCombo(Eval("DS_VARA"), 23) %> >23</option>
                                    <option value="24" <%# ProcessarItemCombo(Eval("DS_VARA"), 24) %> >24</option>
                                    <option value="25" <%# ProcessarItemCombo(Eval("DS_VARA"), 25) %> >25</option>
                                    <option value="26" <%# ProcessarItemCombo(Eval("DS_VARA"), 26) %> >26</option>
                                    <option value="27" <%# ProcessarItemCombo(Eval("DS_VARA"), 27) %> >27</option>
                                    <option value="28" <%# ProcessarItemCombo(Eval("DS_VARA"), 28) %> >28</option>
                                    <option value="29" <%# ProcessarItemCombo(Eval("DS_VARA"), 29) %> >29</option>
                                    <option value="30" <%# ProcessarItemCombo(Eval("DS_VARA"), 30) %> >30</option>
                                    <option value="31" <%# ProcessarItemCombo(Eval("DS_VARA"), 31) %> >31</option>
                                    <option value="32" <%# ProcessarItemCombo(Eval("DS_VARA"), 32) %> >32</option>
                                    <option value="33" <%# ProcessarItemCombo(Eval("DS_VARA"), 33) %> >33</option>
                                    <option value="34" <%# ProcessarItemCombo(Eval("DS_VARA"), 34) %> >34</option>
                                    <option value="35" <%# ProcessarItemCombo(Eval("DS_VARA"), 35) %> >35</option>
                                    <option value="36" <%# ProcessarItemCombo(Eval("DS_VARA"), 36) %> >36</option>
                                    <option value="37" <%# ProcessarItemCombo(Eval("DS_VARA"), 37) %> >37</option>
                                    <option value="38" <%# ProcessarItemCombo(Eval("DS_VARA"), 38) %> >38</option>
                                    <option value="39" <%# ProcessarItemCombo(Eval("DS_VARA"), 39) %> >39</option>
                                    <option value="40" <%# ProcessarItemCombo(Eval("DS_VARA"), 40) %> >40</option>
                                    <option value="41" <%# ProcessarItemCombo(Eval("DS_VARA"), 41) %> >41</option>
                                    <option value="42" <%# ProcessarItemCombo(Eval("DS_VARA"), 42) %> >42</option>
                                    <option value="43" <%# ProcessarItemCombo(Eval("DS_VARA"), 43) %> >43</option>
                                    <option value="44" <%# ProcessarItemCombo(Eval("DS_VARA"), 44) %> >44</option>
                                    <option value="45" <%# ProcessarItemCombo(Eval("DS_VARA"), 45) %> >45</option>
                                    <option value="46" <%# ProcessarItemCombo(Eval("DS_VARA"), 46) %> >46</option>
                                    <option value="47" <%# ProcessarItemCombo(Eval("DS_VARA"), 47) %> >47</option>
                                    <option value="48" <%# ProcessarItemCombo(Eval("DS_VARA"), 48) %> >48</option>
                                    <option value="49" <%# ProcessarItemCombo(Eval("DS_VARA"), 49) %> >49</option>
                                    <option value="50" <%# ProcessarItemCombo(Eval("DS_VARA"), 50) %> >50</option>
                                    <option value="51" <%# ProcessarItemCombo(Eval("DS_VARA"), 51) %> >51</option>
                                    <option value="52" <%# ProcessarItemCombo(Eval("DS_VARA"), 52) %> >52</option>
                                    <option value="53" <%# ProcessarItemCombo(Eval("DS_VARA"), 53) %> >53</option>
                                    <option value="54" <%# ProcessarItemCombo(Eval("DS_VARA"), 54) %> >54</option>
                                    <option value="55" <%# ProcessarItemCombo(Eval("DS_VARA"), 55) %> >55</option>
                                    <option value="56" <%# ProcessarItemCombo(Eval("DS_VARA"), 56) %> >56</option>
                                    <option value="57" <%# ProcessarItemCombo(Eval("DS_VARA"), 57) %> >57</option>
                                    <option value="58" <%# ProcessarItemCombo(Eval("DS_VARA"), 58) %> >58</option>
                                    <option value="59" <%# ProcessarItemCombo(Eval("DS_VARA"), 59) %> >59</option>
                                    <option value="60" <%# ProcessarItemCombo(Eval("DS_VARA"), 60) %> >60</option>
                                    <option value="61" <%# ProcessarItemCombo(Eval("DS_VARA"), 61) %> >61</option>
                                    <option value="62" <%# ProcessarItemCombo(Eval("DS_VARA"), 62) %> >62</option>
                                    <option value="63" <%# ProcessarItemCombo(Eval("DS_VARA"), 63) %> >63</option>
                                    <option value="64" <%# ProcessarItemCombo(Eval("DS_VARA"), 64) %> >64</option>
                                    <option value="65" <%# ProcessarItemCombo(Eval("DS_VARA"), 65) %> >65</option>
                                    <option value="66" <%# ProcessarItemCombo(Eval("DS_VARA"), 66) %> >66</option>
                                    <option value="67" <%# ProcessarItemCombo(Eval("DS_VARA"), 67) %> >67</option>
                                    <option value="68" <%# ProcessarItemCombo(Eval("DS_VARA"), 68) %> >68</option>
                                    <option value="69" <%# ProcessarItemCombo(Eval("DS_VARA"), 69) %> >69</option>
                                    <option value="70" <%# ProcessarItemCombo(Eval("DS_VARA"), 70) %> >70</option>
                                    <option value="71" <%# ProcessarItemCombo(Eval("DS_VARA"), 71) %> >71</option>
                                    <option value="72" <%# ProcessarItemCombo(Eval("DS_VARA"), 72) %> >72</option>
                                    <option value="73" <%# ProcessarItemCombo(Eval("DS_VARA"), 73) %> >73</option>
                                    <option value="74" <%# ProcessarItemCombo(Eval("DS_VARA"), 74) %> >74</option>
                                    <option value="75" <%# ProcessarItemCombo(Eval("DS_VARA"), 75) %> >75</option>
                                    <option value="76" <%# ProcessarItemCombo(Eval("DS_VARA"), 76) %> >76</option>
                                    <option value="77" <%# ProcessarItemCombo(Eval("DS_VARA"), 77) %> >77</option>
                                    <option value="78" <%# ProcessarItemCombo(Eval("DS_VARA"), 78) %> >78</option>
                                    <option value="79" <%# ProcessarItemCombo(Eval("DS_VARA"), 79) %> >79</option>
                                    <option value="80" <%# ProcessarItemCombo(Eval("DS_VARA"), 80) %> >80</option>
                                    <option value="81" <%# ProcessarItemCombo(Eval("DS_VARA"), 81) %> >81</option>
                                    <option value="82" <%# ProcessarItemCombo(Eval("DS_VARA"), 82) %> >82</option>
                                    <option value="83" <%# ProcessarItemCombo(Eval("DS_VARA"), 83) %> >83</option>
                                    <option value="84" <%# ProcessarItemCombo(Eval("DS_VARA"), 84) %> >84</option>
                                    <option value="85" <%# ProcessarItemCombo(Eval("DS_VARA"), 85) %> >85</option>
                                    <option value="86" <%# ProcessarItemCombo(Eval("DS_VARA"), 86) %> >86</option>
                                    <option value="87" <%# ProcessarItemCombo(Eval("DS_VARA"), 87) %> >87</option>
                                    <option value="88" <%# ProcessarItemCombo(Eval("DS_VARA"), 88) %> >88</option>
                                    <option value="89" <%# ProcessarItemCombo(Eval("DS_VARA"), 89) %> >89</option>
                                    <option value="90" <%# ProcessarItemCombo(Eval("DS_VARA"), 90) %> >90</option>
                                    <option value="91" <%# ProcessarItemCombo(Eval("DS_VARA"), 91) %> >91</option>
                                    <option value="92" <%# ProcessarItemCombo(Eval("DS_VARA"), 92) %> >92</option>
                                    <option value="93" <%# ProcessarItemCombo(Eval("DS_VARA"), 93) %> >93</option>
                                    <option value="94" <%# ProcessarItemCombo(Eval("DS_VARA"), 94) %> >94</option>
                                    <option value="95" <%# ProcessarItemCombo(Eval("DS_VARA"), 95) %> >95</option>
                                    <option value="96" <%# ProcessarItemCombo(Eval("DS_VARA"), 96) %> >96</option>
                                    <option value="97" <%# ProcessarItemCombo(Eval("DS_VARA"), 97) %> >97</option>
                                    <option value="98" <%# ProcessarItemCombo(Eval("DS_VARA"), 98) %> >98</option>
                                    <option value="99" <%# ProcessarItemCombo(Eval("DS_VARA"), 99) %> >99</option>
                                    <option value="100" <%# ProcessarItemCombo(Eval("DS_VARA"), 100) %> >100</option>
                                </select>
    <p></p>

                                <label>Tipo de Ação</label>
                                <select id="cboTipoAcao" class="novoSelect" style="width:243px; height:21px; margin-top:0">
                                    <option value="1" <%# ProcessarItemCombo(Eval("TP_MOTIVO_ACAO"), 1) %> >Medida Cautelar</option>
                                    <option value="2" <%# ProcessarItemCombo(Eval("TP_MOTIVO_ACAO"), 2) %> >Exibição de Documentos</option>
                                    <option value="3" <%# ProcessarItemCombo(Eval("TP_MOTIVO_ACAO"), 3) %> >Execução</option>
                                    <option value="4" <%# ProcessarItemCombo(Eval("TP_MOTIVO_ACAO"), 4) %> >Cobrança de Seguro</option>
                                </select>
    <p></p>

                                <label>Causa Raiz</label>

                                <select id="cboCausaRaiz" class="novoSelect" style="width:243px; height:21px; margin-top:0">
			                        <option value="" selected>...</option>
			                        <option value="8" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 8) %> >Causa &#218;nica</option>
			                        <option value="7" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 7) %> >Assistencia Funeral</option>
			                        <option value="5" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 5) %> >Desemprego</option>
			                        <option value="6" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 6) %> >IFT</option>
			                        <option value="4" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 4) %> >IPA</option>
			                        <option value="10" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 10) %> >Incapacidade</option>
			                        <option value="12" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 12) %> >Invalidez Doen&#231;a</option>
			                        <option value="13" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 13) %> >Invalidez acidente</option>
			                        <option value="9" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 9) %> >Morte</option>
			                        <option value="14" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 14) %> >Morte Acidental</option>
			                        <option value="2" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 2) %> >Morte Acidental Conjuge</option>
			                        <option value="3" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 3) %> >Morte Acidental Filhos</option>
			                        <option value="1" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 1) %> >Morte Acidental Titular</option>
			                        <option value="11" <%# ProcessarItemCombo(Eval("TP_CAUSA_RAIZ"), 11) %> >Perda de Renda</option>
                                </select>

                        </ItemTemplate>
                    </asp:FormView>

                    <div class="clear"></div>

                    <div class="button-bar-inline-right" id="Div6">
                        <button type="button" id="btnSalvarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Gravar Dados</button>
                    </div>


                                </div>
                    </fieldset>

    </div>
            
    <div class="clear"></div>

    <div class="button-bar-inline-right" id="barraJudicial">
        <button type="button" id="btnTransformarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Transformar em Sinistro Judicial</button>
    </div>

    <div class="clear"></div>


    <!--fieldset class="fieldset-wizard">
    <legend>Probabilidade</legend>

            <asp:GridView ID="gvJudicialRisco" runat="server" Width="768" DataSourceID="dsJudicialRisco" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="vl_remoto" HeaderText="% Remoto" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="vl_possivel" HeaderText="% Possível" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="vl_provavel" HeaderText="% Provável" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsJudicialRisco" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select s.vl_remoto, s.vl_possivel, s.vl_provavel from sma_sinistro s where s.id_sinistro = :idSinistro"></asp:SqlDataSource>

    </fieldset-->

    <div class="clear"></div>

        </div>
    </div>

    <div id="step-6">	    
        <div id="divAgenda">

    <asp:FormView ID="FormView9" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label25" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label26" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label27" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label28" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label29" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label50" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>


            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label30" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>


    <fieldset class="fieldset-wizard">
    <legend>Total Reservas</legend>

            <asp:GridView ID="GridView7" runat="server" DataSourceID="dsReserva" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="ds_valor" HeaderText="" />
                        <asp:BoundField DataField="ds_evento" HeaderText="Tipo Evento"  />
                        <asp:BoundField DataField="vl_indemnizacao" HeaderText="Indenização"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_honorarios" HeaderText="Honorários"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_despesas" HeaderText="Despesas"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_resseguro" HeaderText="Resseguro"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_cosseguro" HeaderText="Cosseguro"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <asp:SqlDataSource ID="dsReserva" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        SelectCommand="select t.ds_valor, t.tp_valor, t.ds_evento, t.vl_indemnizacao, t.vl_honorarios,
                              t.vl_despesas, t.vl_resseguro, t.vl_cosseguro
                          from ctb_vtotalreservas t
                         where t.id_sinistro = :idSinistro
                         and   (t.vl_indemnizacao <> 0
                          or     t.vl_honorarios <> 0
                          or     t.vl_despesas <> 0
                          or     t.vl_resseguro <> 0
                          or     t.vl_cosseguro <> 0)
                          order by t.id_valor">
    </asp:SqlDataSource>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
    <legend>Lançamentos Reserva</legend>

            <asp:GridView ID="GridView16" runat="server" DataSourceID="dsReservaTotal" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="dt_cadastro" HeaderText="Data" />
                        <asp:BoundField DataField="ds_descricao" HeaderText="Tipo Reserva"  />
                        <asp:BoundField DataField="fl_evento" HeaderText="Tipo Evento" />
                        <asp:BoundField DataField="vl_reserva_somatorio" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Reserva Total"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <asp:SqlDataSource ID="dsReservaTotal" runat="server" ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select to_char(r.dt_cadastro,'dd/mm/yyyy') dt_cadastro,
       tpv.ds_descricao,
       case when r.fl_evento = 'A' then 'AVISO'
            when r.fl_evento = 'J' then 'AJUSTE' || (select ' - ' || t.ds_cm from sto_cm c, sto_tpcm t where c.tp_cm = t.tp_cm and c.id_cm = r.id_cm)
            when r.fl_evento = 'P' then 'PAGTO'
            when r.fl_evento = 'CM' then 'CORREÇAO MONETÁRIA' end fl_evento,
            nvl(r.vl_reserva,0) + nvl(r.vl_cosseguro,0) + nvl(r.vl_resseguro,0) vl_reserva_somatorio,
       r.id_op
  from sto_reserva r 
 inner join ctb_tpvalor tpv
    on tpv.id_valor = r.tp_valor
 where r.id_sinistro = :idSinistro and nvl(r.vl_reserva,0) + nvl(r.vl_cosseguro,0) + nvl(r.vl_resseguro,0) <> 0
 order by r.dt_cadastro">
    </asp:SqlDataSource>

    <div class="clear"></div>


        </div>
    </div>

    <div id="step-7">	    
        <div id="divHistorico">

    <asp:FormView ID="FormView10" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label31" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label32" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label33" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label34" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label35" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label50" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label36" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>


    <!--fieldset class="fieldset-wizard">
    <legend>Histórico de Status</legend>

            <asp:GridView ID="GridView12" runat="server" DataSourceID="dsStatus" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="dt_criacao" HeaderText="Data" />
                        <asp:BoundField DataField="ds_status" HeaderText="Status"  />
                        <asp:BoundField DataField="ds_usuario" HeaderText="Usuário" />
                    </Columns>
            </asp:GridView>

    </fieldset-->

            <asp:SqlDataSource ID="dsStatus" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_char(st.dt_criacao,'dd/mm/yyyy') dt_criacao,
       tpst.ds_status,
       u.ds_usuario
  from sto_status st
 inner join sto_tpstatus tpst
    on st.tp_status = tpst.id_tpstatus
  left outer join adm_usuario u 
    on u.id_usuario = st.id_usuario
 where st.id_sinistro = :idSinistro
 order by st.id_status desc
"></asp:SqlDataSource>

    <fieldset class="fieldset-wizard">
        <legend>Histórico de Status/Comentários</legend>

        <asp:GridView ID="GridView14" runat="server" DataSourceID="dsComentarios" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                <Columns>
                    <asp:BoundField DataField="ds_usuario" HeaderText="Usuário" />
                    <asp:BoundField DataField="dt_registro" HeaderText="Data"  />
                    <asp:BoundField DataField="ds_evento" HeaderText="Evento" />
                    <asp:BoundField DataField="ds_comentario" HeaderText="Comentário" />
                </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsComentarios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select u.ds_usuario, txt.bn_texto ds_comentario,
                            to_char(t.dt_registro,'dd/mm/yyyy') dt_registro,e.ds_evento, t.id_tarefa, t.id_texto 
                    from sma_tarefa t, adm_usuario u, exc_evento e, adm_texto txt
                    where t.id_usuario = u.id_usuario
                    and t.cd_evento = e.cd_evento
                    and txt.id_texto = t.id_texto
                    and t.id_sinistro = :idSinistro
                    order by t.dt_registro desc">
        </asp:SqlDataSource>

        <div class="clear"></div>

    </fieldset>

        <div class="cell-wizard">
            
            <div style="float:left">
            <label for="Itens_DsObjSeguradoEdit"> Administrativo - Novo Status / Comentário </label>

            <asp:SqlDataSource ID="dsEvento" runat="server"
                ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>"     
                SelectCommand = "select -1 cd_evento, ' ' ds_evento from dual
                                 union
                                 select t.cd_evento, upper(t.ds_evento) ds_evento from exc_evento t  where t.fl_sinistro = 1 order by ds_evento">
            </asp:SqlDataSource>

            <asp:DropDownList ID="cboComentarioEvento" runat="server" 
                    DataSourceid="dsEvento"
                    DataTextField="ds_evento" 
                    DataValueField="cd_evento"
                    >
            </asp:DropDownList>

            </div>

            <div style="float:right">
                <label for="source">Judicial - Novo Status / Comentário</label>
                <select size="1" id="cboComentarioJudicial" style="width: 306px;" onchange="source_onchange()">
                    <option value=""></option>
                    <option value="1">Sentença</option>
                    <option value="2">Trânsito em Julgado</option>
                    <option value="3">Audiência</option>
                    <option value="4">Audiência de Conciliação</option>
                    <option value="5">Contestação</option>
                    <option value="6">Apelação</option>
                    <option value="7">Aguardando Julgamento</option>
                    <option value="8">Cálculo de Reserva</option>
                    <option value="9">Subsídios</option>
                    <option value="10">Acórdão</option>
                    <option value="11">Outros</option>
                </select>

            </div>

        <div class="clear"></div>

            <textarea id="txtComentarioEvento" cols="80" rows="5" style="height: 100px;" ></textarea>

        </div>

            <div class="button-bar-inline-right" id="barraComentario">
                <button type="button" id="btnComentario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar Comentário</button>
            </div>


        <div class="clear"></div>

        </div>
    </div>

    <div id="step-8">	    
        <div id="divPagamentos">

    <asp:FormView ID="FormView11" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label37" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label38" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label39" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label40" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label41" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label50" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>


            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label42" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <div class="clear"></div>

    <div class="clear"></div>

            <asp:GridView ID="GridView13" runat="server" DataSourceID="dsPagamentos" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_op" HeaderText="OP" />
                        <asp:BoundField DataField="tp_op" HeaderText="Tipo OP"  />
                        <asp:BoundField DataField="ds_status" HeaderText="Status" />
                        <asp:BoundField DataField="nm_favorecido" HeaderText="Beneficiário" />
                        <asp:BoundField DataField="ds_conta" HeaderText="Conta" />
                        <asp:BoundField DataField="vl_pagamento" HeaderText="Valor Pagto"  DataFormatString="R$ {0:###,###,###.00}" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="dt_pagamento" HeaderText="Dt Pagto" />
                        <asp:BoundField DataField="ds_forma_pagamento" HeaderText="Forma Pagto" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsPagamentos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select v.id_op,
       v.tp_op,
       t.ds_status,
       v.nm_favorecido,
       v.vl_pagamento,
       to_char(v.dt_pagamento,'dd/mm/yyyy') dt_pagamento,
       v.ds_forma_pagamento,
       v.dt_cancelamento,
       v.ds_conta,
       (case when v.dt_cancelamento is not null then 1 else 0 end)
  from vOPSiniestros v, ctb_tpstatusop t
 where v.id_sinistro = :idSinistro and t.id_tpstatusop = v.id_status
"></asp:SqlDataSource>

        <div class="clear"></div>

        </div>
    </div>

    <div id="step-9">	    
        <div id="divArrec">

    <asp:FormView ID="FormView12" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label43" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label44" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label45" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label46" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="clear"></div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label ID="Label47" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Sub-Status</label>
                <asp:Label id="Label50" class="labelDescricao" runat="server" Text='<%# Eval("ds_sub_status") %>' ></asp:Label>
            </div>



            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label48" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

                    <label>Arrecadação de Fundos</label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                    DataSourceID="dsArrecadacao"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="TO_CHAR(C.DT_ARRECADACAO,'DD/MM/YYYY')" 
                            HeaderText="Data Arrecadação" 
                            SortExpression="TO_CHAR(C.DT_ARRECADACAO,'DD/MM/YYYY')" />
                        <asp:BoundField DataField="NRO_CONTA" HeaderText="Nº da Conta" 
                            SortExpression="NRO_CONTA" />
                        <asp:BoundField DataField="NVL(C.VL_ARRECADADO,0)" 
                            HeaderText="Valor Arrecadado" SortExpression="NVL(C.VL_ARRECADADO,0)"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="TO_CHAR(C.DT_VECTO,'DD/MM/YYYY')" 
                            HeaderText="Data Vcto da Conta" 
                            SortExpression="TO_CHAR(C.DT_VECTO,'DD/MM/YYYY')" />
                        <asp:BoundField DataField="NVL(C.NRO_RODADA,0)" HeaderText="Rodada" 
                            SortExpression="NVL(C.NRO_RODADA,0)" />
                        <asp:BoundField DataField="TO_CHAR(C.DT_PROC,'DD/MM/YYYY')" 
                            HeaderText="Data Processo" SortExpression="TO_CHAR(C.DT_PROC,'DD/MM/YYYY')" />
                        <asp:BoundField DataField="TO_CHAR(C.DT_REFERENCIA,'DD/MM/YYYY')" 
                            HeaderText="Data Referencia" 
                            SortExpression="TO_CHAR(C.DT_REFERENCIA,'DD/MM/YYYY')" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="dsArrecadacao" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_char(c.dt_arrecadacao,'dd/mm/yyyy'),
       c.nro_conta,
       nvl(c.vl_arrecadado,0),
       to_char(c.dt_vecto,'dd/mm/yyyy'),
       nvl(c.nro_rodada,0),
       to_char(c.dt_proc,'dd/mm/yyyy'),
       to_char(c.dt_referencia,'dd/mm/yyyy')
  from sma_cobranca c, sma_sinistro s
 where s.id_sinistro = :idSinistro
 and c.id_seguro = s.id_seguro
 order by c.id_cobranca desc
"></asp:SqlDataSource>

        <div class="clear"></div>

        </div>
    </div>

</div>

<div class="both"></div>
        </div>
    </div>

    <div id="novaOP" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 700px; top: 173px; left: 438.5px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Ordem de Pagamento </div>
        <div id="editNovaOP" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Liquidação </label>
                <input id="txtIdLiquidacao" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Valor Pagto </label>
                <input id="txtVlPagto" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Tipo de Pagto </label>
                <input id="txtFlPagto" style="width: 80px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Beneficiário </label>
                <input id="txtDsBeneficiario" style="width: 350px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Data de Pagto </label>
                <input id="txtDtPagto2" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="button-bar-inline">
                <button type="button" id="btnCancelarOP" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
                <button type="button" id="btnGravarOP" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar OP</button>
            </div>

        </div>
    </div>

    <div id="ajusteManual" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 700px; top: 173px; left: 450px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Ajuste Manual </div>
        <div id="editAjusteManual" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 150px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Indenização </label>
                <input id="txtReservaDisponivel" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Honorários </label>
                <input id="txtReservaDisponivelHon" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Despesas </label>
                <input id="txtReservaDisponivelDes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Ressarcimentos </label>
                <input id="txtReservaDisponivelRes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Salvados </label>
                <input id="txtReservaDisponivelSal" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Valor Ajuste </label-->
                <input id="txtValorAjuste" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Honorários </label-->
                <input id="txtValorAjusteHon" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Despesas </label-->
                <input id="txtValorAjusteDes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Honorários </label-->
                <input id="txtValorAjusteRes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Despesas </label-->
                <input id="txtValorAjusteSal" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="clear"></div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnCancelarAjuste" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
                <button type="button" id="btnSalvarAjuste" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar Ajuste</button>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {

            $('#btnCancelarJudicial').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'none';
                abrirJudicial.style.display = 'none';
            });

            $('#btnGravarJudicial').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                $.ajax({
                    type: "post",
                    url: "sinistro?judicial=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                                document.getElementById('txtUsuario').value + '$' +
                                                document.getElementById('txtIndenizacaoJudicial').value.replace(",", ".") + '$' +
                                                document.getElementById('txtHonorarios').value.replace(",", ".") + '$' +
                                                document.getElementById('txtDespesas').value.replace(",", ".") + '$' +
                                                document.getElementById('txtRemoto').value.replace(",", ".") + '$' +
                                                document.getElementById('txtPossivel').value.replace(",", ".") + '$' +
                                                document.getElementById('txtProvavel').value.replace(",", "."),
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Sinistro Judicial gravado com sucesso.');
                        location.reload();
                    }
                });
            });

        });
    
    </script>

    <div id="abrirJudicial" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 700px; top: 173px; left: 438.5px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Reabrir Como Sinistro Judicial </div>
        <div id="Div3" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 50px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Indenização </label>
                <input id="txtIndenizacaoJudicial" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Honorários </label>
                <input id="txtHonorarios" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Despesas </label>
                <input id="txtDespesas" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

        </div>
        <div id="Div5" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 50px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> % Remoto </label>
                <input id="txtRemoto" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> % Possível </label>
                <input id="txtPossivel" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> % Provável </label>
                <input id="txtProvavel" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnGravarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar Judicial</button>
                <button type="button" id="btnCancelarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
            </div>

        </div>
    </div>

    <script type="text/javascript">
        var model = { "coberturas": [] };
        $(document).ready(function () {

            $('#btnPesquisarPessoa').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "get",
                    contentType: "application/json",
                    url: "pessoa?nome=" + document.getElementById('txtNomePessoa').value,
                    data: "{}",
                    dataType: 'json',
                    success: function (result) {
                        //add data

                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.ID_PESSOA, item.TP_PESSOA, item.DS_PESSOA, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexPessoas").flexAddData(pessoas);

                    }
                });
            });

            $('#btnAdicionarCPF').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                if (!validarCPF(document.getElementById('txtCPFPessoa').value)) {
                    if (!validarCNPJ(document.getElementById('txtCPFPessoa').value)) {
                        alert('CPF ou CNPJ Inválido!');
                        return;
                    }
                }

                $.ajax({
                    type: "post",
                    url: "pessoa?docto=" + document.getElementById('txtIdPessoa').value + '$' + document.getElementById('txtCPFPessoa').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('CPF / CNPJ gravado com sucesso.');
                        $.ajax({
                            type: "get",
                            url: "pessoa?doctos=" + document.getElementById('txtIdPessoa').value,
                            success: function (result) {

                                var rows = Array();

                                for (i = 0; i < result.length; i++) {
                                    var item = result[i];
                                    rows.push({ cell: [item.TP_DOCTO, item.NR_DOCTO, ''] });
                                }
                                pessoas = { total: result.length, page: 1, rows: rows }

                                $("#flexDocumentos").flexAddData(pessoas);

                            }
                        });
                    }
                });
            });

            $('#btnAdicionarEnd').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "post",
                    url: "pessoa?endereco=" + document.getElementById('txtIdPessoa').value + '$' + document.getElementById('txtEndereco').value + '$' +
                                          document.getElementById('txtComplemento').value + '$' + document.getElementById('txtBairro').value + '$' +
                                          document.getElementById('txtCidade').value + '$' + document.getElementById('txtUF').value + '$' +
                                          document.getElementById('txtCEP').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.' + result);


                        $.ajax({
                            type: "get",
                            url: "pessoa?enderecos=" + document.getElementById('txtIdPessoa').value,
                            success: function (result) {
                                var rows = Array();

                                for (i = 0; i < result.length; i++) {
                                    var item = result[i];
                                    rows.push({ cell: [item.DS_ENDERECO, item.DS_COMPL, item.DS_BAIRRO, item.DS_CIDADE, item.CD_UF, item.DS_CEP, ''] });
                                }
                                pessoas = { total: result.length, page: 1, rows: rows }

                                $("#flexEnderecos").flexAddData(pessoas);

                            }
                        });


                    }
                });
            });

            $('#btnAdicionarConta').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "post",
                    url: "pessoa?conta=" + document.getElementById('txtIdPessoa').value + '$' + document.getElementById('txtConta').value + '$' +
                                          document.getElementById('txtContaDV').value + '$' + document.getElementById('cboBanco').value + '$' +
                                          document.getElementById('txtAgencia').value + '$' + document.getElementById('txtAgenciaDV').value + '$' +
                                          document.getElementById('chkPrincipal').value + '$' + document.getElementById('cboTipoConta').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');

                        $.ajax({
                            type: "get",
                            url: "pessoa?contas=" + document.getElementById('txtIdPessoa').value,
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

                    }
                });
            });

        });

    </script>

    <div id="Pessoa" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1003; height: 600px; width: 960px; top: 100px; left: 260px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Cadastro Pessoas </div>
        <div id="Div2" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 600px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit">Tipo de Pessoa</label>
                <select id="cboTipoPessoa" style="width: 80px;" >
                  <option value="F">Física</option>
                  <option value="J">Jurídica</option>
                </select>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Nome </label>
                <input id="txtNomePessoa" onkeyup="this.value=retira_acentos(this.value);" style="width: 350px;" type="text" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnPesquisarPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Pesquisar</button>
                <button type="button" id="btnLimparPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Limpar</button>
                <button type="button" id="btnGravarPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar</button>
                <button type="button" id="btnFecharPessoas" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Fechar</button>
            </div>

            <div class="clear"></div>

            <div id="pessoasGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexPessoas"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> CPF/CNPJ </label>
                <input id="txtCPFPessoa" style="width: 100px;" type="text" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarCPF" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>


            <div class="clear"></div>
            <div id="documentosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexDocumentos"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Endereço </label>
                <input id="txtEndereco" onkeyup="this.value=retira_acentos(this.value);" style="width: 200px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Complemento </label>
                <input id="txtComplemento" onkeyup="this.value=retira_acentos(this.value);" style="width: 150px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Bairro </label>
                <input id="txtBairro" onkeyup="this.value=retira_acentos(this.value);" style="width: 100px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Cidade </label>
                <input id="txtCidade" onkeyup="this.value=retira_acentos(this.value);" style="width: 100px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> UF </label>
                <input id="txtUF" style="width: 20px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> CEP </label>
                <input id="txtCEP" style="width: 70px;" type="text" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarEnd" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>

            <div class="clear"></div>
            <div id="enderecosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexEnderecos"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Tipo da Conta </label>
                <select id="cboTipoConta" style="width: 100px;" >
                  <option value="1">Corrente</option>
                  <option value="2">Poupança</option>
                </select>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Banco </label>
                <select id="cboBanco" style="width: 200px;" >
                    <option value="0">000 - Banco Bankpar S.A.	</option>
                    <option value="1">001 - Banco do Brasil S.A.	</option>
                    <option value="3">003 - Banco da Amazônia S.A.	</option>
                    <option value="4">004 - Banco do Nordeste do Brasil S.A.	</option>
                    <option value="12">012 - Banco Standard de Investimentos S.A.	</option>
                    <option value="14">014 - Natixis Brasil S.A. Banco Múltiplo	</option>
                    <option value="17">017 - BNY MELLON	</option>
                    <option value="19">019 - Banco Azteca do Brasil S.A.	</option>
                    <option value="21">021 - BANESTES S.A. Banco do Estado do Espírito Santo	</option>
                    <option value="24">024 - Banco de Pernambuco S.A. - BANDEPE	</option>
                    <option value="25">025 - Banco Alfa S.A.	</option>
                    <option value="29">029 - Banco Banerj S.A.	</option>
                    <option value="33">033 - BANCO SANTANDER	</option>
                    <option value="36">036 - Banco Bradesco BBI S.A.	</option>
                    <option value="37">037 - Banco do Estado do Pará S.A.	</option>
                    <option value="39">039 - Banco do Estado do Piauí S.A. - BEP	</option>
                    <option value="40">040 - Banco Cargill S.A.	</option>
                    <option value="41">041 - Banco do Estado do Rio Grande do Sul S.A.	</option>
                    <option value="44">044 - Banco BVA S.A.	</option>
                    <option value="45">045 - Banco Opportunity S.A.	</option>
                    <option value="47">047 - Banco do Estado de Sergipe S.A.	</option>
                    <option value="62">062 - Hipercard Banco Múltiplo S.A.	</option>
                    <option value="63">063 - Banco Ibi S.A. Banco Múltiplo	</option>
                    <option value="64">064 - Goldman Sachs do Brasil Banco Múltiplo S.A.	</option>
                    <option value="65">065 - Banco Bracce S.A.	</option>
                    <option value="66">066 - Banco Morgan Stanley S.A.	</option>
                    <option value="69">069 - BPN Brasil Banco Múltiplo S.A.	</option>
                    <option value="70">070 - BRB - Banco de Brasília S.A.	</option>
                    <option value="72">072 - Banco Rural Mais S.A.	</option>
                    <option value="73">073 - BB Banco Popular do Brasil S.A.	</option>
                    <option value="74">074 - Banco J. Safra S.A.	</option>
                    <option value="75">075 - Banco CR2 S.A.	</option>
                    <option value="76">076 - Banco KDB S.A.	</option>
                    <option value="78">078 - BES Investimento do Brasil S.A.	</option>
                    <option value="79">079 - JBS Banco S.A.	</option>
                    <option value="84">084 - Unicred Norte do Paraná	</option>
                    <option value="96">096 - Banco BM de Serviços de Liquidação e Custódia S.A	</option>
                    <option value="100">100 - TRANSITÓRIA	</option>
                    <option value="101">101 - Adiantamento de Despesas	</option>
                    <option value="102">102 - FORNECEDORES	</option>
                    <option value="104">104 - Caixa Econômica Federal	</option>
                    <option value="107">107 - Banco BBM S.A.	</option>
                    <option value="168">168 - HSBC Finance (Brasil) S.A. - Banco Múltiplo	</option>
                    <option value="184">184 - Banco Itaú BBA S.A.	</option>
                    <option value="204">204 - Banco Bradesco Cartões S.A.	</option>
                    <option value="208">208 - Banco BTG Pactual S.A.	</option>
                    <option value="212">212 - Banco Matone S.A.	</option>
                    <option value="213">213 - Banco Arbi S.A.	</option>
                    <option value="214">214 - Banco Dibens S.A.	</option>
                    <option value="215">215 - Banco Comercial e de Investimento Sudameris S.A.	</option>
                    <option value="217">217 - Banco John Deere S.A.	</option>
                    <option value="218">218 - Banco Bonsucesso S.A.	</option>
                    <option value="222">222 - Banco Credit Agricole Brasil S.A.	</option>
                    <option value="224">224 - Banco Fibra S.A.	</option>
                    <option value="225">225 - Banco Brascan S.A.	</option>
                    <option value="229">229 - Banco Cruzeiro do Sul S.A.	</option>
                    <option value="230">230 - Unicard Banco Múltiplo S.A.	</option>
                    <option value="233">233 - Banco GE Capital S.A.	</option>
                    <option value="237">237 - BANCO BRADESCO	</option>
                    <option value="241">241 - Banco Clássico S.A.	</option>
                    <option value="243">243 - Banco Máxima S.A.	</option>
                    <option value="246">246 - Banco ABC Brasil S.A.	</option>
                    <option value="248">248 - Banco Boavista Interatlântico S.A.	</option>
                    <option value="249">249 - Banco Investcred Unibanco S.A.	</option>
                    <option value="250">250 - Banco Schahin S.A.	</option>
                    <option value="254">254 - Paraná Banco S.A.	</option>
                    <option value="263">263 - Banco Cacique S.A.	</option>
                    <option value="265">265 - Banco Fator S.A.	</option>
                    <option value="266">266 - Banco Cédula S.A.	</option>
                    <option value="300">300 - Banco de La Nacion Argentina	</option>
                    <option value="318">318 - Banco BMG S.A.	</option>
                    <option value="320">320 - Banco Industrial e Comercial S.A.	</option>
                    <option value="341">341 - BANCO ITAU S/A.	</option>
                    <option value="356">356 - Banco Real S.A.	</option>
                    <option value="366">366 - Banco Société Générale Brasil S.A.	</option>
                    <option value="370">370 - Banco WestLB do Brasil S.A.	</option>
                    <option value="376">376 - Banco J. P. Morgan S.A.	</option>
                    <option value="389">389 - Banco Mercantil do Brasil S.A.	</option>
                    <option value="394">394 - Banco Bradesco Financiamentos S.A.	</option>
                    <option value="399">399 - HSBC Bank Brasil S.A. - Banco Múltiplo	</option>
                    <option value="409">409 - UNIBANCO - União de Bancos Brasileiros S.A.	</option>
                    <option value="412">412 - Banco Capital S.A.	</option>
                    <option value="422">422 - Banco Safra S.A.	</option>
                    <option value="453">453 - Banco Rural S.A.	</option>
                    <option value="456">456 - Banco de Tokyo-Mitsubishi UFJ Brasil S.A.	</option>
                    <option value="464">464 - Banco Sumitomo Mitsui Brasileiro S.A.	</option>
                    <option value="473">473 - Banco Caixa Geral - Brasil S.A.	</option>
                    <option value="477">477 - Citibank N.A.	</option>
                    <option value="479">479 - Banco ItaúBank S.A	</option>
                    <option value="487">487 - Deutsche Bank S.A. - Banco Alemão	</option>
                    <option value="488">488 - JPMorgan Chase Bank	</option>
                    <option value="492">492 - ING Bank N.V.	</option>
                    <option value="494">494 - Banco de La Republica Oriental del Uruguay	</option>
                    <option value="495">495 - Banco de La Provincia de Buenos Aires	</option>
                    <option value="505">505 - Banco Credit Suisse (Brasil) S.A.	</option>
                    <option value="600">600 - Banco Luso Brasileiro S.A.	</option>
                    <option value="604">604 - Banco Industrial do Brasil S.A.	</option>
                    <option value="610">610 - Banco VR S.A.	</option>
                    <option value="611">611 - Banco Paulista S.A.	</option>
                    <option value="612">612 - Banco Guanabara S.A.	</option>
                    <option value="613">613 - Banco Pecúnia S.A.	</option>
                    <option value="623">623 - Banco Panamericano S.A.	</option>
                    <option value="626">626 - Banco Ficsa S.A.	</option>
                    <option value="630">630 - Banco Intercap S.A.	</option>
                    <option value="633">633 - Banco Rendimento S.A.	</option>
                    <option value="634">634 - Banco Triângulo S.A.	</option>
                    <option value="637">637 - Banco Sofisa S.A.	</option>
                    <option value="638">638 - Banco Prosper S.A.	</option>
                    <option value="641">641 - Banco Alvorada S.A.	</option>
                    <option value="643">643 - Banco Pine S.A.	</option>
                    <option value="652">652 - Itaú Unibanco Holding S.A.	</option>
                    <option value="653">653 - Banco Indusval S.A.	</option>
                    <option value="654">654 - Banco A.J.Renner S.A.	</option>
                    <option value="655">655 - Banco Votorantim S.A.	</option>
                    <option value="707">707 - Banco Daycoval S.A.	</option>
                    <option value="719">719 - Banif-Banco Internacional do Funchal (Brasil)S.A.	</option>
                    <option value="721">721 - Banco Credibel S.A.	</option>
                    <option value="724">724 - Banco Porto Seguro S.A.	</option>
                    <option value="734">734 - Banco Gerdau S.A.	</option>
                    <option value="735">735 - Banco Pottencial S.A.	</option>
                    <option value="738">738 - Banco Morada S.A.	</option>
                    <option value="739">739 - Banco BGN S.A.	</option>
                    <option value="740">740 - Banco Barclays S.A.	</option>
                    <option value="741">741 - Banco Ribeirão Preto S.A.	</option>
                    <option value="743">743 - Banco Semear S.A.	</option>
                    <option value="744">744 - BankBoston N.A.	</option>
                    <option value="745">745 - Banco Citibank S.A.	</option>
                    <option value="746">746 - Banco Modal S.A.	</option>
                    <option value="747">747 - Banco Rabobank International Brasil S.A.	</option>
                    <option value="748">748 - Banco Cooperativo Sicredi S.A.	</option>
                    <option value="749">749 - Banco Simples S.A.	</option>
                    <option value="751">751 - Dresdner Bank Brasil S.A. - Banco Múltiplo	</option>
                    <option value="752">752 - Banco BNP Paribas Brasil S.A.	</option>
                    <option value="753">753 - NBC Bank Brasil S.A. - Banco Múltiplo	</option>
                    <option value="755">755 - Bank of America Merrill Lynch Banco Múltiplo S.A.	</option>
                    <option value="756">756 - Banco Cooperativo do Brasil S.A. - BANCOOB	</option>
                    <option value="757">757 - Banco KEB do Brasil S.A.	</option>
                </select>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Agencia </label>
                <input id="txtAgencia" style="width: 50px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> DV </label>
                <input id="txtAgenciaDV" style="width: 20px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Número </label>
                <input id="txtConta" style="width: 50px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> DV </label>
                <input id="txtContaDV" style="width: 20px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Principal </label>
                <input id="chkPrincipal" type="checkbox" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarConta" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>


            <div class="clear"></div>
            <div id="contasGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexContas"> </table></div>


        </div>
    </div>

    <div id="beneficiarios" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: 600px; width: 695px; top: 173px; left: 438.5px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Beneficiários </div>
        <div id="editDialogItem" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 550px;" scrolltop="0" scrollleft="0">
            <input id="txtIdPessoa" type="hidden" />
            <input id="txtIdDocto" type="hidden" />
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> CPF / CNPJ </label>
                <input id="txtCPF" class="w200" type="text" value="" onblur="pesquisarBeneficiario();"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Nome </label>
                <input id="txtNome" style="width: 410px;" type="text" value="" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Parentesco </label>
                <select id="cboParentesco" style="width: 205px;" >
                  <option value="NULL">...</option>
                  <option value="1">TITULAR</option>
                  <option value="2">CONJUGE</option>
                  <option value="3">FILHO</option>
                  <option value="4">MAE</option>
                  <option value="5">PAI</option>
                  <option value="6">AVO</option>
                  <option value="99">OUTROS</option>
                </select>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Conta Bancária </label>
                <select id="cboConta" style="width: 230px;"  >
                </select>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Participação </label>
                <input id="txtParticipacao" style="width: 50px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="button-bar-inline-right">
                <button type="button" id="btnAdicionarBeneficiario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false" >Adicionar</button>
            </div>
            <div class="clear"></div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnEstipulante" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Dados Estipulante</button>
                <button type="button" id="btnCadastroPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cadastro de Pessoas</button>
                <button type="button" id="btnLimparBeneficiarios" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Limpar Lista de Beneficiários</button>
            </div>

            <div class="clear"></div>

            <div id="beneficiariosGrid" class="frameResultado" ><table id="flex1"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Reserva Disponível </label>
                <!--input id="txtReserva" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/-->
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Indenização </label>
                <input id="txtReserva" style="width: 160px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Honorários </label>
                <input id="txtReservaHon" style="width: 160px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Despesas </label>
                <input id="txtReservaDesp" style="width: 160px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Comentário Pagamento </label>
                <textarea id="txtComentario" cols="89" rows="5" style="height: 100px;" ></textarea>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Valor a Ser Liquidado </label>
                <input id="txtValorLiquidacao" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

           <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Data de Pagto </label>
                <input id="txtDtPagto" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Tipo </label>
                <select id="cboTipoLiquidacao" style="width: 150px;" >
                  <option value="1">Indenização</option>
                  <option value="2">Honorário</option>
                  <option value="3">Despesa</option>
                </select>
                <input id="chkBoleto" type="checkbox"/>Boleto Bancário
                <input id="chkBordero" type="checkbox"/>Borderô
                <input id="chkGoverno" type="checkbox"/>Governo
                <input id="chkRetencaoImpostos" type="checkbox"/>Com Retenção de Impostos
             </div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnGravarLiq" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Gravar Liquidação</button>
                <button type="button" id="btnCancelarBeneficiario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
            </div>

        </div>
    </div>

    <div id="docUpload" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 1106px; top: 0px; left: 300px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Importar Documento </div>
        <div id="Div1" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100%;" scrolltop="0" scrollleft="0">
<iframe id="frmImagem" src="docImp.aspx" height="100%" width="100%" frameborder="0"></iframe>        
    </div>
    </div>

    <div id="docView" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 1106px; top: 0px; left: 300px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Visualizar Documento </div>
        <div id="Div4" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100%;" scrolltop="0" scrollleft="0">
            <table style="border-style:none; width=100%;" >
                <tr><td style="width:99%"></td><td align="right"><input type="button" id="btFechar" value="Fechar" onclick="FecharImg();" /></td></tr>
                <tr><td colspan="2" align="center">
                    <img id="imgDoc" src="" alt="" /></td>   
                </tr>
            </table>  
        </div>
    </div>

    <div id="overlay" class="ui-widget-overlay" style="width: 1583px; height: 950px; z-index: 1001; display: none;"></div>

    </form>

</body>
</html>
