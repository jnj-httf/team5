using JnJHackathon_Desafio1.Models;
using JnJHackathon_Desafio1.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace JnJHackathon_Desafio1.Services
{
    public class UbsService
    {
        private UbsRepository _ubsRepository;

        public UbsService()//TODO: Melhoria: Incluir IoC/DI (injeção de dependência) 
        {
            _ubsRepository = new UbsRepository();

        }

        //TODO: Transpilar o método feito em PowerShell do Paulo para o service (corrigir os parâmetros se necessário)
        public UBS BuscarUBSMaisProxima(double latitude, double longitude)
        {
            throw new NotImplementedException(); //TODO remover após a transpilação da func
            return _ubsRepository.BuscarUbsMaisProximaPorLatitudeLongitude(latitude, longitude);
        }

        public IEnumerable<UBS> ListarTodasUBSs()
        {
            return _ubsRepository.ListarTodasUBSs();
        }
    }
}