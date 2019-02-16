namespace JnJHackathon_Desafio1.Migrations
{
    using JnJHackathon_Desafio1.Models;
    using JnJHackathon_Desafio1.Repository;
    using Newtonsoft.Json;
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using System.Net;

    internal sealed class Configuration : DbMigrationsConfiguration<JnJHackathonDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(JnJHackathonDbContext context)
        {

        }

    }
}
