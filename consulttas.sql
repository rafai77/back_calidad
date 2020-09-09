use calidad;
select SUM(num_color3),fecha from registros  WHERE fecha BETWEEN "2020-08-06 00:00" AND "2020-08-10 23:59"
SELECT id_inve FROM user_iver WHERE id_user = 6
show tables
select * from invernaderos
---Obtener los nombres de las columnas
SELECT COLUMN_NAME FROM Information_Schema.Columns WHERE TABLE_NAME = 'registros'
SELECT fecha,num_tunel,blossom,Brix,caliz,cicatriz,cierre,color_disparejo,deforme,flojo,insecto,mecanico,num_color3,num_color4,num_color5,pudricion,reventado,tallo,tamchico,viruz FROM registros

drop table registros12

delete from registros where id_reg=2
-- Insert rows into table 'TableName'
INSERT INTO invernaderos VALUES
( 
 1, "Invernadero-1", "Pimiento"
);
INSERT INTO invernaderos VALUES
( 
 11, "Invernadero-11", "tomate"
);

INSERT INTO invernaderos VALUES
( 
 12, "Invernadero-12", "tomate"
);
INSERT INTO invernaderos VALUES
( 
 16, "Invernadero-16", "tomate"
);


INSERT INTO invernaderos VALUES
( 
 15, "Invernadero-15", "tomate"
);

INSERT INTO invernaderos VALUES
( 
 2, "Invernadero-2", "Pimiento"
);

INSERT INTO invernaderos VALUES
( 
 3, "Invernadero-3", "Pimiento"
);




use calidad;
insert into totales11(fecha,num_color3,num_color4,num_color5,tamchico,Brix,Brix2,pudricion,
    tallo,flojo,mecanico,blossom,reventado,cierre,deforme,cicatriz,insecto,color_disparejo,caliz,
    viruz ) SELECT DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha,sum(num_color3),sum(num_color4),sum(num_color5),sum(tamchico),sum(Brix),sum(Brix2),sum(pudricion),sum(tallo),sum(flojo),sum(mecanico),sum(blossom),sum(reventado),
sum(cierre),sum(deforme),sum(cicatriz),sum(insecto),
sum(color_disparejo),sum(caliz),sum(viruz) from registros where fecha BETWEEN "2020-08-10 00:00:00"and "2020-08-10 23:59:59";

INSERT INTO invernaderos VALUES
( 
 16, "Invernadero-16", "tomate"
);
use calidad;
select num_color3,fecha from totales11 where fecha BETWEEN '2020-08-10 00:00:00' and '2020-08-10 23:59:59'
SELECT DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha sum(num_color3)num_color3,sum(num_color4)as num_color4,sum(num_color5)num_color5,sum(tamchico)as tamchico,sum(Brix)as Brix,sum(Brix2)as Brix2,sum(pudricion)as pudricion,sum(tallo)as tallo,sum(flojo) as flojo,sum(mecanico)as mecanico,sum(blossom)as blossom,sum(reventado)as reventado,sum(cierre)as cierre,sum(deforme)as deforme,sum(cicatriz)as cicatriz,sum(insecto)as insecto,sum(color_disparejo)as color_disparejo,sum(caliz)as caliz,sum(viruz)asviruz  from registros where fecha BETWEEN "2020-08-12 00:00:00" and "2020-08-12 23:59:00"


SELECT DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha,sum(num_color3)num_color3,sum(num_color4)as num_color4,sum(num_color5)num_color5,sum(tamchico)as tamchico,sum(Brix)as Brix,sum(Brix2)as Brix2,sum(pudricion)as pudricion,sum(tallo)as tallo,sum(flojo) as flojo,sum(mecanico)as mecanico,sum(blossom)as blossom,sum(reventado)as reventado,sum(cierre)as cierre,sum(deforme)as deforme,sum(cicatriz)as cicatriz,sum(insecto)as insecto,sum(color_disparejo)as color_disparejo,sum(caliz)as caliz,sum(viruz)asviruz  from registros where fecha BETWEEN "2020-08-12 00:00:00" and "2020-08-12 23:59:00"
create TABLE totales11
(
    i_total int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha date not null,
    num_color3 INT NOT NULL,
    num_color4 INT NOT NULL,
    num_color5 INT NOT NULL,
    tamchico INT NOT NULL,
    Brix  DECIMAL(5,2)  NULL,
    Brix2  DECIMAL(5,2)  NULL,
    pudricion INT NOT NULL,
    tallo INT NOT NULL,
    flojo INT NOT NULL,
    mecanico INT NOT NULL,
    blossom INT NOT NULL,
    reventado INT NOT NULL,
    cierre INT NOT NULL,
    deforme INT NOT NULL,
    cicatriz INT NOT NULL,
    insecto INT NOT NULL,
    color_disparejo INT NOT NULL,
    caliz INT NOT NULL,
    viruz INT NOT NULL,
    UNIQUE (fecha)
);
use calidad;
drop table user_iver
CREATE TABLE user_iver
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL ,
    id_inve INT NOT NULL  ,
    UNIQUE(id_user,id_inve), 
    FOREIGN KEY (id_user) REFERENCES usuarios(id_user),
    FOREIGN KEY (id_inve) REFERENCES invernaderos(id_inver)
);
use calidad;
-- Insert rows into table 'user_iver'
INSERT INTO user_iver
( 
id_user, id_inve
)
VALUES
( 
4, 12
);


