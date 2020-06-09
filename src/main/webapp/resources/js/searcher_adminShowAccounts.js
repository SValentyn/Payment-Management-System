/**
 * Elements on adminShowAccounts.jsp page to search
 */
let number = document.querySelector("#number");
let bfh_selectbox_class = $('.bfh-selectbox');
let currency = document.querySelector("#currency");
let slider_range = $("#slider-range");
let min_value = document.querySelector("#min-value");
let max_value = document.querySelector("#max-value");
let amount = document.querySelector("#amount");
let searchBtn = document.querySelector("#search");

/**
 * It starts immediately after the page loads
 */
window.addEventListener("load", () => {
    if (currency !== undefined) {
        if (currency.value.trim().length === 3) {
            $(bfh_selectbox_class).val(currency.value);
        } else {
            currency.value = $(bfh_selectbox_class).val();
        }
    }

    if (min_value !== undefined && max_value !== undefined) {
        if (min_value.value.trim().length > 0 && max_value.value.trim().length > 0) {
            slider_range.slider({
                range: true,
                min: 0,
                max: 10000,
                values: [min_value.value, max_value.value],
                slide: function (event, ui) {
                    if (ui.values[1] >= 10000) {
                        $(amount).val(ui.values[0] + " - " + ui.values[1] + "+");
                    } else {
                        $(amount).val(ui.values[0] + " - " + ui.values[1]);
                    }
                }
            });
        } else {
            slider_range.slider({
                range: true,
                min: 0,
                max: 10000,
                values: [0, 10000],
                slide: function (event, ui) {
                    if (ui.values[1] >= 10000) {
                        $(amount).val(ui.values[0] + " - " + ui.values[1] + "+");
                    } else {
                        $(amount).val(ui.values[0] + " - " + ui.values[1]);
                    }
                }
            });
        }
    }

    if ($(slider_range).slider("values", 1) >= 10000) {
        $(amount).val($(slider_range).slider("values", 0) + " - " + $(slider_range).slider("values", 1) + "+");
    } else {
        $(amount).val($(slider_range).slider("values", 0) + " - " + $(slider_range).slider("values", 1));
    }
});

/**
 *
 */
bfh_selectbox_class.on('hide.bfhselectbox', () => currency.value = $(bfh_selectbox_class).val());

/**
 *
 */
searchBtn.addEventListener('click', () => {
    number.value = number.value.trim();
    $(min_value).val($(slider_range).slider("values", 0));
    $(max_value).val($(slider_range).slider("values", 1));
});
