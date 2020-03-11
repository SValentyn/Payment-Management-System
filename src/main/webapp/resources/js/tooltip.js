$(function () {
    $('[data-toggle="tooltip"]').tooltip({
        placement: 'right',
        trigger: 'focus',
        delay: {show: 0, hide: 0}
    });

    $('[data-toggle="tooltip-left"]').tooltip({
        placement: 'left',
        trigger: 'focus',
        delay: {show: 0, hide: 0}
    });

    $('[data-toggle="tooltip-top"]').tooltip({
        placement: 'top',
        trigger: 'hover',
        delay: {show: 0, hide: 0}
    });

    $('[data-toggle="tooltip-right-hover"]').tooltip({
        placement: 'right',
        trigger: 'hover',
        delay: {show: 0, hide: 0}
    });
});