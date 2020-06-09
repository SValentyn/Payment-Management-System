/**
 * A script for inserting a counter into text fields to limit the number of characters entered
 */
window.addEventListener("load", () => {
    let appointment = document.querySelector("#appointment");
    let description = document.querySelector("#description");

    if (appointment != null) {
        let maxLength = 100;

        appointment.addEventListener('focus', function () {
            let revText = this.value.length;
            let count = (maxLength - revText);

            if (count <= 0) {
                $("#counter").html('0');
            } else {
                $("#counter").html(count);
            }
        });

        appointment.addEventListener('keyup', function () {
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
    }

    if (description != null) {
        let maxLength = 200;

        description.addEventListener('focus', function () {
            let revText = this.value.length;
            let count = (maxLength - revText);

            if (count <= 0) {
                $("#counter").html('0');
            } else {
                $("#counter").html(count);
            }
        });

        description.addEventListener('keyup', function () {
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
    }
});
