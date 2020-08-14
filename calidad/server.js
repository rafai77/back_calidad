const PORT = process.env.PORT || 3000;
const express = require("express");
const app = express();
const jwt=require('jsonwebtoken');
var session=  require('express-session');

app.use(express.json());
app.use(express.urlencoded({extended: true}));
const mysqlConnection = require('./base');

var moment = require('moment'); // require

const Excel = require('exceljs');

const fs = require('fs');
const tempfile = require('tempfile');
const { json } = require("express");


const cors = require('cors');

app.use(cors());
app.options('*', cors());

var token
var secret="1234abc"
var idu


// devuelve la informacion de alguna columna intervalos de fechsa
app.post('/infocolum', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
    {
      if(err)
      {
       
        res.sendStatus(403);
      }
      else
      {
        var c=req.body.c;
        var f1=req.body.f1+" 00:00:00";
        var f2=req.body.f2+" 23:59:59";
        var sql="select "+c+",fecha from totales11 where fecha BETWEEN '"+f1+"' and '"+f2+"'";
        console.log(sql);
        mysqlConnection.query(sql, function(error, results, fields) {
          console.log(results);
          res.json(
            {
            "campo":c,
            "datos":results,
          });
    });
  };
  });
});

//registro personalizado para 12
// registros con consultas personalisadas11
app.post('/datos12', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
     
      res.sendStatus(403);
    }
    else
    {
     
      mysqlConnection.query('select * from invernaderos where Nombre=?',[req.body.name], function(error, results, fields) {
        
        if (results.length>0) // quiere decir que se econtro un usuario
        {
          
          if(!results){
            res.json(results);          
        } else{
          let idi=results[0].id_inver;
          console.log(idi);
          var mydatei =req.body.fecha.toString().split(" ")
          var mydatef =req.body.fecha.toString().split(" ")
          mydatei=mydatei[0];
          mydatef=mydatef[0];
          mydatei+=" 00:00:00";
          mydatef+=" 23:59:59"
          console.log(mydatei);
          console.log(mydatef);
          mysqlConnection.query("select R.id_reg,U.user,I.Nombre,R.num_tunel,R.num_color3,R.num_color4,R.num_color5,R.tamchico,R.Brix1,R.Brix3,R.Brix1,R.Brix4,R.peso,R.pudricion,R.tallo,R.flojo,R.mecanico,R.blossom,R.reventado,R.cierre,R.deforme,R.cicatriz,R.insecto,R.color_disparejo,R.caliz,R.viruz,R.fecha,R.tiempo from registros12 R,usuarios U,invernaderos I where R.id_user=U.id_user and R.id_inve=I.id_inver and R.id_inve=? and fecha BETWEEN ? AND ?",[idi,mydatei,mydatef], function(error, results, fields) {
            if (results.length>0) // quiere decir que se econtro un usuario
        {
          console.log(results);
          if(!results){
            res.json(results);          
        } else
        {
          res.json(results);          
        }
      }
      else{
        res.json(
          {
            'Status':results.length
          }
          

        );
      }

          });
        }
        }
      });
      
    }

  });       
});

// registros con consultas personalisadas11
app.post('/datos', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
     
      res.sendStatus(403);
    }
    else
    {
     
      mysqlConnection.query('select * from invernaderos where Nombre=?',[req.body.name], function(error, results, fields) {
        
        if (results.length>0) // quiere decir que se econtro un usuario
        {
          
          if(!results){
            res.json(results);          
        } else{
          let idi=results[0].id_inver;
          console.log(idi);
          var mydatei =req.body.fecha.toString().split(" ")
          var mydatef =req.body.fecha.toString().split(" ")
          mydatei=mydatei[0];
          mydatef=mydatef[0];
          mydatei+=" 00:00:00";
          mydatef+=" 23:59:59"
          console.log(mydatei);
          console.log(mydatef);
          mysqlConnection.query("select R.id_reg,U.user,I.Nombre,R.num_tunel,R.num_color3,R.num_color4,R.num_color5,R.tamchico,R.Brix,R.Brix2,R.pudricion,R.tallo,R.flojo,R.mecanico,R.blossom,R.reventado,R.cierre,R.deforme,R.cicatriz,R.insecto,R.color_disparejo,R.caliz,R.viruz,DATE_FORMAT(R.fecha ,'%Y-%m-%d') as '\tFecha',R.tiempo from registros R,usuarios U,invernaderos I where R.id_user=U.id_user and R.id_inve=I.id_inver and R.id_inve=? and fecha BETWEEN ? AND ?",[idi,mydatei,mydatef], function(error, results, fields) {
            if (results.length>0) // quiere decir que se econtro un usuario
        {
          console.log(results);
          if(!results){
            res.json(results);          
        } else
        {
          res.json(results);          
        }
      }
      else{
        res.json(
          {
            'Status':results.length
          }
          

        );
      }

          });
        }
        }
      });
      
    }

  });       
});

