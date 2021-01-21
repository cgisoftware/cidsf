# CGI Design System for Flutter

CGI Design System for flutter.

## Sobre o projeto

_"O projeto veio para trazer um conforto a todos os desenvolvedores com casos onde o desenvolvimento se repete constantemente, como em casos de tabelas de CRUD, campos customizados de data, entre outros..."._

<br>

## Instalação

- Adicione o `cids_cgi: 1.1.6` no `pubspec.yaml` do seu aplicativo.
- Adicione os arquivos do google firebase no Android e iOS.
- Rode `flutter pub get`

# Componens

## SettingsPage

Tela de configurações dos aplicativos

```dart
SettingsPage(
    motorista: false,
    placa: false,
    filled: false,
    cpf: false,
    appBarColor: Colors.transparent,
    appBarTextColor: Colors.white,
);
```

<br>

### - Props

| Propriedade     | Required? |  Type   |      Default value |
| :-------------- | :-------: | :-----: | -----------------: |
| motorista       |   false   | Boolean |              false |
| placa           |   false   | Boolean |              false |
| filled          |   false   | Boolean |              false |
| cpf             |   false   | Boolean |              false |
| appBarColor     |   false   |  Color  | Colors.transparent |
| appBarTextColor |   false   |  Color  | Colors.transparent |

<br>
<br>
<br>

## AuthPage

Tela de login dos aplicativos

<br>

Baixe e adicione essas imagens no folder \<projeto>/images/
<br>
<br>
consultors.png:

<img width="400px" src="https://webcrm.cgisoftware.com.br/static/consultors.png"/>

<br>

<br>
consultors_dark.png:
<br>
<img width="400px" src="https://webcrm.cgisoftware.com.br/static/dark.png"/>

<br>
<br>

```dart

//main.dart
String defaultRoute = indexRoute;

BuildContext biometricsContext;
final biometricsHandler = BiometricsHandler(autenticacaoPage: () {
  Navigator.of(biometricsContext).pushNamed('/auth');
}, homePage: () {
  Navigator.of(biometricsContext)
      .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
});

void main() async {
  biometricsHandler.listen();
  biometricsHandler();
}

//routes.dart
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authRoute:
        return SlideRightRoute(
          widget: BiometricsErrorPage(
              biometricsHandler: biometricsHandler,
              context: (context) {
                biometricsContext = context;
              }),
        );

      case homeRoute:
        return SlideRightRoute(
          widget: HomePage(context: (context) {
            biometricsContext = context;
          }),
        );

      default:
        return SlideRightRoute(
            widget: AuthPage(
          dropDb: () async {
            DatabaseHandler db = DatabaseHandler();
            await db.deleteDb();
          },
          frase: 'Todos os indicadores da sua empresa',
          imagePath: "images/index.jpg",
        ));
    }
  }
}

//constants.dart
const String homeRoute = '/home';
const String authRoute = '/auth';
const String indexRoute = '/';

//home.dart sua padina de home do aplicativo

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  final Function(BuildContext) context; // retorno o context quando carregar a tela sempre!!!
  const HomePage({Key key, @required this.context}) : super(key: key);
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    widget.context(context); //adicione isso no initState!!!
  }
}



```

<br>
<br>
<br>

# Handler

## SharedPreferences

```dart
final handler = SharedPreferencesHandler();

// busca, salva e remove qualquer informação
handler.set("chave", "valor");
handler.get("chave");
handler.remove("chave");
handler.clear(); // limpa toda e qualquer chave salva

handler.setNomeAplicativo("nome app");  // seta o nome do app para aparecer no gateway
handler.setPasswordFirebase("senha");   // seta a senha default do FIREBASE
handler.setVersaoProgramaPacific(1);    // seta a versão do programa .r
handler.setGateway(false);              // seta se utiliza ou não o gateway

handler.getVersaoProgramaPacific();     // busca a versão do programa .r
handler.getNumDevicesVendedor();        // busca o numero de devices
handler.getPasswordFirebase();          // busca a senha default do login no FIREBASE
handler.getNomeAplicativo();            // busca o nome do app configurado
handler.getVersaoMinima();              // busca a versão minima do firebase
handler.getBuildVersion();              // busca a versão de build do app
handler.getNumDevices();                // busca o numero de dispositivos liberados
handler.getMotorista();                 // busca o motorista nas configs
handler.getGateway();                   // busca se utiliza o gateway
handler.getUsuario();                   // busca o usuario
handler.getCodigo();                    // busca o codigo da empresa
handler.getSenha();                     // busca a senha
handler.getPlaca();                     // busca a placa configurada
handler.getToken();                     // busca o token de sessão do gateway
handler.getURL();                       // busca a url do pacific

handler.logout();                       // limpa os dados de login
handler.isAuth();                       // verifica se está logado;
```

<br>
<br>
<br>

## DialogHandler

```dart
final handler = DialogHandler();

// mostra um alert na tela com avisos
handler.show(message: "mensagem para mostrar pro usuário", context: context);

// mostra mensagem para confirmação
handler.confirm(message: "mensagem para mostrar pro usuário", context: context, textBtn1: "btn1", textBtn2: "btn2");
```

<br>
<br>
<br>

## CidsHandler

```dart
final handler = CidsHandler()

// faz load das configurações do json criado no projeto do firebase
// necessario usar no metodo main do arquivo main.dart
handler.initialize(
    gateway: true,
    aplicativo: "",
    senha: "",
    versaoPacific: 2
)
```

<br>
<br>
<br>

## ErrorHandler

```dart
try {
    Dio dio = new Dio();
    Response response = await dio.get("url");

    return response?.data ?? [];
} on DioError catch (error) {
    final handler = ErrorHandler(error.response.data)

    Retorno r = await handler.validaErro();
    throw r.mensagem;
} catch (e) {
    throw e.toString();
}
```
