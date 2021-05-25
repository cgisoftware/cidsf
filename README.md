# CGI Design System for Flutter

CGI Design System for flutter.

## Sobre o projeto

_"O projeto veio para trazer um conforto a todos os desenvolvedores com casos onde o desenvolvimento se repete constantemente, como em casos de tabelas de CRUD, campos customizados de data, entre outros..."._

<br>

## Instalação

- Adicione o `cids_cgi: 2.0.1` no `pubspec.yaml` do seu aplicativo.
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
<br>

## Permissões
<br>

### Android
```xml
<!-- Arquivo AndroidManifest.xml -->
<uses-permission android:name="android.permission.USE_FINGERPRINT"/>
```
<br>

### iOS
```xml
<key>NSFaceIDUsageDescription</key>
<string>Por que vai usar a autenticação?</string>
```

<br>
<br>

No arquivo main.dart adicione:
```dart
//main.dart
var defaultPage;

BuildContext biometricsContext;
final biometricsHandler = BiometricsHandler(
  autenticacaoPage: () {
    Navigator.of(biometricsContext).pushNamed('/auth');
  }, 
  homePage: () {
    Navigator.of(biometricsContext)
      .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  } 
);

void main() async {
  biometricsHandler.listen();
  biometricsHandler();
}

//No build do main.dart, adicionar o home e a geração de rotas.
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: defaultPage,
      onGenerateRoute: r.Router.generateRoute
    );
  }

```
<br>
Crie um arquivo na raiz da pasta lib com o nome page.dart

```dart
//page.dart
final biometricsPage = BiometricsErrorPage(
  biometricsHandler: biometricsHandler,
  context: (context) {
    biometricsContext = context;
  }
);

final homePage = HomePage(
  context: (context) {
    biometricsContext = context;
  }
);

// Se o login por CNPJ estiver como True no firebase crie essa rota:
final loginPage = LoginCnpj(
  context: (context) {
    biometricsContext = context;
  },
);

final authPage = AuthPage(
  dropDb: () async {
    //manupula os dados salvos
  },
  frase: 'Todos os indicadores da sua empresa',
  imagePath: "images/index.jpg",
);
```
<br>
Crie um arquivo na raiz da pasta lib com o nome constants.dart 
<br>
Arquivo para adicionar as strings das rotas do aplicativo

```dart
//constants.dart
const String homeRoute = '/home';
const String authRoute = '/auth';
const String indexRoute = '/index';

// Se o login por CNPJ estiver como True no firebase crie essa rota:
const String loginRoute = '/login_cnpj';
```
<br>
Crie um arquivo na raiz da pasta lib com o nome routes.dart importando as telas do arquivo page.dart

```dart
//routes.dart
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authRoute:
        return SlideRightRoute(widget: biometricsPage);

      case homeRoute:
        return SlideRightRoute(widget: homePage);

// Se o login por CNPJ estiver como True no firebase crie essa rota:
      case loginRoute:
        return SlideRightRoute(widget: loginPage);

      case indexRoute: 
        return SlideRightRoute(widget: authPage);

      default:
        return SlideRightRoute(widget: authPage);
    }
  }
}
```
<br>
No arquivo da tela principal do aplicativo, geralmente a tela Home, adicione algumas configurações extras para buscar o contexto

```dart
//home.dart sua padina de home do aplicativo
class HomePage extends StatefulWidget { //TORNE A HOME UM STATEFULL WIDGET!!!!
  @override
  _HomePageState createState() => _HomePageState();

  //CRIE UMA FUNCTION QUE SERA CHAMADA AO CARREGAR A TELA PASSANDO O CONTEXT!!!!
  final Function(BuildContext) context; 
  const HomePage({Key key, @required this.context}) : super(key: key);
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    //LEMBRE-SE DE PASSAR O CONTEXT AO CRIAR A TELA, SEM ISSO A BIOMETRIA NUNCA IRÁ FNUNCIONAR CORRETAMENTE!!!!
    widget.context(context);
  }
}
```
<br>
Por ultimo e o mais importante, altere o arquivo MainActivity.kt na pasta android do projeto. Necessário para funcionamento no android

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}
```

<br>
<br>
<br>

## QRScan

## Permissões
<br>

### Android
```xml
<!-- Arquivo AndroidManifest.xml -->
<uses-permission android:name="android.permission.CAMERA" />
```
<br>

### iOS
```xml
<key>NSCameraUsageDescription</key>
<string>Your Description</string>

<key>io.flutter.embedded_views_preview</key>
<string>YES</string>
```

<br>
<br>

```dart
//QRScanType.bar   BARCODE
//QRScanType.code  QRCODE
String response = await QRScan().startScan(context, QRScanType.bar);
print(response);
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


handler.setNomeAplicativo("nome app");        // seta o nome do app para aparecer no gateway
handler.setPasswordFirebase("senha");         // seta a senha default do FIREBASE
handler.setVersaoProgramaPacific(1);          // seta a versão do programa .r
handler.setGateway(false);                    // seta se utiliza ou não o gateway

handler.permiteAlterarQuantidadeEscaneada();  // busca se permite alterar a quantidade do mais estoque
handler.getVersaoProgramaPacific();           // busca a versão do programa .r
handler.getNumDevicesVendedor();              // busca o numero de devices
handler.getPasswordFirebase();                // busca a senha default do login no FIREBASE
handler.getNomeAplicativo();                  // busca o nome do app configurado
handler.getVersaoMinima();                    // busca a versão minima do firebase
handler.getBuildVersion();                    // busca a versão de build do app
handler.getNumDevices();                      // busca o numero de dispositivos liberados
handler.getMotorista();                       // busca o motorista nas configs
handler.getGateway();                         // busca se utiliza o gateway
handler.getUsuario();                         // busca o usuario
handler.getCodigo();                          // busca o codigo da empresa
handler.getLogin();                           // busca se o login é por CNPJ
handler.getSenha();                           // busca a senha
handler.getPlaca();                           // busca a placa configurada
handler.getToken();                           // busca o token de sessão do gateway
handler.getURL();                             // busca a url do pacific

handler.logout();                             // limpa os dados de login
handler.isAuth();                             // verifica se está logado;
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
