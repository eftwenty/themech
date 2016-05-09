Global =
  initSelect2: ->
    $('.select2-input').each ->
      that = $(this)
      $(this).select2
        allowClear: true,
      .on 'select2:unselecting', ->
        $(this).data('unselecting', true)
      .on 'select2:opening', (e) ->
        if ($(this).data('unselecting'))
          $(this).removeData('unselecting')
          e.preventDefault()

  initDatatables: ->
    $('#dataTable').dataTable
      aoColumnDefs: [
          bSortable: false,
          aTargets: [-1]
      ]
  
  applyPhoneInputMasks: ->
    $('.phone-mask').each ->
      $(this).inputmask '[+99] (999) 999-9999'

  initInputMasks: ->
    $(document).on('click', 'a.add_fields', ( -> Global.applyPhoneInputMasks() ))


$ ->
  Global.initSelect2()
  Global.initDatatables()
  Global.applyPhoneInputMasks()
  Global.initInputMasks()