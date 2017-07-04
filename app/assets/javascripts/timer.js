$(document).ready( function() {
    var quality = 5;

    var timerId = setTimeout(function set_quality() {
        $("#card_quality").val(quality -= 1);
        if (quality <= 3 ) {
            timerId = setTimeout(set_quality, 20000);
        } else {
            clearTimeout(timerId);
        }
    }, 20000);
});
