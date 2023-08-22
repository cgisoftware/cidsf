import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PoliticaPage extends StatefulWidget {
  @override
  _PoliticaPageState createState() => _PoliticaPageState();
}

class _PoliticaPageState extends State<PoliticaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Privacidade"),
        ),
        body: SingleChildScrollView(child: Container(padding: EdgeInsets.all(10), child: HtmlWidget("""
            <!DOCTYPE html><html lang="pt-br"><head><meta charset="UTF-8">
            <title>Política de privacidade</title></head><body><h1>Política de Privacidade</h1>
            <h2>Tipos de dados coletados</h2>
            <p>Entre os tipos de dados pessoais que este aplicativo recolhe, por si só ou por meio de terceiros, estão: e-mail, nome, sobrenome, cookies e dados de uso.</p>
            <p>Outros dados pessoais recolhidos podem ser descritos em outras seções desta política de  privacidade ou pelo texto explicativo específico apresentado no contexto da coleta de dados.</p>
            <p>Os dados pessoais podem ser livremente fornecidos pelo usuário, ou coletados automaticamente  quando se utiliza este aplicativo.</p>
            <p>Qualquer uso de cookies - ou de outras ferramentas de rastreamento - pelo aplicativo ou pelos  proprietários dos serviços terceirizados utilizados por ele, salvo indicação em contrário,  servem para identificar os usuários e lembrar as suas preferências, com o único propósito de  fornecer os serviços requeridos por eles.</p>
            <p>O não fornecimento de determinados dados pessoais pode tornar impossível para este aplicativo  prestar os seus serviços.</p>
            <p>O usuário assume a responsabilidade pelos dados pessoais de terceiros publicados ou  compartilhados por meio deste serviço (este aplicativo) e confirma que tem o consentimento da  parte terceira para fornecer dados para o proprietário.</p>
            <h2>Modo e local de processamento dos dados</h2>
            <h3>Método de processamento</h3>
            <p>O controlador de dados processa os dados de usuários de forma adequada e tomará as medidas de  segurança adequadas para impedir o acesso não autorizado, divulgação, alteração ou destruição  não autorizada dos dados.</p>
            <p>O processamento de dados é realizado utilizando computadores e /ou ferramentas de TI habilitadas,  seguindo procedimentos organizacionais e meios estritamente relacionados com os fins indicados.  Além do controlador de dados, em alguns casos, os dados podem ser acessados por certos tipos de  pessoas envolvidas com a operação do aplicativo (administração, vendas, marketing, administração  legal do sistema) ou pessoas externas (como fornecedores terceirizados de serviços técnicos,  carteiros, provedores de hospedagem, empresas de TI, agências de comunicação) nomeadas, quando  necessário, como processadores de dados por parte do proprietário. A lista atualizada destas  partes pode ser solicitada a partir do controlador de dados a qualquer momento.</p>
            <h3>Lugar</h3>
            <p>Os dados são processados nas sedes de operação do controlador de dados, e em quaisquer outros  lugares onde as partes envolvidas com o processamento estejam localizadas. Para mais  informações, por favor entre em contato com o controlador de dados.</p>
            <h3>Período de conservação</h3>
            <p>Os dados são mantidos pelo período necessário para prestar o serviço solicitado pelo usuário, ou  pelos fins descritos neste documento, e o usuário pode solicitar ao controlador de dados para  que os suspendam ou os removam.</p>
            <h2>O Uso dos dados coletados</h2>
            <p>Os dados relativos ao usuário são coletados para permitir que o proprietário forneça os serviços,  bem como para os seguintes propósitos: contatar o usuário, comentário de conteúdo e interação  com redes sociais e plataformas externas.</p>
            <p>Os dados pessoais utilizados para cada finalidade estão descrito nas seções específicas deste  documento.</p>
            <h2>Informações detalhadas sobre o processamento de dados pessoais</h2>
            <p>Os dados pessoais são recolhidos para os seguintes fins e utilizando os seguintes serviços:</p>
            <h3>Comentário de conteúdo</h3>
            <p>Os serviços de comentário de conteúdo permitem o usuário a criar e publicar comentários sobre o  conteúdo deste serviço (este aplicativo). Dependendo das configurações escolhidas pelo  proprietário, os usuários podem também deixar comentários anônimos. Se houver um endereço de  e-mail entre os dados pessoais fornecidos pelo usuário, poderá ser usado para enviar  notificações de comentários sobre o mesmo conteúdo. Os usuários são responsáveis pelo conteúdo  de seus comentários. Se um serviço de comentário de conteúdo prestado por terceiros esteja  instalado, este ainda poderá coletar dados de tráfego da Web para as páginas onde o serviço de  comentário esteja instalado, mesmo quando os usuários não usam o serviço de conteúdo de  comentário.</p>
            <h3>Sistema de Comentário gerido diretamente (este aplicativo)</h3>
            <p>Este aplicativo tem seu próprio sistema de comentários de conteúdo interno. Dados pessoais  coletados: e-mail, nome e sobrenome.</p>
            <h3>Interação com redes sociais e plataformas externas</h3>
            <p>Esses tipos de serviços permitem a interação com as redes sociais ou outras plataformas externas  diretamente a partir das páginas deste serviço (este aplicativo). A interação e as informações  obtidas por este aplicativo estão sempre sujeitas às configurações de privacidade do usuário em  cada rede social. Se um serviço que permite a interação com as redes sociais estiver instalado  poderá coletar dados de tráfego para as páginas, onde o serviço esteja instalado, mesmo quando  os usuários não estiverem usando os mesmos.</p>
            <h4>O botão Curtir e widgets sociais do Facebook (Facebook, Inc.)</h4>
            <p>O botão Curtir do Facebook e widgets sociais são serviços que permitem a interação com a rede  social Facebook fornecido pela Facebook, Inc.</p>
            <p>Dados pessoais coletados: cookie e dados de uso. Local de processamento: EUA – Política de  Privacidade.</p>
            <h3>Contatar o usuário</h3>  <h4>Lista de endereçamento ou boletim informativo (este aplicativo)</h4>
            <p>Ao registar-se na lista de endereçamento ou no boletim informativo, o endereço de e-mail do  usuário será adicionado à lista de contatos daqueles que podem receber mensagens de e-mail que  contenham informações de natureza comercial ou promocional sobre este Aplicativo. O seu endereço  de e-mail também poderá ser adicionado a esta lista, como resultado de sua inscrição neste  serviço (este aplicativo).</p>
            <p>Dados pessoais coletados: e-mail.</p>
            <h4>Formulário de contato (este aplicativo)</h4>
            <p>Ao preencher o formulário de contato com os seus dados, os usuários autorizam este aplicativo a  usar esses detalhes para responder aos pedidos de informações, cotação ou qualquer outro tipo de  pedido como indicado pelo título do formulário.</p>
            <p>Dados pessoais coletados: e-mail, nome e sobrenome.</p>
            <h2>Informações adicionais sobre a coleta e processamento de dados</h2>
            <h3>Ação jurídica</h3>
            <p>Os dados pessoais dos usuários podem ser utilizados para fins jurídicos pelo controlador de dados  em juízo ou nas etapas conducentes à possível ação jurídica decorrente de uso indevido deste  serviço (este aplicativo) ou dos serviços relacionados.</p>
            <p>O usuário declara estar ciente de que o controlador dos dados poderá ser obrigado a revelar os  dados pessoais mediante solicitação das autoridades governamentais.</p>
            <h3>Informações adicionais sobre os dados pessoais do usuário</h3>
            <p>Além das informações contidas nesta política de privacidade, este aplicativo poderá fornecer ao  usuário informações adicionais e contextuais sobre os serviços específicos ou a coleta e  processamento de dados pessoais mediante solicitação.</p>
            <h3>Logs do sistema e manutenção</h3>
            <p>Para fins de operação e manutenção, este aplicativo e quaisquer serviços de terceiros poderão  coletar arquivos que gravam a interação com este aplicativo (logs do sistema) ou usar, para este  fim, outros dados Pessoais (tais como o endereço IP).</p>
            <h3>As informações não contidas nesta política</h3>
            <p>Mais detalhes sobre a coleta ou processamento de dados pessoais podem ser solicitados ao  controlador de dados, a qualquer momento. Favor ver as informações de contato no início deste  documento.</p>
            <h3>Os direitos dos usuários</h3>
            <p>Os usuários têm o direito de, a qualquer tempo, consultar o controlador de dados para saber se os  seus dados pessoais foram armazenados e saber mais sobre o conteúdo e origem, verificar a sua  exatidão ou para pedir que sejam complementados, cancelados, atualizados ou corrigidos, ou que  sejam transformados em formato anônimo ou bloquear quaisquer dados mantidos em violação da lei,  bem como se opor ao seu tratamento por quaisquer todas as razões legítimas. Os pedidos devem ser  enviados para o controlador de dados usando a informação de contato fornecida anteriormente.</p>
            <p>Este aplicativo não suporta pedidos de "Não me rastreie".</p>
            <p>Para determinar se qualquer um dos serviços de terceiros que utiliza honram solicitações de "Não  me rastreie", por favor leia as políticas de privacidade.</p>
            <h3>Mudanças nesta política de privacidade</h3>
            <p>O controlador de dados se reserva o direito de fazer alterações nesta política de privacidade a  qualquer momento, mediante comunicação aos seus usuários nesta página. É altamente recomendável  que esta página seja consultada várias vezes em relação à última modificação descrita na parte  inferior. Se o Usuário não concorda com qualquer das alterações da política de privacidade, o  usuário deve cessar o uso deste serviço (este aplicativo) e pode solicitar ao controlador de  dados que apague os dados pessoais dele. Salvo disposição em contrário, a atual política de  privacidade se aplica a todos os dados pessoais dos usuários que o controlador de dados  tiver.</p>
            <h3>Definições e referências jurídicas</h3>
            <h3>Dados pessoais (ou dados)</h3>
            <p>Quaisquer informações relativas a uma pessoa física, pessoa jurídica, instituição ou associação,  as quais sejam, ou possam ser identificadas, mesmo que indiretamente, por referência a quaisquer  outras informações, incluindo um número de identificação pessoal.</p>
            <h3>Dados de uso</h3>
            <p>As informações coletadas automaticamente a partir deste serviço (ou serviços de terceiros  contratados neste serviço (este aplicativo), que podem incluir: os endereços IP ou nomes de  domínio dos computadores utilizados pelos usuários que utilizam este aplicativo, os endereços  URI (Identificador Uniforme de Recurso), a data e hora do pedido, o método utilizado para  submeter o pedido ao servidor, o tamanho do arquivo recebido em resposta, o código numérico que  indica o status do servidor de resposta (resultado positivo, erro , etc.), o país de origem, as  características do navegador e do sistema operacional utilizado pelo usuário, os vários detalhes  de tempo por visita (por exemplo, o tempo gasto em cada página dentro do aplicativo) e os  detalhes sobre o caminho seguido dentro da aplicação, com especial referência à sequência de  páginas visitadas e outros parâmetros sobre o sistema operacional do dispositivo e/ou ambiente  de TI do Usuário.</p>
            <h3>Usuário</h3>
            <p>A pessoa que usa este aplicativo que deverá coincidir com ou estar autorizada pelo titular dos  dados a quem os dados pessoais se referem.</p>
            <h3>Titular dos dados</h3>
            <p>A pessoa jurídica ou física a quem os dados pessoais se referem.</p>
            <h3>Processador de dados (ou supervisor de dados)</h3>
            <p>A pessoa física, pessoa jurídica, a administração pública ou qualquer outro órgão, associação ou  organização autorizada pelo controlador de dados para o processamento dos dados pessoais em  conformidade com esta política de privacidade.</p>
            <h3>Controlador de dados (ou proprietário)</h3>
            <p>A pessoa física, pessoa jurídica, administração pública ou qualquer outra entidade, associação ou  organização com direitos, também em conjunto com outro controlador dos dados, para tomar  decisões sobre as finalidades e os métodos de processamento de dados pessoais e os meios  utilizados, incluindo medidas de segurança relativas ao funcionamento e ao uso deste serviço. O  controlador de dados, a menos que seja especificado de outra forma, é o proprietário deste  serviço (este aplicativo).</p>
            <h3>Este aplicativo</h3>
            <p>A ferramenta de hardware ou software pela qual os dados pessoais do usuário são coletados.</p>
            <h3>Cookie</h3>
            <p>Pequenas unidades de dados armazenados no dispositivo do usuário.</p>
            <h2>Informação jurídica</h2>
            <p>Aviso aos usuários europeus: esta declaração de privacidade foi elaborada em cumprimento das  obrigações nos termos do art. n.10 da Diretiva 95/46/CE, e de acordo com as disposições da  Diretiva 2002/58/CE, tal como revisto pela Diretiva 2009/136/CE, sobre o assunto de Cookies.</p>
            <p>Esta política de privacidade é apenas sobre este Aplicativo.</p><br><br>
            <p><b>Última atualização:</b> 13 de março de 2017</p>
            </body>
            </html>
          """))));
  }
}