use calidad;

SELECT I.Nombre from invernaderos I,user_iver UI where UI.id_inve=I.id_inver and UI.id_user=3
select R.id_reg,U.user,I.Nombre,R.num_tunel,R.num_color3,R.num_color4,R.num_color5,
R.tamchico,R.Brix,R.Brix2,R.pudricion,R.tallo,R.flojo,R.mecanico,R.blossom,R.reventado,
R.cierre,R.deforme,R.cicatriz,R.insecto,R.color_disparejo,R.caliz,R.viruz,R.fecha,R.tiempo
from registros R,usuarios U,invernaderos I where R.id_user=U.id_user and R.id_inve=I.id_inver  and R.id_inve=11
CREATE TABLE registros
(
    id_reg INT NOT NULL  AUTO_INCREMENT , -- primary key column
    id_user INT NOT NULL ,
    id_inve INT NOT NULL  ,
    num_tunel INT NOT NULL,
    num_color3 INT NOT NULL,
    num_color4 INT NOT NULL,
    num_color5 INT NOT NULL,
    tamchico INT NOT NULL,
    Brix  DECIMAL(5,2)  NULL,
    Brix2  DECIMAL(5,2)  NULL,
    pudricion INT NOT NULL,
    tallo INT NOT NULL,
    flojo INT NOT NULL,
    mecanico INT NOT NULL,
    blossom INT NOT NULL,
    reventado INT NOT NULL,
    cierre INT NOT NULL,
    deforme INT NOT NULL,
    cicatriz INT NOT NULL,
    insecto INT NOT NULL,
    color_disparejo INT NOT NULL,
    caliz INT NOT NULL,
    viruz INT NOT NULL,
    fecha DATE not null,
    tiempo TIME,
    UNIQUE (fecha,id_inve,num_tunel),
    PRIMARY KEY(id_reg),
    FOREIGN KEY (id_user) REFERENCES usuarios(id_user),
    FOREIGN KEY (id_inve) REFERENCES invernaderos(id_inver)
);


use calidad

select * from registros
GO
 	/* add search conditions here */

-- Insert rows into table 'registros'
INSERT INTO registros
    (id_user,id_inve,num_tunel,num_color3,num_color4,num_color5,tamchico,Brix,pudricion,
    tallo,flojo,mecanico,blossom,reventado,cierre,deforme,cicatriz,insecto,color_disparejo,caliz,
    viruz,fecha
    )

VALUES
( -- first row: values for the columns in the list above
 1,1,2,20,24,56,25,8.8,2,1,0,0,0,0,0,0,1,1,2,2,3,"22/7/2020 9:48:02"
);
use calidad
select * from registros where id_inve=1; --and fecha<'2020-07-30 08:53'and fecha>'2020-07-30 00:00';
INSERT INTO registros
(id_user,id_inve,num_tunel,num_color3,num_color4,num_color5,tamchico,Brix,pudricion,
tallo,flojo,mecanico,blossom,reventado,cierre,deforme,cicatriz,insecto,color_disparejo,caliz,
viruz,fecha
) 
VALUES(' 1,1,588,1,52,25,22,14,3,1,2,1,3,7,0,0,0,0,0,0,0,2018-08-31 15:13:00')




use calidad
INSERT INTO usuarios (user,pass,rol) VALUES ("Hcimaron","cimarron2020","admin" );
INSERT INTO usuarios (user,pass,rol) VALUES ("usuarios-11","tomate11","checador" );
INSERT INTO usuarios (user,pass,rol) VALUES ("usuarios-12","tomate12","checador" );
INSERT INTO usuarios (user,pass,rol) VALUES ("usuarios-16","tomate16","checador" );




