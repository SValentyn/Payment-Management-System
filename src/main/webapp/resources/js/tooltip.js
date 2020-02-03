$(function () {
    $('[data-toggle="tooltip"]').tooltip({
        placement: 'right',
        trigger: 'focus',
        delay: {show: 0, hide: 0}
    });

    $('.tooltip-top').tooltip({
        placement: 'top',
        trigger: 'hover',
        delay: {show: 0, hide: 0}
    });
});