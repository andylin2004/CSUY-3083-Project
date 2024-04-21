var editing = false;

function editFieldsIn(id_name) {
    var baseID = "#" + id_name;
    document.querySelectorAll(baseID + " input, " + baseID + " select").forEach(function(element) {
        element.removeAttribute("disabled");
    });
    editing = true;
}

function endEditFieldsIn(id_name) {
    var baseID = "#" + id_name;
    document.querySelectorAll(baseID + " input, " + baseID + " select").forEach(function(element) {
        element.setAttribute("disabled", true);
    });
    editing = false;
}

document.addEventListener("DOMContentLoaded", event => {
    var queryStr = window.location.search;
    var urlParams = new URLSearchParams(queryStr);
    
    var category = urlParams.get('column');
    var query = urlParams.get('query');
    var embed = urlParams.get('embed');
    
    if (category != null) {
        document.getElementById('column').value = category;
        document.getElementById('query').value = query;
    }
    
    if (embed) {
        document.querySelectorAll(".hideable *, .hideable").forEach(function(element) {
            element.style.display = 'none';
        })
        document.querySelectorAll(".canBeNewTab").forEach(function(element) {
            element.removeAttribute("data-bs-toggle");
            element.removeAttribute("data-bs-target");
        })
    }
});