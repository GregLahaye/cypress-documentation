# _ = require("lodash")
# Backbone = require("backbone")

## adds a custom lightweight event bus
## to the Cypress class

# splice = (index) ->
  # @_events.splice(index, 1)

_ = require("lodash")
EE = require("events")
Promise = require("bluebird")

module.exports = {
  extend: (obj) ->
    events = new EE

    _.extend(obj, events, {
      emitThen: (eventName, args...) ->
        listeners = events.listeners(eventName)

        listener = (fn) ->
          fn.apply(obj, args)

        Promise.map(listeners, listener)
    })
}
  # $Cypress.extend
  #   event: (name) ->
  #     return if not @_events
  #
  #     _.map @_events[name], "callback"
  #
  #   invoke: (name, args...) ->
  #     return if not events = @event(name)
  #
  #     _.map events, (event) =>
  #       event.apply(@cy, args)
  #
  #   ## coerce the context of trigger'd events
  #   ## to ALWAYS be @cy
  #   trigger: (name) ->
  #     return if not events = @_events and @_events[name]
  #
  #     for event in events
  #       event.ctx = @cy
  #
  #     Backbone.Events.trigger.apply(@, arguments)
  #
  #   triggerPromise: (args...) ->
  #     new Promise (resolve, reject) =>
  #
  #       cb = (resp) ->
  #         if _.has(resp, "__error")
  #           e = resp.__error
  #
  #           if _.isString(e)
  #             err = new Error(e)
  #           else
  #             err = new Error(e.message)
  #
  #             for own prop, val of e
  #               err[prop] = val
  #
  #           err.triggerPromise = true
  #
  #           reject(err)
  #         else
  #           resolve(resp)
  #
  #       args.push(cb)
  #
  #       @trigger.apply(@, args)
  #     .cancellable()
