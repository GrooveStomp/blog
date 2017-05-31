document.addEventListener("DOMContentLoaded", function(event) {
    var button = document.getElementById("mobile-button");
    button.onclick = function() {
        var menu = document.getElementById("mobile-menu");
        if (menu.style.display != "table-cell") {
            menu.style.display = "table-cell";
        } else {
            menu.style.display = "none";
        }
        return false;
    };
});
