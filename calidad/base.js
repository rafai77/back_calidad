const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '1234',
    database: 'calidad'
});

mysqlConnection.connect(function (err){
    if(err)
    {
        console.log(err);
        return;
    } else{
        console.log('DB connected');
    }
});

module.exports = mysqlConnection;
//ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234'