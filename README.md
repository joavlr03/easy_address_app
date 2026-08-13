Easy Address App

Aplicação Flutter para cadastro, consulta, edição e exclusão de endereços, integrada a uma API REST.

📋 Sobre o projeto

O Easy Address App é uma aplicação desenvolvida em Flutter com o objetivo de facilitar o gerenciamento de endereços.

A aplicação permite:

📍 Listar endereços cadastrados
➕ Cadastrar novos endereços
✏️ Editar endereços existentes
🗑️ Excluir endereços
🔎 Buscar endereço por CEP
🌐 Consumir uma API REST para persistência dos dados
🛠️ Tecnologias utilizadas
Flutter
Dart
HTTP para comunicação com a API REST
JSON para troca de dados
Heroku como hospedagem da API

````
📁 Estrutura do projeto
easy_address_app/
├── lib/
│   ├── models/
│   │   └── address.dart
│   │
│   ├── screens/
│   │   ├── address_list_screen.dart
│   │   └── address_form_screen.dart
│   │
│   ├── services/
│   │   └── address_service.dart
│   │
│   └── main.dart
│
├── test/
├── pubspec.yaml
└── README.md

````

🚀 Como executar
Pré-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

Flutter SDK
Dart SDK
Chrome, Edge ou Windows para execução
Git

Verifique a instalação do Flutter:

flutter doctor

Instalação

Clone o projeto:

git clone <URL_DO_REPOSITORIO>


Entre na pasta:

cd easy_address_app


Instale as dependências:

flutter pub get

Executando a aplicação

Para executar no Chrome:

flutter run -d chrome


Para executar no Windows:

flutter run -d windows


Para verificar os dispositivos disponíveis:

flutter devices

🌐 API

A aplicação utiliza uma API REST para gerenciamento dos endereços.

URL base:

https://easy-address-app-15d989ca7c47.herokuapp.com

Endpoints utilizados
Método	Endpoint	Descrição
GET	/addresses	Lista todos os endereços
GET	/addresses/:id	Busca um endereço pelo ID
POST	/addresses	Cria um novo endereço
PUT	/addresses/:id	Atualiza um endereço
DELETE	/addresses/:id	Exclui um endereço
GET	/cep/:zipCode	Consulta endereço pelo CEP
🧩 AddressService

A comunicação com a API está centralizada no arquivo:

lib/services/address_service.dart


O serviço disponibiliza os seguintes métodos:

getAddresses()
getAddressById(int id)
createAddress(Address address)
updateAddress(int id, Address address)
deleteAddress(int id)
getAddressByZipCode(String zipCode)


Essa separação permite que as telas fiquem responsáveis principalmente pela interface e interação com o usuário, enquanto o AddressService concentra a comunicação HTTP.

📦 Modelo de endereço

O modelo utilizado pela aplicação está localizado em:

lib/models/address.dart


Entre os campos utilizados estão:

Nome do usuário
CEP
Logradouro
Bairro
Cidade
Estado
Tipo de endereço
🔄 Fluxo da aplicação
Usuário
   │
   ▼
Tela Flutter
   │
   ▼
AddressService
   │
   ▼
API REST
   │
   ▼
Banco de dados


Para uma consulta de CEP:

Usuário informa CEP
        │
        ▼
AddressFormScreen
        │
        ▼
AddressService
        │
        ▼
API /cep/:zipCode
        │
        ▼
Dados do endereço
        │
        ▼
Formulário preenchido

🧪 Verificação do projeto

Para analisar problemas no projeto, utilize:

flutter analyze


Para executar os testes:

flutter test


Para verificar dependências desatualizadas:

flutter pub outdated


Para limpar arquivos gerados pelo Flutter:

flutter clean


Depois reinstale as dependências:

flutter pub get

⚠️ Solução de problemas
address_service.dart não encontrado

Se aparecer:

Error when reading 'lib/services/address_service.dart':
The system cannot find the path specified


verifique se o arquivo existe exatamente neste caminho:

lib/services/address_service.dart

##Telas

#Tela Inicial 

<img width="494" height="687" alt="Screenshot 2026-08-13 201602" src="https://github.com/user-attachments/assets/1a102323-191f-41eb-87a3-23cc64d1ce77" />

###Tela de endereço

<img width="503" height="662" alt="Screenshot 2026-08-13 201612" src="https://github.com/user-attachments/assets/4494e7a4-72fa-4fe0-a918-b648bf4fd4c3" />

###Tela de exclusão

<img width="501" height="632" alt="Screenshot 2026-08-13 201619" src="https://github.com/user-attachments/assets/2ca46ba0-40de-4981-b7c3-6ed1040b623d" />



Dependências com versões mais recentes

O comando:

flutter pub get


pode informar que existem versões mais recentes de algumas dependências.

Isso não significa necessariamente que o projeto está com erro. Para analisar as versões disponíveis:

flutter pub outdated

🔐 Observações

A URL da API está atualmente definida diretamente no AddressService:

static const String baseUrl =
    'https://easy-address-app-15d989ca7c47.herokuapp.com';


Para ambientes de desenvolvimento, homologação e produção, recomenda-se futuramente utilizar configuração por ambiente para facilitar a troca da API.

📌 Próximos passos

Algumas melhorias que podem ser implementadas:

 Adicionar validação dos campos do formulário
 Melhorar tratamento de erros da API
 Adicionar indicador de carregamento
 Adicionar confirmação antes da exclusão
 Criar testes unitários para AddressService
 Criar testes de widget para as telas
 Adicionar paginação à lista de endereços
 Utilizar variáveis de ambiente para a URL da API
 Melhorar responsividade para diferentes tamanhos de tela
 Adicionar autenticação, caso necessária

 
👨‍💻 Desenvolvimento

O projeto foi desenvolvido utilizando Flutter e segue uma separação básica entre:

Models — representação dos dados
Screens — interface e interação com o usuário
Services — comunicação com serviços externos/API

Essa organização facilita a manutenção e evolução da aplicação.

📄 Licença

Este projeto pode ser utilizado e modificado de acordo com a licença definida pelo responsável pelo repositório.
