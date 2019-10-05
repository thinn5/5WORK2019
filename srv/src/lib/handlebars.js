const { format } = require('timeago.js');

const HELPERS = {};

HELPERS.timeago = (timestamp) => {
    return format(timestamp);
};

HELPERS.timeagoFormatted = (timestamp) => {
    var date = new Date(timestamp * 1000);
    var iso = date.toISOString().match(/(\d{4}\-\d{2}\-\d{2})/);
    return iso[1];
};

HELPERS.setSingular = (varName, varValue, options) => {
    options.data.root[varName] = varValue;
};

module.exports = HELPERS;