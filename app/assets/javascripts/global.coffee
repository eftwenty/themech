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

  initDependentFields: =>
    setupDependentFields = ->
      element       = $(this)
      formGroup     = element.closest('.form-group')
      parentBlock   = formGroup.parent('.dependent')
      referralBoxes = parentBlock.children('.box')
  
      referralBoxes.each ->
        box = $(this);
        condition = box.data('showIf')
        refBoxes  = box.children('.box')
  
        if element.is('select[multiple]')
          controlState = if $.inArray(condition, element.val()) != -1 then condition else null
        else if element.is(':radio') || element.is(':checkbox')
          controlState = formGroup.find(':checked').val()
        else
          controlState = element.val()
  
#        controlState = 'false' if typeof controlState == 'undefined'
  
        conditionForShow = if condition? then String(condition) else 'true'
  
        refBoxes.each ->
          $(this).hide()
  
        if controlState == conditionForShow
          box.show()
        else
          box.find('input[type="text"], select, textarea').val('')
          box.find('select[multiple]').val('')
          box.hide()
          box.find('.select2-chosen').text('Please select')
          box.find('.box').hide()

    $('.dependent select, .dependent input').not('.select2-search__field').not("input[type='hidden']").each setupDependentFields
    $('.dependent select, .dependent input, select').not('.select2-search__field').not("input[type='hidden']").on 'change', setupDependentFields

  initTooltips: ->
    $('.has-tooltip').each ->
      $(this).tooltip()

$ ->
  Global.initSelect2()
  Global.initDatatables()
  Global.applyPhoneInputMasks()
  Global.initInputMasks()
  Global.initDependentFields()
  Global.initTooltips()