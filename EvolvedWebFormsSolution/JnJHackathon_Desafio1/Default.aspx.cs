using JnJHackathon_Desafio1.Models;
using JnJHackathon_Desafio1.Services;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JnJHackathon_Desafio1
{
    public partial class _Default : Page
    {
        UbsService _ubsService; 

        public _Default() //TODO melhoria: Injetar os serviços (IoC, DI)
        {
            _ubsService = new UbsService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var ubsCollection = _ubsService.ListarTodasUBSs();
        }
    }
}