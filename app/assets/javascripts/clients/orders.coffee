Orders =
  initMakeModels: =>
    getModels = ->
      $.ajax
        url: '/get_model'
        type: 'POST'
        dataType: 'json'
        data:
          make: $('#make-selector').val()
        success: (jsonServerResponse) ->
          $('#model-selector').prop 'disabled', ''
          $('#model-selector').empty()
#          jsonServerResponse.models.each ->
#            $('#model-selector').append '<option value="' + this + '">' + this + '</option>'
          $("#model-selector").empty()
            .append(jsonServerResponse.models)
#          $('#model-selector').val(jsonServerResponse.models)

    if $('#make-selector').val() != ''
      getModels()

    $('#make-selector').on 'change', getModels

$ ->
  Orders.initMakeModels()
