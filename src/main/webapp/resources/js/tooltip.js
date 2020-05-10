$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip({
        container: 'body',
        placement: 'right',
        trigger: 'focus',
        delay: {show: 0, hide: 0}
    });

    $('[data-toggle="tooltip-left"]').tooltip({
        container: 'body',
        placement: 'left',
        trigger: 'focus',
        delay: {show: 0, hide: 0}
    });

    $('[data-toggle="tooltip-top"]').tooltip({
        container: 'body',
        placement: 'top',
        trigger: 'hover',
        delay: {show: 0, hide: 0}
    });

    $('[data-toggle="tooltip-right-hover"]').tooltip({
        container: 'body',
        placement: 'right',
        trigger: 'hover',
        delay: {show: 0, hide: 0}
    });
});