$(window).ready(function () {
    var maxCount = 26;

    $("#appointment").focus(function () {
        $("#counter").html(maxCount);
    });

    $("#appointment").keyup(function () {
        var revText = this.value.length;

        if (this.value.length > maxCount) {
            this.value = this.value.substr(0, maxCount);
        }

        var cnt = (maxCount - revText);
        if (cnt <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(cnt);
        }
    });
});

$(window).ready(function () {
    var maxLength = 50;

    $("#description").focus(function () {
        $("#counter").html(maxLength);
    });

    $("#description").keyup(function () {
        var revText = this.value.length;

        if (this.value.length > maxLength) {
            this.value = this.value.substr(0, maxLength);
        }

        var cnt = (maxLength - revText);
        if (cnt <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(cnt);
        }
    });
});