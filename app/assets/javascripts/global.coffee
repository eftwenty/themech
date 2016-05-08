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
$ ->
  Global.initSelect2()
  Global.initDatatables()