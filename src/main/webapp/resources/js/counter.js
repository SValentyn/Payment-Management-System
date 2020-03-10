// For textarea "appointment"
$(window).ready(function () {
    let maxLength = 100;

    $("#appointment").focus(function () {
        let revText = this.value.length;

        let count = (maxLength - revText);
        if (count <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(count);
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

        let count = (maxLength - revText);
        if (count <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(count);
        }
    });
});

// For textarea "description"
$(window).ready(function () {
    let maxLength = 200;

    $("#description").focus(function () {
        let revText = this.value.length;

        let count = (maxLength - revText);
        if (count <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(count);
        }
    });

    $("#description").keyup(function () {
        let revText = this.value.length;

        if (this.value.length > maxLength) {
            this.value = this.value.substr(0, maxLength);
        }

        let count = (maxLength - revText);
        if (count <= 0) {
            $("#counter").html('0');
        } else {
            $("#counter").html(count);
        }
    });
});
