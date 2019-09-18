const { format } = require('timeago.js');

const HELPERS = {};

HELPERS.timeago = (timestamp) => {
    return format(timestamp);
};

module.exports = HELPERS;