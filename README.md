# parking_manager

Uma solução prática e simples para auxiliar no gerenciamento do seu estacionamento através de um aplicativo híbrido desenvolvido em Flutter que entrega soluções simples e práticas, porém bastante eficientes.

## Observação

- O projeto foi desenvolvido utilizando a versão 3.16.0 do Flutter e 3.2.0 do Dart.

## Instruções para executar o projeto

### Certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

- Flutter SDK
- Dart SDK
- IDE Flutter (recomendado: VS Code)

1. **Clone o Repositório:**

   ```
   git clone https://github.com/ericarodrigs/parking-manager.git
   ```

2. **Navegue até o Diretório do Projeto:**
    ```
    cd parking-manager
    ```
3. **Instale as Dependências**
    ```
    flutter pub get
    ```
4. **Execute o Projeto**

    ```
    flutter run
    ```

## Funcionalidades da aplicação

### Homepage

- Ao entrar na aplicação, caímos na tela inicial, onde é mostrado um grid com todas as vagas disponíveis e podemos ter uma identificação visual para diferenciar as vagas livres e ocupadas.

### Register

- Se na homepage o usuário clicar em uma vaga que está livre, será redirecionado para tela de registro, onde vai ter um formulário que deve ser preenchido com as informações do veículo que está fazendo checkin.
- Na tela de registro temos algumas validações de campos obrigatórios e também de regra de negócio, contamos também com uma máscara para formatar e padronizar as placas dos veículos. A máscara contida na aplicação abrange os dois modelos de placas vigentes no Brasil atualmente.
- Além disso, outro detalhe importante é que a data e hora de checkin do veículo foi setada para assumir a data e hora real do momento em que o usuário está realizando esse cadastro, com o objetivo de facilitar a usabilidade da aplicação.

### Edit

- Se na homepage o usuário clicar em uma vaga que já está ocupada, será redirecionado para tela de edição, onde vai poder modificar algum campo que tenha preenchido errado ou também informar o horário de saída de um veículo.
- Nessa tela existe uma regra que valida que o checkout deve ser posterior ao checkin.

### History

- Exibe o histórico de fechamentos que ocorreu em determinado dia. Inicialmente traz as informações do dia atual, mas entrega a possibilidade do usuário poder selecionar um dia específico para trazer esse balanço.
- Além de relacionar e calcular o valor individual de cada veículo que foi fechado em um determinado dia, também é exibido o valor total apurado nesse dia.


## Principais bibliotecas utilizadas

get_it - injetor de dependências
go_router - navegação do app
flutter_bloc - gerenciamento de estados da aplicação 
freezed_annotation - gerador de códigos
sqflite - armazenamento local


## Próximas features

- Habilitar darkTheme;
- Aplicar internacionalização;
- Adicionar autenticação com Firebase authentication;
- Possibilitar gerenciamento de configuração de valor, quantidade de vagas;
- Possibilitar cadastro de diferentes tipos de veículos, permitindo valores diferentes para cada tipo;
- Vincular aplicação com o Firebase firestore para salvar as informações também de forma remota;
- Adicionar testes de widget/integração;
- Paginação de lista na tela de histórico.


## Vídeo do app

![Parking Manager](https://github.com/ericarodrigs/parking-manager/blob/main/parking_manager.mp4)
