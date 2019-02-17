Depois da surpresa causada pelo uso do Powershell para resolver a lógica,
resolvi gastar uma horinha para concluir uma prova de conceito de servidor Web baseado
baseado no trabalho de CosmosKey (https://github.com/CosmosKey/PSIS) entregando os
endpoints desenvolvidos durante o Hackaton.
Usei apenas as lógicas anteriores e as integrei-as em um script unico para poder reutilizar a base de
dados lida em memória, sem ter que ler o JSON completo novamente am cada request.
Um detalhe é que o PSIS como padrao atende ate 4 requests simultaneos e cada um desse roda em uma sessao separada,
isse permite uma implementação mais simples sem preocupação com concorrencia no acesso da coleção de dados.
É possível compartilhar a coleção entre as sessoes, porém seria necessário um cuidado especial na concorrência.

De qualquer forma, meu intúito com isso é mostrar a solução que pode ser viável para um protótipo rápido para
efeito de testes, sendo possível criar um endpoint ou um consumidor rápidamente para validar uma outra solução

Paulo Camargo

"Experiencia lhe dá agilidade e precisão, mas o conhecimento lhe dá versatilidade" grigt