//generar lalista de columnas recive el nombre de la tabla para sacar sus columnas 
app.get('/columns/:name', (req,res)=>{
  var datos;

  mysqlConnection.query("SELECT COLUMN_NAME FROM Information_Schema.Columns WHERE TABLE_NAME = ?",req.params.name, function(error, results, fields) {
     datos= (results);
     var colum=[];
     for (var i in datos)
       colum.push(datos[i]["COLUMN_NAME"]);
     res.json(colum);
  });
});

//genera el excell


app.post('/excel', (req,res)=>{
  const workbook = new Excel.Workbook();
  const worksheet = workbook.addWorksheet("Calidad");
  var datos=req.body.columnas;
  
  var columns=[];
  var aux={};

  for( i in datos)
  {  
    
      aux={header:datos[i].toString(), key:datos[i].toString() ,width:25}
      columns.push(aux);
  }
  
  console.log(columns);
 // res.send("f")

  worksheet.columns = columns;
  
  
    datos= req.body.row
    console.log(datos);
    for(var i in datos)
    { 
    worksheet.addRow(datos[i]);

    }
  
 


//save under export.xlsx
var tempFilePath = tempfile('.xlsx');
workbook.xlsx.writeFile(tempFilePath).then(function() {
  console.log('file is written');
  res.sendFile(tempFilePath, function(err){
      console.log('---------- error downloading file: ' + err);
      
    });

  });
});

function verificaTk(req,res,next)
{
  console.log(req.headers)
  //console.log(req.body)

  let tk=req.headers['vefificador']
  console.log(tk);
  if(typeof tk != 'undefined')
  {       
   console.log(tk)
  req.token=tk;
  next();
  }
  else{
    res.sendStatus(403);
  }
}

app.get('/invernaderos/:id_user', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.sendStatus(403);
    }
    else
    {
      console.log(req);
      console.log(req.params.id_user)
      mysqlConnection.query('SELECT I.Nombre from invernaderos I,user_iver UI where UI.id_inve=I.id_inver and UI.id_user=?  ',req.params.id_user, function(error, results, fields) {
        if (error==null) // quiere decir que se econtro un usuario
        {
          if(!results){
            res.json(results);
        } else{
            
            res.json(results)
        }
        }
        else
        {
          res.json(error)
        }
      });
      
    }

  });       
});

app.get('/invernadero/:id', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.sendStatus(403);
    }
    else
    {
      console.log(req.params);
      mysqlConnection.query('SELECT * from invernaderos where id_inver =?',[req.params.id], function(error, results, fields) {
        if (error==null) // quiere decir que se econtro un usuario
        {
          if(!results){
            res.json(results);
        } else{
            
            res.json(results)
        }
        }
        else
        {
          res.json(error)
        }
      });
      
    }

  });       
});

app.post('/registros', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
     
      res.sendStatus(403);
    }
    else
    {
     
      mysqlConnection.query('select * from invernaderos where Nombre=?',[req.body.name], function(error, results, fields) {
        
        if (results.length>0) // quiere decir que se econtro un usuario
        {
          
          if(!results){
            res.json(results);          
        } else{
          let idi=results[0].id_inver;
          console.log(idi);
          var mydatei =req.body.fecha.toString().split(" ")
          var mydatef =req.body.fecha.toString().split(" ")
          mydatei=mydatei[0];
          mydatef=mydatef[0];
          mydatei+=" 00:00:00";
          mydatef+=" 23:59:59"
          console.log(mydatei);
          console.log(mydatef);
          mysqlConnection.query("select * from registros where id_inve=? and fecha BETWEEN ? AND ?",[idi,mydatei,mydatef], function(error, results, fields) {
            if (results.length>0) // quiere decir que se econtro un usuario
        {
          console.log(results);
          if(!results){
            res.json(results);          
        } else
        {
          res.json(results);          
        }
      }
      else{
        res.json(
          {
            'Status':results.length
          }
          

        );
      }

          });
        }
        }
      });
      
    }

  });       
});