use calidad;
CREATE TABLE registros12
(
    id_reg INT NOT NULL  AUTO_INCREMENT , -- primary key column
    id_user INT NOT NULL ,
    id_inve INT NOT NULL  ,
    num_tunel INT NOT NULL,
    num_color3 INT NOT NULL,
    num_color4 INT NOT NULL,
    num_color5 INT NOT NULL,
    tamchico INT NOT NULL,
    Brix1  DECIMAL(5,2)  NULL,
    Brix2  DECIMAL(5,2)  NULL,
    Brix3  DECIMAL(5,2)  NULL,
    Brix4  DECIMAL(5,2)  NULL,
    peso  DECIMAL(5,2)  NULL,
    pudricion INT NOT NULL,
    tallo INT NOT NULL,
    flojo INT NOT NULL,
    mecanico INT NOT NULL,
    blossom INT NOT NULL,
    reventado INT NOT NULL,
    cierre INT NOT NULL,
    deforme INT NOT NULL,
    cicatriz INT NOT NULL,
    insecto INT NOT NULL,
    color_disparejo INT NOT NULL,
    caliz INT NOT NULL,
    viruz INT NOT NULL,
    fecha DATE not null,
    tiempo TIME,
    UNIQUE (fecha,id_inve,num_tunel),
    PRIMARY KEY(id_reg),
    FOREIGN KEY (id_user) REFERENCES usuarios(id_user),
    FOREIGN KEY (id_inve) REFERENCES invernaderos(id_inver)
);



use calidad;
create TABLE totales12
(
    i_total int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha date not null,
    num_color3 INT NOT NULL,
    num_color4 INT NOT NULL,
    num_color5 INT NOT NULL,
    tamchico INT NOT NULL,
    Brix1  DECIMAL(5,2)  NULL,
    Brix2  DECIMAL(5,2)  NULL,
    Brix3  DECIMAL(5,2)  NULL,
    Brix4  DECIMAL(5,2)  NULL,
    peso   DECIMAL(5,2)  NULL,
    pudricion INT NOT NULL,
    tallo INT NOT NULL,
    flojo INT NOT NULL,
    mecanico INT NOT NULL,
    blossom INT NOT NULL,
    reventado INT NOT NULL,
    cierre INT NOT NULL,
    deforme INT NOT NULL,
    cicatriz INT NOT NULL,
    insecto INT NOT NULL,
    color_disparejo INT NOT NULL,
    caliz INT NOT NULL,
    viruz INT NOT NULL,
    UNIQUE (fecha)
);

select num_color3,num_color4,num_color5,Brix1,Brix2,Brix3,Brix4,DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha from totales12 where fecha BETWEEN '2020-08-06 00:00:00' and '2020-08-14 23:59:59'

select t.fecha as c from    ,registros r

use calidad;
SELECT  t.fecha,COUNT(r.id_user) as cantidad from registros r,totales11 t where t.fecha='2020-09-03' and r.fecha='2020-09-03'
UPDATE  totales11 SET Brix=10 ,Brix2=5 where fecha='2020-09-03'
UPDATE totales11 SET Brix=25 ,Brix2=25 where fecha='2020-09-03'


SELECT t.*,(num_color3+num_color4+num_color5) as Total FROM calidad.totales11 t where fecha='2020-09-03';
SELECT t.*,(num_color3+num_color4+num_color5) as Total FROM totales11 t


SELECT t.Brix2,t.Brix2/(num_color3+num_color4+num_color5) as Total FROM totales11 t
SELECT  t.fecha,COUNT(r.id_user) as cantidad from registros r, totales12 t where t.fecha='2020-09-08 09:03:02.233612' and r.fecha='2020-09-08 09:03:02.233612'



CREATE TABLE registros16
(
    id_reg INT NOT NULL  AUTO_INCREMENT , -- primary key column
    id_user INT NOT NULL ,
    id_inve INT NOT NULL  ,
    num_tunel INT NOT NULL,
    racimo1 INT NOT NULL,
    racimo2 INT NOT NULL,
    racimo3 INT NOT NULL,
    racimo4 INT NOT NULL,
    racimo5 INT NOT NULL,
    racimo6 INT NOT NULL,
    tamchico INT NOT NULL,
    lado varchar(2)not null,
    peso  DECIMAL(5,2)  NULL,
    pudricion INT NOT NULL,
    flojo INT NOT NULL,
    mecanico INT NOT NULL,
    blossom INT NOT NULL,
    cierre INT NOT NULL,
    deforme INT NOT NULL,
    cicatriz INT NOT NULL,
    insecto_daño INT NOT NULL,
    insecto_presencia INT NOT NULL,
    craking INT NOT NULL,
    corte INT NOT NULL,
    golpe INT NOT NULL,
    exverde INT NOT NULL,
    color_disparejo INT NOT NULL,
    arrudago INT NOT NULL,
    blotchy INT NOT NULL,
    suelto INT NOT NULL,
    daño_virus int not null,
    fecha DATE not null,
    tiempo TIME,
    UNIQUE (fecha,id_inve,num_tunel),
    PRIMARY KEY(id_reg),
    FOREIGN KEY (id_user) REFERENCES usuarios(id_user),
    FOREIGN KEY (id_inve) REFERENCES invernaderos(id_inver)
);
INSERT INTO registros16(id_user,id_inve,num_tunel,racimo1,racimo2,racimo3,racimo4,racimo5,racimo6,tamchico,peso,pudricion,flojo,mecanico,blossom,cierre,deforme,cicatriz,insecto_daño,insecto_presencia,,dano_virus,craking,corte,golpe,exverde,arrugado,blotchy,suelto,color_disparejo,fecha,lado,tiempo) 
VALUES(5, 16, 1, 25, 25, 36, 31, 21, 39, 6, 3, 2, 2, 2, 0, 0, 0, 2, 2, 3, 0, 2, 1, 0, 2, 3, 2, 0, 2, '2020-09-08 00:00:00.000', 'N', ' 00:00:00.000')


