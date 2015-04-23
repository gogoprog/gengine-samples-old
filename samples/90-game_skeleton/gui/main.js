var pages = {};

var fader;
var nextPageName;
var faderOpacity = 0;

function showPage(name, duration)
{
    nextPageName = name;
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

        gengine_execute("Application:guiFadeFunction()");

        fader.fadeTo(duration, 0, function() {
            fader.hide();
        });

        gengine_execute("Application.guiFadeFunction = function() end");
    });
}

$(function() {
    var children = $("#main").children().each(function(i) { 
        var name = $(this).attr('id');
        pages[name] = {
            element: $(this)
        };
        pages[name].element.hide();
    });

    fader = $('#fader');
    fader.hide();

    showPage('menu', 0);
});

function play()
{
    gengine_execute("Application:play()");
}

function quit()
{
    gengine_execute("gengine.application.quit()");
}

function updateObjects(count)
{
    $("#objects").html(count);
}
