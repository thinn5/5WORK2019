const EXPRESS = require('express');
const PATH = require('path');
const MORGAN = require('morgan');
const EXPRESS_HANDLEBARS = require('express-handlebars');

// Directories
const CONTROLLERS = PATH.join(__dirname, 'controllers');
const LIB = PATH.join(__dirname, 'lib');
const MODELS = PATH.join(__dirname, 'models');
const PUBLIC = PATH.join(__dirname, 'public');
const ROUTES = PATH.join(__dirname, 'routes');
const VIEWS = PATH.join(__dirname, 'views');

// Initialize
const MY_APP = EXPRESS();

// Settings
MY_APP.set('port', process.env.PORT || 4000);
MY_APP.engine('.hbs', EXPRESS_HANDLEBARS({
    defaultLayout: 'main',
    layoutsDir: PATH.join(VIEWS, 'layout'),
    partialsDir: PATH.join(VIEWS, 'layout', 'partials'),
    extname: '.hbs',
    helpers: require(PATH.join(LIB, 'handlebars'))
}));

// Middlewares
MY_APP.use(MORGAN('dev'));
MY_APP.use(EXPRESS.urlencoded({ extended: false }));
MY_APP.use(EXPRESS.json());

// Global variables
MY_APP.use((req, res, next) => {
    //MY_APP.locals.success = req.flash('success');
    next();
});

// Routes
MY_APP.use(require(PATH.join(ROUTES, 'index')));
MY_APP.use(require(PATH.join(ROUTES, 'authentication')));
/*MY_APP.use('/admin', require(PATH.join(ROUTES, 'backEnd', 'index')));*/

// Public static files
MY_APP.use('/css', EXPRESS.static(PATH.join(PUBLIC, 'css')));
MY_APP.use('/js', EXPRESS.static(PATH.join(PUBLIC, 'js')));
MY_APP.use('/img', EXPRESS.static(PATH.join(PUBLIC, 'img')));
MY_APP.use('/assets', EXPRESS.static(PATH.join(PUBLIC, 'assets')));

// Start server
MY_APP.listen(MY_APP.get('port'), () => {
    console.log('Server automagically working on port : ' + MY_APP.get('port'));
});