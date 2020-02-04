$(window).ready(function () {
    let maxCount = 26;

    $("#appointment").focus(function () {
        $("#counter").html(maxCount);
    });

    $("#appointment").keyup(function () {
        let revText = this.value.length;

        if (this.value.length > maxCount) {
            this.value = this.value.substr(0, maxCount);
        }

        let cnt = (maxCount - revText);
        if (cnt <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(cnt);
        }
    });
});

$(window).ready(function () {
    let maxLength = 200;

    $("#description").focus(function () {
        $("#counter").html(maxLength);
    });

    $("#description").keyup(function () {
        let revText = this.value.length;

        if (this.value.length > maxLength) {
            this.value = this.value.substr(0, maxLength);
        }

        let cnt = (maxLength - revText);
        if (cnt <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(cnt);
        }
    });
});