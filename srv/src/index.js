const EXPRESS = require('express');
const MORGAN = require('morgan');
const PATH = require('path');
const EXPRESS_HANDLEBARS = require('express-handlebars');
const flash = require('connect-flash');
const EXPRESS_SESSION = require('express-session');
const EXPRESS_MYSQL_SESSION = require('express-mysql-session');
const { database } = require('./keys');

// DIRECTORIES
const CONTROLLERS = PATH.join(__dirname, 'controllers');
const LIB = PATH.join(__dirname, 'lib');
const PUBLIC = PATH.join(__dirname, 'public');
const ROUTES = PATH.join(__dirname, 'routes');
const VIEWS = PATH.join(__dirname, 'views');

// INIT
const MY_APP = EXPRESS();

// SETTINGS
MY_APP.set('port', process.env.PORT || 3000);
MY_APP.engine('.hbs', EXPRESS_HANDLEBARS({
    defaultLayout: 'main',
    layoutsDir: PATH.join(VIEWS, 'layout'),
    partialsDir: PATH.join(VIEWS, 'layout', 'partials'),
    extname: '.hbs',
    helpers: require(PATH.join(LIB, 'handlebars'))
}));
MY_APP.set('view engine', '.hbs');

// MIDDLEWARES
MY_APP.use(EXPRESS_SESSION({
    secret: 'srvapplicationfortafesa',
    resave: false,
    saveUninitialized: false,
    store: new EXPRESS_MYSQL_SESSION(database)
}));
MY_APP.use(flash());
MY_APP.use(MORGAN('dev'));
MY_APP.use(EXPRESS.urlencoded({ extended: false }));
MY_APP.use(EXPRESS.json());


// ROUTES
MY_APP.use(require('./routes/admin/index'));
MY_APP.use(require('./routes/auth/authentication'));
MY_APP.use('/admin/students', require('./routes/admin/students'));

// GLOBAL VARIABLES
MY_APP.use((req, res, next) => {
    MY_APP.locals.success = req.flash('success');
    next();
});

// PUBLIC STATIC FILES
MY_APP.use('/css', EXPRESS.static(__dirname + '/public/css'));
MY_APP.use('/js', EXPRESS.static(__dirname + '/public/js'));
MY_APP.use('/img', EXPRESS.static(__dirname + '/public/img'));
MY_APP.use('/assets', EXPRESS.static(__dirname + '/public/assets'));

// START SERVER
MY_APP.listen(MY_APP.get('port'), () => {
    console.log('Server on port : ' + MY_APP.get('port'));
});