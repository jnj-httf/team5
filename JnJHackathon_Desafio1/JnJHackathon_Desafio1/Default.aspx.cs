using JnJHackathon_Desafio1.Models;
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

       RequestResult RequestResult;

        protected void Page_Load(object sender, EventArgs e)
        {
            //HttpClient httpClient = new HttpClient();
            int pageCount = 0;
            using (WebClient webClient = new WebClient()) {
                string webRequestResult = webClient.DownloadString("https://api-ldc-hackathon.herokuapp.com/api/ubs/" + pageCount);

                var ubsJson = JsonConvert.DeserializeObject<RequestResult>(webRequestResult);
                UBSGridView.DataSource = ubsJson;

                //ResquestRequest.DataSource = RequestResult;
            }


        }
    }
}