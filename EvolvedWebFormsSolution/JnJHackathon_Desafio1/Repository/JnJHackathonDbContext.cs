using JnJHackathon_Desafio1.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace JnJHackathon_Desafio1.Repository
{
    public class JnJHackathonDbContext : DbContext
    {
        public DbSet<UBS> UBSs { get; set; }
    }
}