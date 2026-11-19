# Gerenciador de Personagens

Este repositório apresenta o sistema de gerenciamento de personagens desenvolvido para **Crônicas do Mundo Shinobi**, um jogo multiplayer criado utilizando BYOND e Dream Maker.

O módulo é responsável por controlar o ciclo de vida dos personagens, desde sua criação até o carregamento e salvamento dos dados.

Entre suas funcionalidades estão o gerenciamento de atributos, progressão, habilidades, aparência, localização e inventário.

O projeto faz parte do desenvolvimento de Crônicas do Mundo Shinobi e demonstra a implementação prática de sistemas de gerenciamento e persistência de dados em Dream Maker.

## Funcionalidades

### Criação de personagens
- Escolha do nome, clã e vila.
- Definição da localização inicial.
- Inicialização do personagem no mundo.

## Tecnologias utilizadas

- **BYOND:** plataforma utilizada para desenvolvimento do jogo.
- **Dream Maker (DM):** linguagem e ambiente de programação utilizados na implementação dos sistemas.
- **Git:** controle de versões do projeto.
- **GitHub:** hospedagem e documentação do código-fonte.
- 
## Estrutura dos arquivos

| Arquivo | Responsabilidade |
|---|---|
| `Login.dm` | Inicialização do cliente, menu de entrada e gerenciamento das opções de personagem. |
| `LoadYSave(Character).dm` | Criação, carregamento e salvamento dos personagens, incluindo atributos, habilidades e inventário. |
