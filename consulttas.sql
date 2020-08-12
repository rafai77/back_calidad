use calidad;
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
 2, "Invernadero-2", "Pimiento"
);

INSERT INTO invernaderos VALUES
( 
 3, "Invernadero-3", "Pimiento"
);

INSERT INTO invernaderos VALUES
( 
 16, "Invernadero-16", "tomate"
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