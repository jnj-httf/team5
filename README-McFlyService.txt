Depois da surpresa causada pelo uso do Powershell para resolver a l�gica,
resolvi gastar uma horinha para concluir uma prova de conceito de servidor Web baseado
baseado no trabalho de CosmosKey (https://github.com/CosmosKey/PSIS) entregando os
endpoints desenvolvidos durante o Hackaton.
Usei apenas as l�gicas anteriores e as integrei-as em um script unico para poder reutilizar a base de
dados lida em mem�ria, sem ter que ler o JSON completo novamente am cada request.
Um detalhe � que o PSIS como padrao atende ate 4 requests simultaneos e cada um desse roda em uma sessao separada,
isse permite uma implementa��o mais simples sem preocupa��o com concorrencia no acesso da cole��o de dados.
� poss�vel compartilhar a cole��o entre as sessoes, por�m seria necess�rio um cuidado especial na concorr�ncia.

De qualquer forma, meu int�ito com isso � mostrar a solu��o que pode ser vi�vel para um prot�tipo r�pido para
efeito de testes, sendo poss�vel criar um endpoint ou um consumidor r�pidamente para validar uma outra solu��o

Paulo Camargo

"Experiencia lhe d� agilidade e precis�o, mas o conhecimento lhe d� versatilidade" grigt