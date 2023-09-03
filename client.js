const { Client } = require('pg');

const pgclient = new Client({
    host: process.env.POSTGRES_HOST,
    port: process.env.POSTGRES_PORT,
    user: 'postgres',
    password: 'postgres',
    database: 'postgres'
});

pgclient.connect();

pgclient.query('select version();', (err, res) => {
    if (err) throw err
    console.log(err, res.rows);
});
pgclient.query("select '_' collate \"en_US\" < 'e' collate \"en_US\";", (err, res) => {
    if (err) throw err
    console.log(err, res.rows);
});
pgclient.query("select 'lock_note' collate \"en_US\" < 'locked_by' collate \"en_US\";", (err, res) => {
    if (err) throw err
    console.log(err, res.rows);
});

pgclient.query("select 'lock_note' collate \"C\" < 'locked_by' collate \"C\";", (err, res) => {
    if (err) throw err
    console.log(err, res.rows);
    pgclient.end()
});
