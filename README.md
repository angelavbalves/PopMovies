<h1 align="center">
  <img src="https://user-images.githubusercontent.com/101536863/209855203-5f46c51d-7198-45c6-8827-aa1e9754b562.png" width="350">
</h1>
<p align="center">
  

<hr>

O PopMovies foi construído utilizando a API do TheMovies DB (https://www.themoviedb.org/).
Dentre as funcionalidades do APP temos:
   * Listagem de filmes populares
   * Listagem de filmes favoritos
   * Listagem de filmes por gênero
   * Tela de detalhes do filme selecionado e listagem de filmes similares a ele
   * Dark-Mode
   * Filtro de filme por título
<hr>

### 📌 Versão
Essa aplicação foi desenvolvida com Swift 5.5.2 no Xcode 13.2.1 e o iOS mínimo é o 15.2 - utilizei de versões mais antigas das ferramentas, pois minha máquina não é capaz de dar suporte as mais atualizadas.
<hr>

### 🛠️ Construído com
* Para a construção do layout empreguei ViewCode e o Tiny Constraints para auxílio;
* Para realizar o download das imagens e manter um placeholder utilizei o KingFisher;
* Para persistência dos filmes favoritos fiz uso do CoreData;
* Desenvolvi, para as rotas da aplicação, coordinators responsáveis por administrar o fluxo de telas;
* Para esse projeto, optei pela arquitetura MVVM;
* Escrevi testes unitários para as funções do CoreData por meio de um Container Mock;
* Há também testes unitários para camada de Service, garantindo inclusive a coerência  da model;
* Utilizei de métodos genéricos em meu Service, para ter a flexibilidade de utilizar o mesmo método para diversas requisições;
* Ademais, apliquei conceitos como: injeção de dependência, componentes, protocolos e paginação
<hr>

### 🔧 Instalação

Primeiramente, buscar a URL do projeto aqui no GitHub:

<img width="400" src="https://user-images.githubusercontent.com/101536863/209856799-984a7036-5032-4701-89ea-707bccf82c14.png">

O segundo passo é abrir um terminal na pasta que deseja salvar o projeto e realizar um git clone:
    
    git clone https://github.com/angelavbalves/PopMovies.git
    
Após esse passo, abrir o projeto no Xcode e realizar a build.
<hr>

### 🎥 Demonstração
<video src="https://user-images.githubusercontent.com/101536863/211392948-a9c1a509-4312-4034-ad95-804d2522cb20.mp4">






