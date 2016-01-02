
function showPage(name, duration)
{
    gengine_execute("gengine.gui.showPage('" + name + "', " + duration + ")");
}

$(function() {
    showPage("menu", 2);
});

function play()
{
    showPage("hud", 500);
}

function quit()
{
    gengine_execute("gengine.application.quit()");
}

function updateObjects(count)
{
    $("#objects").html(count);
}
