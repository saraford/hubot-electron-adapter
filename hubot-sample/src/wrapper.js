var events = require('events');

exports.Wrapper = function() {
    var robotEvents = new events.EventEmitter();

    function generateEvent(args) {
        console.log("Emitting event with args " + JSON.stringify(args));
        robotEvents.emit("myEvent", args);
    }

    return {
        robotEvents: robotEvents,
        generateEvent: generateEvent
    };
}