app.get('/', verificaTk, (req, res)=> {
    jwt.verify(req.token,secret,(err,data)=>
    {
      if(err)
      {
        res.sendStatus(403);
      }
      else
      {
       
         res.send('Back-end De Calidad \n by Priva-cimarron ');
      }

    });       
});
    
app.post('/loggin', function (req,res){ 
  var user = req.body.user;
    var pass = req.body.pass;
    if (user && pass) 
    {
		  mysqlConnection.query('SELECT * FROM usuarios WHERE user = ? AND pass = ?', [user, pass], function(error, results, fields) {
      if (results.length > 0) // quiere decir que se econtro un usuario
      {
                
                //req.session.loggedin = true;// inicio
                //req.session.username = user;
                idu=results[0].id_user
                var User={
                  'id':results[0].id_user,
                  'user':results[0].user,
                  'pass':results[0].pass,
                  'rol':results[0].rol
                }
                token=jwt.sign(User, secret);
                console.log(User) ;

                mysqlConnection.query('SELECT id_inve FROM user_iver WHERE id_user = ?', [idu], function(error, results, fields) {
                  console.log(User) ;
                  console.log(error);
                  if (error==null) // quiere decir que se econtro un usuario
                  {
                    
                    console.log(results)               
                    res.json(
                        {
                            user:User,
                            log: true,
                            name :`${user}`,
                            error : false,
                            status : `bienvenido ${user}`,
                            token: token,
                            id_inver: results[0].id_inve
                            
                        });
                  }
                  
                  
                });
               
            } 
            else 
            {
                res.json(
                    {
                        log: false,
                        name :null,
                        error : true,
                        status: ` Username o Password mal ${error}!`
                    }   )
			}			
			
		});
    } 
    else 
    {
        res.json(
        {
            log: false,
            name :null,
            error : true,
            status: 'Introducir los dos valores '
        }   );
    }
});

// registra un nuevo ususario 
app.post('/registrar', function (req, res){
  var user = req.body.user;
  var pass = req.body.pass;
  var rol="normal"
  mysqlConnection.query('SELECT * FROM usuarios WHERE user = ? ', [user], function(error, results, fields) {
    if (results.length == 0) 
    { // puede ser registrado 
      mysqlConnection.query('INSERT INTO usuarios (user,pass,rol) VALUES  (?,?,?)', [user,pass,rol], function(error, results, fields) 
      {
          if(!error)
          {
          res.json(
              {
                  Agregado: true,
                  Nombre: `${user}`,
                  error: false
              }   )
          }
      });


    }
    else
    {
      // usuario ya registrado  
      res.json(
        {
            Agregado: false,
            Nombre: `${user}`,
            error: error
        }   )
    }
  });
});
//agragar 11
app.post('/addC', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.json(
        {
          log: false,
          User: null,
          error: true,
          status: 'no se puede registrar una surco asi iniciar sesion por favor'
        }
      )
    }
    else
    {
      data=req.body.REG;
      data=JSON.parse(data);
     
      var regi=[];
      var i=0;
      var f="";
      for (var prop in data)
      {
        regi[i]=data[prop];
        if(prop=='fecha')
        f=data[prop];
        i++;
      }
    console.log(f);
    var f1=f;
    f1=f.split(" ");
    f=f.substr(10);
    f1=f1[0];
    console.log(f);
    regi[i]=f;
    var f2=f1
    f1+=" 00:00:00";
    f2+=" 23:59:00";    
    console.log(f1,f2);
      //console.log(data);
      mysqlConnection.query('INSERT INTO registros(id_user,id_inve,num_tunel,num_color3,num_color4,num_color5,tamchico,Brix,Brix2,pudricion,tallo,flojo,mecanico,blossom,reventado,cierre,deforme,cicatriz,insecto,color_disparejo,caliz,viruz,fecha,tiempo) VALUES(?)', [regi], function(error, results, fields) {
        if(!error)
        {
          //actualizar el total 
          mysqlConnection.query('select * from totales11 where fecha BETWEEN ? and ?',[f1,f2], function(error, results, fields) {
          
          if(results.length==0)
          {
            // se crea el registro 
            mysqlConnection.query("insert into totales11(fecha,num_color3,num_color4,num_color5,tamchico,Brix,Brix2,pudricion,tallo,flojo,mecanico,blossom,reventado,cierre,deforme,cicatriz,insecto,color_disparejo,caliz,viruz ) SELECT DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha,sum(num_color3),sum(num_color4),sum(num_color5),sum(tamchico),sum(Brix),sum(Brix2),sum(pudricion),sum(tallo),sum(flojo),sum(mecanico),sum(blossom),sum(reventado),sum(cierre),sum(deforme),sum(cicatriz),sum(insecto),sum(color_disparejo),sum(caliz),sum(viruz) from registros where fecha BETWEEN ? and ?",[f1,f2], function(error, results, fields) {   
              console.log(results);
            });
            console.log("no existe el registro del total para ese dia");
          }
          else
          {
            mysqlConnection.query("SELECT sum(num_color3)num_color3,sum(num_color4)as num_color4,sum(num_color5)num_color5,sum(tamchico)as tamchico,sum(Brix)as Brix,sum(Brix2)as Brix2,sum(pudricion)as pudricion,sum(tallo)as tallo,sum(flojo) as flojo,sum(mecanico)as mecanico,sum(blossom)as blossom,sum(reventado)as reventado,sum(cierre)as cierre,sum(deforme)as deforme,sum(cicatriz)as cicatriz,sum(insecto)as insecto,sum(color_disparejo)as color_disparejo,sum(caliz)as caliz,sum(viruz)as viruz  from registros where fecha BETWEEN ? and ?",[f1,f2], function(error, row, fields) {   
              //actualiza
              console.log(row)
              var regi="";
              var i=0;
              for (var prop in row[0])
              {
                regi+=prop+"="+row[0][prop]+",";
              }
              regi=regi.substr(0,regi.length-1);
              console.log(regi);
              regi="UPDATE totales11 set "+regi+" where fecha BETWEEN '"+f1+"' and '"+f2+"'"
              console.log(regi);
              mysqlConnection.query(regi, function(error, results, fields) {
              console.log(results);

              });

              console.log(results);
            });
            console.log("solo se debe actualizar ");
          }
          });
          res.json(
            {
              Id_user: `${idu}`,
              error: false,
              status: 'surco agregado'
    
            }
          )
        }
        else
        {
          console.log(error)
          res.json({
              Cajas: "error",
              Id_user:"error",
              error: true,
              status: 'cajas no anotadas'
          }
          )
        }

        
      });
    }

  });       
});

