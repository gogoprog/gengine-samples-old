var pages = {};

var fader;
var nextPageName;
var faderOpacity = 0;

function showPage(name, duration, lua)
{
    nextPageName = name;
    gengine_execute("Game.interState = function() " + ((typeof lua == "undefined") ? "" : lua) + "end");
    fader.show();
    fader.fadeTo(duration, 1, function() {
        for(var k in pages)
        {
            if(k==nextPageName)
            {
                pages[k].element.show();
            }
            else
            {
                pages[k].element.hide();
            }
        }

        gengine_execute("Game:interState()");

        fader.fadeTo(duration, 0, function() {
            fader.hide();
        });
    });
}


$(function() {
    var children = $("#main").children().each(function(i) { 
        pages[$(this).attr('id')] = {};
    });

    for(var k in pages)
    {
        pages[k].element = $('#' + k);
        pages[k].element.hide();
    }

    fader = $('#fader');
    fader.hide();

    showPage('menu', 0);
});

function play()
{

}

function quit()
{
    gengine_execute("gengine.application.quit()");
}