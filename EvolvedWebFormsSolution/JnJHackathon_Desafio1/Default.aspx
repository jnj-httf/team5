<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="JnJHackathon_Desafio1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   

<asp:gridview 
  id="ubsGridView" 
  autogeneratecolumns="False"
  emptydatatext="No data available." 
  allowpaging="True" 
  runat="server" DataKeyNames="co_cep"
    >
    <Columns>
        <asp:BoundField DataField="dsc_cidade" HeaderText="Cidade" 
            InsertVisible="False" ReadOnly="True" SortExpression="dsc_cidade" />
        <%--<asp:BoundField DataField="CompanyName" HeaderText="CompanyName" 
            SortExpression="CompanyName" />
        <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
            SortExpression="FirstName" />
        <asp:BoundField DataField="LastName" HeaderText="LastName" 
            SortExpression="LastName" />--%>
    </Columns>
   
</asp:gridview>

</asp:Content>