//actualizar cajas
app.put('/actualizar/', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.json(
        {
          log: false,
          User: null,
          error: true,
          status: 'no se puede actualizar una caja asi iniciar sesion por favor'
        }
      )
    }
    else
    {
      data=req.body.REG;
      data=JSON.parse(data);
      console.log(data);
      var regi="";
      var i=0;
      for (var prop in data) {
        if(prop=='fecha')
        regi+=prop+"='"+data[prop]+"',";
        else
        regi+=prop+"="+data[prop]+",";
        
    }
    console.log(regi[regi.length-1]);
    regi=regi.substr(0,regi.length-1);
    console.log(regi);
   // print(asd);
    regi="UPDATE registros set "+regi+" where id_reg="+req.body.id.toString();
      //console.log(data);
      mysqlConnection.query(regi, function(error, results, fields) {
        if(!error)
        {
          res.json(
            {
              Id_user: `${idu}`,
              error: false,
              status: 'tunel actualizado'
    
            }
          )
        }
        else
        {
          console.log(error)
          res.json({
              Cajas: "error",
              Id_user:"error",
              error: true,
              status: 'tunel no actualizado'
          }
          )
        }

        
      });
    }

  });       
});

//borrar registro
app.delete('/borrar/:id', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.json(
        {
          log: false,
          User: null,
          error: true,
          status: 'no se puede borrar un tunel asi iniciar sesion por favor'
        }
      )
    }
    console.log(req.params.id);
    var id=req.params.id;
      //console.log(data);
      mysqlConnection.query("Delete From registros where id_reg=?", [id],function(error, results, fields) {
        if(!error)
        {
          res.json(
            {
              Id_user: `${idu}`,
              error: false,
              status: 'tunel actualizado'
            }
          )
        }
        else
        {
          console.log(error)
          res.json({
              Cajas: "error",
              Id_user:"error",
              error: true,
              status: 'tunel no actualizado'
          }
          )
        }
      });
  });       
});

// cerrar sesion 
app.get('/logout', (req,res)=>{
  req.session.destroy();
  console.log("salio");
  res.json({
      log:false 
  })
});

