/**
 * Script to display the current time
 */
setInterval(() => {
    document.getElementById('currentDateTime').innerHTML = getCurrentDateTime();
}, 1000);

// Function to get the current date and time
function getCurrentDateTime() {
    let current_datetime = new Date();
    let day = leadingZerosFormat(current_datetime.getDate());
    let month = leadingZerosFormat(current_datetime.getMonth() + 1);
    let year = current_datetime.getFullYear();
    let hours = leadingZerosFormat(current_datetime.getHours());
    let minutes = leadingZerosFormat(current_datetime.getMinutes());
    let seconds = leadingZerosFormat(current_datetime.getSeconds());

    return hours + ":" + minutes + ":" + seconds + " " + day + "." + month + "." + year;
}

// Function to add leading zeros
function leadingZerosFormat(value) {
    if (value < 10) value = '0' + value;
    return value;
}
