const express = require('express');
const app = express();         
const bodyParser = require('body-parser');
const port = 3000; //porta padrão
const sql = require('mssql');
const connStr = "Server=XXX;Database=XXX;User Id=XXX;Password=XXX;";