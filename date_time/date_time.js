
console.log(getCurrentDateTime());

function getCurrentDateTime() {
  const date = new Date();
  const year = date.getFullYear();
  let mon = date.getMonth() + 1;
  let mday = date.getDate();
  let hour = date.getHours();
  let min = date.getMinutes();
  let sec = date.getSeconds();
  if(mon < 10) {
    mon = "0" + mon;
  }
  if(mday < 10) {
    mday = "0" + mday;
  }
  if(hour < 10) {
    hour = "0" + hour;
  }
  if(min < 10) {
    min = "0" + min;
  }
  if(sec < 10) {
    sec = "0" + secu;
  }
  return [year, mon, mday].join("/") + " " + [hour, min, sec].join(":");
}
