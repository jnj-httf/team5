using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using JnJHackathon_Desafio1.Models;
using Newtonsoft.Json;

namespace JnJHackathon_Desafio1.Repository
{
    public class UbsRepository : JnJHackathonDbContext
    {
        //TODO: Melhoria: Injetores (IoC/DI) e UnitOfWork quando surgir mais repositórios

        internal UBS BuscarUbsMaisProximaPorLatitudeLongitude(double latitude, double longitude)
        {
            CarregarListaUbsNoDbSeEstiverVazia();
            throw new NotImplementedException();
        }

        internal IEnumerable<UBS> ListarTodasUBSs()
        {
            CarregarListaUbsNoDbSeEstiverVazia();
            return UBSs.ToList();
        }

        /// <summary>
        /// Carrega todas as UBSs do webservice em banco caso a base esteja descarregada (Somente para análise da equipe do Hackathon pois, em condições normais, a carga seria executada via migration no Package Manager Console)
        /// </summary>
        private void CarregarListaUbsNoDbSeEstiverVazia()
        {
            if (UBSs.Any())
                return;

            using (WebClient webClient = new WebClient())
            {
                for (int i = 0; i < 100; i++)
                {
                    string webRequestResult = webClient.DownloadString("https://api-ldc-hackathon.herokuapp.com/api/ubs/" + i);

                    var requestResult = JsonConvert.DeserializeObject<RequestResult>(webRequestResult);

                    UBSs.AddRange(requestResult.records);
                }

                SaveChanges();
            }
        }

    }
}