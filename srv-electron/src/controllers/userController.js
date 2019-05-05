const controller = {};

controller.list = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM users', (err, users) => {
            if (err) {
                next(err);
            }
            res.render('users', {
                data: users
            });
        });
    });
};

controller.add = (req, res) => {
    const data = req.body;
    req.getConnection((err, conn) => {
        conn.query('INSERT INTO users set ?', [data], (err, users) => {
            if (err) {
                next(err);
            }
            res.redirect('/');
        });
    });
};

controller.edit = (req, res) => {
    const id = req.params.id;
    req.getConnection((err, conn) => {
        conn.query('SELECT * FROM users WHERE id = ?', [id], (err, user) => {
            if (err) {
                next(err);
            }
            res.render('user_edit', {
                data: user[0]
            });
        });
    });
};

controller.update = (req, res) => {
    const id = req.params.id;
    const newUser = req.body;
    req.getConnection((err, conn) => {
        conn.query('UPDATE users set ? WHERE id = ?', [newUser, id], (err, users) => {
            if (err) {
                next(err);
            }
            res.redirect('/');
        });
    });
};


controller.delete = (req, res) => {
    const id = req.params.id;
    req.getConnection((err, conn) => {
        conn.query('DELETE FROM users WHERE id = ?', [id], (err, users) => {
            if (err) {
                next(err);
            }
            res.redirect('/');
        })
    })
};

module.exports = controller;