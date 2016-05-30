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
          $("#model-selector").empty()
            .append(jsonServerResponse.models)

    if $('#make-selector').val() != ''
      getModels

    $('#make-selector').on 'select2:select', getModels

  initPriceCalculation: =>
    calculatePrice = ->
      service_ids = []
      $('.service-select').each ->
        service_ids.push $(this).val()

      $.ajax
        url: '/calculate_price'
        type: 'POST'
        dataType: 'json'
        data:
          service_ids: service_ids
        success: (jsonServerResponse) ->
          $('#price').html jsonServerResponse.price


    $(document).on('click', 'a.add_fields', ( ->
      calculatePrice()
      $('.service-select').on 'select2:select', calculatePrice
    ))

    $(document).on('click', 'a.remove_fields', ( ->
      calculatePrice()
      $('.service-select').on 'select2:select', calculatePrice
    ))

$ ->
  Orders.initMakeModels()
  Orders.initPriceCalculation()
