var app = require('electron').app;
var BrowserWindow = require('electron').BrowserWindow;
const PATH = require('path');
const EXPRESS = require('express');
// MIDDLEWARES
MY_APP.use(MORGAN('dev'));
const MYSQL = require('mysql');
const MY_CONNECTION = require('express-myconnection');
const DATA_BASE = require(PATH.join(__dirname, 'config', 'database'));
const EXPRESS_HANDLEBARS = require('express-handlebars');

// DIRECTORIES
const ROUTES = PATH.join(__dirname, 'routes');
const VIEWS = PATH.join(__dirname, 'views');
const LIB = PATH.join(__dirname, 'lib');
const PUBLIC = PATH.join(__dirname, 'public');

// INIT
const MY_APP = EXPRESS();

// IMPORTING ROUTES
const INDEX_ROUTES = require(PATH.join(ROUTES, 'index'));
const USER_ROUTES = require(PATH.join(ROUTES, 'users'));
const AUTHENTICATION_ROUTES = require(PATH.join(ROUTES, 'authentication'));

// SETTINGS
MY_APP.set('port', process.env.PORT || 3000);
//MY_APP.set('view engine', 'ejs');
MY_APP.set('views', PATH.join(__dirname, 'views'));
MY_APP.engine('.hbs', EXPRESS_HANDLEBARS({
    defaultLayout: 'main',
    layoutsDir: PATH.join(VIEWS, 'layout'),
    partialsDir: PATH.join(VIEWS, 'partials'),
    extname: '.hbs',
    helpers: PATH.join(LIB, 'handlebars')
}));
MY_APP.set('view engine', '.hbs');

// MIDDLEWARES
MY_APP.use(MORGAN('dev'));
/*MY_APP.use(MY_CONNECTION(MYSQL, {
    host: 'localhost',
    user: 'root',
    password: '',
    port: 3306,
    database: 'database_development'

}, 'single'));*/
MY_APP.use(EXPRESS.urlencoded({ extended: false }));
MY_APP.use(EXPRESS.json());

// GLOBAL VARIABLES
MY_APP.use((req, res, next) => {
    next;
});

// ROUTES
MY_APP.use('/', INDEX_ROUTES);
MY_APP.use('/users', USER_ROUTES);
MY_APP.use(AUTHENTICATION_ROUTES);

// PUBLIC STATIC FILES
MY_APP.use(EXPRESS.static(PATH.join(__dirname, 'public')));

// START SERVER
MY_APP.listen(MY_APP.get('port'), () => {
    console.log('Server on port : ' + MY_APP.get('port'));
});

let win;

function createWindow() {
    win = new BrowserWindow({
        width: 1200,
        height: 800,
        webPreferences: {
            nodeIntegration: true
        }
    });
    win.loadURL('http://localhost:3000');
    win.webContents.openDevTools();
    win.on('closed', () => {
        win = null
    })
}
app.on('ready', createWindow);
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit()
    }
});

app.on('activate', () => {
    if (win === null) {
        createWindow()
    }
});