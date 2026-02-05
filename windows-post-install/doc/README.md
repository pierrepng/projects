## Documentação do Projeto

Aqui será onde eu irei disponibilizar a documentação simples do projeto. 📖

## Documentação
Aqui irá conter os detalhes e updates do projeto.

## **v0.1** - Windows Update Funcional 
## **Aviso** ⚠️ Execute sempre como Administrador. O script realiza alterações no sistema.

1. O que é este projeto:
   Automatiza tarefas comuns após a formatação do Windows usando PowerShell.

2. Qual problema ele resolve:
   Após formatar o Windows, tarefas como atualização do sistema, drivers e instalação de programas são repetitivas e demoradas.
   Este projeto visa padronizar e automatizar esse processo.

3. O que ele faz:
   3.1. Atualiza o Windows automaticamente.
   3.2. Detecta se é necessário reiniciar.
   3.4. Executa com privilégios administrativos.
   4.5. Fornece menu interativo.

4. Como usar:
   4.1. Mais importante é rodar o 'start.bat' como admin.
   4.2. Depois disso irá abrir um menu interativo.

5. Fluxo de execução
   5.1. Verifica se o script está sendo executado com permissões de administrador.
   5.2. Caso não esteja ele solicita elevação de permissão.
   5.3. O script verifica se o módulo PSWindowsUpdate está instalado.
   5.4. Faz a busca de atualizações disponíveis no sistema.
   5.5. Instala as atualizações.
   5.6. Verifica se é necessário reinicialização e se o usuário deseja reiniciar agora ou mais tarde.

6. Escolhas Técnicas
   6.1. Utilizei o PSWindowsUpdate por oferecer mais controle que o WindowsUpdate padrão.
   6.2. IgnoreReboot para que o sistema não reinicie inesperadamente.
   6.3. Menu interativo para facilitar o uso para todos.
---






