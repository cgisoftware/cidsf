# CGI Design System for Flutter

CGI Design System for flutter.

## Sobre o projeto

_"O projeto veio para trazer um conforto a todos os desenvolvedores com casos onde o desenvolvimento se repete constantemente, como em casos de tabelas de CRUD, campos customizados de data, entre outros..."._

<br>

## Instalação

- Adicione o `cids_cgi: 1.0.17` no `pubspec.yaml` do seu aplicativo.
- Adicione os arquivos do google firebase no Android e iOS.
- Rode `flutter pub get`

# Componens

## SettingsPage

```dart
SettingsPage(
    motorista: false,
    placa: false,
    filled: false,
    cpf: false,
    appBarColor: Colors.transparent,
    appBarTextColor: Colors.white,
    gateway: true,
    aplicativo: "nome do app",
    password: "password",
    versaoProgramaPacific: 1
);
```

<br>

### - Props

| Propriedade           | Required? |  Type   |      Default value |
| :-------------------- | :-------: | :-----: | -----------------: |
| motorista             |   false   | Boolean |              false |
| placa                 |   false   | Boolean |              false |
| filled                |   false   | Boolean |              false |
| cpf                   |   false   | Boolean |              false |
| appBarColor           |   false   |  Color  | Colors.transparent |
| appBarTextColor       |   false   |  Color  | Colors.transparent |
| gateway               |   false   | Boolean |              false |
| aplicativo            |   false   | String  |                 "" |
| password              |   true    | String  |               null |
| versaoProgramaPacific |   true    | Integer |               null |

<br>
<br>
<br>

# Handler

## SharedPreferences

```dart
final handler = SharedPreferencesHandler();

// busca e salva qualquer informação
handler.set("chave", "valor");
handler.get("chave");


handler.getVersaoProgramaPacific(); // busca a versão do programa .r
handler.getNumDevicesVendedor();    // busca o numero de devices
handler.getVersaoMinima();          // busca a versão minima do firebase
handler.getBuildVersion();          // busca a versão de build do app
handler.getNumDevices();            // busca o numero de dispositivos liberados
handler.getMotorista();             // busca o motorista nas configs
handler.getUsuario();               // busca o usuario
handler.getCodigo();                // busca o codigo da empresa
handler.getSenha();                 // busca a senha
handler.getPlaca();                 // busca a placa configurada
handler.getToken();                 // busca o token de sessão do gateway
handler.getURL();                   // busca a url do pacific
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

## FirebaseHandler

```dart
final handler = FirebaseHandler()

// faz load das configurações do json criado no projeto do firebase
// necessario usar no metodo main do arquivo main.dart
handler.initialize()
```