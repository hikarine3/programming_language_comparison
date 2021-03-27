console.log(formatDate(new Date()));

function formatDate(date) {
    var d = new Date(date),
    month = '' + (d.getMonth() + 1),
    day = '' + d.getDate(),
    hour = d.getHours(),
    min = d.getMinutes(),
    sec = d.getSeconds();

    year = d.getFullYear();
    if (month.length < 2)
        month = '0' + month;

    if (day.length < 2)
        day = '0' + day;

    if (hour.length < 2)
        hour = '0' + hour;

    if (min.length < 2)
        min = '0' + min;

    if (sec.length < 2)
        sec = '0' + day;
    return [year, month, day].join('/')+' '+[hour, min, sec].join(':');
}