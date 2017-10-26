document.addEventListener("DOMContentLoaded", function(event) {
    var button = document.getElementById("mobile-button");
    button.onclick = function() {
        var menu = document.getElementById("mobile-menu");
        if (menu.style.display != "block") {
            menu.style.display = "block";
        } else {
            menu.style.display = "none";
        }
        return false;
    };
});