CREATE TABLE totales16
(
    i_total int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fecha DATE not null,
    racimo1 INT NOT NULL,
    racimo2 INT NOT NULL,
    racimo3 INT NOT NULL,
    racimo4 INT NOT NULL,
    racimo5 INT NOT NULL,
    racimo6 INT NOT NULL,
    tamchico INT NOT NULL,
    peso  DECIMAL(5,2)  NULL,
    pudricion INT NOT NULL,
    flojo INT NOT NULL,
    mecanico INT NOT NULL,
    blossom INT NOT NULL,
    cierre INT NOT NULL,
    deforme INT NOT NULL,
    cicatriz INT NOT NULL,
    insecto_daño INT NOT NULL,
    insecto_presencia INT NOT NULL,
    craking INT NOT NULL,
    corte INT NOT NULL,
    golpe INT NOT NULL,
    exverde INT NOT NULL,
    color_disparejo INT NOT NULL,
    arrudago INT NOT NULL,
    blotchy INT NOT NULL,
    suelto INT NOT NULL,
    daño_virus int not null,
    UNIQUE (fecha)

)




insert into totales16(fecha,racimo1,racimo2,racimo3,racimo4,racimo5,racimo6,tamchico,peso,pudricion,flojo,mecanico,blossom,cierre,deforme,cicatriz,insecto_daño,insecto_presencia,daño_virus,craking,corte,golpe,exverde,arrugado,blotchy,suelto,color_disparejo) SELECT DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha,sum(racimo1),sum(racimo2),sum(racimo3),sum(racimo4),sum(racimo5),sum(racimo6),sum(tamchico),sum(peso),sum(pudricion),sum(flojo),sum(mecanico),sum(blossom),sum(cierre),sum(deforme),sum(cicatriz),sum(insecto_daño),sum(insecto_presencia),sum(daño_virus),sum(craking),sum(corte),sum(golpe),sum(exverde),sum(arrugado),sum(blotchy),sum(suelto),sum(color_disparejo) from registros16 where fecha BETWEEN '2020-09-08' and '2020-09-08'
SELECT DATE_FORMAT(fecha ,'%Y-%m-%d')as fecha,sum(racimo1),sum(racimo2),sum(racimo3),sum(racimo4),sum(racimo5),sum(racimo6),sum(tamchico),sum(peso),sum(pudricion),sum(flojo),sum(mecanico),sum(blossom),sum(cierre),sum(deforme),sum(cicatriz),sum(insecto_daño),sum(insecto_presencia),sum(daño_virus),sum(craking),sum(corte),sum(golpe),sum(exverde),sum(arrugado),sum(blotchy),sum(suelto),sum(color_disparejo) from registros16 where fecha BETWEEN '2020-09-08' and '2020-09-08'



UPDATE totales16 set fecha=2020-09-08,racimo1=33,racimo2=13,racimo3=44,racimo4=45,racimo5=36,racimo6=35,tamchico=102,peso=26,pudricion=8,flojo=5,mecanico=6,blossom=5,cierre=6,deforme=4,cicatriz=9,insecto_daño=8,daño_virus=1,craking=3,corte=2,golpe=4,exverde=3,arrugado=2,blotchy=2,suelto=1,color_disparejo=2 where fecha BETWEEN '2020-09-08 00:00:00' and '2020-09-08 23:59:00'

select R.id_reg,U.user,I.Nombre,R.num_tunel,R.racimo1,R.racimo2,R.racimo3,R.racimo4,R.racimo5,R.racimo6,R.tamchico,R.peso,R.pudricion,R.flojo,R.mecanico,R.blossom,R.cierre,R.deforme,R.cicatriz,R.insecto_daño,R.insecto_presencia,R.daño_virus,R.craking,R.corte,R.golpe,R.exverde,R.arrugado,R.blotchy,R.suelto,R.color_disparejo,R.fecha,R.lado,R.tiempo from registros16 R,usuarios U,invernaderos I where R.id_user=U.id_user and R.id_inve=I.id_inver and R.id_inve=16 and fecha BETWEEN '2020-09-08 00:00:00' and '2020-09-08 23:59:00'