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

function pageLoadTasks() {
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
    var editForm = document.getElementById("editModal");

    function hideDisclosures() {
        editForm.querySelectorAll(".external-record-group .collapse").forEach(function (element) {
            element.className = "collapse";
        });
    }
    
    endEditFieldsIn('main-group');

    editForm.querySelectorAll(".external-record-group .collapse").forEach(function (element) {
        element.addEventListener('show.bs.collapse', refresh);
        
        function refresh() {
            let iframe = this.querySelector("iframe");
            iframe.src = iframe.dataset.storedtoload;
        }
    });

    editForm.addEventListener('hide.bs.modal', hideDisclosures);
}

document.addEventListener("DOMContentLoaded", pageLoadTasks);