//anañidr al 12
app.post('/addC12', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.json(
        {
          log: false,
          User: null,
          error: true,
          status: 'no se puede registrar una caja asi iniciar sesion por favor'
        }
      )
    }
    else
    {
      data=req.body.REG;
      data=JSON.parse(data);
      console.log(data);
      var regi=[];
      var i=0;
      var f="";
      for (var prop in data) {
        regi[i]=data[prop];
        if(prop=='fecha')
        f=data[prop];
        i++;
        
    }
    console.log(i);
    f=f.substr(10);
    console.log(f);
    regi[i]=f;
    console.log(regi);
      //console.log(data);
      mysqlConnection.query('INSERT INTO registros12(id_user,id_inve,num_tunel,num_color3,num_color4,num_color5,tamchico,Brix1,Brix2,Brix3,Brix4,peso,pudricion,tallo,flojo,mecanico,blossom,reventado,cierre,deforme,cicatriz,insecto,color_disparejo,caliz,viruz,fecha,tiempo) VALUES(?)', [regi], function(error, results, fields) {
        if(!error)
        {
          res.json(
            {
              Id_user: `${idu}`,
              error: false,
              status: 'surco agregado'
    
            }
          )
        }
        else
        {
          console.log(error)
          res.json({
              Cajas: "error",
              Id_user:"error",
              error: true,
              status: 'cajas no anotadas'
          }
          )
        }

        
      });
    }

  });       
});
 
//registros12
app.post('/registros12', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
     
      res.sendStatus(403);
    }
    else
    {
     
      mysqlConnection.query('select * from invernaderos where Nombre=?',[req.body.name], function(error, results, fields) {
        
        if (results.length>0) // quiere decir que se econtro un usuario
        {
          
          if(!results){
            res.json(results);          
        } else{
          let idi=results[0].id_inver;
          console.log(idi);
          var mydatei =req.body.fecha.toString().split(" ")
          var mydatef =req.body.fecha.toString().split(" ")
          mydatei=mydatei[0];
          mydatef=mydatef[0];
          mydatei+=" 00:00:00";
          mydatef+=" 23:59:59"
          console.log(mydatei);
          console.log(mydatef);
          mysqlConnection.query("select * from registros12 where id_inve=? and fecha BETWEEN ? AND ?",[idi,mydatei,mydatef], function(error, results, fields) {
            if (results.length>0) // quiere decir que se econtro un usuario
        {
          console.log(results);
          if(!results){
            res.json(results);          
        } else
        {
          res.json(results);          
        }
      }
      else{
        res.json(
          {
            'Status':results.length
          }
          

        );
      }

          });
        }
        }
      });
      
    }

  });       
});

//update 12
app.put('/actualizar12/', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.json(
        {
          log: false,
          User: null,
          error: true,
          status: 'no se puede actualizar una caja asi iniciar sesion por favor'
        }
      )
    }
    else
    {
      data=req.body.REG;
      data=JSON.parse(data);
      console.log(data);
      var regi="";
      var i=0;
      for (var prop in data) {
        if(prop=='fecha')
        regi+=prop+"='"+data[prop]+"',";
        else
        regi+=prop+"="+data[prop]+",";
        
    }
    console.log(regi[regi.length-1]);
    regi=regi.substr(0,regi.length-1);
    console.log(regi);
   // print(asd);
    regi="UPDATE registros12 set "+regi+" where id_reg="+req.body.id.toString();
      //console.log(data);
      mysqlConnection.query(regi, function(error, results, fields) {
        if(!error)
        {
          res.json(
            {
              Id_user: `${idu}`,
              error: false,
              status: 'tunel actualizado'
    
            }
          )
        }
        else
        {
          console.log(error)
          res.json({
              Cajas: "error",
              Id_user:"error",
              error: true,
              status: 'tunel no actualizado'
          }
          )
        }

        
      });
    }

  });       
});

app.delete('/borrar12/:id', verificaTk, (req, res)=> {
  jwt.verify(req.token,secret,(err,data)=>
  {
    if(err)
    {
      res.json(
        {
          log: false,
          User: null,
          error: true,
          status: 'no se puede borrar un tunel asi iniciar sesion por favor'
        }
      )
    }
    console.log(req.params.id);
    var id=req.params.id;
      //console.log(data);
      mysqlConnection.query("Delete From registros12 where id_reg=?", [id],function(error, results, fields) {
        if(!error)
        {
          res.json(
            {
              Id_user: `${idu}`,
              error: false,
              status: 'tunel actualizado'
            }
          )
        }
        else
        {
          console.log(error)
          res.json({
              Cajas: "error",
              Id_user:"error",
              error: true,
              status: 'tunel no actualizado'
          }
          )
        }
      });
  });       
});
app.listen(PORT, ()=> console.log(`Server is up on port: ${PORT}`));