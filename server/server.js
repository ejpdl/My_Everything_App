const express = require('express');
const mysql = require('mysql');
const moment = require('moment');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');

const app = express();

app.use(cors({ origin: '*' }));
app.use(express.json());
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: false }));


const logger = (req, res, next) => {

    console.log(`${req.method} ${req.protocol}://${req.get("host")}${req.originalUrl} : ${moment().format()}`);

    next();

}

app.use(logger);

const JWT_SECRET = 'secret_key';

const authenticateToken = (req, res, next) => {

    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if(!token) return res.sendStatus(401);

    jwt.verify(token, JWT_SECRET, (err, user) => {

        if(err) return res.sendStatus(403);

        req.user = user;
        next();

    });

};

const connection = mysql.createConnection({

    host: "biocbiqex4rghgsfu663-mysql.services.clever-cloud.com",
    user: "uy2stsslf8pfxnb2",
    password: "PZGgHRBRmT5BgUHC5Qz6",
    database: "biocbiqex4rghgsfu663"

});

connection.connect((err) => {

    if(err){

        console.log(`Error Connecting to the database: ${err}`);
        return;

    }

    console.log(`Successfully Connected to the database`);

});



// Register
app.post('/user/register', async (req, res) => {

    const { username, password } = req.body;

    const hash = await bcrypt.hash(password, 10);
    const query = `INSERT INTO auth_credentials (username, password) VALUES (?, ?)`;

    connection.query(query, [username, hash], (err, results) => {

        if(err){

            if(err.code === 'ER_DUP_ENTRY'){

                return res.status(409).json({ error: `Username already exists` });

            }

            return res.status(500).json({ error: `Database Error`, details: err.message });

        }

        const token = jwt.sign({ id: results.insertId, username }, JWT_SECRET, { expiresIn: '1h' });

        res.status(200).json({ message: `User registered successfully`, token });

    });

});


// Log In
app.post('/user/login', (req, res) => {

    const { username, password } = req.body;

    const query = `SELECT * FROM auth_credentials WHERE BINARY username = ?`;

    connection.query(query, [username], async (err, results) => {

        if(err || results.length === 0) {
            return res.status(401).json({ error: `Invalid username or password` });
        }

        const user = results[0];
        const isMatch = await bcrypt.compare(password, user.password);
        
        if(!isMatch) {

            return res.status(401).json({ error: `Invalid username or password` });

        }

        const token = jwt.sign({  id: user.id, username: user.username }, JWT_SECRET, { expiresIn: '1h' });

        res.status(200).json({

            message: `Login Successfull`,
            token: token,

        });

    });

});

app.post('/character/add', authenticateToken, async (req, res) => {

    const { image, first_name, course } = req.body;
    const userId = req.user.id;

    const ifExist = `SELECT * FROM user_character WHERE user_id = ?`;

    connection.query(ifExist, [userId], (checkErr, existingRows) => {

        if(checkErr) return res.status(500).json({ error: `Error checking existing character` });

        if(existingRows.length > 0){
            return res.status(400).json({ error: `Character already exists for this user` });
        }

        const insertQuery = `INSERT INTO user_character (user_id, image, first_name, course) VALUES (?, ?, ?, ?)`;

        connection.query(insertQuery, [userId, image, first_name, course], (err, result) => {

            if(err){

                console.log("MYSQL Error: ", err);

                if (err.code === 'ER_DUP_ENTRY') {
                    return res.status(409).json({ error: 'Character already exists for this user' });
                }

                return res.status(500).json({ error: `Failed to save character` });

            }

            res.status(201).json({ message : `Character saved successfully` });

        });

    });

});


app.get('/character/me', authenticateToken, async (req, res) => {

    const userId = req.user.id;

    const query = `SELECT image, first_name FROM user_character WHERE user_id = ?`;

    connection.query(query, [userId], (err, results) => {

        if(err) return res.status(500).json({ error: `Failed to fetch character` });

        if(results.length === 0){

            return res.status(404).json({ error: `Character not found` });

        }

        res.status(200).json(results[0]);

    });

});



// Get the user details
app.get('/user/:id', authenticateToken, async (req, res) => {

    const { id } = req.params;
    
    if (parseInt(id) !== req.user.id) {
        return res.status(403).json({ error: 'Unauthorized access' });
    }

    const query = `SELECT * FROM auth_credentials WHERE id = ?`;

    connection.query(query, [id], (err, rows) => {

        if (err) return res.status(401).json({ error: err.message });

        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: `No user found` });
        }

    });

});


app.post('/todo/create', authenticateToken, (req, res) => {

  const { title, description, month, day } = req.body;
  const userId = req.user.id;

  const query = `INSERT INTO todos (user_id, title, description, month, day) VALUES (?, ?, ?, ?, ?)`;

  connection.query(query, [userId, title, description, month, day], (err, result) => {
    
    if (err) {
      return res.status(500).json({ error: 'Database Error', details: err.message });
    }

    res.status(200).json({ message: 'To-Do created successfully' });

  });

});

app.get('/todo/all', authenticateToken, (req, res) => {

  const userId = req.user.id;

  const query = `SELECT * FROM todos WHERE user_id = ? ORDER BY id DESC`;

  connection.query(query, [userId], (err, results) => {

    if (err) {
      return res.status(500).json({ error: 'Database error', details: err.message });
    }

    res.status(200).json(results);

  });

});

app.delete('/todo/delete/:id', authenticateToken, (req, res) => {

  const todoId = req.params.id;
  const userId = req.user.id;

  const query = `DELETE FROM todos WHERE id = ? AND user_id = ?`;

  connection.query(query, [todoId, userId], (err, result) => {

    if (err) return res.status(500).json({ error: 'Database error', details: err.message });

    if (result.affectedRows === 0) return res.status(404).json({ error: 'Task not found or unauthorized' });

    res.status(200).json({ message: 'To-do deleted successfully' });

  });

});


// GET ALL USER
app.get(`/users/view_all`, async (req, res) => {

    const query = `SELECT * FROM auth_credentials`;

    connection.query(query, (err, rows) => {

        if(err) return res.status(500).json({ error: `Error fetching users` });

        res.status(200).json(rows);

    });

});


// DELETE A USER
app.delete(`/user/delete/:id`, async (req, res) => {

    const { id } = req.params;

    const query = `DELETE FROM auth_credentials WHERE id = ?`;

    connection.query(query, [id], (err, rows) => {

        if(err) return res.status(500).json({ error: `Error deleting user` });

        res.status(200).json({ message: `User deleted successfully` });

    });

});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {

    console.log(`Server is now running at port ${PORT}`);


});

