
function showPage(name, effect, duration)
{
    gengine_execute("gengine.gui.showPage('" + name + "', '" + effect + "', " + duration + ")");
}

$(function() {
    showPage("menu", "fade", 2);
});

function play()
{
    showPage("hud", "fade", 500);
}

function quit()
{
    gengine_execute("gengine.application.quit()");
}

function updateObjects(count)
{
    $("#objects").html(count);
}
