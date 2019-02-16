using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using JnJHackathon_Desafio1.Models;
using Newtonsoft.Json;

namespace JnJHackathon_Desafio1.Repository
{
    public class UbsRepository
    {
        //TODO: Melhoria: Injetores (IoC/DI) e UnitOfWork quando/se surgir mais repositórios
        private JnJHackathonDbContext _context;

        public UbsRepository()
        {
            _context = new JnJHackathonDbContext();
        }

        internal UBS BuscarUbsMaisProximaPorLatitudeLongitude(double latitude, double longitude)
        {
            CarregarListaUbsNoDbSeEstiverVazia();
            throw new NotImplementedException();
        }

        internal IEnumerable<UBS> ListarTodasUBSs()
        {
            CarregarListaUbsNoDbSeEstiverVazia();
            return _context.UBSs.ToList();
        }

        /// <summary>
        /// Carrega todas as UBSs do webservice em banco caso a base esteja descarregada (Somente para análise da equipe do Hackathon pois, em condições normais, a carga seria executada via migration no Package Manager Console)
        /// </summary>
        private void CarregarListaUbsNoDbSeEstiverVazia()
        {
            if (_context.UBSs.Any())
                return;

            for (int i = 0; i < 1885; i++) 
            {
                //NOTA o for foi colocado fora intencionalmente para dar um pequeno delay
                //a web api estava dando timeout quando os requests eram feitos de forma direta (o código roda muito rápido e faz com que a api negue requests em determinado momento)
                using (WebClient webClient = new WebClient())
                {
                    string webRequestResult = webClient.DownloadString("https://api-ldc-hackathon.herokuapp.com/api/ubs/" + i);

                    var requestResult = JsonConvert.DeserializeObject<RequestResult>(webRequestResult);

                    foreach (var ubs in requestResult.records)
                    {
                        ubs.id = Guid.NewGuid();
                        _context.UBSs.Add(ubs);
                    }

                    //Houve um problema a usar uma chave composta de latitude e longitude (existem registros duplicados no dataSet e o banco nega o insert)
                    //Foi criado um id guid no modelo e foi necessário remover o AddRange e iterar sobre a collection para gerar a Guid dinamicamente devido ao code-first do entity
                    //UBSs.AddRange(requestResult.records);

                    _context.SaveChanges();
                }
            }
        }

    }
}