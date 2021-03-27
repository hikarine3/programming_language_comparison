console.log(get_x_days_ago(2));

function get_x_days_ago(x){
    var date = new Date();
    return formatDate(date.setDate(date.getDate() - x));
}

function formatDate(date) {
    var d = new Date(date),
    month = '' + (d.getMonth() + 1),
    day = '' + d.getDate(),
    year = d.getFullYear();
    if (month.length < 2)
        month = '0' + month;
    if (day.length < 2)
        day = '0' + day;
    return [year, month, day].join('/');
}