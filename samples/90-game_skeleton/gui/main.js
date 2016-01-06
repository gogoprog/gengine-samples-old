
$(function() {
    gengine.gui.showPage("menu", "fade", 2);
});

function play()
{
    gengine.gui.showPage("hud", "fade", 500);
}

function quit()
{
    gengine.execute("gengine.application.quit()");
}

function updateObjects(count)
{
    $("#objects").html(count);
}
