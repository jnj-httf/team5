namespace JnJHackathon_Desafio1.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Init_Create_Table_Ubs : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.UBS",
                c => new
                    {
                        id = c.Guid(nullable: false),
                        co_cep = c.String(),
                        vlr_latitude = c.String(),
                        vlr_longitude = c.String(),
                        cod_munic = c.String(),
                        cod_cnes = c.String(),
                        nom_estab = c.String(),
                        dsc_endereco = c.String(),
                        dsc_bairro = c.String(),
                        dsc_cidade = c.String(),
                        dsc_telefone = c.String(),
                        dsc_estrut_fisic_ambiencia = c.String(),
                        dsc_adap_defic_fisic_idosos = c.String(),
                        dsc_equipamentos = c.String(),
                        dsc_medicamentos = c.String(),
                    })
                .PrimaryKey(t => t.id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.UBS");
        }
    }
}
