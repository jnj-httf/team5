using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace JnJHackathon_Desafio1.Models
{
    public class UBS
    {
        [Key]
        public Guid id { get; set; }

        public string co_cep { get; set; }
        public string vlr_latitude { get; set; }
        public string vlr_longitude { get; set; }
        public string cod_munic { get; set; }
        public string cod_cnes { get; set; }
        public string nom_estab { get; set; }
        public string dsc_endereco { get; set; }
        public string dsc_bairro { get; set; }
        public string dsc_cidade { get; set; }
        public string dsc_telefone { get; set; }
        public string dsc_estrut_fisic_ambiencia { get; set; }
        public string dsc_adap_defic_fisic_idosos { get; set; }
        public string dsc_equipamentos { get; set; }
        public string dsc_medicamentos { get; set; }
    }
}