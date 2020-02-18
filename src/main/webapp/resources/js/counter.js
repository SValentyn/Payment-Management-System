$(window).ready(function () {
    var maxLength = 26;

    $("#appointment").focus(function () {
        let revText = this.value.length;

        let cnt = (maxLength - revText);
        if (cnt <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(cnt);
        }
    });

    $("#appointment").keyup(function () {
        let revText = this.value.length;

        if (revText > 0) {
            $("#counter").html(revText);
        }

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

$(window).ready(function () {
    var maxLength = 200;

    $("#description").focus(function () {
        let revText = this.value.length;

        let cnt = (maxLength - revText);
        if (cnt <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(cnt);
        }
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