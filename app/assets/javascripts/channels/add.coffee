$(document).on 'turbolinks:load', ->
  $(".add_channel").on 'click', (e) =>
    $('#add_channel_modal').modal('open')
    return false
  $('.add_channel_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          channel: {
            slug: $('#channel_slug').val()
            team_id: $('#channel_team_id').val()
          }
        }
        success: (data, text, jqXHR) ->
          window.add(data['slug'], data['id'], 'channel')
          window.open(data['id'], 'channels')
          Materialize.toast('Canal adicionado com sucesso &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema ao adicionar canal &nbsp;<b>:(</b>', 4000, 'red')

    $('#add_channel_modal').modal('close')
    return false